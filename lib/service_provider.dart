import 'dart:developer';

import 'package:dio/dio.dart';

import 'service_model.dart';

class ServiceProvider {
  List<Service> services = [];
  final Dio dio = Dio();

  // Fetch services from API
  Future<void> fetchServices() async {
    const String url = "https://api.thenotary.app/customer/login";

    try {
      final response = await dio.post(
        url,
        data: {"email": "nandhakumar1411@gmail.com"},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        final data = response.data;

        log('Available Services: ${data['data']['availableServices']}');

        if (data['data'] != null && data['data']['availableServices'] != null) {
          final availableServices =
              data['data']['availableServices']['services'];

          if (availableServices != null) {
            services = (availableServices as List)
                .map((json) => Service.fromJson(json))
                .toList();
          } else {
            throw Exception("No 'services' data found in response.");
          }
        } else {
          throw Exception("Invalid response structure.");
        }
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching or parsing services: $e');
    }
  }

  List<Service> filterServices(String query) {
    return services.where((service) {
      final serviceName = service.serviceName.toLowerCase();
      final description = service.description.toLowerCase();
      final input = query.toLowerCase();
      return serviceName.contains(input) || description.contains(input);
    }).toList();
  }
}
