import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '탐색',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text('탐색 페이지'),
      ),
    );
  }
}
