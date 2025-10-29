import 'package:e_tourism/pages/GenericFormPage.dart';
import 'package:flutter/material.dart';

class DriverFormPage extends StatelessWidget {
  final Map<String, dynamic> initialValues;
  final Function(Map<String, dynamic>) onSubmit;

  DriverFormPage({this.initialValues = const {}, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return GenericFormPage(
      title: 'Driver Form',
      fields: ['id', 'first_name', 'last_name', 'plateNumber', 'description'],
      initialValues: initialValues,
      onSubmit: onSubmit,
    );
  }
}