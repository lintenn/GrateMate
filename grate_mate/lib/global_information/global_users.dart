library users;
import '../models/user.dart';
List<User> users = [
  User(id: 1, firstName: 'Jesus', lastName: 'Moreno', username: 'jesu-m0', email: 'jesus@gmail.com', password: '1234', dateOfBirth: DateTime(2000,4,28), phoneNumber: '+34123456789',
  profilePhotoUrl: 'https://de.web.img2.acsta.net/r_654_368/img/47/d9/47d93afd6f4a7ab3050916cab486d2a9.jpg',),
  User(id: 2, firstName: 'Luis Miguel', lastName: 'Garcia', username: 'linten', email: 'linten@gmail.com', password: '1234', dateOfBirth: DateTime(2001), phoneNumber: '+34123456789',
  profilePhotoUrl: 'https://de.web.img2.acsta.net/r_654_368/img/47/d9/47d93afd6f4a7ab3050916cab486d2a9.jpg')
];

// bool isLogged = false;
// late User userLogged;

bool isLogged = true;
late User userLogged = users[0];