import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';

class FireStoreNetworkClient implements INetworkClient {
  FireStoreNetworkClient({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  }) async {
    CollectionReference collection = _fireStore.collection(endpoint);

    Query query = collection;

    queryParameters?.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        value.forEach((operator, operatorValue) {
          switch (operator) {
            case 'isEqualTo':
              query = query.where(key, isEqualTo: operatorValue);
              break;
            case 'isGreaterThan':
              query = query.where(key, isGreaterThan: operatorValue);
              break;
            case 'isLessThan':
              query = query.where(key, isLessThan: operatorValue);
              break;
            case 'isGreaterThanOrEqualTo':
              query = query.where(key, isGreaterThanOrEqualTo: operatorValue);
              break;
            case 'isLessThanOrEqualTo':
              query = query.where(key, isLessThanOrEqualTo: operatorValue);
              break;
            case 'arrayContains':
              query = query.where(key, arrayContains: operatorValue);
              break;
            case 'in':
              query = query.where(key, whereIn: operatorValue);
              break;
            default:
              throw ArgumentError('Unsupported operator: $operator');
          }
        });
      } else {
        query = query.where(key, isEqualTo: value);
      }
    });

    QuerySnapshot snapshot = await query.get();
    return snapshot.docs.map(
      (doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          ...data,
          'id': doc.id,
        };
      },
    ).toList();
  }

  @override
  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  }) async {
    CollectionReference collection = _fireStore.collection(endpoint);
    DocumentReference docRef =
        await collection.add(data as Map<String, dynamic>);
    return {'id': docRef.id};
  }

  @override
  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  }) async {
    if (additionalParam is! String) {
      throw ArgumentError(
          'Document ID must be provided in additionalParam for PUT.');
    }
    DocumentReference docRef =
        _fireStore.collection(endpoint).doc(additionalParam);
    await docRef.set(data as Map<String, dynamic>);
    return {'id': docRef.id};
  }

  @override
  Future<dynamic> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  }) async {
    if (additionalParam is! String) {
      throw ArgumentError(
          'Document ID must be provided in additionalParam for DELETE.');
    }
    await _fireStore.collection(endpoint).doc(additionalParam).delete();
    return {'deleted': true};
  }

  @override
  Future<dynamic> patch({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    dynamic additionalParam,
  }) async {
    if (additionalParam is! String) {
      throw ArgumentError(
          'Document ID must be provided in additionalParam for PATCH.');
    }
    DocumentReference docRef =
        _fireStore.collection(endpoint).doc(additionalParam);
    await docRef.update(data as Map<String, dynamic>);
    return {'updated': true};
  }
}
