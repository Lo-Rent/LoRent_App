class ServiceProviderUser {
  String name;
  String email;
  String phone;
  String identityProof;
  String identityNumber;
  //TODO identity proof upload
  List<Company> companies;

  ServiceProviderUser({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.identityProof = '',
    this.identityNumber = '',
    this.companies,
  });
}

class Company {
  String companyName;
  String gstin;
  String cin;
  String addressL1;
  String city;
  String state;
  String country;
  String pinCode;

  Map<String, dynamic> map;

  Company({
    this.companyName = '',
    this.gstin = '',
    this.cin = '',
    this.addressL1 = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.pinCode = '',
  });

  void toMap() {
    map = {
      'companyName': companyName,
      'GSTIN': gstin,
      'CIN': cin,
      'addressL1': addressL1,
      'city': city,
      'state': state,
      'country': country,
      'pinCode': pinCode,
    };
  }

  void fromMap() {
    this.companyName = map['companyName'];
    this.gstin = map['GSTIN'];
    this.cin = map['CIN'];
    this.addressL1 = map['addressL1'];
    this.city = map['city'];
    this.state = map['state'];
    this.country = map['country'];
    this.pinCode = map['pinCode'];
  }
}
