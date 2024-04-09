class Property {
  final String? id;
  final String propertyId;
  final String type;
  final String ownerId;

  Property({
    this.id = '',
    required this.propertyId,
    required this.type,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id!.isEmpty ? '' : "",
      'propertyId': propertyId,
      'type': type,
      'ownerId': ownerId,
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'],
      propertyId: json['propertyId'],
      type: json['type'],
      ownerId: json['ownerId'],
    );
  }
}
