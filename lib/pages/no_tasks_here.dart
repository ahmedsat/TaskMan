import 'package:flutter/material.dart';

class NoTasksHere extends StatelessWidget {
  const NoTasksHere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset('assets/noData.png'),
      ),
    );
  }
}
