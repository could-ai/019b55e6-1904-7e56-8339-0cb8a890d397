import 'package:flutter/material.dart';
import '../models/destination.dart';

class DestinationDetailScreen extends StatelessWidget {
  static const routeName = '/destination-detail';

  const DestinationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération des arguments passés via la navigation
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;

    return Scaffold(
      appBar: AppBar(
        title: Text(destination.title),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Hero
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                destination.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Titre et Prix
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      destination.location,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    '${destination.price.toStringAsFixed(0)} €',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 5),
                  Text(
                    destination.rating.toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Description
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Text(
                destination.description,
                textAlign: TextAlign.justify, // Style "text-justify"
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5, // Line height
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Bouton de réservation
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Réservation simulée avec succès !')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // "rounded-lg"
                    ),
                  ),
                  child: const Text('Réserver maintenant', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
