import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/models/house_listing_model.dart';
import 'package:lo_rent/models/owner_or_tenant_user.dart';
import 'package:lo_rent/models/service_provider_user.dart';
import 'package:lo_rent/modules/bookings/bookings_screen.dart';
import 'package:lo_rent/modules/chats/chats_screen.dart';
import 'package:lo_rent/modules/home/home_screen.dart';
import 'package:lo_rent/modules/services_listing/services_listing_screen.dart';
import 'package:lo_rent/utilities/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';

const List<String> availableRoles = [
  "Owner",
  "Tenant",
  "Service Provider",
];

class ProviderData extends ChangeNotifier {
  User _firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Show Spinner:
  bool showSpinner = false;
  revertShowSpinner() {
    showSpinner = !showSpinner;
    notifyListeners();
  }

  // Current Role:
  String currentUserRole = '';

  saveCurrentUserRole(String role) {
    currentUserRole = role;
    notifyListeners();
  }

  // Owner Or Tenant User:
  OwnerOrTenantUser ownerOrTenantUser = OwnerOrTenantUser();
  String idP = '';

  getOwnerOrTenantUser() async {
    DocumentSnapshot ds = await _firestore
        .collection(currentUserRole)
        .doc(_firebaseUser.uid)
        .get();
    ownerOrTenantUser.name = ds.get('name');
    ownerOrTenantUser.email = ds.get('email');
    ownerOrTenantUser.phone = ds.get('phone');
    ownerOrTenantUser.identityProof = ds.get('identityProof');
    ownerOrTenantUser.identityNumber = ds.get('identityNumber');
    notifyListeners();

    idP = ds.get('identityProof');
  }

  setTempIdProof(String proof) {
    idP = proof == null ? ownerOrTenantUser.identityProof : proof;
    notifyListeners();
  }

  saveOwnerOrTenantUser(OwnerOrTenantUser user) async {
    await _firestore.collection(currentUserRole).doc(_firebaseUser.uid).set({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'identityProof': user.identityProof,
      'identityNumber': user.identityNumber,
    });
    await getOwnerOrTenantUser();
  }

  // Service Provider User:
  ServiceProviderUser serviceProviderUser = ServiceProviderUser();
  ServiceProviderUser tempSPUser = ServiceProviderUser();
  int currentCompanyIndex = -1;

  getServiceProviderUser({bool setTemp}) async {
    DocumentSnapshot ds = await _firestore
        .collection(currentUserRole)
        .doc(_firebaseUser.uid)
        .get();
    serviceProviderUser.name = ds.get('name');
    serviceProviderUser.email = ds.get('email');
    serviceProviderUser.phone = ds.get('phone');
    serviceProviderUser.identityProof = ds.get('identityProof');
    serviceProviderUser.identityNumber = ds.get('identityNumber');

    for (Map<String, dynamic> comp in ds.get('companies')) {
      Company company = Company();
      company.map = comp;
      company.fromMap();

      if (serviceProviderUser.companies != null)
        serviceProviderUser.companies.add(company);
      else
        serviceProviderUser.companies = [company];
    }
    if (setTemp) setTempSPUserToDefault();
    notifyListeners();
  }

  setTempSPUserToDefault() {
    tempSPUser = serviceProviderUser;
    notifyListeners();
  }

  setTempSPUserIdP(String proof) {
    tempSPUser.identityProof = proof;
    notifyListeners();
  }

  setCompany(Company company) {
    if (tempSPUser.companies == null) {
      tempSPUser.companies = [company];
    } else {
      if (currentCompanyIndex == -1)
        tempSPUser.companies.add(company);
      else {
        tempSPUser.companies.removeAt(currentCompanyIndex);
        tempSPUser.companies.insert(currentCompanyIndex, company);
      }
    }
    notifyListeners();
  }

  deleteCompany(int index) {
    tempSPUser.companies.removeAt(index);
    notifyListeners();
  }

  setCurrentCompanyIndex(int index) {
    currentCompanyIndex = index;
    notifyListeners();
  }

  saveServiceProviderUser() async {
    List<Map<String, dynamic>> companiesMapsList = [];
    for (Company comp in tempSPUser.companies) {
      comp.toMap();
      companiesMapsList.add(comp.map);
    }

    await _firestore.collection(currentUserRole).doc(_firebaseUser.uid).set({
      'name': tempSPUser.name,
      'email': tempSPUser.email,
      'phone': tempSPUser.phone,
      'identityProof': tempSPUser.identityProof,
      'identityNumber': tempSPUser.identityNumber,
      'companies': companiesMapsList,
    });

    await getServiceProviderUser(setTemp: false);
  }

  // Root View:
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    BookingsScreen(),
    ServicesListingScreen(),
    ChatsScreen(),
  ];
  Widget currentPage = HomeScreen();

  getCurrentPage() {
    currentPage = pages[currentIndex];
    notifyListeners();
  }

  void changePageInRoot(int index) {
    currentIndex = index;
    getCurrentPage();
  }

  void changePageOutRoot(BuildContext context, int index) {
    currentIndex = index;
    Navigator.popUntil(context,
        (Route route) => (route.settings.name == RouteNames.SERVICE_PROFILE));
    getCurrentPage();
  }

  void changePage(BuildContext context, int index) {
    if (ModalRoute.of(context).settings.name == RouteNames.ROOT) {
      changePageInRoot(index);
    } else {
      changePageOutRoot(context, index);
    }
  }

  // House Listing:
  HouseListingModel houseListingModel = HouseListingModel();
  List<PlatformFile> pickedFiles = [];

  updateHouseListingModel(HouseListingModel model) {
    houseListingModel = model;
    notifyListeners();
  }

  setTempHouseType(String type) {
    houseListingModel.houseType =
        type == null ? houseListingModel.houseType : type;
    notifyListeners();
  }

  setAvailableForRental(String value) {
    houseListingModel.availableForRental = value;
    notifyListeners();
  }

  setBHK(String value) {
    houseListingModel.bhk = value;
    notifyListeners();
  }

  setAddress(Map<String, String> map) {
    houseListingModel.addressLine2 = map['street-address'];
    houseListingModel.locality = map['extended-address'];
    houseListingModel.city = map['locality'];
    houseListingModel.state = map['region'];
    houseListingModel.country = map['country-name'];
    houseListingModel.pinCode = map['postal-code'];
    notifyListeners();
  }

  addTOPickedFiles(FilePickerResult result) {
    for (PlatformFile pf in result.files) {
      pickedFiles.add(pf);
    }
    notifyListeners();
  }

  deleteFromPickedFiles(int index) {
    pickedFiles.removeAt(index);
    notifyListeners();
  }

  resetPickedFiles() {
    pickedFiles = [];
  }

  Future<bool> saveHouseListing() async {
    houseListingModel.ownerUid = _firebaseUser.uid;
    for (PlatformFile file in pickedFiles) {
      File fileToBeUploaded = File(file.path);
      // await fileToBeUploaded.writeAsBytes(
      //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

      print(fileToBeUploaded);
      String fileName = file.name;
      String fileExtension = file.extension;
      String storageSubFolder =
          (fileExtension == 'jpg' || fileExtension == 'png')
              ? 'images'
              : (fileExtension == 'mp4')
                  ? 'videos'
                  : 'documents';

      // Add file name to the gallery in HouseListingModel object
      houseListingModel.gallery = {'images': [], 'videos': [], 'documents': []};
      // houseListingModel.gallery[storageSubFolder].add(file);

      // try {
      //   TaskSnapshot taskSnapshot = await FirebaseStorage.instance
      //       .ref('HouseListingsFiles/$storageSubFolder/$fileName')
      //       .putData(bytes)
      //       .whenComplete(() => null);
      //   String urlDownload = await taskSnapshot.ref.getDownloadURL();
      //   print('UrlDownload: $urlDownload');
      //   houseListingModel.gallery[storageSubFolder].add(urlDownload);
      //
      //   houseListingModel.toMap();
      //
      //   String houseListingUid =
      //       '${houseListingModel.ownerUid}-${houseListingModel.houseNo}-${houseListingModel.houseName}';
      //   await _firestore
      //       .collection('HouseListings')
      //       .doc(houseListingUid)
      //       .set(houseListingModel.map);
      // } on FirebaseException catch (e) {
      //   print('FirebaseException caught: $e');
      //   return false;
      // }
    }
    return true;
  }
}
