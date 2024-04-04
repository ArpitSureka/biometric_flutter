import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowImage extends StatefulWidget {
  final String imageUrl;
  final String title;

  ShowImage({required this.imageUrl, required this.title});

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  late Future<http.Response> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = fetchImage();
  }

  Future<http.Response> fetchImage() async {
    return http.get(Uri.parse(widget.imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
          future: _imageFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Failed to load image');
            } else {
              return Image.memory(snapshot.data!.bodyBytes); // Display fetched image
            }
          },
        ),
      ),
    );
  }
}
