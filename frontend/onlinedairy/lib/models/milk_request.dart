// import 'package:onlinedairy/models/PUser.dart';
//
// class MilkRequest {
//   int? _id;
//   DateTime? _date;
//   double? _liters;
//   double? _fatPercentage;
//   double? _proteinPercentage;
//   int? _waterContent;
//   int? _pricePerLiter;
//   String? _totalPrice;
//   String? _paymentMethod;
//   PUser? _user;
//   String? _employee;
//
//   MilkRequest({
//     int? id,
//     DateTime? date,
//     double? liters,
//     double? fatPercentage,
//     double? proteinPercentage,
//     int? waterContent,
//     int? pricePerLiter,
//     String? totalPrice,
//     String? paymentMethod,
//     PUser? user,
//     String? employee,
//   })  : _id = id,
//         _date = date,
//         _liters = liters,
//         _fatPercentage = fatPercentage,
//         _proteinPercentage = proteinPercentage,
//         _waterContent = waterContent,
//         _pricePerLiter = pricePerLiter,
//         _totalPrice = totalPrice,
//         _paymentMethod = paymentMethod,
//         _user = user,
//         _employee = employee;
//
//   int? get id => _id;
//   set id(int? value) => _id = value;
//
//   DateTime? get date => _date;
//   set date(DateTime? value) => _date = value;
//
//   double? get liters => _liters;
//   set liters(double? value) => _liters = value;
//
//   double? get fatPercentage => _fatPercentage;
//   set fatPercentage(double? value) => _fatPercentage = value;
//
//   double? get proteinPercentage => _proteinPercentage;
//   set proteinPercentage(double? value) => _proteinPercentage = value;
//
//   int? get waterContent => _waterContent;
//   set waterContent(int? value) => _waterContent = value;
//
//   int? get pricePerLiter => _pricePerLiter;
//   set pricePerLiter(int? value) => _pricePerLiter = value;
//
//   String? get totalPrice => _totalPrice;
//   set totalPrice(String? value) => _totalPrice = value;
//
//   String? get paymentMethod => _paymentMethod;
//   set paymentMethod(String? value) => _paymentMethod = value;
//
//   PUser? get user => _user;
//   set user(PUser? value) => _user = value;
//
//   String? get employee => _employee;
//   set employee(String? value) => _employee = value;
//
//   /// **Convert JSON to MilkRequest Object**
//   factory MilkRequest.fromJson(Map<String, dynamic> json) {
//     return MilkRequest(
//       id: json['id'],
//       date: json['date'] != null ? DateTime.parse(json['date']) : null, // Convert String to DateTime
//       liters: (json['liters'] as num?)?.toDouble(),
//       fatPercentage: (json['fatPercentage'] as num?)?.toDouble(),
//       proteinPercentage: (json['proteinPercentage'] as num?)?.toDouble(),
//       waterContent: json['waterContent'],
//       pricePerLiter: json['pricePerLiter'],
//       totalPrice: json['totalPrice'],
//       paymentMethod: json['paymentMethod'],
//       user: json['user'] != null ? PUser.fromJson(json['user']) : null,
//       employee: json['employee'],
//     );
//   }
//
//   /// **Convert MilkRequest Object to JSON**
//   Map<String, dynamic> toJson() {
//     return {
//       'id': _id,
//       'date': _date?.toIso8601String(), // Convert DateTime to String
//       'liters': _liters,
//       'fatPercentage': _fatPercentage,
//       'proteinPercentage': _proteinPercentage,
//       'waterContent': _waterContent,
//       'pricePerLiter': _pricePerLiter,
//       'totalPrice': _totalPrice,
//       'paymentMethod': _paymentMethod,
//       'user': _user?.toJson(),
//       'employee': _employee,
//     };
//   }
// }
import 'package:onlinedairy/models/PUser.dart';

class MilkRequest {
  int? _id;
  DateTime? _date;
  double? _liters;
  double? _fatPercentage;
  double? _proteinPercentage;
  double? _waterContent;  // Changed from int?
  double? _pricePerLiter; // Changed from int?
  double? _totalPrice;    // Changed from String?
  String? _paymentMethod;
  PUser? _user;
  String? _employee;

  MilkRequest({
    int? id,
    DateTime? date,
    double? liters,
    double? fatPercentage,
    double? proteinPercentage,
    double? waterContent,
    double? pricePerLiter,
    double? totalPrice,
    String? paymentMethod,
    PUser? user,
    String? employee,
  })  : _id = id,
        _date = date,
        _liters = liters,
        _fatPercentage = fatPercentage,
        _proteinPercentage = proteinPercentage,
        _waterContent = waterContent,
        _pricePerLiter = pricePerLiter,
        _totalPrice = totalPrice,
        _paymentMethod = paymentMethod,
        _user = user,
        _employee = employee;

  // Getters/Setters (Updated types)
  int? get id => _id;
  set id(int? value) => _id = value;

  DateTime? get date => _date;
  set date(DateTime? value) => _date = value;

  double? get liters => _liters;
  set liters(double? value) => _liters = value;

  double? get fatPercentage => _fatPercentage;
  set fatPercentage(double? value) => _fatPercentage = value;

  double? get proteinPercentage => _proteinPercentage;
  set proteinPercentage(double? value) => _proteinPercentage = value;

  double? get waterContent => _waterContent;
  set waterContent(double? value) => _waterContent = value;

  double? get pricePerLiter => _pricePerLiter;
  set pricePerLiter(double? value) => _pricePerLiter = value;

  double? get totalPrice => _totalPrice;
  set totalPrice(double? value) => _totalPrice = value;

  String? get paymentMethod => _paymentMethod;
  set paymentMethod(String? value) => _paymentMethod = value;

  PUser? get user => _user;
  set user(PUser? value) => _user = value;

  String? get employee => _employee;
  set employee(String? value) => _employee = value;

  factory MilkRequest.fromJson(Map<String, dynamic> json) {
    return MilkRequest(
      id: json['id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      liters: (json['liters'] as num?)?.toDouble(),
      fatPercentage: (json['fatPercentage'] as num?)?.toDouble(),
      proteinPercentage: (json['proteinPercentage'] as num?)?.toDouble(),
      waterContent: (json['waterContent'] as num?)?.toDouble(),
      pricePerLiter: (json['pricePerLiter'] as num?)?.toDouble(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'],
      user: json['farmer'] != null ? PUser.fromJson(json['farmer']) : null,
      employee: json['employee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'date': _date?.toIso8601String(),
      'liters': _liters,
      'fatPercentage': _fatPercentage,
      'proteinPercentage': _proteinPercentage,
      'waterContent': _waterContent,
      'pricePerLiter': _pricePerLiter,
      'totalPrice': _totalPrice,
      'paymentMethod': _paymentMethod,
      'farmer': _user?.toJson(), // Changed from 'user' to 'farmer'
      'employee': _employee,
    };
  }

  @override
  String toString() {
    return 'MilkRequest{_id: $_id,\n _date: $_date,\n _liters: $_liters,\n _fatPercentage: $_fatPercentage,\n _proteinPercentage: $_proteinPercentage,\n _waterContent: $_waterContent,\n _pricePerLiter: $_pricePerLiter,\n _totalPrice: $_totalPrice,\n _paymentMethod: $_paymentMethod,\n _user: $_user,\n _employee: $_employee}';
  }
}