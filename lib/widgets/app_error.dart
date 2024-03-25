import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String error;
  const AppError({
    super.key, required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(error),
        ElevatedButton(onPressed: () {}, child: Text("Refresh"))
      ],
    );
  }
}
