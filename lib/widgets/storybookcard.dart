import 'package:flutter/material.dart';

import 'package:whisperverse_app/stories/storymodel.dart';

class Storybookcard extends StatelessWidget {
  const Storybookcard({super.key, required this.storymodel});
  final Book storymodel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(15),
            clipBehavior: Clip.hardEdge,
            child: storymodel.coverImage,
          ),
          Text(storymodel.title),
          Text(storymodel.author),
        ],
      ),
    );
  }
}
