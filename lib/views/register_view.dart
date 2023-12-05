import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_appointment_app/components/button.dart';
import 'package:medical_appointment_app/utils/config.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _gender;
  late final TextEditingController _type;
  late final TextEditingController _birthDate;

  bool obsecurePass = true;
  var items = [
    'male',
    'female',
  ];
  var docItems = [
    'patient',
    'doctor',
  ];

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _gender = TextEditingController();
    _type = TextEditingController();
    _birthDate = TextEditingController();
    _gender.text = 'male';
    _type.text = 'patient';

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _gender.dispose();
    _type.dispose();
    _birthDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register view'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Config.spaceSmall,
            TextFormField(
              controller: _name,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your full name here',
                labelText: 'Full name',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email here',
                labelText: 'Email',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _password,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Config.primaryColor,
              obscureText: obsecurePass,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your password here',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecurePass = !obsecurePass;
                    });
                  },
                  icon: obsecurePass
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Config.primaryColor,
                        ),
                ),
              ),
            ),
            Config.spaceSmall,
            DropdownButtonFormField(
              // Initial Value
              value: _gender.text,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Down Arrow Icon

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText:
                    'Select your gender', // You can customize this hint text
                labelText: 'Gender', // You can customize this label text
                prefixIcon: Icon(_gender.text == 'male'
                    ? Icons.male_rounded
                    : Icons.female_rounded),
                prefixIconColor: Config.primaryColor,
                alignLabelWithHint: true,
              ),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (newValue) {
                setState(() {
                  _gender.text = newValue.toString();
                });
              },
            ),
            Config.spaceSmall,
            DropdownButtonFormField(
              // Initial Value
              value: _type.text,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Down Arrow Icon

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText:
                    'Select your user type', // You can customize this hint text
                labelText: 'User type', // You can customize this label text
                prefixIcon: Icon(_type.text == 'patient'
                    ? Icons.person_rounded
                    : Icons.medical_services),
                prefixIconColor: Config.primaryColor,
                alignLabelWithHint: true,
              ),
              // Array list of items
              items: docItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (newValue) {
                setState(() {
                  _type.text = newValue.toString();
                });
              },
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _birthDate,
              keyboardType: TextInputType.text,
              cursorColor: Config.primaryColor,
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime.now(),
                    onChanged: (date) {}, onConfirm: (date) {
                  _birthDate.text = DateFormat('yyyy-MM-dd').format(date);
                  log(date.toString());
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Birthdate',
                labelText: 'Birthdate',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.date_range),
                prefixIconColor: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            Button(
              width: double.infinity,
              title: 'Sign Up',
              onPressed: () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _email.text, password: _password.text)
                    .then((value) {
                  var data = {
                    'user_id': value.user!.uid,
                    'full_name': _name.text,
                    'gender': _gender.text,
                    'type': _type.text,
                    'birth_date': _birthDate.text,
                    'profile_picture': 'default_profile_picture.webp',
                  };

                  var collection =
                      FirebaseFirestore.instance.collection('users_data');
                  collection
                      .add(data) // <-- Your data
                      .then((_) =>
                          Navigator.of(context).pushReplacementNamed('/home'))
                      .catchError((error) => log(error));
                });
              },
              disable: false,
            ),
            Config.spaceSmall,
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text(
                'Already have an account? Sign in!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
