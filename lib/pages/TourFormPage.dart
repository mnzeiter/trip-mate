import 'package:e_tourism/pages/GenericFormPage.dart';
import 'package:flutter/material.dart';

class TourFormPage extends StatelessWidget {
  final Map<String, dynamic> initialValues;
  final Function(Map<String, dynamic>) onSubmit;
  final List<Map<String, dynamic>> guides;
  final List<Map<String, dynamic>> drivers;
  final List<Map<String, dynamic>> programs;

  TourFormPage({
    this.initialValues = const {},
    required this.onSubmit,
    required this.guides,
    required this.drivers,
    required this.programs,
  });

  @override
  Widget build(BuildContext context) {
    return GenericFormPage(
      title: 'Tour Form',
      fields: [
     'guide_id','driver_id','program_id','price','number','startDate','endDate'
     
      ],
      initialValues: initialValues,
      onSubmit: onSubmit,
    );
  }
}
