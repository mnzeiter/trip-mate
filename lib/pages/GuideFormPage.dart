  import 'package:e_tourism/pages/GenericFormPage.dart';
  import 'package:flutter/material.dart';

  class GuideFormPage extends StatelessWidget {
    final Map<String, dynamic> initialValues;
    final Function(Map<String, dynamic>) onSubmit;

    GuideFormPage({this.initialValues = const {}, required this.onSubmit});

    @override
    Widget build(BuildContext context) {
      return GenericFormPage(
        title: 'Guide Form',
        fields: ['id', 'first_name', 'last_name', 'address', 'mobile', 'description'],
        initialValues: initialValues,
        onSubmit: onSubmit,
      );
    }
  }