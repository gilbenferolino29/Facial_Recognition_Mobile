// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/src/controllers/data_controller.dart';
import 'package:mobile_ui/src/screens/resources/button_choices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DataController dcController;
  int buttonChoice = 0;
  @override
  void initState() {
    dcController = DataController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PageController _pageController = PageController(initialPage: 0);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height / 100 * 3),
            Center(
              child: Text(
                'Attendance System',
                style: GoogleFonts.inter(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
            ),
            SizedBox(height: size.height / 100 * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                accountsButton(buttonChoice, _pageController),
                attendanceButton(buttonChoice, _pageController)
              ],
            ),
            SizedBox(height: size.height / 100 * 3),
            StreamBuilder(
                stream: dcController.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("No Internet Connection");

                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());

                    default:
                      Center(child: Text('Something is wrong'));
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Something is wrong'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    //print(wc.currentWeather);
                    return Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) => setState(() {
                          buttonChoice = value;
                        }),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          if (buttonChoice == 0) {
                            return accountsWidget(size);
                          } else if (buttonChoice == 1) {
                            return attendanceWidget(size);
                          } else {
                            return Text('None');
                          }
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  ListView accountsWidget(Size size) {
    return ListView.builder(
      itemCount: dcController.allAccounts.length,
      itemBuilder: (context, index) {
        final data = dcController.allAccounts;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          child: Container(
            padding: EdgeInsets.all(5),
            height: size.height / 100 * 8,
            width: size.width / 100 * 20,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ' + data[index]['id'].toString(),
                        style: GoogleFonts.inter(
                            fontSize: 8, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Name: ' + data[index]['name'],
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        data[index]['department'],
                        style: GoogleFonts.inter(
                            fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data[index]['collegeName'],
                        style: GoogleFonts.inter(
                            fontSize: 9, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('On Leave',
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            height: 20,
                            width: 5,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: data[index]['onLeave']
                                    ? Color.fromARGB(255, 6, 240, 14)
                                    : Colors.grey)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: [
                        Text('Resigned',
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              height: 20,
                              width: 5,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: data[index]['resigned']
                                      ? Colors.red
                                      : Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ListView attendanceWidget(Size size) {
    return ListView.builder(
      itemCount: dcController.allAttendance.length,
      itemBuilder: (context, index) {
        final data = dcController.allAttendance;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          child: Container(
            padding: EdgeInsets.all(5),
            height: size.height / 100 * 8,
            width: size.width / 100 * 20,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ' + data[index]['name'],
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        data[index]['department'],
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('Date',
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      Text(data[index]['date'],
                          style: GoogleFonts.inter(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Column(
                      children: [
                        Text('Time',
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Text(data[index]['time'],
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
