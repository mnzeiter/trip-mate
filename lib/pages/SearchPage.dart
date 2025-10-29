import 'package:e_tourism/pages/TourDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> tours = [];

  Future<void> searchTours() async {
    final name = searchController.text;
    final response = await http.post(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tour/search'),
      body: jsonEncode({'name': name})
    );

    if (response.statusCode == 200) {
      setState(() {
        tours = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Search failed!'),
        backgroundColor: Colors.red,
      ));
    }

    

  
  }

  @override
  Widget build(BuildContext context) {
  int _selectedIndex = 1;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Tours',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              Icons.search,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Find Your Next Adventure!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter tour name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tour),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: searchTours,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: tours.isEmpty
                  ? Center(
                child: Text(
                  'No tours found, try searching!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: tours.length,
                itemBuilder: (context, index) {
                  final tour = tours[index];
                   return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shadowColor: Colors.blueGrey.shade400,
                    child: ListTile(
                      leading: Icon(Icons.tour, color: Colors.blue),
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
    ),

      
    );
  }
}
