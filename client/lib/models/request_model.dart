class RequestModel {
  String? id;
  String ownerId;
  String propertyId;
  String guestId;
  String status;

  RequestModel({
    this.id,
    required this.ownerId,
    required this.propertyId,
    required this.guestId,
    required this.status,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json['_id'],
        ownerId: json['ownerId'],
        propertyId: json['propertyId'],
        guestId: json['guestId'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id ?? '',
        'ownerId': ownerId,
        'propertyId': propertyId,
        'guestId': guestId,
        'status': status,
      };
}
