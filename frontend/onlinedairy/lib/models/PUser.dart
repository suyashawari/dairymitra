class PUser {
  int? _id;
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _password;  // Changed from _passward to _password
  String? _role;
  BankDetails? _bankDetails;

  PUser({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? password,  // Changed from passward to password
    String? role,
    BankDetails? bankDetails,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _address = address;
    _password = password;  // Changed from passward to password
    _role = role;
    _bankDetails = bankDetails;
  }

  @override
  String toString() {
    return 'PUser{_id: $_id, _name: $_name, _email: $_email, _phoneNumber: $_phoneNumber, _address: $_address, _password: $_password, _role: $_role, _bankDetails: $_bankDetails}';
  } // Getters and setters
  int? get id => _id;
  set id(int? id) => _id = id;

  String? get name => _name;
  set name(String? name) => _name = name;

  String? get email => _email;
  set email(String? email) => _email = email;

  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;

  String? get address => _address;
  set address(String? address) => _address = address;

  String? get password => _password;  // Changed from passward to password
  set password(String? password) => _password = password;  // Changed from passward to password

  String? get role => _role;
  set role(String? role) => _role = role;

  BankDetails? get bankDetails => _bankDetails;
  set bankDetails(BankDetails? bankDetails) => _bankDetails = bankDetails;

  // JSON serialization
  factory PUser.fromJson(Map<String, dynamic> json) {
    return PUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      password: json['password'],  // Changed from passward to password
      role: json['role'],
      bankDetails: json['bankDetails'] != null
          ? BankDetails.fromJson(json['bankDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'phoneNumber': _phoneNumber,
      'address': _address,
      'password': _password,  // Changed from passward to password
      'role': _role,
      'bankDetails': _bankDetails?.toJson(),
    };
  }
}

class BankDetails {
  String? _accountHolder;
  String? _accountNumber;
  String? _ifscCode;

  BankDetails({
    String? accountHolder,
    String? accountNumber,
    String? ifscCode,
  }) {
    _accountHolder = accountHolder;
    _accountNumber = accountNumber;
    _ifscCode = ifscCode;
  }

  // Getters and setters
  String? get accountHolder => _accountHolder;
  set accountHolder(String? accountHolder) => _accountHolder = accountHolder;

  String? get accountNumber => _accountNumber;
  set accountNumber(String? accountNumber) => _accountNumber = accountNumber;

  String? get ifscCode => _ifscCode;
  set ifscCode(String? ifscCode) => _ifscCode = ifscCode;

  // JSON serialization
  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      accountHolder: json['accountHolder'],
      accountNumber: json['accountNumber'],
      ifscCode: json['ifscCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountHolder': _accountHolder,
      'accountNumber': _accountNumber,
      'ifscCode': _ifscCode,
    };
  }
}