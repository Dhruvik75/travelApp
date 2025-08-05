import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add user details
  Future<void> addUserDetails(
    Map<String, dynamic> userInfoMap,
    String id,
  ) async {
    try {
      await _firestore.collection("users").doc(id).set(userInfoMap);
    } catch (e) {
      throw Exception("Failed to add user details: $e");
    }
  }

  // Add post details and return post ID
  Future<String> addPostDetails(Map<String, dynamic> postInfoMap) async {
    try {
      DocumentReference docRef = await _firestore
          .collection("posts")
          .add(postInfoMap);
      return docRef.id;
    } catch (e) {
      throw Exception("Failed to add post details: $e");
    }
  }

  // Get user by email
  Future<QuerySnapshot> getUserByEmail(String email) async {
    try {
      return await _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get();
    } catch (e) {
      throw Exception("Failed to get user by email: $e");
    }
  }

  // Toggle like on post
  Future<void> toggleLike(String postId, String userId) async {
    try {
      DocumentReference postRef = _firestore.collection("posts").doc(postId);
      DocumentSnapshot snapshot = await postRef.get();

      List<dynamic> likes = snapshot.get('likes') ?? [];

      if (likes.contains(userId)) {
        await postRef.update({
          'likes': FieldValue.arrayRemove([userId]),
        });
      } else {
        await postRef.update({
          'likes': FieldValue.arrayUnion([userId]),
        });
      }
    } catch (e) {
      throw Exception("Failed to toggle like: $e");
    }
  }

  // Add a comment to a post
  Future<void> addComment(
    String postId,
    Map<String, dynamic> commentData,
  ) async {
    try {
      await _firestore
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .add(commentData);
    } catch (e) {
      throw Exception("Failed to add comment: $e");
    }
  }

  // Get all comments on a post
  Stream<QuerySnapshot> getComments(String postId) {
    try {
      return _firestore
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception("Failed to fetch comments: $e");
    }
  }

  // Get all posts
  Stream<QuerySnapshot> getAllPosts() {
    try {
      return _firestore
          .collection("posts")
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception("Failed to fetch posts: $e");
    }
  }
}
