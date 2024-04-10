class Property {
  final String? id;
  final String propertyId;
  final String type;
  final String ownerId;
  double? distance;

  Property({
    this.id = '',
    this.distance,
    required this.propertyId,
    required this.type,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id!.isEmpty ? '' : "",
      'distance': distance,
      'propertyId': propertyId,
      'type': type,
      'ownerId': ownerId,
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'],
      // ignore: prefer_null_aware_operators
      distance: json['distance'] != null ? json['distance'].toDouble() : null,
      propertyId: json['propertyId'],
      type: json['type'],
      ownerId: json['ownerId'],
    );
  }
}
