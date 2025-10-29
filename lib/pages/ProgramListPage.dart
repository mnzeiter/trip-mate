//صفحة عرض جميع البرامج السياحية المتاحة في فترة زمنية محددة:
//======================
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:provider/provider.dart';
//import '../my_model.dart';

class ProgramListPage extends StatefulWidget {
  @override
  _ProgramListPageState createState() => _ProgramListPageState();
}

class _ProgramListPageState extends State<ProgramListPage> {
  List<Map<String, dynamic>> programs = [];

  @override
  void initState() {
    super.initState();
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    final response = await http.get(Uri.parse('https://your-backend-api.com/programs'));
    setState(() {
      programs = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tourism Programs')),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return ListTile(
            title: Text(program['name']),
            subtitle: Text(program['description']),
          );
        },
      ),
    );
  }
}
