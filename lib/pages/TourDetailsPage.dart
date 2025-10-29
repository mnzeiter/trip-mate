import 'dart:convert';

import 'package:e_tourism/UserDate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TourDetailsPage extends StatefulWidget{
  final int id;
  final String tourName;
  final String tourDescription;
  final String tourType;
  final String tourPrice;
  final int tourCapacity;
  final int registeredUsers;
  final String startDate;
  final String endDate;
   
   TourDetailsPage({
    required this.id,
    required this.tourName,
    required this.tourDescription,
    required this.tourType,
    required this.tourPrice,
    required this.tourCapacity,
    required this.registeredUsers,
    required this.startDate,
    required this.endDate,
  });
  
  @override
  State<StatefulWidget> createState() => _TourDetailsPage();

  
}


class _TourDetailsPage extends State<TourDetailsPage> {
    
  //List<Map<String, dynamic>> tours = [];
    int regCount = 0;
    dynamic userData;
    
@override
void initState() {
    fetchCount();
    userData = Provider.of<UserData>(context, listen: false);
    super.initState();
    
}


Future<void> fetchCount() async {
    final response = await http.post(Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tourist/count'),
      body: jsonEncode({'tour_id': widget.id})
    );
    final responseData = jsonDecode(response.body);
    print(response.body);
    setState(() {
    regCount = responseData["regCount"]; 
    });
    
  }


  Future<void> joinToTour(tourID, userID) async {
    if(tourID == null ){
      if(regCount < widget.tourCapacity){
        final response = await http.post(Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tourist/join'),
    body: jsonEncode({'tour_id': widget.id, 'id': userID})
    );
    final responseData = jsonDecode(response.body);
    print({"tour":widget.id, "user":userID});
    if(responseData['join'] == true ){
        userData.tourID = widget.id;
        Navigator.of(context).pushNamedAndRemoveUntil('/myTours', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message']),
        backgroundColor: Colors.green,
        ),);  
        }else {
        
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message']),
        backgroundColor: Colors.red,
        ),);
    }
      }else{
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Join Faild, Capacity is full.'),
        backgroundColor: Colors.red,
        ),);
      }
      
    }else {
        
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Join Faild, you have tour.'),
        backgroundColor: Colors.red,
        ),);
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tourName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.tour,
              size: 50,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Join to Best Tours for Your Journey',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(widget.tourDescription,
            style: TextStyle(fontSize: 16,),  
            ),
            SizedBox(height: 16),
            Text(
              'Type:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(widget.tourType,
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Price:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('${widget.tourPrice}',
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Capacity:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('${widget.tourCapacity}',
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'registered:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('$regCount',
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'startDate:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('${widget.startDate}'.split(' ')[0],
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'endDate:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('${widget.endDate}'.split(' ')[0],
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            
          ],
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: ElevatedButton(
              onPressed: () {
         joinToTour(Provider.of<UserData>(context, listen: false).tourID, 
            Provider.of<UserData>(context, listen: false).userID); 
            
          }, 

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue
              ),
              child: const Text('Join to Tour',
              style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ), 
      
      )
    );
  }
}
