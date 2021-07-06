import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lo_rent/app_provider.dart';
import 'package:lo_rent/models/house_listing_model.dart';
import 'package:lo_rent/modules/owner_specific/house_listings/widgets/file_card.dart';
import 'package:lo_rent/utilities/routes.dart';
import 'package:lo_rent/widgets/add_button.dart';
import 'package:lo_rent/widgets/custom_button.dart';
import 'package:lo_rent/widgets/custom_popup_menu.dart';
import 'package:lo_rent/widgets/custom_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class AddHouseListingScreen extends StatelessWidget {
  final GlobalKey<FormState> _listingFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    HouseListingModel houseListingModel =
        Provider.of<ProviderData>(context).houseListingModel;
    bool showSpinner = Provider.of<ProviderData>(context).showSpinner;

    TextEditingController _addressLine2Controller = TextEditingController(
        text:
            Provider.of<ProviderData>(context).houseListingModel.addressLine2);
    TextEditingController _localityController = TextEditingController(
        text: Provider.of<ProviderData>(context).houseListingModel.locality);
    TextEditingController _cityController = TextEditingController(
        text: Provider.of<ProviderData>(context).houseListingModel.city);
    TextEditingController _stateController = TextEditingController(
        text: Provider.of<ProviderData>(context).houseListingModel.state);
    TextEditingController _countryController = TextEditingController(
        text: Provider.of<ProviderData>(context).houseListingModel.country);
    TextEditingController _pinCodeController = TextEditingController(
        text: Provider.of<ProviderData>(context).houseListingModel.pinCode);

    List<PlatformFile> files = Provider.of<ProviderData>(context).pickedFiles;
    List<FileCardWidget> displayFiles = [];
    if (files.length > 0) {
      for (PlatformFile platformFile in files) {
        displayFiles.add(
          FileCardWidget(
            platformFile: platformFile,
            onLongPress: () async {
              String status = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete File?'),
                  content: Text(
                    'Are you sure you want to delete this file?',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'cancel'),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'delete'),
                      child: Text(
                        'Delete',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              if (status == 'delete') {
                Provider.of<ProviderData>(context, listen: false)
                    .deleteFromPickedFiles(files.indexOf(platformFile));
              }
            },
          ),
        );
      }
    }

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: SpinKitWave(
          color: kAccentColor,
          size: 30.0,
        ),
        child: Scaffold(
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
                _cancel(context);
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
                          _save(context, houseListingModel);
                        }),
                  ),
                  SizedBox(width: 10.0),
                  ButtonWidget(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
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
                      _cancel(context);
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 20, left: 20),
                    child: Text(
                      'House Details',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text('Add details of the house',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.name,
                    initialValue: houseListingModel.houseName ?? '',
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
                    initialValue: houseListingModel.description ?? '',
                    onSaved: (input) => houseListingModel.description = input,
                    validator: (input) => input == null || input.isEmpty
                        ? "Description should not be empty"
                        : null,
                    hintText:
                        "Located very close to a children's park, this 3 BHK house has a beautiful scenery around it."
                        " There are hardly any water or power supply cut.\n"
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
                      houseListingModel.houseType ?? 'Select a house type',
                      style: houseListingModel.houseType != null
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context).textTheme.caption,
                    ),
                    onSelected: (String value) {
                      Provider.of<ProviderData>(context, listen: false)
                          .setTempHouseType(value);
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
                              Text(
                                  'Add address manually or through google maps',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.my_location),
                            onPressed: () async {
                              var address = await Navigator.push(
                                  context,
                                  SlideRoute(
                                      routeName: RouteNames.GOOGLE_MAP_SCREEN));
                              if (address != null) {
                                _parseAddressStringToMap(
                                    context, address.toString());
                              }
                            }),
                      ],
                    ),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.name,
                    initialValue: houseListingModel.houseNo ?? '',
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
                    initialValue: houseListingModel.addressLine1 ?? '',
                    onSaved: (input) => houseListingModel.addressLine1 = input,
                    hintText: "Diamond Colony",
                    labelText: "Address Line 1",
                    iconData: Icons.location_city_outlined,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.streetAddress,
                    controller: _addressLine2Controller,
                    onSaved: (input) => houseListingModel.addressLine2 = input,
                    validator: (input) => input == null || input.isEmpty
                        ? "Address Line 2 should not be empty"
                        : null,
                    hintText: 'Shivaji Road',
                    labelText: "Address Line 2",
                    iconData: Icons.location_city_outlined,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.text,
                    controller: _localityController,
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
                    controller: _cityController,
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
                    controller: _stateController,
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
                    controller: _countryController,
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
                    controller: _pinCodeController,
                    onSaved: (input) => houseListingModel.pinCode = input,
                    validator: (input) => input == null || input.isEmpty
                        ? "PIN code should not be empty"
                        : null,
                    hintText: "560021",
                    labelText: "PIN Code",
                    iconData: Icons.location_city_outlined,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 20, left: 20),
                    child: Text(
                      'Rental Details',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text('Add details related to the rent of the house',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.multiline,
                    initialValue: houseListingModel.instructions ?? '',
                    onSaved: (input) => houseListingModel.instructions = input,
                    validator: (input) => input == null || input.isEmpty
                        ? "Instructions should not be empty"
                        : null,
                    hintText: "Kindly mention instructions for the tenants.",
                    labelText: "Instructions",
                    iconData: Icons.label_important_outline,
                    maxLines: 6,
                    sizedBoxHeight: 15,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    initialValue: houseListingModel.rentFees ?? '',
                    onSaved: (input) => houseListingModel.rentFees = input,
                    validator: (input) => input == null || input.isEmpty
                        ? "Rent Fees should not be empty"
                        : null,
                    hintText: "12,000.00",
                    labelText: "Rent Fees (in INR)",
                    iconData: Icons.money_outlined,
                  ),
                  PopupMenuWidget(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'Yes',
                        child: Text(
                          'Yes',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'No',
                        child: Text(
                          'No',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                    labelText: 'Available for Rental?',
                    icon: Icons.check_circle_outline,
                    child: Text(
                      houseListingModel.availableForRental ??
                          'Is house available for rental?',
                      style: houseListingModel.availableForRental != null
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context).textTheme.caption,
                    ),
                    onSelected: (String value) {
                      Provider.of<ProviderData>(context, listen: false)
                          .setAvailableForRental(value);
                    },
                  ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      initialValue: houseListingModel.builtUpArea ?? '',
                      onSaved: (input) => houseListingModel.builtUpArea = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Built-Up Area should not be empty"
                          : null,
                      hintText: "1000.00",
                      labelText: "Built-Up Area (in sq ft)",
                      iconData: Icons.house_outlined,
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    PopupMenuWidget(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: '1',
                          child: Text(
                            '1',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        PopupMenuItem(
                          value: '2',
                          child: Text(
                            '2',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        PopupMenuItem(
                          value: '3',
                          child: Text(
                            '3',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        PopupMenuItem(
                          value: '4',
                          child: Text(
                            '4',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                      labelText: 'BHK',
                      icon: Icons.house_outlined,
                      child: Text(
                        houseListingModel.bhk ?? 'Select BHK of the house',
                        style: houseListingModel.bhk != null
                            ? Theme.of(context).textTheme.bodyText2
                            : Theme.of(context).textTheme.caption,
                      ),
                      onSelected: (String value) {
                        Provider.of<ProviderData>(context, listen: false)
                            .setBHK(value);
                      },
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      initialValue: houseListingModel.security ?? '',
                      onSaved: (input) => houseListingModel.security = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Security should not be empty"
                          : null,
                      hintText: "Security",
                      labelText: "Security",
                      iconData: Icons.security_outlined,
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      initialValue: houseListingModel.carpetArea ?? '',
                      onSaved: (input) => houseListingModel.carpetArea = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Carpet Area should not be empty"
                          : null,
                      hintText: "650.00",
                      labelText: "Carpet Area (in sq ft)",
                      iconData: Icons.house_outlined,
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      initialValue: houseListingModel.ageOfProperty ?? '',
                      onSaved: (input) =>
                          houseListingModel.ageOfProperty = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Property Age should not be empty"
                          : null,
                      hintText: "5",
                      labelText: "Age of Property (in years)",
                      iconData: Icons.house_outlined,
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.multiline,
                      initialValue: houseListingModel.furnishing ?? '',
                      onSaved: (input) => houseListingModel.furnishing = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Furnishing Details should not be empty"
                          : null,
                      hintText:
                          "2 curtains, 1 sofa set, 5 cushions, 2 bedding, 2 rugs",
                      labelText: "Furnishing Details",
                      iconData: Icons.single_bed_outlined,
                      maxLines: 4,
                      sizedBoxHeight: 15,
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      initialValue: houseListingModel.floorNumber ?? '',
                      onSaved: (input) => houseListingModel.floorNumber = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Floor Number(s) should not be empty"
                          : null,
                      hintText: "12",
                      labelText: "Floor Number(s)",
                      iconData: Icons.house_outlined,
                    ),
                  if (houseListingModel.availableForRental == 'Yes')
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      initialValue: houseListingModel.parking ?? '',
                      onSaved: (input) => houseListingModel.parking = input,
                      validator: (input) => input == null || input.isEmpty
                          ? "Parking Details should not be empty"
                          : null,
                      hintText: "Covered, 2 Open",
                      labelText: "Parking Details",
                      iconData: Icons.local_parking_outlined,
                    ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 20, left: 20),
                    child: Text(
                      'Gallery',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                        'Add Images, Videos, and/or Documents of the house',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  Column(
                    children: displayFiles,
                  ),
                  AddButtonWidget(
                    icon: Icons.upload_file,
                    text: 'Upload Files',
                    onPressed: () async {
                      print('Upload Files button clicked');
                      Provider.of<ProviderData>(context, listen: false)
                          .revertShowSpinner();
                      FilePickerResult result = await FilePicker.platform
                          .pickFiles(allowMultiple: true, withReadStream: true);
                      Provider.of<ProviderData>(context, listen: false)
                          .revertShowSpinner();
                      if (result != null) {
                        Provider.of<ProviderData>(context, listen: false)
                            .addTOPickedFiles(result);
                      } else {
                        print('Result is null');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _parseAddressStringToMap(BuildContext context, String address) {
    Map<String, String> addressComponents = {};

    RegExp regExp = RegExp(r'^(.*)<span class="(.*)">(.*)$');
    List<String> list = address.split('</span>');
    for (String text in list) {
      if (text == '') continue;
      RegExpMatch match = regExp.firstMatch(text);
      addressComponents.addEntries([MapEntry(match.group(2), match.group(3))]);
    }
    Provider.of<ProviderData>(context, listen: false)
        .setAddress(addressComponents);
  }

  void _save(BuildContext context, HouseListingModel houseListingModel) async {
    if (_listingFormKey.currentState.validate() &&
        houseListingModel.houseType != null &&
        houseListingModel.houseType != '') {
      final snackBar1 = SnackBar(content: Text('Saving...'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);

      //Provider.of<ProviderData>(context, listen: false).revertShowSpinner();
      _listingFormKey.currentState.save();
      Provider.of<ProviderData>(context, listen: false)
          .updateHouseListingModel(houseListingModel);
      bool statusSuccess =
          await Provider.of<ProviderData>(context, listen: false)
              .saveHouseListing();
      //Provider.of<ProviderData>(context, listen: false).revertShowSpinner();
      final snackBar = statusSuccess
          ? SnackBar(content: Text('House Listing created successfully'))
          : SnackBar(
              content: Text('Some error occurred! Please try again later'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
          content:
              Text('There are errors in some fields! Please correct them!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _cancel(BuildContext context) {
    Provider.of<ProviderData>(context, listen: false)
        .updateHouseListingModel(HouseListingModel());
    Provider.of<ProviderData>(context, listen: false).resetPickedFiles();
    Navigator.pop(context);
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    Provider.of<ProviderData>(context, listen: false)
        .updateHouseListingModel(HouseListingModel());
    Provider.of<ProviderData>(context, listen: false).resetPickedFiles();
    return true;
  }
}
