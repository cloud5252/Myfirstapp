import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'Updarte_UserName_view_Model.dart';

// ignore: must_be_immutable
class Updateusername extends StatelessWidget {
  Updateusername({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdarteUsernameModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => UpdarteUsernameModel(),
      builder: (context, viewmodel, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.blue.shade200,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                backgroundColor: Colors.blue.shade200,
                centerTitle: true,
                title: const Text(
                  'Update User Name',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Name Update',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '🔑',
                          style: TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              viewmodel.setNewValue(value);
                              print('Value changing :: $value');
                            },
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white70,
                                  width: 3,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 10,
              bottom: 40,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () =>
                        viewmodel.updateUsername(username: viewmodel.newValue),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
