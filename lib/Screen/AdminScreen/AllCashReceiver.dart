// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bondhu_mithai_app/Screen/AdminScreen/CashReceiverProfile.dart';
import 'package:bondhu_mithai_app/Screen/AdminScreen/DeliveryManPaymentAdd.dart';
import 'package:bondhu_mithai_app/Screen/AdminScreen/DeliveryManProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class AllCashReceiver extends StatefulWidget {


 

  const AllCashReceiver({super.key, });

  @override
  State<AllCashReceiver> createState() => _AllCashReceiverState();
}

class _AllCashReceiverState extends State<AllCashReceiver> {








bool loading = false;

var DataLoad = "";

 



//  Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('CashReceiver');

Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
     
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }
     

    print(AllData);
}








Future BlockCashReceiver (String CashReceiverEmail, String AdminApprove) async{



                            setState(() {
                                  loading = true;
                                });


  final CashReceiverInfo =
    FirebaseFirestore.instance.collection('CashReceiver').doc(CashReceiverEmail);


  var  CashReceiverData = {

    "AdminApprove":AdminApprove =="true"?"false":"true",

    };





    
                                     // CustomerInfo Collection Update 
                          CashReceiverInfo.update(CashReceiverData).then((value) => setState((){


                            setState(() {
                                  loading = false;
                                });



                  AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Aproval Add Successfull',
                        desc: 'আপনার Approval দেওয়া সফলভাব্রে সম্পন্ন হয়েছে। ধন্যবাদ',
                        
                        btnOkOnPress: () {

                          refresh();


                        },
                        )..show();




              

                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);




                          }));





















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
      loading = true;
    });


    setState(() {
          
             getData();

     });


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
        title: const Text("All CashReceiver", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
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
                children:  [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) =>CashReceiverProfilePage(context,AllData[index]["CashReceiverEmail"]),
                    backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                    foregroundColor: Colors.white,
                    icon: Icons.info,
                    label: 'All Info',
                  ),
                ],
                          ),
              
                          // The end action pane is the one at the right or the bottom side.
                          endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [


                  //      SlidableAction(
                  //   // An action can be bigger than the others.
                  //   flex: 2,
                  //   onPressed: (context) =>DeliveryManPaymentAdd(context,AllData[index]["Cash"],AllData[index]["DeliveryManEmail"]),
                  //   backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                  //   foregroundColor: Colors.white,
                  //   icon: Icons.payment,
                  //   label: 'CashIn',
                  // ),





                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (context){

                      BlockCashReceiver(AllData[index]["CashReceiverEmail"], AllData[index]["AdminApprove"]);
                    },
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label:AllData[index]["AdminApprove"]=="true"? 'Block User':"Add User",
                  ),
                
                ],
                          ),
              
                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child:  ListTile(
                
                   leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(92, 107, 192, 1),
                      child: Text("${AllData[index]["CashReceiverName"][0].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
              
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AllData[index]["CashReceiverEmail"]}'),
                        Text('Phone: ${AllData[index]["CashReceiverPhoneNumber"]}'),
                        

                      //  int.parse(AllData[index]["DeliveryCount"])>0? Text('OnDelivery: ${AllData[index]["DeliveryCount"]}', style: TextStyle(color: Colors.green[600]),):Text('OnDelivery: ${AllData[index]["DeliveryCount"]}', style: TextStyle(color: Colors.red[600]),)
                      ],
                    ),
                    trailing:AllData[index]["AdminApprove"]=="true"? Text("Enabled", style: TextStyle(color:  Colors.green[600]),):Text("Disabled", style: TextStyle(color:  Colors.red[600]),),
                
                title: Text('${AllData[index]["CashReceiverName"]}', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)),
                        );
                      },
                      itemCount: AllData.length,
                    ),
              ),
    );
  }
}

void doNothing(BuildContext context) {}

void EveryPaymentHistory(BuildContext context){
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory()));
}



// void DeliveryManPaymentAdd(BuildContext context,String TotalCash, String DeliveryManEmail){
//   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryManPaymnetAdd(DeliveryManEmail: DeliveryManEmail, TotalCash: TotalCash)));
// }





void CashReceiverProfilePage(BuildContext context, String CashReceiverEmail){

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CashReceiverProfile(CashReceiverEmail: CashReceiverEmail)));
}