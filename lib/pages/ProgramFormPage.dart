import 'package:e_tourism/pages/GenericFormPage.dart';
import 'package:flutter/material.dart';

class ProgramFormPage extends StatelessWidget {
  final Map<String, dynamic> initialValues;
  final Function(Map<String, dynamic>) onSubmit;

  ProgramFormPage({this.initialValues = const {}, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return GenericFormPage(
      title: 'Program Form',
      fields: ['id', 'type', 'name', 'description'],
      initialValues: initialValues,
      onSubmit: onSubmit,
    );
  }
}