class VideoFolder {
  final String folderName;
  final List<VideoFile> videoFiles;

  VideoFolder({
    required this.folderName,
    required this.videoFiles,
  });
}

class VideoFile {
  final String name;
  final String path;
  String? thumbNailPath;

  VideoFile({
    required this.name,
    required this.path,
    this.thumbNailPath,
  });
}
