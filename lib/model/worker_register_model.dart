class WorkerRegisterModel{
  late String status;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;
  String? idNumber;
  Location? location;
  late String message;
  WorkerRegisterModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    phone = json['phone'];
    message =json['message'];
    status = json['status'];
    idNumber = json['IDNumber'];
    location = json['location'] != null  ?new Location.fromJson(json['location']): null;
  }
}

class Location {
  List<double>? coordinates;

  Location({this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
  }
}