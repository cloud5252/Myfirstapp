import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final void Function(int index)? pressed;

  const MyTextBox({
    super.key,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    // Labels ki ek list
    final items = [
      'Update UserName',
      'Changed Password',
      'Delete my Account',
      'About this app',
      'Logout',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                items[index],
                style: TextStyle(color: Colors.grey.shade900),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade600,
                size: 20,
              ),
              onTap: () => pressed?.call(index),
            ),
          );
        },
      ),
    );
  }
}
