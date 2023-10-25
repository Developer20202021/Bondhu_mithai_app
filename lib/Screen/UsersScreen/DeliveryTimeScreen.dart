import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/UsersScreen/UserFoods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';






class DeliveryTimeScreen extends StatefulWidget {


  final CustomerPhoneNumber;
  final OrderID;
  final allFood;
  



  const DeliveryTimeScreen({super.key, required this.CustomerPhoneNumber, required this.OrderID, required this.allFood});

  @override
  State<DeliveryTimeScreen> createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {

    TextEditingController CustomerCommentController = TextEditingController();


  var uuid = Uuid();


  bool loading = false;

  double foodRating = 3.0;






// hive database

  final _mybox = Hive.box("mybox");


  List AllFoodID = [];





 Future ListForLoop() async{



  _mybox.delete("FoodIDForReview");




  for (var i = 0; i < widget.allFood.length; i++) {

    

    AllFoodID.insert(AllFoodID.length, widget.allFood[i]["FoodID"]);

    
  }


  _mybox.put("FoodIDForReview", AllFoodID);



 }
















  List  AllData = [];




Future<void> getData() async {

  setState(() {
    loading = true;
  });



  
   try {




    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');
      
      Query CustomerOrderHistoryQuery = _collectionRef.where("OrderID", isEqualTo: widget.OrderID).where("CustomerPhoneNumber", isEqualTo: widget.CustomerPhoneNumber).where("OrderType", isEqualTo: "online");



    QuerySnapshot querySnapshot = await CustomerOrderHistoryQuery.get();


    

    // Get data from docs and convert map to List
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


      print(AllData);
  


     




     if (AllData.length == 0) {




          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserFoods()));

    

     } else {




  
      

      setState(() {
       
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
       

       
     }





     
   } catch (e) {
     
   }



    print(AllData);
}








// Food Review Data send to Firebase 


Future ReviewForFood(String ReviewID) async{


    setState(() {
      loading = true;
    });




          for (var i = 0; i < AllFoodID.length; i++) {



            final CustomerOrderHistoryCollection = FirebaseFirestore.instance.collection("FoodReview");


          var FoodReviewMsg = {

            "ReviewID":ReviewID,
            "FoodID":AllFoodID[i],
            "ReviewMsg":CustomerCommentController.text.trim().toLowerCase(),
            "rating":foodRating.toString(),
            "CustomerName":AllData[0]["CustomerName"],
            "Date":DateTime.now().toLocal().toIso8601String()



          };

           CustomerOrderHistoryCollection.doc(ReviewID).set(FoodReviewMsg).then((value) =>setState((){



             _mybox.delete("FoodIDForReview");



            setState(() {
              loading = false;
            });

           



                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserFoods()),
                );





                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
                        content: const Text('Something Wrong'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      )));


















            
          }









          


}


















@override
  void initState() {


    ListForLoop();
     
    // TODO: implement initState
    getData();
     
    super.initState();
  }



 Future refresh() async{


    setState(() {

  ListForLoop();
      
  getData();

    });




  }














  @override
  Widget build(BuildContext context) {


FocusNode myFocusNode = new FocusNode();


  
 var ReviewID = uuid.v4();






    return Scaffold(


      


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: ColorName().appColor,
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


                  // FirebaseAuth.instance
                  // .authStateChanges()
                  // .listen((User? user) {
                  //   if (user == null) {
                  //     print('User is currently signed out!');
                  //   } else {
                  // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                  // //   }
                  // });

                  
                   



                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2")));



                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3")));



                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),


              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
      ),




        appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
     
        title: const Text("",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),


      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):RefreshIndicator(
                onRefresh: refresh,
                child: SingleChildScrollView(
              
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                      
                          children: [
              
                          
              
              
                   AllData[0]["DeliveryStatus"]=="New"? Column(
                      children: [
              
                        Center(
                          child: Text("আপনার Order Delivery Man কে দেওয়া হচ্ছে।", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ),
              
                        SizedBox(height: 20,),
              
              
              
                        Center(
                            child: Lottie.asset(
                            'lib/images/animation_lnhlbfie.json',
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300
                            ),
                          ),
                      ],
                    ):Text(""),
              
              
              
              
                  AllData[0]["DeliveryStatus"]=="packaging"?  Column(
                      children: [
                       
              
                        Center(
                          child: Text("আপনার খাবার প্যাকেটজাত করা হচ্ছে।", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ),
              
                        SizedBox(height: 20,),
              
              
              
                        Center(
                            child: Lottie.asset(
                            'lib/images/animation_lnis5mhm.json',
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300
                            ),
                          ),
                      ],
                    ):Text(""),
              
              
              
              
              
              
              
              
                         AllData[0]["DeliveryStatus"]=="OnTheRoad"?  Column(
              
              
                      children: [
                       
              
                        Center(
                          child: Text("আপনার খাবার বাসায় যাচ্ছে", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ),
              
                        SizedBox(height: 20,),
              
              
                     
              
              
              
                        Center(
                            child: Lottie.asset(
                            'lib/images/animation_lnhlgn0q.json',
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300
                            ),
                          ),
                      ],
                    ):Text(""),
              
              
              
                
                AllData[0]["DeliveryStatus"]=="DeliveryComplete"? Column(
                      children: [
                       
              
                      
              
                  
              
              
                     
              
              
              
                        Center(
                            child: Lottie.asset(
                            'lib/images/animation_lnisii5q.json',
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300
                            ),
                          ),
              
              
              
              
                           TextField(
                        
                       
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Your Comment',
                             labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
                    ),
                            hintText: 'Enter Your Comment',
                          
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: ColorName().appColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                        controller: CustomerCommentController,
                      ),
              
              
              
                RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
              
                        setState(() {
                          foodRating = rating;
                        });
                        print(rating);
                      },
                    ),
              
              
              
              
                    SizedBox(height: 10,),
              
              
                    
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 100, child:TextButton(onPressed: () async{
                                
                           
                      
                                ReviewForFood(ReviewID);
                                
                                
                                
                    }, child: Text("Save", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                            backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                          ),),),
                  ),
                          
              
              
              
              
                      ],
              
              
                    ):Text(""),
              
              
              
              
              
              
              
                      
                      
                      
                
                          ],
                      
                      
                      
                      
                        ),
                      ),
              
              
              
                    ),
              ),




    );
  }
}