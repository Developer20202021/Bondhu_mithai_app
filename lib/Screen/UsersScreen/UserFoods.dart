import 'package:bondhu_mithai_app/Screen/HomeScreen/EveryFoodScreen/EveryFoodScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



class UserFoods extends StatefulWidget {
  const UserFoods({super.key});

  @override
  State<UserFoods> createState() => _UserFoodsState();
}

class _UserFoodsState extends State<UserFoods> {

bool loading = true;

var DataLoad = "";
int moneyAdd =0;
var totalUserFoods = "";


var RestaurantOpen = "true";

   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('foodinfo');

Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


       if (AllData.length == 0) {

      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {


          //  for (var i = 0; i < AllData.length; i++) {

          //       var money = AllData[i]["BikePaymentDue"];
          //       int moneyInt = int.parse(money);

      

          //             setState(() {
          //               totalUserFoods = AllData.length.toString();
          //               moneyAdd = moneyAdd + moneyInt;
          //               AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
          //             });

       
          //         }



          setState(() {
               AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
               loading = false;
          });




     }


    print(AllData);
}









@override
  void initState() {
    
    super.initState();
    // TODO: implement initState
    getData();
   
  }





 Future refresh() async{


    setState(() {
      
  getData();

    });




  }













  @override
  Widget build(BuildContext context) {
    return Scaffold(
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











      appBar:  AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Foods", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,


        
      ),
      body: DataLoad == "0"? Center(child: Text("No Data Available")):RefreshIndicator(
        onRefresh: refresh,
        child: GridView.builder(
                itemCount: AllData.length,
                
                itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor)
                  ),
                  height: 330,

                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                        //Image Container 

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                width: 130.0,
                                height: 130.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Image.network(
                                  "${AllData[index]["foodImageUrl"]}",
                                  height: 130.0,
                                  width: 130.0,
                                ),
                              ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2, right: 3),
                          child: Text("${AllData[index]["FoodName"].toString().toUpperCase()}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                        ),

                        



  // DiscountAvailable
                      

                   AllData[index]["DiscountAvailable"]?Column(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2),
                          child: Text("Price: ${AllData[index]["FoodSalePrice"]}৳", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),),
                        ),
                        SizedBox(width: 9,),

                            Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2),
                          child: Text("Discount Price: ${AllData[index]["FoodDiscountPrice"]}৳", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                        ),



                   ],):
                   
                   
                   Padding(
                          padding: const EdgeInsets.only(left: 18,top: 2),
                          child: Text("Price: ${AllData[index]["FoodSalePrice"]}৳", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                        ),


                        





                AllData[index]["RestaurantOpen"]=="false"?Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Closed Now"),
                  ),
                ):        

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: 100, child:TextButton(onPressed: (){
                              
                    //      Navigator.push(
                    //   context,
                              
                    //          MaterialPageRoute(builder: (context) => AccessoriesSaleToCustomer(AccessoriesID: AllData[index]["AccessoriesID"], AccessoriesName: AllData[index]["AccessoriesName"], AccessoriesSalePrice: AllData[index]["AccessoriesSalePrice"], AccessoriesAvailableNumber: AllData[index]["AccessoriesAvailableNumber"])),
                    // );
                              
                              
                              
                              
                  }, child: Text("Order Now", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                       
                          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                        ),),),
                ),



                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [


                    IconButton(onPressed: (){


                                      
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EveryFoodScreen(DiscountAvailable: AllData[index]["DiscountAvailable"], FoodDiscountPrice: AllData[index]["FoodDiscountPrice"], FoodID: AllData[index]["FoodID"], FoodName: AllData[index]["FoodName"], FoodSalePrice: AllData[index]["FoodSalePrice"], foodImageUrl: AllData[index]["foodImageUrl"], FoodDescription: null, FoodUnit: null,)));

                         


                    }, icon: Icon(Icons.preview_outlined, color: Theme.of(context).primaryColor,)),





                    IconButton(onPressed: (){


                         


                    }, icon: Icon(Icons.favorite_outline, color: Theme.of(context).primaryColor,))





                  ],
                ),











                    ],





                  ),



                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                  mainAxisExtent: 350,
                ),
              ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}











void UserFoodsPageToCustomerProfile(BuildContext context, String CustomerNID){


  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerProfile(CustomerNID: CustomerNID)));


}





void EveryPaymentHistory(BuildContext context, String CustomerNID, String CustomerPhoneNumber){

  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentHistory(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber)));


}








 void CustomerAddPayment(BuildContext context, String CustomerNID, String CustomerPhoneNumber, String BikePaymentDue){


  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPaymentAdd(CustomerNID: CustomerNID, CustomerPhoneNumber: CustomerPhoneNumber, BikePaymentDue: BikePaymentDue,)));


}