import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert'; // for json.decode

class CompareImage extends StatefulWidget {
  @override
  _CompareImageState createState() => _CompareImageState();
}

class _CompareImageState extends State<CompareImage> {
  File? _image;
  final picker = ImagePicker();
  List<dynamic> dataList = [];
  int status = 0;
  String match = "None Matched";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _sendData(BuildContext context) async {
    // You need to replace 'your-api-endpoint' with your actual API endpoint
    status = 1;
    var url = Uri.parse('https://swc.iitg.ac.in/arpit_btp/comparejson');
    var request = http.MultipartRequest('POST', url);

    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _image!.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    } else {
      print('No image selected.');
      return; // Exit the function if no image is selected
    }

    try {
      // Rest of the code
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 302) {
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);
        setState(() {
          dataList = jsonData; // Assuming 'data' is the key for the list in JSON
        });
        status = 2;
        int maximum = 0 ;
        for (var i = 0; i < dataList.length; i++){
          if(dataList[i]['second'] > maximum ){
            maximum = dataList[i]['second'];
            match = dataList[i]['first'] + " matched with " + dataList[i]['second'] + " score";
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(content: new Text("Data sent successfully")));
      } else {
        print('Failed to send data');
        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(content: new Text("Error sending data")));
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Compare Fingerprint in Database'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    _image!,
                    width: 300,
                    height: 300,
                  ),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Take Picture'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _sendData(context);
              },
              child: Text('Compare in Database'),
            ),
            SizedBox(
              height: 50,
              child: status == 2 ? Text(
                match, // Assuming 'name' is the key for name in JSON
                style: TextStyle(fontSize: 16.0),
              )
              : status == 1 ? const CircularProgressIndicator(
                color: Colors.black,
              ) : const SizedBox.shrink(),
            ),
            Expanded(
              child: dataList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Center(
                                  child: Text(
                                    dataList[index]['first'], // Assuming 'name' is the key for name in JSON
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                              Text(
                                dataList[index]['second'].toString(), // Assuming 'name' is the key for name in JSON
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          // You can add more widgets here based on your data structure
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
