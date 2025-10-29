import 'package:flutter/material.dart';

class GenericFormPage extends StatefulWidget {
  final String title;
  final List<String> fields;
  final Map<String, dynamic> initialValues;
  final Function(Map<String, dynamic>) onSubmit;

  GenericFormPage({
    required this.title,
    required this.fields,
    required this.initialValues,
    required this.onSubmit,
  });

  @override
  _GenericFormPageState createState() => _GenericFormPageState();
}

class _GenericFormPageState extends State<GenericFormPage> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = Map.fromIterable(
      widget.fields,
      key: (field) => field,
      value: (field) => TextEditingController(text: widget.initialValues[field]?.toString() ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ...widget.fields.map((field) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: controllers[field],
                decoration: InputDecoration(
                  labelText: field,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $field';
                  }
                  return null;
                },
              ),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final data = Map.fromIterable(
                    widget.fields,
                    key: (field) => field,
                    value: (field) => controllers[field]!.text,
                  );
                  widget.onSubmit;
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}