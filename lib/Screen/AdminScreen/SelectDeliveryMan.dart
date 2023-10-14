// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class AllStaff extends StatefulWidget {


 

  const AllStaff({super.key, });

  @override
  State<AllStaff> createState() => _AllStaffState();
}

class _AllStaffState extends State<AllStaff> {








  bool loading = false;

var DataLoad = "";

 



// // Firebase All Customer Data Load

// List  AllData = [];


//   CollectionReference _collectionRef =
//     FirebaseFirestore.instance.collection('admin');

// Future<void> getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await _collectionRef.get();

//     // Get data from docs and convert map to List
//      AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
//      if (AllData.length == 0) {
//       setState(() {
//         DataLoad = "0";
//       });
       
//      } else {

//       setState(() {
     
//        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
//        loading = false;
//      });
       
//      }
     

//     print(AllData);
// }





// @override
//   void initState() {
//     // TODO: implement initState
//     setState(() {
//       loading = true;
//     });
//     getData();
//     super.initState();
//   }



  
  Future refresh() async{


  //   setState(() {
      
  // getData();

  //   });


  }












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(92, 107, 192, 1),
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

                  //     FirebaseAuth.instance
                  // .authStateChanges()
                  // .listen((User? user) {
                  //   if (user == null) {
                  //     print('User is currently signed out!');
                  //   } else {
                  // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                  //   }
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


                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2")));



                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),






             
           IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.admin_panel_settings_rounded,
                  color: Colors.white,
                  size: 25,
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
                  size: 25,
                ),
              ),
            ],
          ),),
      ),






      appBar:  AppBar(
        
        
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        automaticallyImplyLeading: false,
        title: const Text("Set Delivery Man", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                        secondRingColor: Color.fromRGBO(92, 107, 192, 1),
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
                color: Color.fromRGBO(92, 107, 192, 1),
                onRefresh: refresh,
                child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: const ValueKey(0),
              
                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
              
                // A pane can dismiss the Slidable.
             
              
                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                    foregroundColor: Colors.white,
                    icon: Icons.info,
                    label: 'All Info',
                  ),
                ],
                          ),
              
                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: const ActionPane(
                motion: ScrollMotion(),
                children: [


                       SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: BlockYourUser,
                    backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label: 'Add',
                  ),





                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: BlockYourUser,
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label: 'Send SMS',
                  ),
                
                ],
                          ),
              
                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child:  ListTile(
                
                   leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                      child: Text("m".toString().toUpperCase(),style: TextStyle(color: Colors.white)),
                    ),
              
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('mahadikaushik8888@gmail.com'),
                        Text('Phone: 01721915550'),
                      ],
                    ),
                    trailing: Text("Paid", style: TextStyle(color:  Colors.green[600]),),
                
                title: Text('Mahadi Hasan', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)),
                        );
                      },
                      itemCount: 20,
                    ),
              ),
    );
  }
}

void doNothing(BuildContext context) {}

void EveryPaymentHistory(BuildContext context){
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory()));
}





void BlockYourUser(BuildContext context){
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlockAdmin()));
}