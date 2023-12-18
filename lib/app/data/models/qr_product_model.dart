class QrProductModel {
  final int? id;
  final String? qrCode;
  final String? name;
  final String? price;
  final String? quantity;
  final String? description;
  QrProductModel(
      {this.qrCode,
      this.id,
      this.name,
      this.price,
      this.quantity,
      this.description});
  factory QrProductModel.fromMap(Map<String, dynamic> json) {
    return QrProductModel(
      id: json['id'],
      qrCode: json['qrCode'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qrCode'] = qrCode;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['description'] = description;
    return data;
  }
}
