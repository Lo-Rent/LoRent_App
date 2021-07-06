import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/models/owner_or_tenant_user.dart';
import 'package:lo_rent/models/service_provider_user.dart';
import 'package:lo_rent/modules/bookings/bookings_screen.dart';
import 'package:lo_rent/modules/chats/chats_screen.dart';
import 'package:lo_rent/modules/home/home_screen.dart';
import 'package:lo_rent/modules/services_listing/services_listing_screen.dart';
import 'package:lo_rent/utilities/routes.dart';

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
    ownerOrTenantUser.name = ds.data()['name'];
    ownerOrTenantUser.email = ds.data()['email'];
    ownerOrTenantUser.phone = ds.data()['phone'];
    ownerOrTenantUser.identityProof = ds.data()['identityProof'];
    ownerOrTenantUser.identityNumber = ds.data()['identityNumber'];
    notifyListeners();

    idP = ds.data()['identityProof'];
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
    serviceProviderUser.name = ds.data()['name'];
    serviceProviderUser.email = ds.data()['email'];
    serviceProviderUser.phone = ds.data()['phone'];
    serviceProviderUser.identityProof = ds.data()['identityProof'];
    serviceProviderUser.identityNumber = ds.data()['identityNumber'];

    for (Map<String, dynamic> comp in ds.data()['companies']) {
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
}
