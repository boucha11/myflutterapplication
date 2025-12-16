import 'package:flutter/material.dart';
import '../widgets/myform.dart';

class Subscribe extends StatelessWidget {
  const Subscribe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.greenAccent,
        title: const Text("Subscribe"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.subscriptions_rounded),
        ),
      ),
      body: const Myform(),
    );
  }
}
