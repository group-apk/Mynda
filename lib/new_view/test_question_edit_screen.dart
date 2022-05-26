import 'package:flutter/material.dart';

class HealthTestEditScreen extends StatefulWidget {
  const HealthTestEditScreen({Key? key, required this.testName}) : super(key: key);
  final String testName;
  @override
  State<HealthTestEditScreen> createState() => _HealthTestEditScreenState();
}

class _HealthTestEditScreenState extends State<HealthTestEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${widget.testName} Test Editor'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            // passing this to root
            Navigator.of(context).pop();
          },
        ),
      ),
      body:Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, position){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Question ${position+1}', 
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            );
          },
        ),
      ));
  }
}