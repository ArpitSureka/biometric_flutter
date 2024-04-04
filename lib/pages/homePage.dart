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
    backgroundColor: Colors.black,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
            child: Image.asset(
              'assets/images/iitg-logo.png', // Replace 'assets/logo.png' with your image path
              height: 100,
              width: 100,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Text(
              'Biometric Recognition using Fingerprint',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
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
                        child: const SizedBox(
                          width : 150,
                          height: 50,
                          child: Center(child: Text('Add Fingerprint')),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/listFiles');
                        },
                        child: const SizedBox(
                            width : 150,
                            height: 50,
                            child: Center(child: Text('Database'))
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/compare');
                        },
                        child: const SizedBox(
                            width : 150,
                            height: 50,
                            child: Center(child: Text('Compare Fingerprints'))
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Page4()),
                          );
                        },
                        child: const SizedBox(
                          width : 150,
                          height: 50,
                          child: Center(child: Text('About US')),
                        ),
                      ),
                    ],
                  ),
                ),
                ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Text(
              '© Arpit Sureka, Archit Avadhane',
              style: TextStyle(
                color: Colors.white,
              )
          ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Text('BTP IIT-Guwahati Mechanical Department',
                style: TextStyle(
                  color: Colors.white,
                )),
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