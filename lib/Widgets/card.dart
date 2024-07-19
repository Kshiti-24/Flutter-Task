import 'package:flutter/material.dart';
import 'package:speechtotext/Constants/colors.dart';

class RecordingCard extends StatelessWidget {
  final String text;
  final String timestamp;
  final VoidCallback onTap;

  const RecordingCard({
    required this.text,
    required this.timestamp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        color: AppColors.containerBackground,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            timestamp,
            style: TextStyle(fontSize: 14),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
