import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    bool InternetConnection = false;

    void ConnectionCheck() async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        Navigator.of(context).pop();
        // print('YAY! Free cute dog pics!');
        setState(() {
          result;
        });
      } else {
        print('No internet :( Reason:');
        print(InternetConnectionChecker().connectionStatus);
      }
    }

    ConnectionCheck();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        title: const Text(
          "",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 140, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Lottie.asset('lib/images/animation_lk8h52lj.json',
                    fit: BoxFit.cover, width: 400, height: 300),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  "NO INTERNET CONNECTION",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                        minimumSize: Size.fromHeight(60)),
                    onPressed: () {
                      ConnectionCheck();
                    },
                    child: Text(
                      "RETRY",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}



// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();
//     paint.color = Colors.purple;
//     paint.style = PaintingStyle.fill;

//     var path = Path();

//     path.moveTo(0, size.height * 0.9167);
//     path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
//         size.width * 0.5, size.height * 0.9167);
//     path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
//         size.width * 1.0, size.height * 0.9167);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

