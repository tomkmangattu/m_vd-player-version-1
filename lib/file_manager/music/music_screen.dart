import 'package:flutter/material.dart';
import 'package:m_vd/file_manager/data/constants.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: bgmGradient,
      ),
    );
  }
}
