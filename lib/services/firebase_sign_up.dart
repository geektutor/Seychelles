import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grantconsent/utilities/custom_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_sign_out.dart';

var userCreated;
Future<SignUpStatus> signUpUser(
    {@required ConsentUser newUser, @required String password}) async {
  signOutUser();
  final _auth = FirebaseAuth.instance;

  final checkPhone = await Firestore.instance
      .collection('Users')
      .where('PhoneNumber', isEqualTo: newUser.phoneNumber)
      .limit(1)
      .getDocuments();
  if (checkPhone.documents.length == 0) {
    // Phone number doesn't exist.
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: newUser.email, password: password);
      if (result != null) {
        userCreated = await _auth.currentUser();
        sendVerificationEmail();
        saveNewUserData(newUser);
        return SignUpStatus.success;
      } else {
        print('Failed!');
      }
    } catch (e) {
      print(e);
      return e.toString().contains('WEAK')
          ? SignUpStatus.weakPassword
          : e.toString().contains('INVALID_EMAIL')
              ? SignUpStatus.invalidEmail
              : e.toString().contains('ALREADY_IN_USE')
                  ? SignUpStatus.userExists
                  : SignUpStatus.unknownException;

    }
    return SignUpStatus.unknownException;
  } else {
    return SignUpStatus.phoneExists;
  }
}

Future sendVerificationEmail() async {
  try {
    userCreated.sendEmailVerification();
  } catch (e) {
    //TODO: take action to handle sending email failure.
    print(e);
  }
}

void saveNewUserData(ConsentUser user) async {
//  final firebaseUser = await FirebaseAuth.instance.currentUser();
  final _seychellesFirestore = Firestore.instance;
  _seychellesFirestore.collection("Users").document(userCreated.uid).setData({
    'FirstName': user.firstName,
    'LastName': user.lastName,
    'PhoneNumber': user.phoneNumber,
    'Email': user.email,
  'Picture' :user.pictureURL
  });
  return;
}

enum SignUpStatus {
  success,
  weakPassword,
  invalidEmail,
  userExists,
  unknownException,
  phoneExists
}
enum EmailStatus {
  emailSent,
  emailFailed,
}
