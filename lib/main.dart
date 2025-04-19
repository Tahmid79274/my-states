import 'package:flutter/material.dart';
import 'package:states/new_contact_view.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<List<Contact>> contacts = ValueNotifier<List<Contact>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (
          BuildContext contactContext,
          List<Contact> listOfContacts,
          child,
        ) {
          final contacts = listOfContacts;
          return ListView.builder(
            itemCount: listOfContacts.length,
            itemBuilder: (context, index) {
              final contact = listOfContacts[index];
              return Dismissible(
                onDismissed: (direction) {
                  // ContactBook().removeContact(contact: contact);
                  listOfContacts.remove(contact);
                },
                key: ValueKey(contact.id),
                child: ListTile(
                  title: Text(contact.name),
                  tileColor: Colors.amber,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => NewContactView()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Contact {
  final String id;
  final String name;
  Contact({required this.name}) : id = Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];

  int get length => value.length;

  void addContact({required Contact contact}) {
    value.add(contact);
    notifyListeners();
  }

  void removeContact({required Contact contact}) {
    value.remove(contact);
    notifyListeners();
  }

  Contact? getContact({required int index}) {
    return index < value.length ? value[index] : null;
  }
}
