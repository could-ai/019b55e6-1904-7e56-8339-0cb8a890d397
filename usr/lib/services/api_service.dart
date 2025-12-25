import '../models/destination.dart';
import '../data/mock_data.dart';

/// Ce service agit comme une interface entre le Frontend (Flutter) et le Backend.
/// Actuellement, il simule des appels API (comme si on appelait un serveur Node.js ou Python).
/// Plus tard, vous pourrez remplacer le contenu de ces méthodes par de vraies requêtes HTTP.
class ApiService {
  
  // Simule un appel GET /api/destinations
  Future<List<Destination>> getDestinations() async {
    // Simulation d'un délai réseau (comme un vrai serveur)
    await Future.delayed(const Duration(milliseconds: 800)); 
    return mockDestinations;
  }

  // Simule un appel GET /api/destinations/:id
  Future<Destination> getDestinationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockDestinations.firstWhere(
      (d) => d.id == id,
      orElse: () => throw Exception('Destination non trouvée'),
    );
  }

  // Simule un appel POST /api/bookings
  Future<bool> bookDestination(String destinationId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Ici on connecterait le backend Python/Node pour enregistrer la réservation
    return true; 
  }
}
