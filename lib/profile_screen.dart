import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_proj/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  UserModel userModel = UserModel();

  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user.uid)
          .get()
          .then((value) {
        setState(() {
          widget.userModel = UserModel.fromMap(value.data());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${widget.userModel.email}'),
              Text('${widget.userModel.fullName}'),
              Text('${widget.userModel.gender}'),
              Text('${widget.userModel.ic}'),
              Text('${widget.userModel.region}'),
              Text('${widget.userModel.states}'),
              Text('${widget.userModel.uid}'),
            ],
          ),
        ),
      ),
    );
  }
}
