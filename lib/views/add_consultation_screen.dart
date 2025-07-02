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


class AddConsultationScreen extends StatefulWidget {
  const AddConsultationScreen({super.key});

  @override
  _AddConsultationScreenState createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController topicController = TextEditingController();

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    setState(() {
      dateController.text =
          "${pickedDate!.year}-${pickedDate.month}-${pickedDate.day}";
    });
    }

  // Function to show Time Picker
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(
          context,
        ); // Formats time based on device locale
      });
    }
  }

  void _saveConsultation(BuildContext context) {
    if (dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        topicController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final newConsultation = Consultation(
      date: dateController.text,
      time: timeController.text,
      description: descriptionController.text,
      topic: topicController.text,
    );

    Provider.of<ConsultationViewModel>(
      context,
      listen: false,
    ).addConsultation(newConsultation);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Consultation booked successfully!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Consultation"),
      backgroundColor: Colors.blueAccent,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker Field
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Select Date",
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true,
            ),
            SizedBox(height: 10),

            // Time Picker Field
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: "Select Time",
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () => _selectTime(context),
                ),
              ),
              readOnly: true,
            ),
            SizedBox(height: 10),

            // Other Input Fields
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 10),

            TextField(
              controller: topicController,
              decoration: InputDecoration(labelText: "Topic"),
            ),
            SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: () => _saveConsultation(context),
              child: Text("Save Consultation"),
            ),
          ],
        ),
      ),
    );
  }
}
