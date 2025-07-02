import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/consultation.dart';
import '../viewmodels/consultation_viewmodel.dart';

// Group Members 
// K Kekane, 220043566
// TA Mokgothu, 222029599
// TF Mokone, 222014234
// ST Hadebe, 222078272
// K Taaibosch, 222001440
// TP Montsho, 222034315


class ConsultationDetailsScreen extends StatelessWidget {
  final Consultation consultation;

  const ConsultationDetailsScreen({super.key, required this.consultation});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this consultation?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ConsultationViewModel>(
                  context,
                  listen: false,
                ).deleteConsultation(consultation);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Consultation deleted!")),
                );
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consultation Details"),
      backgroundColor: Color.fromARGB(255, 51, 30, 145),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📅 Date: ${consultation.date}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "⏰ Time: ${consultation.time}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "📝 Description: ${consultation.description}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "📌 Topic: ${consultation.topic}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmDelete(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Delete Consultation"),
            ),
          ],
        ),
      ),
    );
  }
}
