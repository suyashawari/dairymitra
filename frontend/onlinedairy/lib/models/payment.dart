class Payment {
  String? _date;
  String? _paymentMode;
  int? _money;

  Payment({String? date, String? paymentMode, int? money}) {
    if (date != null) {
      this._date = date;
    }
    if (paymentMode != null) {
      this._paymentMode = paymentMode;
    }
    if (money != null) {
      this._money = money;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get paymentMode => _paymentMode;
  set paymentMode(String? paymentMode) => _paymentMode = paymentMode;
  int? get money => _money;
  set money(int? money) => _money = money;

  Payment.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _paymentMode = json['paymentMode'];
    _money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this._date;
    data['paymentMode'] = this._paymentMode;
    data['money'] = this._money;
    return data;
  }
}
