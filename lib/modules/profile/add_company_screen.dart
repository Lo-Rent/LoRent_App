import 'package:flutter/material.dart';
import 'package:lo_rent/app_provider.dart';
import 'package:lo_rent/constants.dart';
import 'package:lo_rent/models/service_provider_user.dart';
import 'package:lo_rent/widgets/custom_button.dart';
import 'package:lo_rent/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddCompanyScreen extends StatelessWidget {
  final GlobalKey<FormState> _companyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ServiceProviderUser providerUser =
        Provider.of<ProviderData>(context).tempSPUser;

    int currentCompanyIndex =
        Provider.of<ProviderData>(context).currentCompanyIndex;

    Company company = currentCompanyIndex == -1
        ? Company()
        : providerUser.companies[currentCompanyIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Company',
          style: Theme.of(context).textTheme.headline6,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kSecondaryColor,
          ),
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
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
                      saveData(context, company);
                    }),
              ),
              SizedBox(width: 10.0),
              ButtonWidget(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
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
                },
              ),
              SizedBox(width: 10.0),
              ButtonWidget(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                borderRadius: 10.0,
                color: Colors.grey[300],
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ),
                onPressed: () {
                  cancel(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _companyFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
                child: Text('Company details',
                    style: Theme.of(context).textTheme.headline5),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text('Change your company details and save them',
                    style: Theme.of(context).textTheme.caption),
              ),
              TextFieldWidget(
                keyboardType: TextInputType.name,
                onSaved: (input) => company.companyName = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Company Name should not be empty"
                    : null,
                initialValue: company.companyName,
                hintText: "Global Service Providers",
                labelText: "Company Name",
                iconData: Icons.business,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.visiblePassword,
                onSaved: (input) => company.gstin = input,
                validator: (input) => input == null || input.isEmpty
                    ? "GSTIN should not be empty"
                    : null,
                initialValue: company.gstin,
                hintText: "GSTIN",
                labelText: "GSTIN",
                iconData: Icons.verified_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.visiblePassword,
                onSaved: (input) => company.cin = input,
                validator: (input) => input == null || input.isEmpty
                    ? "CIN should not be empty"
                    : null,
                initialValue: company.cin,
                hintText: "CIN",
                labelText: "CIN",
                iconData: Icons.verified_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.streetAddress,
                onSaved: (input) => company.addressL1 = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Address Line 1 should not be empty"
                    : null,
                initialValue: company.addressL1,
                hintText: "C-20, Resonance Building",
                labelText: "Address Line 1",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.streetAddress,
                onSaved: (input) => company.city = input,
                validator: (input) => input == null || input.isEmpty
                    ? "City should not be empty"
                    : null,
                initialValue: company.city,
                hintText: "Bengaluru",
                labelText: "City",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.streetAddress,
                onSaved: (input) => company.state = input,
                validator: (input) => input == null || input.isEmpty
                    ? "State should not be empty"
                    : null,
                initialValue: company.state,
                hintText: "Karnataka",
                labelText: "State",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.streetAddress,
                onSaved: (input) => company.country = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Country should not be empty"
                    : null,
                initialValue: company.country,
                hintText: "India",
                labelText: "Country",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.number,
                onSaved: (input) => company.pinCode = input,
                validator: (input) => input == null || input.isEmpty
                    ? "PinCode should not be empty"
                    : null,
                initialValue: company.pinCode,
                hintText: "560005",
                labelText: "PinCode",
                iconData: Icons.location_pin,
              ),
              SizedBox(height: 15.0)
            ],
          ),
        ),
      ),
    );
  }

  void saveData(BuildContext context, Company company) {
    if (_companyFormKey.currentState.validate()) {
      _companyFormKey.currentState.save();
      Provider.of<ProviderData>(context, listen: false).setCompany(company);
      final snackBar = SnackBar(content: Text('Company saved successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
          content:
              Text('There are errors in some fields! Please correct them!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void resetData(BuildContext context) {
    _companyFormKey.currentState.reset();
  }

  void cancel(BuildContext context) {
    Navigator.pop(context);
  }
}
