import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class UserProfile extends StatefulWidget {

  final CustomerID;
  final CustomerPhoneNumber;




  const UserProfile({super.key, required this.CustomerID, required this.CustomerPhoneNumber});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var uuid = Uuid();

  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController CustomerAddressController = TextEditingController();
  TextEditingController ProblemShareCustomerNameController = TextEditingController();
  TextEditingController ProblemShareCustomerPhoneNumberController = TextEditingController();
  TextEditingController ProblemShareProblemMessageController = TextEditingController();









bool loading = true;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];


  // Firebase All Customer Data Load

List  AllSearchData = [];


Future<void> getSearchData(String phoneNumber) async {
    // Get docs from collection reference
     CollectionReference _SearchCollectionRef =
    FirebaseFirestore.instance.collection('CustomerInfo');

     Query _SearchCollectionRefQuery = _SearchCollectionRef.where("CustomerPhoneNumber", isEqualTo: phoneNumber);


    QuerySnapshot SearchCollectionQuerySnapshot = await _SearchCollectionRefQuery.get();

    // Get data from docs and convert map to List
     AllSearchData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllSearchData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;

      });
       
     } else {

      setState(() {
     
      AllData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }
     

    print(AllData);
}





var AllOrderHistoryData =[];
var AllOrder = 0;

Future<void> getOrderHistorySearchData(String phoneNumber) async {
    // Get docs from collection reference
     CollectionReference _SearchCollectionRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

     Query _SearchCollectionRefQuery = _SearchCollectionRef.where("CustomerPhoneNumber", isEqualTo: phoneNumber);


    QuerySnapshot SearchCollectionQuerySnapshot = await _SearchCollectionRefQuery.get();

    // Get data from docs and convert map to List
     AllOrderHistoryData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
      AllOrder = AllOrderHistoryData.length;
     });
     

}
















@override
  void initState() {

    getOrderHistorySearchData(widget.CustomerPhoneNumber);

    setState(() {
      loading = true;
    });
    // TODO: implement initState
    getSearchData(widget.CustomerPhoneNumber);

    super.initState();
  }








  Future refresh() async{


    setState(() {
  getOrderHistorySearchData(widget.CustomerPhoneNumber);
  getSearchData(widget.CustomerPhoneNumber);

    });




  }










//Customer Name Update

 Future updateData(String CustomerName,) async{

    setState(() {
      loading = true;
    });




         final docUser = FirebaseFirestore.instance.collection("CustomerInfo").doc(widget.CustomerID);

                  final UpadateData ={

                    "CustomerName":CustomerName

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");

                  getSearchData(widget.CustomerPhoneNumber);

          

                  setState(() {


                        CustomerNameController.clear();
                        loading = false;

                        
                      });




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }








//Customer Address Update

 Future updateAddressData(String CustomerAddress,) async{

    setState(() {
      loading = true;
    });




         final docUser = FirebaseFirestore.instance.collection("CustomerInfo").doc(widget.CustomerID);

                  final UpadateData ={

                    "CustomerAddress":CustomerAddress

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");

                  getSearchData(widget.CustomerPhoneNumber);

          

                  setState(() {
                        CustomerAddressController.clear();
                        loading = false;
                        
                      });




                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));



  }







  // help support Data upload 


  Future HelpSupport(String problemShareID, CustomerName, CustomerPhoneNumber, CustomerProblemMessage) async{


     final CustomerProblemCollection = FirebaseFirestore.instance.collection("CustomerProblems");


     var saveData ={

      "CustomerName":CustomerName,
      "CustomerPhoneNumber":CustomerPhoneNumber,
      "ProblemShareID":problemShareID,
      "CustomerProblemMessage":CustomerProblemMessage,
      "Date":DateTime.now().toLocal().toIso8601String()


     };



     

         CustomerProblemCollection.doc(problemShareID).set(saveData).then((value) =>setState((){

          print("Done");



                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TableStructure()),
                // );





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


















  @override
  Widget build(BuildContext context) {



    var problemShareID = uuid.v4();









     bool isSwitched = false;  
  var textValue = 'Switch is OFF';  
  
  void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true;  
        textValue = 'Switch Button is ON';  
      });  
      print('Switch Button is ON');  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
        textValue = 'Switch Button is OFF';  
      });  
      print('Switch Button is OFF');  
    }  
  }  
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Center(
            child: Text(
              "Profile",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              
                              ListTile(
                                leading: Icon(Icons.share, color: Colors.purple,),
                                title: Text('Share'),
                                trailing: Container(
                                        width: 100,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Share",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.purple),
                                          ),
                                        ),
                                      ),
                              ),
                              // Switch(
                              //     // thumb color (round icon)
                              //       activeColor: Colors.blue,  
                              //       activeTrackColor: Colors.yellow,  
                              //       inactiveThumbColor: Colors.redAccent,  
                              //       inactiveTrackColor: Colors.orange,  
                              //     // boolean variable value
                              //     value: isSwitched,  
                              //     // changes the state of the switch
                              //     onChanged: toggleSwitch, ),

                              ListTile(
                                leading: Icon(Icons.dark_mode, color: Colors.purple,),
                                title: Text('Dark Mode'),
                                trailing:  Switch(
                                  // thumb color (round icon)
                                    activeColor: Colors.purple,  
                                    activeTrackColor: Colors.grey,  
                                    inactiveThumbColor: Colors.green,  
                                    inactiveTrackColor: Colors.white,  
                                  // boolean variable value
                                  value: isSwitched,  
                                  // changes the state of the switch
                                  onChanged: toggleSwitch, ),
                              ),


                             ListTile(
                                leading: Icon(Icons.edit,
                                color: Colors.purple,),
                                title: Text('Edit Profile'),
                                trailing: Container(
                                        width: 100,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.purple),
                                          ),
                                        ),
                                      ),
                              ),





                               ListTile(
                                leading: Icon(Icons.change_circle,
                                color: Colors.purple,),
                                title: Text('Change Theme'),
                                trailing: Container(
                                        width: 100,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Change",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.purple),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.settings),
                  color: Colors.purple,
                ))
          ],
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
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
                onRefresh: refresh,
                child: SingleChildScrollView(
                          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "${AllData[0]["CustomerImageURL"]}",
                          ),
                        ),
                        Center(
                          child: Text(
                            "${AllData[0]["CustomerName"]}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${AllData[0]["CustomerEmail"]}",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.purple,
                                    ),
                                    Text(
                                      "Order: ${AllOrder.toString()}",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 131, 90, 7),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.point_of_sale,
                                      color: Colors.purple,
                                    ),
                                    Text(
                                      "Points: 00 ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 131, 90, 7),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Colors.purple,
                                    ),
                                    Text(
                                      "Connection: 00 ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 131, 90, 7),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              
                    //Information
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(
                                    Icons.info,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "Information",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 48, 2, 56),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
              
                                    // Name Section
                                    TextField(
                                      controller: CustomerNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter Name',
              
                                        hintText: 'Enter Your Name',
              
                                        //  enabledBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                        //     ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                    ),
              
                                    SizedBox(
                                      height: 20,
                                    ),
              
                                   
              
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: TextButton(
                                            onPressed: () async{

                                              updateData(CustomerNameController.text.trim().toLowerCase());






                                            },
                                            child: Text(
                                              "Save",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<Color>(
                                                      Colors.purple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )))),
              
                    SizedBox(
                      height: 14,
                    ),
              
                    // Connect Friend
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                    leading: Icon(
                                      Icons.share,
                                      color: Colors.purple,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "Connect Friend",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 48, 2, 56),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))))),
              
                    SizedBox(
                      height: 14,
                    ),
              
                    // get Membership
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(
                                    Icons.card_membership,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "Get Membership",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 48, 2, 56),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Send Your Profile",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<Color>(
                                                      Colors.purple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )))),
              
                    SizedBox(
                      height: 14,
                    ),
              
                    // Earn points
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "Earn Points",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 48, 2, 56),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )))),
              
                    SizedBox(
                      height: 14,
                    ),
              
                    // Change Address
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "Change Address",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 48, 2, 56),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 14,
                                    ),
              
                                    // Change Address Section
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter New Address',
              
                                        hintText: 'Enter New Address',
              
                                        //  enabledBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                        //     ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                    ),
              
                                    SizedBox(
                                      height: 14,
                                    ),
              
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: TextButton(
                                            onPressed: () async{


                                              updateAddressData(CustomerAddressController.text.trim());


                                            },
                                            child: Text(
                                              "Save",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<Color>(
                                                      Colors.purple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )))),
              
                    SizedBox(
                      height: 14,
                    ),
              
                    // Settings
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                    leading: Icon(
                                      Icons.settings,
                                      color: Colors.purple,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "Settings",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 48, 2, 56),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))))),
              
                    SizedBox(
                      height: 14,
                    ),
              
                    // Help & Support
                    Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                            child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(
                                    Icons.contact_support,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "Help & Support",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 48, 2, 56),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 14,
                                    ),
                                    // Name Section
                                    TextField(
                                      controller: ProblemShareCustomerNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Name',
              
                                        hintText: 'Your Name',
              
                                        //  enabledBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                        //     ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                    ),
              
                                    SizedBox(
                                      height: 14,
                                    ),
                                    // Email Section
                                    TextField(
                                      controller: ProblemShareCustomerPhoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Phone Number',
              
                                        hintText: 'Phone Number',
              
                                        //  enabledBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                        //     ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                    ),
              
                                    SizedBox(
                                      height: 14,
                                    ),
              
                                    // Name Section
                                    TextField(
                                     controller: ProblemShareProblemMessageController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Write Problem',
              
                                        hintText: 'Write Problem',
              
                                        //  enabledBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                        //     ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 5,
                                    ),
              
                                    SizedBox(
                                      height: 14,
                                    ),
              
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: TextButton(
                                            onPressed: () async{

                                              
                                              HelpSupport(problemShareID, ProblemShareCustomerNameController.text.trim().toLowerCase(), ProblemShareCustomerPhoneNumberController.text.trim().toLowerCase(), ProblemShareProblemMessageController.text.trim().toLowerCase());


                                            },
                                            child: Text(
                                              "Submit",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<Color>(
                                                      Colors.purple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )))),
                  ]))),
              ));
  }
}

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double w = size.width;
//     double h = size.height;
//     final path = Path();
//     path.lineTo(0, h);
//     path.quadraticBezierTo(w * 0.5, h - 700, w, h);

//     path.lineTo(w, 0);

//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }

// }

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
