import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/main_drawer.dart';
import 'destination_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Découvrir le Monde'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const MainDrawer(), // Le menu latéral fonctionnel
      body: Container(
        color: Colors.grey[100], // "bg-gray-100"
        child: ListView.builder(
          padding: const EdgeInsets.all(16), // "p-4"
          itemCount: mockDestinations.length,
          itemBuilder: (ctx, index) {
            final destination = mockDestinations[index];
            return Card(
              elevation: 4, // "shadow-md"
              margin: const EdgeInsets.only(bottom: 20), // "mb-5"
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // "rounded-xl"
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DestinationDetailScreen.routeName,
                    arguments: destination,
                  );
                },
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        destination.imageUrl,
                        height: 200, // "h-48"
                        width: double.infinity, // "w-full"
                        fit: BoxFit.cover, // "object-cover"
                        errorBuilder: (ctx, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.image_not_supported)),
                        ),
                      ),
                    ),
                    // Contenu Textuel
                    Padding(
                      padding: const EdgeInsets.all(16), // "p-4"
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                destination.title,
                                style: const TextStyle(
                                  fontSize: 20, // "text-xl"
                                  fontWeight: FontWeight.bold, // "font-bold"
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${destination.rating} ★',
                                  style: TextStyle(
                                    color: Colors.teal.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                destination.location,
                                style: const TextStyle(color: Colors.grey), // "text-gray-500"
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${destination.price.toStringAsFixed(0)} € / nuit',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                ),
                              ),
                              const Text(
                                'Voir détails',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
