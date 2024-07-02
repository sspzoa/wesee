import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService(this.client);

  Stream<AuthState> get onAuthStateChange => client.auth.onAuthStateChange;

  Future<AuthResponse> signInWithIdToken({
    required OAuthProvider provider,
    required String idToken,
    required String accessToken,
  }) {
    return client.auth.signInWithIdToken(
      provider: provider,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signInWithOAuth(String provider) {
    return client.auth.signInWithOAuth(OAuthProvider.values.firstWhere(
          (p) => p.toString().split('.').last.toLowerCase() == provider.toLowerCase(),
    ));
  }

  Future<List<Map<String, dynamic>>> getFeedItems() async {
    try {
      return await client
          .from('feed_items')
          .select()
          .order('created_at', ascending: false);
    } catch (error) {
      print('Error fetching feed items: $error');
      rethrow;
    }
  }

  Future<void> addFeedItem(String title, String content) async {
    try {
      final user = client.auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      await client.from('feed_items').insert({
        'title': title,
        'content': content,
        'author_id': user.id,
        'author_name': user.userMetadata?['full_name'],
      });
    } catch (error) {
      print('Error adding feed item: $error');
      rethrow;
    }
  }

  Future<void> deleteFeedItem(int itemId) async {
    try {
      await client.from('feed_items').delete().eq('id', itemId);
    } catch (error) {
      print('Error deleting feed item: $error');
      rethrow;
    }
  }

  User? getCurrentUser() => client.auth.currentUser;
}