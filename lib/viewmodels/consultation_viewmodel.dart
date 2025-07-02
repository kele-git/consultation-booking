import 'package:flutter/material.dart';
import '../models/consultation.dart';

class ConsultationViewModel with ChangeNotifier {
  final List<Consultation> _consultations = [];

  List<Consultation> get consultations => _consultations;

  void addConsultation(Consultation consultation) {
    _consultations.add(consultation);
    notifyListeners();
  }

  void deleteConsultation(Consultation consultation) {
    _consultations.remove(consultation);
    notifyListeners();
  }
}
