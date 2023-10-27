import 'package:bondhu_mithai_app/Screen/Dashboard/EveryCustomerAllDueOrder.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// 



class DeliveryManProfile extends StatefulWidget {


  final String DeliveryManEmail;
  





  const DeliveryManProfile({super.key, required this.DeliveryManEmail});

  @override
  State<DeliveryManProfile> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<DeliveryManProfile> {


bool loading = true;







   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("DeliveryMan");

Future<void> getData(String DeliveryManEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("DeliveryManEmail", isEqualTo: DeliveryManEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       loading = false;
        // getSaleData();
     });

    print(AllData);
}














  // Firebase All Customer Data Load

// List  AllOrderHistoryData = [];
// var BikeSaleDataLoad = "";



// Future<void> getSaleData() async {
//     // Get docs from collection reference
//     // QuerySnapshot querySnapshot = await _collectionRef.get();
//   // setState(() {
//   //   loading = true;
//   // });


//   CollectionReference _collectionCustomerOrderHistoryRef =
//     FirebaseFirestore.instance.collection('CustomerOrderHistory');

//     Query CustomerOrderHistoryQuery = _collectionCustomerOrderHistoryRef.where("DeliveryManEmail", isEqualTo: widget.DeliveryManEmail);
//     QuerySnapshot CustomerOrderHistoryQuerySnapshot = await CustomerOrderHistoryQuery.get();

//     // Get data from docs and convert map to List
//      AllOrderHistoryData = CustomerOrderHistoryQuerySnapshot.docs.map((doc) => doc.data()).toList();

//        if (AllOrderHistoryData.length == 0) {
//       setState(() {
//         BikeSaleDataLoad = "0";
//       });
       
//      } else {

//       setState(() {
      
//        AllOrderHistoryData = CustomerOrderHistoryQuerySnapshot.docs.map((doc) => doc.data()).toList();
//        loading = false;
//      });
       
//      }

//     print(AllOrderHistoryData);
// }


















@override
  void initState() {
    // TODO: implement initState
    
    getData(widget.DeliveryManEmail);

    // getSaleData();
    super.initState();
  }



  Future refresh() async{


    setState(() {
            loading = true;
            
           getData(widget.DeliveryManEmail);
          //  getSaleData();

    });

  }
















  @override
  Widget build(BuildContext context) {




    


 

    return  Scaffold(
      backgroundColor: Colors.white,

      


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () async{



                   FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                    }
                  });





                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {

    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));


                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),),
      ),

      
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Delivery Man Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: loading?Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xFF1A1A3F),
            secondRingColor: Theme.of(context).primaryColor,
            thirdRingColor: Colors.white,
            size: 100,
          ),
        ):Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      
                      Center(
                        child:  CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "${AllData[0]["DeloiveryManImageUrl"]}",
                          ),
                        ),
                      ),
              
               SizedBox(
                        height: 20,
                      ),
      
      
                  Table(
                       border: TableBorder(
                       horizontalInside:
                  BorderSide(color: Colors.white, width: 10.0)),
                      textBaseline: TextBaseline.ideographic,
                        children: [
      
                  
                  
      
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["DeliveryManName"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),
      
      
      
      
      
      
      
      
                  
      
                        TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Email", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["DeliveryManEmail"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
                         TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["DeliveryManAddress"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
      
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["DeliveryManPhoneNumber"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),




                                //  TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                //   Container(child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Text("First Order Time", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                //   )),
                                //   Container(child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Text("${AllData[0]["FirstOrderDate"]}", style: TextStyle(fontSize: 15.0),),
                                //   )),
                                
                                // ]),
      
      
      
                   
      
                          
                      
                                
      
                           TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("RegistrationType", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["registrationType"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                         
                          
      
      
                   
      
                      
      
                         
                    
                       
                        ],
                      ),


                    SizedBox(height: 35,),



                Container(
                width: 400,
                height: 300,
                  decoration: BoxDecoration(
                  color: ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color: Colors.grey
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
                    child: Image.network("${AllData[0]["DeloiveryManNIDFrontImageUrl"]}", fit: BoxFit.cover),
                  ),






                         SizedBox(height: 25,),



                Container(
                width: 400,
                height: 300,
                  decoration: BoxDecoration(
                  color: ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color: Colors.grey
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
                    child: Image.network("${AllData[0]["DeloiveryManNIDFrontImageUrl"]}", fit: BoxFit.cover),
                  ),




      //               // for(int i = 0; i<AllOrderHistoryData.length; i++)

      //                BikeSaleDataLoad == "0" ?Text("No Data Available"):Padding(
      //             padding:  EdgeInsets.all(8.0),
      //             child: Container(
                       
      //            decoration: BoxDecoration(
      //             color: ColorName().AppBoxBackgroundColor,
     

      //             border: Border.all(
      //                       width: 2,
      //                       color: ColorName().AppBoxBackgroundColor
      //                     ),
      //             borderRadius: BorderRadius.circular(10)      
      //            ),
      
                    
      //               child: ListTile(
                      
                   
                        
      //                         title: Text("Order No:- ${(i+1).toString()}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      //                         trailing: TextButton(onPressed: (){
      
      
      //                                 //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfPreviewPage(CustomerName: AllData[0]["CustomerName"].toString().toUpperCase(), DeliveryManEmail: AllData[0]["DeliveryManEmail"], DeliveryManEmail: AllData[0]["DeliveryManEmail"], CustomerFileNo: AllSaleData[i]["BikeDeliveryNo"], CustomerAddress: AllData[0]["CustomerAddress"], BikeName: AllSaleData[i]["BikeName"], BikeEngineNo: AllSaleData[i]["BikeEngineNo"], BikeChassisNo: AllSaleData[i]["BikeChassisNo"], BikeSalePrice: AllSaleData[i]["BikeSalePrice"], BikeCashInAmount: AllSaleData[i]["BikeBillPay"], BikePaymentDue: AllSaleData[i]["BikePaymentDue"], BikeColor: AllSaleData[i]["BikeColor"], BikeCondition: AllSaleData[i]["BikeConditionMonth"])));
      
      
                               
      
      
      
      
      
      //                         }, child: Text("Print", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                               
      //             backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
      //           ),)
      
      // ,
      //                         subtitle: Column(
      //                           mainAxisAlignment: MainAxisAlignment.start,
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
                                 
      //                             Text("Name:${AllOrderHistoryData[i]["CustomerName"].toString().toUpperCase()}"),
      //                             Text("Phone Number:${AllOrderHistoryData[i]["DeliveryManEmail"]}"),
                  
      //                             Text("Order Date: ${AllOrderHistoryData[i]["OrderDate"]}"),

      //                             Text("Order Type: ${AllOrderHistoryData[i]["OrderType"]}"),

      //                             Text("Total Price: ${AllOrderHistoryData[i]["TotalFoodPrice"]} ৳"),
                                  
                                

      //                             Text("Chairs:  ${AllOrderHistoryData[i]["Chairs"].toString()}"),

                                


      //                              Text("Cash In: ${AllOrderHistoryData[i]["CashIn"]} "),

      //                               Text("Receiver Email: ${AllOrderHistoryData[i]["MoneyReceiverEmail"]} "),

      //                               Text("Receiver Name: ${AllOrderHistoryData[i]["MoneyReceiverName"].toString().toUpperCase()} "),


      //                             Text("${AllOrderHistoryData[i]["CustomerType"]}"),
      //                           ],
      //                         ),
                        
                        
                        
      //                       ),
      //             ),
      //           ),




      
      
      
      
      
      
      
      
                      SizedBox(height: 15,),


                      
      // AllData[0]["CustomerType"] =="Due"?
      
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   crossAxisAlignment: CrossAxisAlignment.end,
      //                   children: [
      
      //                     Container(width: 150, child:TextButton(onPressed: (){
      
      
      //                             //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EveryCustomerAllDueOrder(indexNumber: "", DeliveryManEmail: AllData[0]["DeliveryManEmail"])));
      
      
                           
      
      
      
      
      
      //                     }, child: Text("Due Order", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
      //             backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
      //           ),),),
      //                   ],
      //                 ):Text(""),
      
      
                 
      
      
      
      
                     
      
      
      
              
              
              
              
              
                    ],
                  ),
                ),
              ),
      ),
        
        floatingActionButton: FloatingActionButton(
      onPressed: (){




          // Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => EditPreviousCustomer(DeliveryManEmail: AllData[0]["DeliveryManEmail"] , CustomerAddress:  AllData[0]["CustomerAddress"], CustomerName: AllData[0]["CustomerName"] , DeliveryManEmail: AllData[0]["DeliveryManEmail"]  , CustomerEmail: AllData[0]["CustomerEmail"] , CustomerFatherName: AllData[0]["CustomerFatherName"] , CustomerMotherName:  AllData[0]["CustomerMotherName"], CustomerGuarantor1Name:  AllData[0]["CustomerGuarantor1Name"], CustomerGuarantor1PhoneNumber:  AllData[0]["CustomerGuarantor1PhoneNumber"], CustomerGuarantor1Address:  AllData[0]["CustomerGuarantor1Address"], CustomerGuarantor2Name:  AllData[0]["CustomerGuarantor2Name"], CustomerGuarantor2PhoneNumber:  AllData[0]["CustomerGuarantor2PhoneNumber"], CustomerGuarantor2NID:  AllData[0]["CustomerGuarantor2NID"], CustomerGuarantor2Address: AllData[0]["CustomerGuarantor2Address"] , CustomerGuarantor1NID: AllData[0]["CustomerGuarantor1NID"])),
          //             );











      },
        tooltip: 'Edit',
        child: const Icon(Icons.edit),
      ), 
      
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