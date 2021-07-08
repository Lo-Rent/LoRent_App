import 'dart:io';

import 'package:file_picker/file_picker.dart';

class HouseListingModel {
  HouseListingModel({
    this.ownerUid,
    this.houseName,
    this.description,
    this.houseType,
    this.houseNo,
    this.addressLine1,
    this.addressLine2,
    this.locality,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.instructions,
    this.rentFees,
    this.availableForRental,
    this.builtUpArea,
    this.bhk,
    this.security,
    this.carpetArea,
    this.ageOfProperty,
    this.furnishing,
    this.floorNumber,
    this.parking,
    this.gallery,
  });

  String ownerUid;
  String houseName;
  String description;
  String houseType;
  String houseNo;
  String addressLine1;
  String addressLine2;
  String locality;
  String city;
  String state;
  String country;
  String pinCode;
  String instructions;
  String rentFees;
  String availableForRental;
  String builtUpArea;
  String bhk;
  String security;
  String carpetArea;
  String ageOfProperty;
  String furnishing;
  String floorNumber;
  String parking;
  Map<String, List<String>> gallery;

  Map<String, dynamic> map;

  void toMap() {
    map = {
      'houseName': houseName,
      'description': description,
      'houseType': houseType,
      'houseNo': houseNo,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'locality': locality,
      'city': city,
      'state': state,
      'country': country,
      'pinCode': pinCode,
      'instructions': instructions,
      'rentFees': rentFees,
      'availableForRental': availableForRental,
      'builtUpArea': builtUpArea,
      'bhk': bhk,
      'security': security,
      'carpetArea': carpetArea,
      'ageOfProperty': ageOfProperty,
      'furnishing': furnishing,
      'floorNumber': floorNumber,
      'parking': parking,
      'gallery': gallery,
    };
  }

  void fromMap() {}
}
