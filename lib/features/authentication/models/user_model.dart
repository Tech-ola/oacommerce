import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  // Constructor for usermodel 
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email, 
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Helper function to get full name 
  String get fullName => '$firstName $lastName';

  // Helper to get phone nmber 
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // Static function to split full name 
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Static function to genrate ausernmae from full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  // Static function to create an empty user model 
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', username: '', email: '', phoneNumber: '', profilePicture: '');

  // Convert model to JSON structure 
  Map<String, dynamic> toJson() {
    return {
      'FirstName' : firstName,
      'LastName' : lastName,
      'Username' : username,
      'Email' : email,
      'PhoneNumber' : phoneNumber,
      'ProfilePicture' : profilePicture,
    };
  }

// Factory method to create usermodel 
factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data();
  if (data != null) {
    return UserModel(
      id: document.id, 
      firstName: data['FirstName'] ?? '', 
      lastName: data['LastName'] ?? '', 
      username: data['Username'] ?? '', 
      email: data['Email'] ?? '', 
      phoneNumber: data['PhoneNumber'] ?? '', 
      profilePicture: data['ProfilePicture'] ?? '',
    );
  } else {
    throw Exception("Document snapshot is null!");
  }
}



}