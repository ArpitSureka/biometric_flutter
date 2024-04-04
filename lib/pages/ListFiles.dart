import 'package:flutter/material.dart';
import 'dart:convert'; // for json.decode
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:biometric/pages/showImage.dart';

class ListFiles extends StatefulWidget {
  @override
  _ListFilesState createState() => _ListFilesState();
}

class _ListFilesState extends State<ListFiles> {
  List<dynamic> dataList = []; // List to store fetched data

  // Fetch data from API
  void fetchData() async {
    // Replace 'YOUR_API_ENDPOINT' with your actual API endpoint
    // var response = await YOUR_HTTP_CLIENT.get(Uri.parse('YOUR_API_ENDPOINT'));
    var url = Uri.parse('https://swc.iitg.ac.in/arpit_btp/listfiles');
    var response = await http.get(url);

    // Check if request was successful
    if (response.statusCode == 200) {
      // Parse JSON response
      var jsonData = json.decode(response.body);
      setState(() {
        // print(jsonData);
        dataList =
            jsonData; // Assuming 'data' is the key for the list in JSON
      });
    } else {
      // Handle error
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database of Fingerprints'),
      ),
      body: dataList.isEmpty // Check if data is fetched
          ? const Center(
              child:
                  CircularProgressIndicator(), // Display loading indicator while fetching data
            )
          : ListView.builder(
              itemCount: dataList.length,
              reverse: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          dataList[index]['name'], // Assuming 'name' is the key for name in JSON
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to another page when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowImage(
                                imageUrl: "https://swc.iitg.ac.in/arpit_btp/files/" + dataList[index]['path'],
                                title: dataList[index]['name'],
                              ),
                            ),
                          );
                        },
                        child: Text('View'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
