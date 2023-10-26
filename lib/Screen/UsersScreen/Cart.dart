import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bondhu_mithai_app/Screen/Dashboard/AllCustomer.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/FrontScreen/LogInScreen.dart';
import 'package:bondhu_mithai_app/Screen/UsersScreen/DeliveryTimeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:badges/badges.dart' as badges;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';






class CustomerCartScreen extends StatefulWidget {

  final CustomerName;
  final CustomerPhoneNumber;



  const CustomerCartScreen({super.key,  required this.CustomerName,required this.CustomerPhoneNumber});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {

  
  var uuid = Uuid();



  TextEditingController DiscountCodeController = TextEditingController();











bool loading = false;

var DataLoad = "";




  int userSelectedFoodCount = 0;

  var selectedData =[];

  var selectedFoodAmount = [];

  double foodAmount = 1.0;
  int selectedFoodIndex = 0;

  List SelectedFoodItem = [];


  var LastUpdatedFood =[];

  var LastUpdatedFoodLength = 0; 

  double CustomerFoodPrice = 0;


  bool locationEnable = false;




  // Customer Lat and Long 
  
var lat = "";
var long = "";

double distanceKm = 9.0;


  String? _currentAddress;
  Position? _currentPosition;



// hive database

  final _mybox = Hive.box("mybox");






  void readData() async{


    
   

 print(_mybox.get("UserAddToCartFood"));


   
   LastUpdatedFood = _mybox.get("UserAddToCartFood"); 


     if (LastUpdatedFood.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      for (var i = 0; i < LastUpdatedFood.length; i++) {


        var thisFoodOrderPrice = LastUpdatedFood[i]["ThisFoodOrderPrice"];

        double thisFoodOrderPriceDouble = double.parse(thisFoodOrderPrice.toString());

        setState(() {
          CustomerFoodPrice = CustomerFoodPrice + thisFoodOrderPriceDouble;
        });


        
      }





      setState(() {

     
     LastUpdatedFoodLength = LastUpdatedFood.length;
      LastUpdatedFood = _mybox.get("UserAddToCartFood"); 
       loading = false;
     });
       
     }

        
      
  }










  

  // Get Customer Location 



Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    await Geolocator.openLocationSettings();
    // return await Geolocator.getCurrentPosition();

    // return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {


          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                );


      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {


    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                );
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.


  return await Geolocator.getCurrentPosition();
}








Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    setState(() {
      _currentAddress ='${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode},';

      
        setState(() {
          locationEnable = true;
        });
      

      print(_currentAddress);
    });
  }).catchError((e) {
    debugPrint(e);
  });
 }














  












 










  Future updateData(List AllOrderFood, String OrderID) async{

    setState(() {
      loading = true;
    });








         final docUser = FirebaseFirestore.instance.collection("CustomerOrderHistory").doc(OrderID);


         // update Data comming soon

                  final UpadateData ={

                      "CustomerName":widget.CustomerName,
                      "CustomerPhoneNumber":widget.CustomerPhoneNumber,
                      "CustomerPersonNumber":"1",
                      "CustomerAddress":"",
                      "OrderDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      "OrderTime":"${DateTime.now().toLocal().toIso8601String()}",
                      "OrderMonth":"${DateTime.now().month}/${DateTime.now().year}",
                      "OrderYear":"${DateTime.now().year}",
                      "CustomerID":"",
                      "OrderID":OrderID,
                      "OrderType":"online",
                      "OrderStatus":"open",
                      "CustomerType":"Due",
                      "CashIn":"0.0",
                      "Chairs":["online"],
                      "AllOrderFood":AllOrderFood,
                      "TotalFoodPrice":CustomerFoodPrice.toString(),
                      "WithDeliveryFeeFoodPrice":CustomerFoodPrice.toString(),
                      "DueAmount":CustomerFoodPrice.toString(),
                      "DeliveryStatus":"New",
                      "GoogleAddress":_currentAddress,
                      "Lat":lat,
                      "Long":long,
                      "distanceFormShopKm":distanceKm

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState(() async{


                    print("Done");



                    var AdminMsg = "${distanceKm.ceil()}Km দূরে ${CustomerFoodPrice}৳ Order এসেছে। Phone No:${widget.CustomerPhoneNumber}";




                       final response = await http
                                .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01721915550&message=${AdminMsg}'));

                             

                            if (response.statusCode == 200) {
                              // If the server did return a 200 OK response,
                              // then parse the JSON.
                              print(jsonDecode(response.body));




                              
                    
                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Order Confirm Successfull',
                      message:
                          'Order Confirm Successfull',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                              setState(() {
                             
                                loading = false;
                              });
                            
                            } else {

                               setState(() {
                               
                                loading = false;
                              });
                              // If the server did not return a 200 OK response,
                              // then throw an exception.
                              throw Exception('Failed to load album');
                            }








                 

                    
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AllCustomer(indexNumber:"1")),
                // );

                  // setState(() {
                  //       loading = false;
                  //     });




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }




























@override
  void initState() {



WidgetsBinding.instance.addPostFrameCallback((_) {
 AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Allow Location',
            desc: 'Please Sir, আমাদের Order টি Confirm করতে অবশ্যই আপনাকে location allow করতে হবে। যদি আপনি Location Disable করে থাকেন তবে আপনার Page টি Refresh করুন অথবা নিচের Ok Button Press করুন এবং Location on করুন। অথবা আপনাকে Log Out করে দেওয়া হবে।',
            
            btnOkOnPress: () {

              refresh();

            },
            )..show();
});



 _determinePosition().then((Position position){

      setState(() => _currentPosition = position);

      setState(() {

        lat = position.latitude.toString();
        long = position.longitude.toString();

     double distanceInMeters = Geolocator.distanceBetween(double.parse(lat), double.parse(long), LatitudeAndLong().OurLat, LatitudeAndLong().OurLong);


     distanceKm = distanceInMeters/1000.0;

     

     print("Our Shop Distance From You: ${distanceInMeters/1000.0}Km");

      });

       _getAddressFromLatLng(_currentPosition!);




    });








    // TODO: implement initState
    setState(() {
      loading = true;
    });
    // getData();

    readData();

    super.initState();
  }














  
Future refresh() async{









   _determinePosition().then((Position position){

      setState(() => _currentPosition = position);

      setState(() {

        lat = position.latitude.toString();
        long = position.longitude.toString();

     double distanceInMeters = Geolocator.distanceBetween(double.parse(lat), double.parse(long), LatitudeAndLong().OurLat, LatitudeAndLong().OurLong);


     distanceKm = distanceInMeters/1000.0;




     
               distanceKm >=8.0? WidgetsBinding.instance.addPostFrameCallback((_) {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Sorry Sir',
                          desc: 'আপনার Location আমাদের থেকে ${distanceKm.ceil()}Km দূরে। তাই আপনি আমাদের Service নিতে পারবেন না।',
                          
                          btnOkOnPress: () {

                            // refresh();

                          },
                          )..show();
                      }): WidgetsBinding.instance.addPostFrameCallback((_) {
                    

                        Text("");
                      });





              locationEnable?Text(""): WidgetsBinding.instance.addPostFrameCallback((_) {
                              AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: 'Allow Location',
                                          desc: 'Please Sir, আমাদের Order টি Confirm করতে অবশ্যই আপনাকে location allow করতে হবে। যদি আপনি Location Disable করে থাকেন তবে আপনার Page টি Refresh করুন অথবা নিচের Ok Button Press করুন এবং Location on করুন। অথবা আপনাকে Log Out করে দেওয়া হবে।',
                                          
                                          btnOkOnPress: () {

                                            refresh();

                                          },
                                          )..show();
                              });

     






     print("Our Shop Distance From You: ${distanceInMeters/1000.0}Km");

      });

       _getAddressFromLatLng(_currentPosition!);




    });








// setState(() {

  
      
//    readData();

//     });


  }
























  @override
  Widget build(BuildContext context) {

     var OrderID = uuid.v4();



    return Scaffold(

      floatingActionButton: distanceKm <=8.0? Container(width: 150, child:  TextButton(onPressed: () async{


  
  List myList = List.from(LastUpdatedFood);



  updateData(LastUpdatedFood, OrderID);


  // _mybox.delete("UserAddToCartFood");

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryTimeScreen(CustomerPhoneNumber: widget.CustomerPhoneNumber, OrderID: OrderID, allFood: myList,)));







      }, child: Text("Confirm", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
              ),),):Text(""),

        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
              automaticallyImplyLeading: false,
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60),
                  ),
                ),



            actions: [
        
        
        
        IconButton(onPressed: (){







  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        
          decoration: BoxDecoration(
              color: Colors.white,
            
              
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))    
             ),
        
      
        child: Column(
          children: [
            Table(
                  border: TableBorder.all(color:Colors.grey),
                  children: [


                  // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Name',
                           
                           
                          ),
                          padding: EdgeInsets.all(6),
                        ),

                           Padding(
                          child: Text(
                            '${widget.CustomerName.toString().toUpperCase()}',
                           
                           
                          ),
                          padding: EdgeInsets.all(6),
                        ),
                      ],
                    ),


                



                  TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Address',
                           
                            
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '${_currentAddress}',
                          
                         
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),



                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Phone Number',
                           
                         
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '${widget.CustomerPhoneNumber}',
                         
                      
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),

                    
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Total Price',
                           
                       
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '${CustomerFoodPrice.toString()}৳',
                         
                        
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),



                    
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Delivery Fee',
                           
                     
                          ),
                          padding: EdgeInsets.all(6),
                        ),


                          Padding(
                          child: Text(
                            '0৳',
                         
                          ),
                          padding: EdgeInsets.all(6),
                        ),




                      ],
                    ),



                         
                    


                    



                  





      ]),



      











          ],
        ),);
    });



        }, icon: Icon(Icons.price_check_outlined))
        
        
            ],
            iconTheme: IconThemeData(color: Colors.white),
          
          
             toolbarHeight: 100, 
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                


                Text(
                  "Name: ${widget.CustomerName.toString().toUpperCase()}",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),

                Text(
                  "Phone No: ${widget.CustomerPhoneNumber}",
                  style:
                       TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),


                Text(
                  "Address: ${_currentAddress}",
                  style:
                       TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),

                  Text(
                  "Total Price: ${CustomerFoodPrice.toString()}৳",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),



              ],
            ),
            backgroundColor: ColorName().appColor,
            bottomOpacity: 0.0,
            elevation: 0.0,
          ),
        ),
        body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Color.fromRGBO(92, 107, 192, 1),
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
                 color: ColorName().appColor,
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: LastUpdatedFoodLength,
                    
                    itemBuilder: (BuildContext context, int index) {
              
              
                     
              
              
                     
              
                      
              
              
              
              
              
                      return Card(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          leading: Image.network(
                            "${LastUpdatedFood[index]["foodImageUrl"]}",
                          ),
                          title: Text(
                            "${LastUpdatedFood[index]["FoodName"]}",
                            style: TextStyle(
                                color: Color.fromARGB(255, 48, 2, 56),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            "${LastUpdatedFood[index]["Foodprice"]} Taka per ${LastUpdatedFood[index]["FoodUnit"]}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
              
              
                        Text(
                            "Order Amount: ${LastUpdatedFood[index]["FoodAmount"]}",
                            style: TextStyle(
                                color: ColorName().appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
              
                            
              
              
                                  SizedBox(
                                  width: 5,
                                ),
              
              
                                 Text(
                            "Order Price: ${LastUpdatedFood[index]["ThisFoodOrderPrice"]}৳",
                            style: TextStyle(
                                color: ColorName().appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
              
              
              
              
              
              
                                
                               
                           
                                SizedBox(
                                  width: 5,
                                ),
                              
              
                          
                              ],
                            ),
              
              
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ))));
                    },
                  ),
              ),



          
                     


                     
       );
  }
}



