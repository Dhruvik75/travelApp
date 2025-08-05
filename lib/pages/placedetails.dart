import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlaceDetailPage extends StatelessWidget {
  final String placeId;

  PlaceDetailPage({required this.placeId});

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection('places').doc(placeId);

    return Scaffold(
      appBar: AppBar(title: Text('Place Details')),
      body: FutureBuilder<DocumentSnapshot>(
        future: docRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final data = snapshot.data!;
          final likes = data['likes'] ?? 0;
          final image = data['image'];
          final comments = List.from(data['comments'] ?? []);

          return Column(
            children: [
              Image.network(image),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Likes: $likes'),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () async {
                      await docRef.update({'likes': likes + 1});
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(comments[i]['text']),
                    subtitle: Text('by ${comments[i]['user']}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
