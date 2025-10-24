import 'package:flutter/material.dart';

class MyReceipt extends StatefulWidget {
  const MyReceipt({super.key});

  @override
  State<MyReceipt> createState() => _MyReceiptState();
}

class _MyReceiptState extends State<MyReceipt> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Thank you For Your Order!"),
          Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15),
            child: const Text(''),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Estimated delivery time is:4:12 PM "),
        ],
      ),
    );
  }
}
