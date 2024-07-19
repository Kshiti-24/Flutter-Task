import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class APIs{

  static Future<void> saveToFirebase(String text) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = path.join(tempDir.path, 'speech_recording.wav');
    final File audioFile = File(filePath);
    final docRef = await FirebaseFirestore.instance.collection('speeches').add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('audio_files')
          .child('${docRef.id}.wav');
      await storageRef.putFile(audioFile);
      print('Audio file uploaded successfully');
    } catch (e) {
      print('Error uploading audio file: $e');
    }
  }
}