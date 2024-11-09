// services_screen.dart

import 'package:flutter/material.dart';

import 'service_model.dart';
import 'service_provider.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ServiceProvider serviceProvider = ServiceProvider();
  List<Service> filteredServices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndDisplayServices();
  }

  // Fetch and display services
  Future<void> fetchAndDisplayServices() async {
    await serviceProvider.fetchServices();
    setState(() {
      filteredServices = serviceProvider.services;
      isLoading = false;
    });
  }

  // Update filtered services based on search input
  void onSearchChanged(String query) {
    setState(() {
      filteredServices = serviceProvider.filterServices(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Available Services",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      labelText: 'Search services...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return Card(
                        child: ListTile(
                          tileColor: Colors.green[200],
                          title: Text(service.serviceName),
                          subtitle: Text(service.serviceIdText),
                          trailing: Text('Cost: \$${service.cost}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
