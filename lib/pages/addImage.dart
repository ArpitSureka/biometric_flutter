import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _image;
  // final picker = ImagePicker();
  TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 500, maxWidth: 500);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => _image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _sendData(BuildContext context) async {
    String textData = _textEditingController.text;

    // You need to replace 'your-api-endpoint' with your actual API endpoint
    var url = Uri.parse('https://swc.iitg.ac.in/arpit_btp/');
    var request = http.MultipartRequest('POST', url);

    request.fields['name'] = textData;
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Add Fingerprint to Database',
            style: TextStyle(
              color: Colors.black,
            ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.',
              style: TextStyle(
                color: Colors.white,
              ),
            )
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
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextFormField(
                controller: _textEditingController,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter Name for Fingerprint',
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.white,
                ),

              ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _sendData(context);
              },
              child: Text('Upload Fingerprint'),
            ),
          ],
        ),
      ),
    );
  }
}
