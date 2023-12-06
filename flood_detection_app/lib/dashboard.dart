import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("esp");
  final int dateFlexWidth = 4;
  final int timeFlexWidth = 4;
  final int levelFlexWidth = 4;
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

    Widget expandedCol(String content, int flex) => Expanded(
          flex: flex,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(),
                color: const Color.fromARGB(255, 134, 217, 255)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                content,
                style: textStyle,
                selectionColor: Colors.amber,
              ),
            ),
          ),
        );

    Widget expandedRow(String content, int flex) => Expanded(
        flex: flex,
        child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(content, style: textStyle),
            )));

    return Center(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  expandedCol('Date', dateFlexWidth),
                  expandedCol('Time', timeFlexWidth),
                  expandedCol('Water Level', levelFlexWidth)
                ],
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  duration: Duration.zero,
                  query: ref.limitToLast(14),
                  reverse: true,
                  defaultChild: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.4,),
                      const CircularProgressIndicator(),
                      SizedBox(height: MediaQuery.of(context).size.height*0.3,)
                  ],),
                  itemBuilder: (context, snapshot, animation, index) {
                    Map<Object?, Object?> dataSnapshot =
                        snapshot.value as Map<Object?, Object?>;
                    Map<String?, dynamic> data =
                        dataSnapshot.cast<String?, dynamic>();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        expandedRow(data['date'], dateFlexWidth),
                        expandedRow(data['time'], timeFlexWidth),
                        expandedRow(
                            data['water-level'].toString(), levelFlexWidth),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  // void _loadActivity() async {
  //   print('data');
  //   DatabaseReference starCountRef = FirebaseDatabase.instance.ref('esp/water');
  //   print('data2');
  //   // starCountRef.onValue.listen((DatabaseEvent event) {
  //   //   final data = event.snapshot.value;
  //   //   print(data);
  //   // });
  //   starCountRef.onChildChanged.listen((event) {
  //     final data = event.snapshot.key;
  //     print(data);
  //   });
  //   print('data3');
  //   // final List<String> actList = [];
  //   // DatabaseReference ref = FirebaseDatabase.instance.ref();
  //   // ref.child('esp').onChildAdded.listen((event) {
  //   //   DataSnapshot snapshot = event.snapshot;
  //   //   var data = snapshot.value;
  //   //   print(data);
  //   // });

  //   // final refStream =
  //   //     FirebaseDatabase.instance.ref('esp/water').onValue;
  //   // starCountRef.onValue.listen((DatabaseEvent event) {
  //   //   final data = event.snapshot.value;
  //   //   print(data);
  //   // });

  //   // setState(() {
  //   //   _focusList = actList;
  //   // });
  // }
}
