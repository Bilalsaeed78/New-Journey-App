class Property {
  final String propertyId;
  final String propertyType;
  final String ownerId;

  Property({
    required this.propertyId,
    required this.propertyType,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'propertyType': propertyType,
      'owner': ownerId,
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyId: json['_id'],
      propertyType: json['propertyType'],
      ownerId: json['owner'],
    );
  }
}
