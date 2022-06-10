// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/src/controllers/data_controller.dart';
import 'dart:convert';
import 'package:mobile_ui/src/screens/id_screen.dart';

class UserScreen extends StatefulWidget {
  final String id;

  const UserScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ScrollController _scrollController = ScrollController();

  scrollToTop() async {
    await Future.delayed(const Duration(milliseconds: 250));
    print('scrolling to top');
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Stream<QuerySnapshot<Map<String, dynamic>>> _attendanceStream =
        FirebaseFirestore.instance
            .collection('attendance')
            .where('employeeID', isEqualTo: int.parse(widget.id))
            .snapshots();

    print(_attendanceStream);
    return Scaffold(
      //floatingActionButton: FloatingActionButton.small(onPressed: onPressed)
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu_rounded, color: Colors.black),
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IdentificationScreen()));
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _attendanceStream,
          builder: (context, snapshot) {
            _attendanceStream.listen((snapshot) {
              scrollToTop();
            });
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Something went wrong!');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  children: const [
                    Text('Fetching Data'),
                    CircularProgressIndicator()
                  ],
                ),
              );
            }
            print(snapshot.data!.docs[0]['attendanceID']);
            return SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.amberAccent,
                  ),
                  Positioned(
                    top: 10,
                    left: 5,
                    right: 5,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.greenAccent),
                          child: Icon(Icons.person,
                              size: 150, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Text(snapshot.data!.docs[0]['name'],
                                style: GoogleFonts.actor(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Text(snapshot.data!.docs[0]['department'],
                                style: GoogleFonts.actor(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    child: Container(
                      height: (size.height / 100) * 60,
                      width: size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, -2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 25, right: 30),
                              height: 80,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Subject Code',
                                    style: GoogleFonts.actor(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Date',
                                    style: GoogleFonts.actor(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Time',
                                    style: GoogleFonts.actor(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),

                          SizedBox(
                            height: (size.height / 100) * 50,
                            child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      height: (size.height / 100) * 8,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        color: remarksColor(snapshot
                                            .data!.docs[index]['remarks']
                                            .toUpperCase()),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data!
                                                    .docs[index]['classcode']
                                                    .toString(),
                                                style: GoogleFonts.actor(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Spacer(),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['date'],
                                                style: GoogleFonts.actor(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Spacer(),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['time'],
                                                style: GoogleFonts.actor(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )

                          // for (var attendance in dcController.allAttendance) {
                          //   print(attendance);
                          //   return SingleChildScrollView(
                          //     controller: _scrollController,
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           height: (size.height / 100) * 8,
                          //           width: size.width,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.all(
                          //                 Radius.circular(50),
                          //               ),
                          //               color: Colors.amberAccent),
                          //           child: Text(attendance['name']),
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  MaterialColor remarksColor(remarks) {
    if (remarks == "ABSENT") {
      return Colors.grey;
    } else if (remarks == 'LATE') {
      return Colors.red;
    } else {
      return Colors.amber;
    }
  }

  void scrollUp() {}
}
