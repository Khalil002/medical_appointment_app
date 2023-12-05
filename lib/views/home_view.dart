import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home view'),
          backgroundColor: Colors.greenAccent,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/');
                });
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(FirebaseAuth.instance.currentUser!.email!),
            ],
          ),
        ));
  }
}
