import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lo_rent/app_provider.dart';
import 'package:lo_rent/constants.dart';
import 'package:group_button/group_button.dart';
import 'package:lo_rent/utilities/routes.dart';
import 'package:lo_rent/utilities/ui.dart';
import 'package:lo_rent/widgets/custom_button.dart';
import 'package:lo_rent/widgets/custom_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

enum LoginState { PHONE_VERIFICATION, OTP_VERIFICATION }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  String _phoneController;
  String _otpController;

  String _selectedRole;
  bool _hidePassword = true;
  bool _showSpinner = false;
  String _verificationId;
  LoginState _loginState = LoginState.PHONE_VERIFICATION;

  @override
  Widget build(BuildContext context) {
    double left = 20.0, right = 20.0;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: SpinKitWave(
        color: kAccentColor,
        size: 30.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: kPrimaryColor),
          ),
          backgroundColor: kAccentColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: kAccentColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            kAppName,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 24, color: kPrimaryColor),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "------Tag line here!------",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: kPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  //TODO implement Hero for logo
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border: Border.all(width: 5, color: kPrimaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: left, right: right, top: 30.0),
                child: Text(
                  'Select your role:',
                  style: kNormalTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: left, right: right, top: 15.0, bottom: 20.0),
                child: GroupButton(
                  spacing: 8,
                  isRadio: true,
                  direction: Axis.vertical,
                  buttonWidth:
                      MediaQuery.of(context).size.width - (left + right),
                  buttonHeight: 45.0,
                  onSelected: (index, isSelected) {
                    setState(() {
                      _selectedRole = availableRoles[index];
                    });
                  },
                  buttons: availableRoles,
                  selectedButton: -1,
                  selectedTextStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  unselectedTextStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  selectedColor: Colors.deepPurpleAccent[700],
                  unselectedColor: Colors.white,
                  unselectedBorderColor: Colors.deepPurpleAccent[700],
                  borderRadius: BorderRadius.circular(60.0),
                  selectedShadow: <BoxShadow>[
                    BoxShadow(color: Colors.transparent)
                  ],
                  unselectedShadow: <BoxShadow>[
                    BoxShadow(color: Colors.transparent)
                  ],
                ),
              ),
              _selectedRole != null
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3,
                        vertical: 15.0,
                      ),
                      child: Divider(
                        color: kAccentColor,
                        thickness: 2.0,
                      ),
                    )
                  : SizedBox(),
              _selectedRole != null
                  ? AbsorbPointer(
                      absorbing: _loginState != LoginState.PHONE_VERIFICATION,
                      child: Form(
                        key: _phoneFormKey,
                        child: TextFieldWidget(
                          onSaved: (value) {
                            _phoneController = value;
                          },
                          labelText: "Phone Number",
                          hintText: "+919563348569",
                          iconData: Icons.phone_android_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (input) {
                            if (!input.startsWith('+') &&
                                !input.startsWith('00'))
                              return 'Phone number must start with country code!';
                            return null;
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
              _selectedRole != null
                  ? AbsorbPointer(
                      absorbing: _loginState != LoginState.OTP_VERIFICATION,
                      child: Form(
                        key: _otpFormKey,
                        child: TextFieldWidget(
                          onSaved: (value) {
                            _otpController = value;
                          },
                          labelText: "OTP",
                          hintText: "••••••",
                          iconData: Icons.lock_outline_rounded,
                          keyboardType: TextInputType.number,
                          obscureText: _hidePassword,
                          validator: (input) {
                            if (input == null || input.isEmpty)
                              return 'Enter the OTP';
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            color: kHintTextColor,
                            icon: Icon(_hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              _selectedRole != null
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(left, 40.0, right, 40.0),
                      child: ButtonWidget(
                        onPressed: () {
                          if (_loginState == LoginState.PHONE_VERIFICATION) {
                            verifyPhoneAndGetOtp();
                          } else {
                            verifyOtp();
                          }
                        },
                        color: kAccentColor,
                        highlightedElevation: 8,
                        child: Text(
                          _loginState == LoginState.PHONE_VERIFICATION
                              ? 'Get OTP'
                              : 'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: kPrimaryColor),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhoneAndGetOtp() async {
    if (_phoneFormKey.currentState.validate()) {
      _phoneFormKey.currentState.save();

      setState(() {
        _showSpinner = true;
      });

      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: _phoneController,
          verificationCompleted: (phoneAuthCredential) async {
            setState(() {
              _showSpinner = false;
            });
          },
          verificationFailed: (verificationFailed) async {
            setState(() {
              _showSpinner = false;
            });
            final snackBar =
                SnackBar(content: Text(verificationFailed.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              _showSpinner = false;
              _loginState = LoginState.OTP_VERIFICATION;
              _verificationId = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) async {},
        );
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
    }
  }

  void verifyOtp() async {
    if (_otpFormKey.currentState.validate()) {
      _otpFormKey.currentState.save();
      setState(() {
        _showSpinner = true;
      });

      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: _otpController);

      try {
        final authCredential =
            await _auth.signInWithCredential(phoneAuthCredential);

        if (authCredential?.user != null) {
          await validateUser(authCredential?.user);
        }

        setState(() {
          _showSpinner = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _showSpinner = false;
        });

        final snackBar = SnackBar(content: Text(e.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> validateUser(User user) async {
    bool isValidUser = true, isNewUser = true;
    for (String role in availableRoles) {
      DocumentSnapshot ds =
          await _firestore.collection(role).doc(user.uid).get();
      if (ds.exists) {
        if (role == _selectedRole) {
          if (ds.data() != null) isNewUser = false;
        } else {
          isValidUser = false;
        }
        break;
      }
      // QuerySnapshot qs = await _firestore.collection(role).get();
      // if (qs.docs.length > 0) {
      //   for (var doc in qs.docs) {
      //     if (doc.id == user.uid) {
      //       if (role == _selectedRole) {
      //         if (doc.data().isNotEmpty) isNewUser = false;
      //       } else
      //         isValidUser = false;
      //       break;
      //     }
      //     // if (qs.docs.contains(user.uid)) if (role == _selectedRole) {
      //     //   if (ds.data().isNotEmpty) {
      //     //     isNewUser = false;
      //     //     break;
      //     //   } else
      //     //     break;
      //     // } else {
      //     //   isValidUser = false;
      //     //   break;
      //   }
      // }
      if (!isValidUser || !isNewUser) break;
    }

    if (isValidUser) {
      Provider.of<ProviderData>(context, listen: false)
          .saveCurrentUserRole(_selectedRole);
      if (isNewUser) {
        await _firestore.collection(_selectedRole).doc(user.uid).set(Map());
        if (_selectedRole != availableRoles.last)
          Navigator.pushReplacement(
              context, FadeInRoute(routeName: RouteNames.PROFILE));
        else
          Navigator.pushReplacement(
              context, FadeInRoute(routeName: RouteNames.SERVICE_PROFILE));
      } else {
        if (_selectedRole != availableRoles.last) {
          await Provider.of<ProviderData>(context, listen: false)
              .getOwnerOrTenantUser();
          Navigator.pushReplacement(
              context, FadeInRoute(routeName: RouteNames.ROOT));
        } else {
          await Provider.of<ProviderData>(context, listen: false)
              .getServiceProviderUser(setTemp: true);
          //TODO Move to ROOT for Service Providers
        }

        final snackBar =
            SnackBar(content: Text('Welcome back! Move to Home Screen'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
          content: Text('Invalid user! Check your details and try again.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
