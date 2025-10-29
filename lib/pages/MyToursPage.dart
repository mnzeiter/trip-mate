import 'package:e_tourism/UserDate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class MyToursPage extends StatefulWidget {
  @override
  _MyToursPageState createState() => _MyToursPageState();
}

class _MyToursPageState extends State<MyToursPage> {
  int? tourID;
  Map<String, dynamic> tour = {};

  @override
  void initState() {
    super.initState();
    tourID = Provider.of<UserData>(context, listen: false).tourID; 
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    if(tourID != null)    
   {
     final response = await http.post(Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tour'),
    body: jsonEncode({"tour_id": tourID})
    );
    setState(() {
      tour = Map<String, dynamic>.from(jsonDecode(response.body));
    });
    print(tourID);
   }
   
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
    if(index == 0){
      Navigator.of(context).pushNamedAndRemoveUntil('/tours', (Route<dynamic> route) => false);
    }
       if(index == 1){
      Navigator.of(context).pushNamedAndRemoveUntil('/search', (Route<dynamic> route) => false);

    }
       if(index == 2){
      Navigator.of(context).pushNamedAndRemoveUntil('/myTours', (Route<dynamic> route) => false);

    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
          'Your Tours',
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
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person,
              size: 50,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              'Show your tour for your journey',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: tour.isEmpty
                  ? Center(
                child: Text(
                  'No tours found, try join!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
              )  : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Name:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['name'],
            style: TextStyle(fontSize: 20,),  
            ),
            const SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['description'],
            style: TextStyle(fontSize: 16,),  
            ),
            const SizedBox(height: 5),
            Text(
              'Type:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['type'],
            style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              'Price:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['price'],
            style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              'Name of Driver:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['driverName'],
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              'Name of Guide:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['guideName'],
            style: TextStyle(fontSize: 18),
            ),
             const SizedBox(height: 5),
            Text(
              'startDate:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['startDate'].split(' ')[0],
            style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              'endDate:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tour['endDate'].split(' ')[0],
            style: TextStyle(fontSize: 18),
            ),
            
            
          ],
        ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.blueGrey[400],
          selectedFontSize: 20,
          selectedIconTheme: IconThemeData(color: Colors.blue),
          selectedItemColor: Colors.blue,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.tour),
        label: 'Tours',

      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'My Tour',
      ),  
    ],
      currentIndex: _selectedIndex, 
  onTap: _onItemTapped,   
    )
    );
  }
}
