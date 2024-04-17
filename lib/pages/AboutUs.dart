import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PersonWidget(
              name: 'Arpit Sureka',
              image: 'assets/images/1677913414wer.jpg',
              description: 'B.Tech Student 2020-2024 (200103127),            Mechanical Department, IITG',
            ),
            PersonWidget(
              name: 'Archit Avadhane',
              image: 'assets/images/16779134.jpeg',
              description: 'B.Tech Student 2020-2024 (200103016),                Mechanical Department, IITG',
            ),
            PersonWidget(
              name: 'Satish Kumar Panda',
              image: 'assets/images/iit_1673236760.jpg',
              description: 'BTP Supervisor, Assistant Professor, Mechanical Department, IIT BHU',
            ),
            PersonWidget(
              name: 'Sandeep Reddy Basireddy',
              image: 'assets/images/CET_4134.original.jpg',
              description: 'BTP Supervisor, Assistant Professor, Mechanical Department, IITG',
            ),
          ],
        ),
      ),
    );
  }
}

class PersonWidget extends StatelessWidget {
  final String name;
  final String image;
  final String description;

  const PersonWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
