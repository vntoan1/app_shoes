import 'package:cloud_firestore/cloud_firestore.dart';
// lưu trữ và truy xuất dữ liệu từ cơ sở dữ liệu Firestore
import 'package:sport_shoes_store/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  final String email;
  String firstName;
  final String username;
  String phoneNumber;
  String lastName;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.username,
      required this.lastName,
      required this.phoneNumber,
      required this.profilePicture});
  // Lớp UserModel đại diện cho dữ liệu người dùng và cung cấp các phương thức để thao tác với dữ liệu này
  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => Formatter.formatPhoneNumber(phoneNumber);
  static List<String> nameParts(fullName) => fullName.split(" ");
  // Tách tên đầy đủ thành danh sách các từ, ở trong phần profile
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toUpperCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toUpperCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: '',
      email: '',
      firstName: '',
      username: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '');

  /// Chuyển đổi mô hình sang cấu trúc JSON để lưu trữ dữ liệu trong Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }
// Chuyển đổi đối tượng UserModel thành định dạng JSON để lưu trữ trong Firestore hoặc bất kỳ nơi nào cần dữ liệu JSON. Các trường trong đối tượng được ánh xạ thành các key tương ứng.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    return UserModel.empty();
  }
}
