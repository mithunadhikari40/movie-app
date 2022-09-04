import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    required this.message,
    required this.callback,
  }) : super(key: key);

  final String message;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: callback,
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }
}
