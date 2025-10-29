// واجهة إدارة الأدمن لإضافة، تحديث أو حذف البيانات

import 'package:e_tourism/pages/DriverFormPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminCRUDPage extends StatefulWidget {
  @override
  _AdminCRUDPageState createState() => _AdminCRUDPageState();
}

class _AdminCRUDPageState extends State<AdminCRUDPage> {
  List<Map<String, dynamic>> guides = [];
  List<Map<String, dynamic>> drivers = [];
  List<Map<String, dynamic>> programs = [];
  List<Map<String, dynamic>> tours = [];
  @override
  void initState() {
    fetchAdminData();
    super.initState();
  }

  Future<void> fetchAdminData() async {

    final guidesResponse = await http.get(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/guides'),
    );
    final driversResponse = await http.get(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/drivers'),
    );
    final programsResponse = await http.get(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/programs'),

    );
    final toursResponse = await http.get(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tours'),

    );


    setState(() {
      guides = List<Map<String, dynamic>>.from(jsonDecode(guidesResponse.body));
      drivers = List<Map<String, dynamic>>.from(jsonDecode(driversResponse.body));
      programs = List<Map<String, dynamic>>.from(jsonDecode(programsResponse.body));
      tours = List<Map<String, dynamic>>.from(jsonDecode(toursResponse.body));
    });
  }

  Future<void> addGuide(Map<String, dynamic> guide) async {
    
    await http.post(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/guides'),
      
      body: jsonEncode(guide),
    );
    fetchAdminData();
  }

  Future<void> delete(int id, String table) async {
    await http.post(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/${table}/delete'),
      
      body: jsonEncode({'${table}_id': id}),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             IconButton(onPressed: (){
            
              Navigator.of(context).pushNamed('/report');
             
       
          }, icon: Icon(Icons.date_range_outlined, color: Colors.white,) ),      
            Text(
          'Admin DashBoard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
          IconButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout...'),
        backgroundColor: Colors.green,
        ),);
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
             
       
          }, icon: Icon(Icons.logout, color: Colors.white,) )        
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.admin_panel_settings,
              size: 100,
              color: Colors.blueGrey.shade800,
            ),
            SizedBox(height: 20),
            Text(
              'Manage Guides, Drivers, and Programs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.blueGrey.shade900,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blueGrey.shade900,
                      tabs: [
                        Tab(text: 'Guides'),
                        Tab(text: 'Drivers'),
                        Tab(text: 'Programs'),
                        Tab(text: 'Tours'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildListSection('guide', guides),
                          _buildListSection('driver', drivers),
                          _buildListSection('program', programs),
                          _buildListSection('tour', programs),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Action to add a new guide
               
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blueGrey.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Add New',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(String title, List<Map<String, dynamic>> data) {
    return data.isEmpty
        ? Center(child: Text('No $title available.'))
        : ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.blueGrey.shade800),
            title: Text('${item['name']??''} ${item['fName']??''} ${item['lName']??''}'),
            subtitle: Text('ID: ${item['id']} , ${item['mobile'] ==''? "mobile:item['mobile']":''}'),
            trailing: title == 'tour' ? Icon(Icons.tour) : IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                delete(item['id'], title);
              },
            ),
            onTap: (){
                 if(title == 'driver'){
                      // ignore: avoid_types_as_parameter_names
                   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverFormPage(onSubmit: ({'id': item['id'],'first_name': item['first_name'],'last_name': item['last_name'],'plateNumber': item['plateNumber'],'description': item['description']} ) { addguide },)));
                 }
                 if(title == 'guide'){
                   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverFormPage(onSubmit: ({'id': item['id'],'first_name': item['first_name'],'last_name': item['last_name'],'plateNumber': item['plateNumber'],'description': item['description']} ) {  },)));

                 }
                 if(title == 'program'){
                   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverFormPage(onSubmit: ({'id': item['id'],'first_name': item['first_name'],'last_name': item['last_name'],'plateNumber': item['plateNumber'],'description': item['description']} ) {  },)));

                 }
                 if(title == 'tour')
                 {
                   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverFormPage(onSubmit: ({'id': item['id'],'first_name': item['first_name'],'last_name': item['last_name'],'plateNumber': item['plateNumber'],'description': item['description']} ) {  },)));

                 }
            },
          ),
        );
      },
    );
  }
}