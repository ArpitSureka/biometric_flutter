import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    // appBar: AppBar(
    //   title: Text('Home Page'),
    // ),
    // backgroundColor: Color.fromRGBO(),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
            child: Image.asset(
              'assets/images/iitg-logo.png', // Replace 'assets/logo.png' with your image path
              height: 100,
              width: 100,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addImage');
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text('Add Fingerprint'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/listFiles');
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text('Database'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/compare');
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text('Compare Fingerprints'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Page4()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text('About US'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 60),
            child: Text('© Arpit Sureka, Archit Avadhane'),
          ),
        ],
      ),
    ),
  );
}
}


class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 4'),
      ),
      body: Center(
        child: Text('Page 4 Content'),
      ),
    );
  }
}