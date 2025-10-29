import 'package:e_tourism/pages/TourDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ToursListPage extends StatefulWidget {
  @override
  _ToursListPageState createState() => _ToursListPageState();
}

class _ToursListPageState extends State<ToursListPage> {
  List<Map<String, dynamic>> tours = [];
  int id = 0;

  @override
  void initState() {
    super.initState();
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    final response = await http.get(Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tours'));
    setState(() {
      tours =  List<Map<String, dynamic>>.from(jsonDecode(response.body));
    });
    
    
  }

  Future<void> fetchCount() async {
    final response = await http.get(Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tourist/count'));
    setState(() {
      tours = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    });
    
    
  }

  int _selectedIndex = 0;

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
        title: Text(
          'Available Tourism Programs',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
              Icons.tour,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Explore the Best Programs for Your Journey',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child:  tours.isEmpty
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                itemCount:  tours.length,
                itemBuilder: (context, index) {
                  final  tour =  tours[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shadowColor: Colors.blueGrey.shade400,
                    child: ListTile(
                      leading: Icon(Icons.card_travel, color: Colors.blue),
                      title: Text(
                        tour['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          tour['description'],
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.blueGrey.shade800),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TourDetailsPage(id: tour['id'], tourName: tour['name'], tourDescription: tour['description'], tourType: tour['type'], tourPrice: tour['price'], tourCapacity: tour['number'], registeredUsers: tour['number'], startDate: tour['startDate'], endDate: tour['endDate'])));

                      },
                    ),
                  );
                },
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
