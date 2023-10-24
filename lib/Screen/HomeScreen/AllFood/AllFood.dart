import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/EveryFoodScreen/EditFood.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/EveryFoodScreen/EveryFoodScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';




class AllFood extends StatefulWidget {
  const AllFood({super.key});

  @override
  State<AllFood> createState() => _AllFoodState();
}

class _AllFoodState extends State<AllFood> {


  // এখানে Date দিয়ে Data fetch করতে হবে। 

  bool loading = true;



var DataLoad = ""; 
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

      setState(() {
        DataLoad = "";
        
      });



      

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
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title:  Text("Foods", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
        
      ),
      body:loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15,),
              itemBuilder: (BuildContext context, int index) {
      
                    //  DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return    Padding(
                
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(

                        color: Colors.white,
                        elevation: 18,
                        shadowColor: ColorName().appColor,
                        borderRadius: BorderRadius.circular(20),
                    child: ListTile(



                          onLongPress: () {

                          showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          title: Text('Edit & Close This Item'),
                          content: Container(
                            height: 220,
                            child: Column(
                              
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: [
                          
                          
                          
                                
                                Text("আপনি যদি Food এর কোনো ভুল Information Edit করতে চান তবে Edit Button এ Press করুন। এবং যদি আপনার Food কে Public এ Visible করতে না চান তবে Close করুন।",style: TextStyle(fontSize:15,color: ColorName().appColor),),
                          
                                SizedBox(height: 20,),
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                                  Row(
                          
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                          
                          
                          
                                           Container(width: 100, child:TextButton(onPressed: () async{
                          
                          
                                  
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditFoodScreen(FoodID: AllData[index]["FoodID"], DiscountAvailable: AllData[index]["DiscountAvailable"], FoodDescription: AllData[index]["FoodDescription"], FoodDiscountPrice: AllData[index]["FoodDiscountPrice"], FoodName: AllData[index]["FoodName"], FoodSalePrice: AllData[index]["FoodSalePrice"], FoodTag: AllData[index]["FoodTag"], FoodUnit: AllData[index]["FoodUnit"])));
                          
                          
                                                   }, child: Text("Edit", style: TextStyle(color: Colors.white, fontSize: 13),), style: ButtonStyle(
                                             
                                        backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                            ),),),
                          
                          
                          
                          
                          
                          
                          
                          
                          
                            
                         AllData[index]["FoodPublicVisible"]=="yes"? Container(width: 100, child:TextButton(onPressed: () async{
                          
                                  setState(() {
                                    loading = true;
                                  });
                          
                          
                          
                                   final docUser = FirebaseFirestore.instance.collection("foodinfo").doc(AllData[index]["FoodID"]);
                          
                          
                                    var FoodData ={
                          
                                  "FoodPublicVisible":"no"
                          
                                  
                                    };
                          
                          
                          
                          
                          
                          
                          
                          
                          
                                           
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                                              docUser.update(FoodData).then((value) =>setState((){
                          
                          
                          
                                                loading = false;
                          
                                                getData();

                                               


                                                 
                          
                          
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => AllFood()),
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
                          
                          
                                  
                                                   
                          
                          
                                                   }, child: Text("Close", style: TextStyle(color: Colors.white, fontSize: 13),), style: ButtonStyle(
                                             
                                        backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                            ),),):Container(width: 100, child:TextButton(onPressed: () async{
                          
                                  setState(() {
                                    loading = true;
                                  });
                          
                          
                          
                                   final docUser = FirebaseFirestore.instance.collection("foodinfo").doc(AllData[index]["FoodID"]);
                          
                          
                                    var FoodData ={
                          
                                  "FoodPublicVisible":"yes"
                          
                                  
                                    };
                          
                          
                          
                          
                          
                          
                          
                          
                          
                                           
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                                              docUser.update(FoodData).then((value) =>setState((){
                          
                          
                          
                                                loading = false;
                                                 getData();

                                     
                          
                          
                          
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => AllFood()),
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
                          
                          
                                  
                                                   
                          
                          
                                                   }, child: Text("Open", style: TextStyle(color: Colors.white, fontSize: 13),), style: ButtonStyle(
                                             
                                        backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                            ),),),
                          
                          
                          
                          
                                  ],
                                )
                          
                          
                                                  
                          
                          
                            ],),
                          ),
                      )
                  );
                        

                      },





                      onTap: () {



                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EveryFoodScreen(FoodID: AllData[index]["FoodID"], DiscountAvailable: AllData[index]["DiscountAvailable"], FoodDescription: AllData[index]["FoodDescription"], FoodDiscountPrice: AllData[index]["FoodDiscountPrice"], FoodName: AllData[index]["FoodName"], FoodSalePrice: AllData[index]["FoodSalePrice"], FoodTag: AllData[index]["FoodTag"], FoodUnit: AllData[index]["FoodUnit"], foodImageUrl: AllData[index]["foodImageUrl"],)));
                      },
                  
                    
                          leading: Container(
                            width: 100,
                            height: 160,
                            child: Image.network(
                            
                              "${AllData[index]["foodImageUrl"]}",
                    
                              fit: BoxFit.cover,
                                                  
                            ),
                          ),
                        
                              title: Text("Price: ${AllData[index]["FoodSalePrice"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              
                              subtitle: Column(
                        
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${AllData[index]["FoodName"]}", style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                  
                                  Text("Food Unit: ${AllData[index]["FoodUnit"]}", style: TextStyle(fontWeight: FontWeight.bold),),

                                  Text("Public Visible: ${AllData[index]["FoodPublicVisible"]}", style: TextStyle(fontWeight: FontWeight.bold),),

                                 AllData[index]["DiscountAvailable"]? Text("Discount Price: ${AllData[index]["FoodDiscountPrice"].toString().toUpperCase()}৳", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),):Text(""),



                  
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                );
              },
            ),
      ));
  }
}