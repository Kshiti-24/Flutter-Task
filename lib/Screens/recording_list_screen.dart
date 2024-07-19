import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speechtotext/Constants/colors.dart';
import 'package:speechtotext/Widgets/card.dart';
import 'playback_screen.dart';

class RecordingsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recordings',
          style: TextStyle(
              color: AppColors.background, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('speeches')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return RecordingCard(
                text: doc['text'],
                timestamp:
                    doc['timestamp']?.toDate()?.toString() ?? "No TimeStamp",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaybackScreen(
                        text: doc['text'],
                        docId: doc.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
