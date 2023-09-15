import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class example extends StatefulWidget {
  @override
  _exampleState createState() => _exampleState();
}

class _exampleState extends State<example> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> addUser() async {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'name': nameController.text,
      'email': emailController.text,
    });
    // Clear the text fields after adding a user
    nameController.clear();
    emailController.clear();
  }

  Future<void> updateUserEmail(String userId, String currentEmail) async {
    final DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Email'),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'New Email'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                userRef.update({'email': emailController.text});
                Navigator.of(context).pop();
                // Clear the email text field after updating
                emailController.clear();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
    // Update the email text field with the current email after dialog is closed
    emailController.text = currentEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addUser,
              child: Text('Add User'),
            ),
            SizedBox(height: 16.0),
            Text('Users:'),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final users = snapshot.data!.docs;
                List<Widget> userWidgets = [];
                for (var user in users) {
                  final userData = user.data() as Map<String, dynamic>;
                  final userName = userData['name'];
                  final userEmail = userData['email'];
                  final userId = user.id; // Get the document ID
                  userWidgets.add(
                    ListTile(
                      title: Text(userName),
                      subtitle: Text(userEmail),
                      trailing: ElevatedButton(
                        onPressed: () => updateUserEmail(userId, userEmail),
                        child: Text('Update Email'),
                      ),
                    ),
                  );
                }
                return Column(
                  children: userWidgets,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}