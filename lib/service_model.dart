// service_model.dart

class Service {
  final String id;
  final String serviceId;
  final String serviceName;
  final String description;
  final int cost;

  Service({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.description,
    required this.cost,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      description: json['description'],
      cost: json['cost'],
    );
  }

  String get serviceIdText {
    if (serviceId == "LSA_ONLINE") {
      return "Real Estate Notarization";
    } else if (serviceId == "LSA_OFFLINE") {
      return "Real Estate Offline Notarization";
    } else {
      return serviceId;
    }
  }
}
