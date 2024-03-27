import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('../assets/images/oops_icon.png'),
            const SizedBox(height: 20),
            const Icon(Icons.error_outline, size: 40, color: Colors.red),
            const SizedBox(height: 20),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Try Again'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
