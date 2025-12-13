import 'rest_auth_service.dart';
import 'rest_firestore_service.dart';

/// Instâncias SINGLETON usadas no app inteiro

final RestAuthService authRestService = RestAuthService();
final RestFirestoreService firestoreRestService = RestFirestoreService();
