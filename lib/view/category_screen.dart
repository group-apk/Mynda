import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/widget.dart';
import 'dashboard.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  
  late final Stream<QuerySnapshot> quizzes =
      FirebaseFirestore.instance.collection('QuizList').snapshots();


  Widget quizList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: quizzes,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong.');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }

              final data = snapshot.requireData;
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Image.network(
                              '${data.docs[index]['quizImgurl']}',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              color: Colors.black26,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${data.docs[index]['quizTitle']}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),                                 
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${data.docs[index]['quizDesc']}',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,

      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()));
        },
      ),
    );
  }
}


/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/widget.dart';
import 'dashboard.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final Stream<QuerySnapshot> quizzes =
      FirebaseFirestore.instance.collection('QuizList').snapshots();

  Widget quizList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: quizzes,
            builder: (BuildContext context, AsyncSnapshot snapshot) {


              if(snapshot.hasError){
                return const Text('Something went wrong.');
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Text('Loading');
              }

              final data=snapshot.requireData;
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: data.size,
                itemBuilder:(context,index){
                  return QuizTile( 
                        noOfQuestions: 
                        int.parse('${data.docs[index]['question']}'),
                            //snapshot.data.documents.length,
                        imageUrl:
                        '${data.docs[index]['quizImgurl']}',
                            //snapshot.data.documents[index].data['quizImgurl'],
                        title:
                        '${data.docs[index]['quizTitle']}',
                            //snapshot.data.documents[index].data['quizTitle'],
                        description:
                        '${data.docs[index]['quizDesc']}',
                            //snapshot.data.documents[index].data['quizDesc'],
                        id: 
                        '${data.docs[index]['quizId']}',
                          //snapshot.data.documents[index].data["quizId"],
                  );  
              },);
            },
          )
        ],
      ),
    );
  }

/*
  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      QuizList = value;
      setState(() {});
    });
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
        //brightness: Brightness.li,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>const DashboardScreen()));
        },
      ),
    );
  }
}


class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description;
  final int noOfQuestions;

  QuizTile(
      {required this.title,
      required this.imageUrl,
      required this.description,
      required this.id,
      required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/
