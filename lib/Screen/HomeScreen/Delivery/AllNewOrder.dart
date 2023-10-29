import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/AdminScreen/SelectDeliveryMan.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllNewOrder extends StatefulWidget {
  const AllNewOrder({super.key});

  @override
  State<AllNewOrder> createState() => _AllNewOrderState();
}

class _AllNewOrderState extends State<AllNewOrder> {



bool loading = true;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

Future<void> getData() async {
    // Get docs from collection reference

    
    Query CustomerOrderHistoryQuery = _collectionRef.where("DeliveryStatus", isEqualTo: "New");
    QuerySnapshot querySnapshot = await CustomerOrderHistoryQuery.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }
     

    print(AllData);
}





@override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
    getData();
    super.initState();
  }



    Future refresh() async{

    setState(() {
      // loading = true;
      getData();
    });

    // getData();




  }






















 





  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorName().appColor),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Customer New Order",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: loading?Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xFF1A1A3F),
            secondRingColor: Theme.of(context).primaryColor,
            thirdRingColor: Colors.white,
            size: 100,
          ),
        ):DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Center(
                  //   child: Text(
                  //     "Order History ",
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 48, 2, 56),
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 24),
                  //   ),
                  // ),
        
            
                  // SizedBox(
                  //   height: 20,
                  // ),
          for(var item in AllData)
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          leading: Icon(Icons.food_bank, color: ColorName().appColor,
                          size: 40,
                          ),
                          title: Text(
                            'ID:${item["OrderID"]}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 48, 2, 56),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          subtitle: Row(
                            children: [
                            item["DeliveryStatus"] =="New"?  Icon(
                                Icons.check,
                                color: Colors.green,
                              ):Text(""),
        
                              
        
                              
        
        
        
        
        
                              SizedBox(
                                width: 2,
                              ),
                              Text("${item["DeliveryStatus"]}"),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "${item["OrderDate"]}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Container(
                                child: DottedLine(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 4.0,
                              dashColor: Colors.black,
                              dashGradient: [Colors.grey, ColorName().appColor],
                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                              dashGapColor: Colors.transparent,
                              dashGapGradient: [Colors.grey, Colors.purple],
                              dashGapRadius: 0.0,
                            )),
        
                            SizedBox(
                              height: 30,
                            ),
              //  for (int j = 0; j < item["AllProduct"].; j++)
               for(var product in item["AllOrderFood"])
                            Row(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      '${product["foodImageUrl"]}',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${product["FoodName"]}",
                                      style: TextStyle(
                                          color: ColorName().appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                
                                    Row(
                                      children: [
                                        Text(
                                          "${product["FoodAmount"]}",
                                          style: TextStyle(
                                              color: ColorName().appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "${product["Foodprice"]}",
                                          style: TextStyle(
                                              color: ColorName().appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
        
                            SizedBox(
                              height: 10,
                            ),
        
                            // Row(
                            //   children: [
                            //     Center(
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(20.0),
                            //         child: SizedBox.fromSize(
                            //           size: Size.fromRadius(58), // Image radius
                            //           child: Image.network(
                            //             'https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000',
                            //             width: 50,
                            //             height: 50,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           "Burger Tasty Food",
                            //           style: TextStyle(
                            //               color: Colors.purple,
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 16),
                            //         ),
                            //         SizedBox(
                            //           height: 5,
                            //         ),
                            //         Row(
                            //           children: [
                            //             Icon(
                            //               Icons.star,
                            //               color: Colors.purple,
                            //             ),
                            //             Text("5"),
                            //             Text(
                            //               "/1kg / 120 Kcal",
                            //               style: TextStyle(
                            //                   color: Colors.grey,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 13),
                            //             ),
                            //           ],
                            //         ),
                            //         SizedBox(
                            //           height: 5,
                            //         ),
                            //         Row(
                            //           children: [
                            //             Text(
                            //               "1",
                            //               style: TextStyle(
                            //                   color: Colors.grey,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 20),
                            //             ),
                            //             Icon(
                            //               Icons.close,
                            //               color: Colors.grey,
                            //             ),
                            //             Text(
                            //               "15",
                            //               style: TextStyle(
                            //                   color: Colors.purple,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 20),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     )
                            //   ],
                            // ),
        
                            // SizedBox(
                            //   height: 30,
                            // ),
        
                            Container(
                                child: DottedLine(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 4.0,
                              dashColor: Colors.black,
                              dashGradient: [Colors.grey, ColorName().appColor],
                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                              dashGapColor: Colors.transparent,
                              dashGapGradient: [Colors.grey, ColorName().appColor],
                              dashGapRadius: 0.0,
                            )),
        
                            SizedBox(
                              height: 30,
                            ),
        
                            Row(
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "------",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${item["TotalFoodPrice"]}৳",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
        
                            SizedBox(
                              height: 20,
                            ),
        
                            // Calculation Section
                            Row(
                              children: [
                                Text(
                                  "Delivery",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "------",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${item["DeliveryFee"]}৳",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
        
                            SizedBox(
                              height: 20,
                            ),
        
                            Row(
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "-------",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${item["WithDeliveryFeeFoodPrice"]}৳",
                                  style: TextStyle(
                                      color: ColorName().appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
        
                            SizedBox(
                              height: 20,
                            ),
        
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: ColorName().appColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Information",
                                          style: TextStyle(
                                              color: ColorName().appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
        
                                    Text(
                                      "Name: ${item["CustomerName"].toString().toUpperCase()}",
                                      style: TextStyle(
                                          color: Color(0xffFB2576),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                       Text(
                                      "Phone No: ${item["CustomerPhoneNumber"]}",
                                      style: TextStyle(
                                          color: Color(0xffFB2576),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
        
                                    Text(
                                      "Email: ${item["CustomerEmail"]}",
                                      style: TextStyle(
                                          color: Color(0xffFB2576),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
        
                                    // Address Section
                                    SizedBox(
                                      height: 20,
                                    ),
        
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: ColorName().appColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Address",
                                          style: TextStyle(
                                              color: ColorName().appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
        
                                    Text(
                                      "${item["CustomerAddress"]}",
                                      style: TextStyle(
                                          color: ColorName().AppBoxBackgroundColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
        
                               
        
        
        
        
        
        
        
                              SizedBox(
                                      height: 20,
                                    ),
        
        
                                    Row(
                                      children: [
        
        
        
                                         Container(width: 190, child:TextButton(onPressed: (){




               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectDeliveryMan(CustomerEmail: item["CustomerEmail"], CustomerNumber: item["CustomerPhoneNumber"], OrderID: item["OrderID"],)));
        
        
                  //            final snackBar = SnackBar(
                  //   /// need to set following properties for best effect of awesome_snackbar_content
                  //   elevation: 0,
                  //   behavior: SnackBarBehavior.floating,
                  //   backgroundColor: Colors.transparent,
                  //   content: AwesomeSnackbarContent(
                  //     title: 'Successfully Added',
                  //     message:
                  //         'Your Product Price is Added Successfully',
        
                  //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  //     contentType: ContentType.success,
                  //   ),
                  // );
        
                  // ScaffoldMessenger.of(context)
                  //   ..hideCurrentSnackBar()
                  //   ..showSnackBar(snackBar);
        
        
        
        
                           }, child: Text("Select Delivery Man", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
                backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                            ),),),
                        Divider(thickness: 2, height: 30,color: Colors.purple,),
        
        
        
                                      ],
                                    )
        
        
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}