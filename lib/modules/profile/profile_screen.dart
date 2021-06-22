import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lo_rent/app_provider.dart';
import 'package:lo_rent/constants.dart';
import 'package:lo_rent/models/owner_or_tenant_user.dart';
import 'package:lo_rent/utilities/routes.dart';
import 'package:lo_rent/widgets/custom_button.dart';
import 'package:lo_rent/widgets/custom_popup_menu.dart';
import 'package:lo_rent/widgets/custom_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _profileFormKey = new GlobalKey<FormState>();
  final bool showBackButton =
      Navigator().pages != null && Navigator().pages.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    OwnerOrTenantUser providerUser =
        Provider.of<ProviderData>(context).ownerOrTenantUser;

    OwnerOrTenantUser ownerOrTenantUser = OwnerOrTenantUser();

    String idp = Provider.of<ProviderData>(context).idP;
    bool showSpinner = Provider.of<ProviderData>(context).showSpinner;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: SpinKitWave(
        color: kAccentColor,
        size: 30.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline6,
          ),
          automaticallyImplyLeading: false,
          leading: showBackButton
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: kSecondaryColor,
                  ),
                  splashRadius: 25,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5)),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      borderRadius: 10.0,
                      color: kAccentColor,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      onPressed: () {
                        saveData(context, ownerOrTenantUser, idp);
                      }),
                ),
                SizedBox(width: 10.0),
                ButtonWidget(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                    borderRadius: 10.0,
                    color: Colors.grey[300],
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: kSecondaryColor,
                      ),
                    ),
                    onPressed: () {
                      resetData(context);
                    }),
              ],
            ),
          ),
        ),
        body: Form(
          key: _profileFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
                  child: Text(
                    'Profile details',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text('Change the following details and save them',
                      style: Theme.of(context).textTheme.caption),
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.name,
                  onSaved: (input) => ownerOrTenantUser.name = input,
                  validator: (input) => input == null || input.isEmpty
                      ? "Name should not be empty"
                      : null,
                  initialValue: providerUser.name,
                  hintText: "John Doe",
                  labelText: "Full Name",
                  iconData: Icons.person_outline,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (input) => ownerOrTenantUser.email = input,
                  validator: (input) =>
                      !input.contains('@') || !input.contains('.')
                          ? "Should be a valid email"
                          : null,
                  initialValue: providerUser.email,
                  hintText: "johndoe@gmail.com",
                  labelText: "Email",
                  iconData: Icons.alternate_email,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.phone,
                  onSaved: (input) => ownerOrTenantUser.phone = input,
                  validator: (input) =>
                      !input.startsWith('+') && !input.startsWith('00')
                          ? "Phone number must start with country code!"
                          : null,
                  initialValue: providerUser.phone,
                  hintText: "+919563348569",
                  labelText: "Phone number",
                  iconData: Icons.phone_android_outlined,
                ),
                PopupMenuWidget(
                    itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: 'Aadhaar Card',
                            child: Text(
                              'Aadhaar Card',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          PopupMenuItem(
                            value: 'PAN Card',
                            child: Text(
                              'PAN Card',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          )
                        ],
                    labelText: 'Identity Proof',
                    icon: Icons.person_outline,
                    child: Text(
                      idp != '' ? idp : 'Select an identity proof',
                      style: idp != ''
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context).textTheme.caption,
                    ),
                    onSelected: (String value) {
                      Provider.of<ProviderData>(context, listen: false)
                          .setTempIdProof(value);
                    }),
                TextFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (input) => ownerOrTenantUser.identityNumber = input,
                  validator: (input) => input == null || input.isEmpty
                      ? "Identity Number should not be empty"
                      : null,
                  initialValue: providerUser.identityNumber,
                  hintText: "Identity proof number",
                  labelText: "Identity number",
                  iconData: Icons.verified_outlined,
                ),
                SizedBox(height: 15.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveData(
      BuildContext context, OwnerOrTenantUser user, String idp) async {
    if (_profileFormKey.currentState.validate() && idp != '') {
      Provider.of<ProviderData>(context, listen: false).revertShowSpinner();
      _profileFormKey.currentState.save();
      user.identityProof = idp;
      await Provider.of<ProviderData>(context, listen: false)
          .saveOwnerOrTenantUser(user);
      Provider.of<ProviderData>(context, listen: false).revertShowSpinner();
      final snackBar = SnackBar(content: Text('Profile saved successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (showBackButton) {
        //TODO pop
      } else {
        Navigator.pushReplacement(
            context, FadeInRoute(routeName: RouteNames.ROOT));
      }
    } else {
      final snackBar = SnackBar(
          content:
              Text('There are errors in some fields! Please correct them!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void resetData(BuildContext context) {
    Provider.of<ProviderData>(context, listen: false).setTempIdProof(null);
    _profileFormKey.currentState.reset();
  }
}
