import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';

import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: const [],
          future: Future.delayed(const Duration(seconds: 1)).then(
            (value) => _dao.findAll(),
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data!;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return _ContactItem(contact: contact);
                  },
                );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Erro Desconhecido'),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push<Contact>(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              )
              .then((value) => setState(() {}));
        },
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.account.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
