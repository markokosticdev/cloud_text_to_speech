import 'package:cloud_text_to_speech/src/amazon/audio/audio_request_param.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voice_model.dart';

class TtsParamsAmazon extends AudioRequestParamsAmazon {
  /// Rate is the speed at which the voice will speak.
  ///
  /// * `rate` default to default.

  TtsParamsAmazon({
    required VoiceAmazon voice,
    required String audioFormat,
    required String text,
    String? rate,
    String? pitch,
  }) : super(
          voice: voice,
          audioFormat: audioFormat,
          text: text,
          rate: rate ?? 'default',
          pitch: pitch ?? 'default',
        );
}
