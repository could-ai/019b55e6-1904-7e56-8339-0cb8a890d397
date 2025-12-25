import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../services/api_service.dart';
import '../widgets/main_drawer.dart';
import 'destination_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Destination>> _destinationsFuture;

  @override
  void initState() {
    super.initState();
    _destinationsFuture = _apiService.getDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Découvrir le Monde'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const MainDrawer(),
      body: Container(
        color: Colors.grey[100],
        child: FutureBuilder<List<Destination>>(
          future: _destinationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.teal));
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucune destination trouvée.'));
            }

            final destinations = snapshot.data!;

            // LayoutBuilder pour rendre le site Responsive (Web & Mobile)
            return LayoutBuilder(
              builder: (context, constraints) {
                // Si l'écran est large (Web/Tablette), on utilise une Grille
                if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(24),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 1100 ? 3 : 2,
                      childAspectRatio: 0.85, // Ratio hauteur/largeur des cartes
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                    ),
                    itemCount: destinations.length,
                    itemBuilder: (ctx, index) => _buildDestinationCard(context, destinations[index]),
                  );
                }
                // Sinon (Mobile), on utilise une Liste
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: destinations.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildDestinationCard(context, destinations[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDestinationCard(BuildContext context, Destination destination) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias, // Assure que l'image respecte les bords arrondis
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            DestinationDetailScreen.routeName,
            arguments: destination,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Image.network(
                destination.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            // Contenu
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                destination.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${destination.rating} ★',
                                style: TextStyle(
                                  color: Colors.teal.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                destination.location,
                                style: const TextStyle(color: Colors.grey, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${destination.price.toStringAsFixed(0)} €',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const Text(
                          'Voir',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
