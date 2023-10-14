import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';



class DeliveryManCustomers extends StatefulWidget {

  final indexNumber ;



  const DeliveryManCustomers({super.key, required this.indexNumber});

  @override
  State<DeliveryManCustomers> createState() => _DeliveryManCustomersState();
}

class _DeliveryManCustomersState extends State<DeliveryManCustomers> {

TextEditingController customerPhoneNumberController = TextEditingController();

var searchField ="";

bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('customer');

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











// Firebase All Customer Data Load

List  AllSearchData = [];


Future<void> getSearchData(String phoneNumber) async {
    // Get docs from collection reference
     CollectionReference _SearchCollectionRef =
    FirebaseFirestore.instance.collection('customer');

     Query _SearchCollectionRefQuery = _SearchCollectionRef.where("CustomerPhoneNumber", isEqualTo: phoneNumber);


    QuerySnapshot SearchCollectionQuerySnapshot = await _SearchCollectionRefQuery.get();

    // Get data from docs and convert map to List
     AllSearchData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();
     if (AllSearchData.length == 0) {
      setState(() {
        DataLoad = "0";
      });
       
     } else {

      setState(() {
     
       AllData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();
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
      
  getData();

    });




  }









  @override
  Widget build(BuildContext context) {

 FocusNode myFocusNode = new FocusNode();


   




    return Scaffold(

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


              widget.indexNumber == "4"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.person_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
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




      backgroundColor: Colors.white,
      appBar:  AppBar(

        toolbarHeight: searchField=="search"?100:56,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title:  searchField=="search"?ListTile(

          leading: IconButton(onPressed: (){


            setState(() {
              loading = true;
              searchField = "";
            });



            getSearchData(customerPhoneNumberController.text);


            print("___________________________________________________________________________________________${customerPhoneNumberController.text}_____________________");


            // comming soon 















          }, icon: Icon(Icons.search, color: Theme.of(context).primaryColor,)),
          title: TextField(

                      keyboardType: TextInputType.phone,
                      
                      decoration: InputDecoration(
                        
                          border: OutlineInputBorder(),
                          labelText: 'Customer Phone No',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Customer Phone No',
            
                           enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                          
                          
                          ),

                        controller: customerPhoneNumberController,
                  
                    ),
            
            



        ):Text("Customers", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [


          searchField == "search"?IconButton(onPressed: (){


            // showSearch(context: context, delegate: MySearchDelegate());

            


                      setState(() {
                              
                              searchField = "";
                              customerPhoneNumberController.text ="";
                            });





            










          }, icon: Icon(Icons.close)):IconButton(onPressed: (){


            setState(() {
              
              searchField = "search";
            });


          

            








          

          }, icon: Icon(Icons.search))







        ],
        
      ),
      body: DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
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
                    onPressed: (context) => DeliveryManCustomersPageToCustomerProfile(context,AllData[index]["CustomerNID"] ),
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) => DeliveryManCustomersPageToCustomerProfile(context,AllData[index]["CustomerNID"]),
                    backgroundColor: Color(0xFF21B7CA),
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
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (context) => AllData[index]["CustomerType"]=="Paid"?(Context) => EveryPaymentHistory(context,AllData[index]["CustomerNID"] ,AllData[index]["CustomerPhoneNumber"] ): CustomerAddPayment(context,AllData[index]["CustomerNID"] ,AllData[index]["CustomerPhoneNumber"], AllData[index]["BikePaymentDue"]),
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.payment,
                    label: 'Give OTP',
                  ),
                  
                ],
              ),
      
              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child:  ListTile(
                
                   leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text("${AllData[index]["CustomerName"][0].toString().toUpperCase()}",style: TextStyle(color: Colors.white),),
        ),
      
        subtitle:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NID:${AllData[index]["Address"]}'),
            Text('Phone No:${AllData[index]["CustomerPhoneNumber"]}'),
          ],
        ),
        trailing: Text("${AllData[index]["CustomerType"]}"),
                
                title: Text("${AllData[index]["CustomerName"]}", style: TextStyle(
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

void DeliveryManCustomersPageToCustomerProfile(BuildContext context, String CustomerNID){



  
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerProfile(CustomerNID: CustomerNID)));
}





void EveryPaymentHistory(BuildContext context, String CustomerNID, String CustomerPhoneNumber){



  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber)));
}








 void CustomerAddPayment(BuildContext context, String CustomerNID, String CustomerPhoneNumber, BikePaymentDue){







  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPaymentAdd(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber, BikePaymentDue: BikePaymentDue,)));
}






// class MySearchDelegate extends SearchDelegate {


//   @override
//   Widget? buildLeading(BuildContext context)=>IconButton(onPressed:()=>close(context, null), icon: Icon(Icons.arrow_back));



//   @override
//   List<Widget>? buildActions(BuildContext context)=>[IconButton(onPressed:(){


//     if (query.isEmpty) {


//       close(context, null);
      
//     } else {

//       query ="";
      
//     }



//   }, icon: Icon(Icons.clear))];












  

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }