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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this._image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _sendData(BuildContext context) async {

    // You need to replace 'your-api-endpoint' with your actual API endpoint
    var url = Uri.parse('https://swc.iitg.ac.in/arpit_btp/compare');
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
      var response = await request.send();
      // Rest of the code
      if (response.statusCode == 200 || response.statusCode == 302) {
        print('Data sent successfully');
        print(response);
        print(response.statusCode);
        // var jsonData = json.decode(response.body);
        // setState(() {
        //   // print(jsonData);
        //   dataList =
        //       jsonData; // Assuming 'data' is the key for the list in JSON
        // });
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text("Data sent successfully")));
      } else {
        print('Failed to send data');
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text("Error sending data")));
      }
      Navigator.pop(context);

    } catch (e) {
      print('Error sending request: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Add Fingerprint to Database'),
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
          ],
        ),
      ),
    );
  }
}
