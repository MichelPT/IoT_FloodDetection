import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';

class MainStatusScreen extends StatefulWidget {
  const MainStatusScreen({super.key});

  @override
  State<MainStatusScreen> createState() => _MainStatusScreenState();
}

class _MainStatusScreenState extends State<MainStatusScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('esp');
  Color backgroundColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.03,
        fontWeight: FontWeight.w400);
    return Center(
      child: FirebaseAnimatedList(
        shrinkWrap: true,
        duration: Duration.zero,
        query: ref.orderByKey().limitToLast(1),
        defaultChild: const CircularProgressIndicator(),
        itemBuilder: (context, snapshot, animation, index) {
          Map<Object?, Object?> dataSnapshot =
              snapshot.value as Map<Object?, Object?>;
          Map<String?, dynamic> data = dataSnapshot.cast<String?, dynamic>();
          var waterLevel = 0;
          var statusrn = '';
          var warning = '';
          waterLevel = data['water-level'];
          if (waterLevel < 400) {
            statusrn = 'Below flood stage';
            warning = 'None';
            backgroundColor = Colors.green;
          } else if (waterLevel < 600) {
            statusrn = 'Near flood stage';
            warning = 'Minor flooding, some low-lying areas may be affected';
            backgroundColor = Colors.yellow;
          } else if (waterLevel < 900) {
            statusrn = 'Above flood stage';
            warning =
                'Major flooding detected, widespread flooding is expected';
            backgroundColor = Colors.red;
          }
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            color: backgroundColor,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Current water level score:'),
                  Text(
                    waterLevel.toString(),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.15,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(statusrn, style: textStyle),
                  Text(warning, style: textStyle)
                ]),
          );
        },
      ),
    );
  }

  // Future<int> loadData() async {
  //   print('object1');
  //   var list = FirebaseList(query: ref.orderByKey().limitToLast(1));
  //   print(list.toString());
  //   ref.orderByKey().limitToLast(1).once().then((event) {
  //     DataSnapshot snapshot = event.snapshot;
  //     if (snapshot.exists) {
  //       Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
  //       int lastAddedUserId = data['water-level'];
  //       print('Last added user ID: $lastAddedUserId');
  //     } else {
  //       print('No data found');
  //     }
  //     ;
  //   });
  //   // ref.onValue.listen((event) {
  //   //   Map<Object?, Object?> dataSnapshot =
  //   //       event.snapshot.value as Map<Object?, Object?>;
  //   //   Map<String?, dynamic> data = dataSnapshot.cast<String?, dynamic>();
  //   //   waterLevel = data['water-level'];
  //   // });
  //   // if (waterLevel < 100) {
  //   //   statusrn = 'Below flood stage';
  //   //   warning = 'None';
  //   // } else if (waterLevel < 300) {
  //   //   statusrn = 'Near flood stage';
  //   //   warning = '	Minor flooding, some low-lying areas may be affected';
  //   // } else if (waterLevel < 500) {
  //   //   statusrn = 'Above flood stage';
  //   //   warning = 'Moderate flooding, some properties may be affected';
  //   // } else if (waterLevel < 800) {
  //   //   statusrn = 'Well above flood stage';
  //   //   warning = 'Major flooding, widespread flooding is expected';
  //   // }
  //   final event = await ref.once(DatabaseEventType.value);
  //   print('object2');
  //   final waterLevel = event.snapshot.value;
  //   print('object3');
  //   Map<Object?, Object?> dataSnapshot = waterLevel as Map<Object?, Object?>;
  //   print('object4');
  //   Map<String?, dynamic> data = dataSnapshot.cast<String?, dynamic>();
  //   print('object5');
  //   int waterLevelData = data['water-level'];
  //   print('object6');
  //   if (waterLevelData < 100) {
  //     statusrn = 'Below flood stage';
  //     warning = 'None';
  //   } else if (waterLevelData < 300) {
  //     statusrn = 'Near flood stage';
  //     warning = '	Minor flooding, some low-lying areas may be affected';
  //   } else if (waterLevelData < 500) {
  //     statusrn = 'Above flood stage';
  //     warning = 'Moderate flooding, some properties may be affected';
  //   } else if (waterLevelData < 800) {
  //     statusrn = 'Well above flood stage';
  //     warning = 'Major flooding, widespread flooding is expected';
  //   }
  //   return waterLevelData;
  // }
}
