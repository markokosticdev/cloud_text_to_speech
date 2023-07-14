import 'dart:convert';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/common/http/base_response_mapper.dart';
import 'package:cloud_text_to_speech/src/common/other/constants.dart';
import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/google/voices/voice_model.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_responses.dart';
import 'package:http/http.dart' as http;

class VoicesResponseMapperGoogle extends BaseResponseMapper {
  @override
  BaseResponse map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          final json = jsonDecode(response.body)['voices'] as List<dynamic>;
          var voices = json
              .map((e) => VoiceGoogle.fromJson(e as Map<String, dynamic>))
              .toList(growable: false);

          voices.sort((a, b) => a.locale.compareTo(b.locale));

          voices =
              Helpers.mapVoiceNames(voices, VoiceNames.male, VoiceNames.female);

          return VoicesSuccessGoogle(voices: voices);
        }
      case 400:
        return VoicesFailedBadRequestGoogle(
            reasonPhrase: response.reasonPhrase);
      case 401:
        return VoicesFailedUnauthorizedGoogle();
      case 429:
        return VoicesFailedTooManyRequestsGoogle();
      case 502:
        return VoicesFailedBadGateWayGoogle();
      default:
        return VoicesFailedUnkownErrorGoogle(
            code: response.statusCode,
            reason: response.reasonPhrase ?? response.body);
    }
  }
}