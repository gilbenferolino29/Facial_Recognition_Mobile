import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/src/controllers/data_controller.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final DataController dcController = DataController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu_rounded, color: Colors.black),
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
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
                        shape: BoxShape.circle, color: Colors.greenAccent),
                    child: Icon(Icons.person, size: 150, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder(
                      future: dcController.getAllAttendance(),
                      builder: (context, future) {
                        if (future.hasData) {
                          return Column(
                            children: [
                              Text(dcController.allAttendance[2]['name'],
                                  style: GoogleFonts.actor(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Text(dcController.allAttendance[2]['department'],
                                  style: GoogleFonts.actor(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          );
                        }
                        return Text('User',
                            style: GoogleFonts.actor(
                                fontSize: 20, fontWeight: FontWeight.w600));
                      })
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
                        offset:
                            const Offset(0, -2), // changes position of shadow
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
                        padding: EdgeInsets.only(left: 50, right: 50),
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
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              'Date',
                              style: GoogleFonts.actor(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              'Time',
                              style: GoogleFonts.actor(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    FutureBuilder(
                        future: dcController.getAllAttendance(),
                        builder: (context, future) {
                          if (future.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: dcController.allAttendance.length,
                                itemBuilder: (context, index) {
                                  if (dcController.allAttendance[index]
                                          ['name'] ==
                                      'Gilben Feroliono') {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        height: (size.height / 100) * 8,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            color: Colors.amberAccent),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'someSubjectCode',
                                                  style: GoogleFonts.actor(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Spacer(),
                                                Text(
                                                  dcController
                                                          .allAttendance[index]
                                                      ['date'],
                                                  style: GoogleFonts.actor(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Spacer(),
                                                Text(
                                                  dcController
                                                          .allAttendance[index]
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
                                  }
                                  return SizedBox();
                                });
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
                          }
                          return Text('Fetching Data...',
                              style: GoogleFonts.actor(
                                  fontSize: 20, fontWeight: FontWeight.w600));
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
