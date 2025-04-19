import 'package:flutter/material.dart';
import 'package:states/main.dart';

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Enter name'),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: nameController.text);
              ContactBook().addContact(contact: contact);
              Navigator.of(context).pop();
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
