import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
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

                      onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EveryFoodScreen()));
                      },
                  
                    
                          leading: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              "${AllData[index]["foodImageUrl"]}",
                                                  
                            ),
                          ),
                        
                              title: Text("Price: ${AllData[index]["FoodSalePrice"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              
                              subtitle: Column(
                        
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${AllData[index]["FoodName"]}", style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                  
                                  Text("Food Unit: ${AllData[index]["FoodUnit"]}", style: TextStyle(fontWeight: FontWeight.bold),),

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