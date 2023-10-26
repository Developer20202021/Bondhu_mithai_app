import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/DeliveryManImageUpload.dart';
import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/ManagerImageUpload.dart';
import 'package:bondhu_mithai_app/Screen/AllRegistrationScreen/StaffImageUpload.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';









class CustomerLocation extends StatefulWidget {
  const CustomerLocation({super.key});

  @override
  State<CustomerLocation> createState() => _CustomerLocationState();
}

class _CustomerLocationState extends State<CustomerLocation> {


 bool loading = false;

 var lat = "";
 var long = "";

  String? _currentAddress;
  Position? _currentPosition;









/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}





Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    setState(() {
      _currentAddress ='${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode},';

      

      

      print(_currentAddress);
    });
  }).catchError((e) {
    debugPrint(e);
  });
 }













  
  @override
  void initState() {



    _determinePosition().then((Position position){

      setState(() => _currentPosition = position);

      setState(() {

        lat = position.latitude.toString();
        long = position.longitude.toString();

      });

       _getAddressFromLatLng(_currentPosition!);




    });











// _determinePosition().then((value) => setState((){


//   lat = value.latitude.toString();
//   long = value.longitude.toString();
//   var speed = value.speed.toString();

//   print("${lat} ${long} speed:${speed}");



// double distanceInMeters = Geolocator.distanceBetween(double.parse(lat), double.parse(long), LatitudeAndLong().OurLat, LatitudeAndLong().OurLong);

// // 25.0973621,89.0100336

// print("Our Shop Distance From You: ${distanceInMeters/1000.0}Km");











// }));
    // print(_determinePosition());

  
    super.initState();
   
    
  }


  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();



   



 var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
           
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.google.com/maps/place/@${lat},${long},19z/entry=ttu"));



 



    


 

    return  Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
       automaticallyImplyLeading: false,
        title: const Text("Location", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: WebViewWidget(controller: controller),
        
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}