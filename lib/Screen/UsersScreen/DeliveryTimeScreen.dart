import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class DeliveryTimeScreen extends StatefulWidget {
  const DeliveryTimeScreen({super.key});

  @override
  State<DeliveryTimeScreen> createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {

    TextEditingController CustomerCommentController = TextEditingController();

  var deliveryStatus = "delivered";











  @override
  Widget build(BuildContext context) {


FocusNode myFocusNode = new FocusNode();


  







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
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),


      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
        
            children: [

            


                 deliveryStatus=="cooking"? Column(
                    children: [

                      Center(
                        child: Text("আপনার খাবার প্রস্তুত হচ্ছে।", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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




                deliveryStatus=="Packaging"?  Column(
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








           deliveryStatus=="delivery"?  Column(
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



              
              deliveryStatus=="delivered"?  Column(
                    children: [
                     

                      Center(
                        child: Text("Enjoy Your Meal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ),

                      SizedBox(height: 20,),


                   



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
            




                    ],
                  ):Text(""),







        
        
        
              
            ],
        
        
        
        
          ),
        ),



      ),




    );
  }
}