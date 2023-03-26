import 'package:flutter/material.dart';
import 'package:grate_mate/widgets/mate_text_p.dart';
import '../global_information/colors_palette.dart';
import '../models/user.dart';
import '../global_information/global_users.dart' as Users;


class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GrateMate.grayGrateMate,
        body: SingleChildScrollView(
          child: Container(
            //TODO All the other screens have 20 margin on left and right side, but here somehow we need 15.. why?
            margin: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 7,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    //border: Border.all(width: 2, color: Colors.grey)
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePhotoUrl),
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16,),
                buildInfoCard('Name','${user.firstName} ${user.lastName}'),
                buildInfoCard('Email',user.email),
                buildInfoCard('Phone Number',user.phoneNumber),
                buildInfoCard('Date of Birth','${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}'),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Users.isLogged = false;
                      Navigator.pushReplacementNamed(context, '/home/login');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,5,0,5),
      child: Card(
              child: ListTile(
                title: MateTextP(text: title),
                subtitle: MateTextP(text: subtitle),
              ),
            ),
    );
  }
}
