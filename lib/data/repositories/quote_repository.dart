import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_quote.dart';
import '../../core/constants/firestore_paths.dart';

class QuoteRepository {
  QuoteRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<UserQuote>> watchQuotes(String uid) => _firestore
      .collection(FirestorePaths.quotes(uid))
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => UserQuote.fromJson(d.data())).toList());

  Future<void> saveQuote(String uid, UserQuote quote) => _firestore
      .doc(FirestorePaths.quote(uid, quote.id))
      .set(quote.toJson());

  Future<void> deleteQuote(String uid, String quoteId) =>
      _firestore.doc(FirestorePaths.quote(uid, quoteId)).delete();

  Future<void> updateQuote(String uid, UserQuote quote) => _firestore
      .doc(FirestorePaths.quote(uid, quote.id))
      .update(quote.toJson());
}
