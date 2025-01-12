import 'package:flutter/material.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '프로젝트',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text('프로젝트 페이지'),
      ),
    );
  }
}
