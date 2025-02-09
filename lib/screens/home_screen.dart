import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:public_tranport_app/screens/login.dart';
import 'package:public_tranport_app/account.dart';
import 'package:public_tranport_app/constants.dart';
import 'package:public_tranport_app/screens/trnsprt_details.dart';
import 'package:public_tranport_app/widgets/account_box.dart';
import 'package:public_tranport_app/widgets/transport_card.dart';
import '../schedule.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Schedule> schedules;
  late Account account;

  @override
  void initState() {
    super.initState();

    // Mock Schedule Data
    String schJson = """[{
      "fromTime":"10:00",
      "toTime":"10:30",
      "location":"Nasrcity Station",
      "price":5.0
    },
    {
      "fromTime":"11:05",
      "toTime":"11:45",
      "location":"Nasrcity Station",
      "price":5.0
    },
    {
      "fromTime":"11:25",
      "toTime":"12:30",
      "location":"Nasrcity Station",
      "price":3.0
    }]""";

    var dSch = jsonDecode(schJson);
    schedules = (dSch as List).map((data) => Schedule.fromJson(data)).toList();

    // Mock Account Data
    String accJson =
        '{"firstName": "Muhammad", "lastName": "Ellithy", "balance": 18, "rewards": 10.25, "trips": 189}';
    var dAcc = jsonDecode(accJson);
    account = Account.fromJson(dAcc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMoonStones,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: kGray,
                        child: Icon(Icons.person, color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello,\nMuhammad',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Where will you go today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      labelText: "Search destination...",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  // White Background Container
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choose your transport',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 15),

                              // Bus Option
                              TransportCard(
                                name: 'Bus',
                                image: 'assets/images/bus.png',
                                pressSelect: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TrnsprtDetails(
                                          title: 'Bus',
                                          image: 'assets/images/bus.png',
                                          location: 'Nasrcity BUSStation',
                                          destination: 'Maadi BUSStation',
                                          schedules: schedules,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 20),

                              // MRT Option
                              TransportCard(
                                name: 'MRT',
                                image: 'assets/images/small_mrt.png',
                                background: kMoonStones,
                                topValue: 30,
                                bottomValue: 0,
                                pressSelect: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TrnsprtDetails(
                                          title: 'MRT',
                                          image: 'assets/images/mrt.png',
                                          location: 'Nasrcity MRTStation',
                                          destination: 'Maadi MRTStation',
                                          schedules: schedules,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Account Balance Summary
                  Positioned(
                    top: 10,
                    left: 20,
                    right: 20,
                    child: AccountBox(
                      balance: account.balance,
                      rewards: account.rewards,
                      trips: account.trips,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
