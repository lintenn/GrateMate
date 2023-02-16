import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100,),
            Container(
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                //border: Border.all(width: 2, color: Colors.grey)
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePhotoUrl),
                backgroundColor: Colors.grey,
              ),
            ),
            SizedBox(height: 16,),
            buildInfoCard('Name','${user.firstName} ${user.lastName}'),
            buildInfoCard('Email',user.email),
            buildInfoCard('Phone Number',user.phoneNumber),
            buildInfoCard('Date of Birth','${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}'),
            SizedBox(height: 50,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //TODO: make logout del user
                },
                child: Text('Logout'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12,5,12,5),
      child: Card(
              child: ListTile(
                title: Text(title),
                subtitle: Text(subtitle),
              ),
            ),
    );
  }
}
