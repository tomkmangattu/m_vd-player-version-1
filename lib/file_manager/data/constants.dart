import 'package:flutter/painting.dart';

const List<String> supportedVideoFormats = ['.mp4', '.webm', '.mpeg', '.mkv'];
const List<String> supportedAudioFiles = ['.mp3'];

const Color topColor = Color(0xff1C1638);
const Color middleColor = Color(0xff19182D);
const Color bottomColor = Color(0xff191735);
const Color navColor = Color(0xff1A163F);

const LinearGradient bgmGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [topColor, navColor],
);

enum StorageErrors {
  lookUpFailed,
  sdCardNotPresent,
  internalInfoFail,
  sdInfoFail,
}
