// صفحة تعرض تقرير عن عدد الجولات التي أجرتها كل حافلة بين تاريخين

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  List<Map<String, dynamic>> reportData = [];

  Future<void> generateReport() async {
    final startDate = startDateController.text;
    final endDate = endDateController.text;

    final response = await http.post(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tour/history'),
      body: jsonEncode({'startDate': startDate, 'endDate': endDate })
    );

    if (response.statusCode == 200) {
      setState(() {
         reportData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to generate report!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tour Report',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white60,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              Icons.bar_chart,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'Generate Tour Report',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: endDateController,
              decoration: InputDecoration(
                labelText: 'End Date',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateReport,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Generate Report',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: reportData.isEmpty
                  ? Center(
                child: Text(
                  'No data available for the selected dates.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: reportData.length,
                itemBuilder: (context, index) {
                  final report = reportData[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bus,
                        color: Colors.blue.shade900,
                        size: 40,
                      ),
                      title: Text(
                        'Driver name: ${report['driverName']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      subtitle: Text(
                        'Tours: ${report['number']}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
