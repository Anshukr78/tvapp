
class AddressModel{
  // String id;
  String first_name;
  String last_name;
  String phone_number;
  String city;
  String country;
  String pincode;
  String lat;
  String long;

  AddressModel(
      {required this.city,
      required this.country,
      required this.first_name,
      required this.last_name,
      required this.lat,
      required this.long,
      required this.phone_number,
      required this.pincode});

}