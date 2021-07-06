import 'package:flutter/material.dart';
import 'package:lo_rent/models/house_listing_model.dart';
import 'package:lo_rent/utilities/routes.dart';
import 'package:lo_rent/widgets/custom_button.dart';
import 'package:lo_rent/widgets/custom_popup_menu.dart';
import 'package:lo_rent/widgets/custom_text_field.dart';
import '../../../constants.dart';

class AddHouseListingScreen extends StatefulWidget {
  @override
  _AddHouseListingScreenState createState() => _AddHouseListingScreenState();
}

class _AddHouseListingScreenState extends State<AddHouseListingScreen> {
  final GlobalKey<FormState> _listingFormKey = GlobalKey<FormState>();
  HouseListingModel houseListingModel = HouseListingModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add House Listing',
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
                      print('Save button pressed');
                    }),
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _listingFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWidget(
                keyboardType: TextInputType.name,
                onSaved: (input) => houseListingModel.houseName = input,
                validator: (input) => input == null || input.isEmpty
                    ? "House Name should not be empty"
                    : null,
                hintText: "Ajay Nivas",
                labelText: "House Name",
                iconData: Icons.house_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.multiline,
                onSaved: (input) => houseListingModel.description = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Description should not be empty"
                    : null,
                hintText:
                    "Located very close to a children's park, this 3 BHK house has a beautiful scenery around it."
                    "There are hardly any water or power supply cut.\n"
                    "The rooms are large and airy, making it a suitable choice for a family.",
                labelText: "Description",
                iconData: Icons.description_outlined,
                maxLines: 6,
                sizedBoxHeight: 15,
              ),
              PopupMenuWidget(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'Apartment',
                    child: Text(
                      'Apartment',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Villa',
                    child: Text(
                      'Villa',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Duplex',
                    child: Text(
                      'Duplex',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Independent House',
                    child: Text(
                      'Independent House',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Studio',
                    child: Text(
                      'Studio',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Triplex',
                    child: Text(
                      'Triplex',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
                labelText: 'House Type',
                icon: Icons.house_outlined,
                child: Text(
                  houseListingModel.houseType != null
                      ? houseListingModel.houseType
                      : 'Select a house type',
                  style: houseListingModel.houseType != null
                      ? Theme.of(context).textTheme.bodyText2
                      : Theme.of(context).textTheme.caption,
                ),
                onSelected: (String value) {
                  setState(() {
                    houseListingModel.houseType = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, right: 20, left: 20, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address',
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 5),
                          Text('Add address manually or through google maps',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () => Navigator.push(context,
                          SlideRoute(routeName: RouteNames.GOOGLE_MAP_SCREEN)),
                    ),
                  ],
                ),
              ),
              TextFieldWidget(
                keyboardType: TextInputType.name,
                onSaved: (input) => houseListingModel.houseNo = input,
                validator: (input) => input == null || input.isEmpty
                    ? "House Number should not be empty"
                    : null,
                hintText: "A-234",
                labelText: "House Number",
                iconData: Icons.house_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.streetAddress,
                onSaved: (input) => houseListingModel.addressLine1 = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Address Line 1 should not be empty"
                    : null,
                hintText: "Diamond Colony",
                labelText: "Address Line 1",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.streetAddress,
                onSaved: (input) => houseListingModel.addressLine2 = input,
                hintText: 'Shivaji Road',
                labelText: "Address Line 2",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.text,
                onSaved: (input) => houseListingModel.locality = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Locality should not be empty"
                    : null,
                hintText: "Shivaji Nagar",
                labelText: "Locality",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.text,
                onSaved: (input) => houseListingModel.city = input,
                validator: (input) => input == null || input.isEmpty
                    ? "City should not be empty"
                    : null,
                hintText: "Bangalore",
                labelText: "City",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.text,
                onSaved: (input) => houseListingModel.state = input,
                validator: (input) => input == null || input.isEmpty
                    ? "State should not be empty"
                    : null,
                hintText: "Karnataka",
                labelText: "State",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.text,
                onSaved: (input) => houseListingModel.country = input,
                validator: (input) => input == null || input.isEmpty
                    ? "Country should not be empty"
                    : null,
                hintText: "India",
                labelText: "Country",
                iconData: Icons.location_city_outlined,
              ),
              TextFieldWidget(
                keyboardType: TextInputType.number,
                onSaved: (input) => houseListingModel.pinCode = input,
                validator: (input) => input == null || input.isEmpty
                    ? "PIN code should not be empty"
                    : null,
                hintText: "560021",
                labelText: "PIN Code",
                iconData: Icons.location_city_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
