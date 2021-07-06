import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/app_provider.dart';

import 'package:lo_rent/utilities/app_images.dart';
import 'package:lo_rent/utilities/routes.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  FirebaseAuth _auth;
  User _user;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      //TODO -> return SomethingWentWrong();
      print('Firestore error');
    }
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.LOGO), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurple[600],
    );
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      await FirebaseAppCheck.instance
          .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
      setState(() {
        _auth = FirebaseAuth.instance;
        _user = _auth.currentUser;
        if (_user == null) {
          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context, FadeInRoute(routeName: RouteNames.LOGIN));
          });
        } else {
          Timer(Duration(seconds: 2), () {
            validateUser();
          });
        }
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Future<void> validateUser() async {
    for (String role in availableRoles) {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection(role)
          .doc(_user.uid)
          .get();
      if (ds.exists) {
        Provider.of<ProviderData>(context, listen: false)
            .saveCurrentUserRole(role);
        if (ds.data() != null) {
          print('Go to home screen : $role');
          if (role != availableRoles.last) {
            await Provider.of<ProviderData>(context, listen: false)
                .getOwnerOrTenantUser();
            Navigator.pushReplacement(
                context, FadeInRoute(routeName: RouteNames.ROOT));
          } else {
            await Provider.of<ProviderData>(context, listen: false)
                .getServiceProviderUser(setTemp: true);
            //TODO Move to ROOT for Service Providers
          }
        } else {
          if (role != availableRoles.last)
            Navigator.pushReplacement(
                context, FadeInRoute(routeName: RouteNames.PROFILE));
          else
            Navigator.pushReplacement(
                context, FadeInRoute(routeName: RouteNames.SERVICE_PROFILE));
        }
        break;
      }
    }
  }
}
