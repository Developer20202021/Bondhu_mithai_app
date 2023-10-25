import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dotted_line/dotted_line.dart';

class EveryFoodScreen extends StatefulWidget {

  final FoodID;
  final FoodName;
  final DiscountAvailable;
  final foodImageUrl;
  final FoodSalePrice;
  final FoodDiscountPrice;
  final FoodDescription;
  final FoodUnit;
  final FoodTag;





  const EveryFoodScreen({super.key, required this.DiscountAvailable, required this.FoodDiscountPrice, required this.FoodID, required this.FoodName, required this.FoodSalePrice, required this.foodImageUrl, required this.FoodDescription, required this.FoodUnit, required this.FoodTag});

  @override
  State<EveryFoodScreen> createState() => _EveryFoodScreenState();
}

class _EveryFoodScreenState extends State<EveryFoodScreen> {



  List AllData = [];

  var DataLoad = "0";

  bool loading = true;


  var AllReviewsCount = "0";
  double allRatingAdd = 0.0;

  // double averagerating = 0.0;




Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();




    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('FoodReview');
      
      Query FoodReviewQuery = _collectionRef.where("FoodID", isEqualTo: widget.FoodID);



    QuerySnapshot querySnapshot = await FoodReviewQuery.get();


    

    // Get data from docs and convert map to List
      setState(() {
         AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
      });


       if (AllData.length == 0) {

      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {


           for (var i = 0; i < AllData.length; i++) {

                var rating = AllData[i]["rating"];

                print("____________________________${rating}");
                double ratingDouble = double.parse(AllData[i]["rating"]);

      

                      setState(() {
                        AllReviewsCount = AllData.length.toString();
                        allRatingAdd = allRatingAdd + ratingDouble;
                       
                      });

       
                  }



          setState(() {
              DataLoad = "";
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







  var UserReview = [
    {
      "userName": "Mahadi Hasan",
      "UserRating": 2,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 3,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 2,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 2,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 4,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 3,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 5,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
  ];


  int UserAddToCartNumber = 0;

    void plusOne() {
      setState(() {
      UserAddToCartNumber =  UserAddToCartNumber + 1;
      });
    }

    void minusOne() {
      if (UserAddToCartNumber == 0) {
        setState(() {
         UserAddToCartNumber = 0;
        });
      }
      else{
         setState(() {
       UserAddToCartNumber = UserAddToCartNumber - 1;
      });
      }

     
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
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
        ],
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Show food Image

                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(158), // Image radius
                      child: Image.network(
                        '${widget.foodImageUrl}',
                        width: 400,
                        height: 350,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Center(
                  child: Text(
                    "${widget.FoodName}",
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 2, 56),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.sell,
                            size: 16,
                            color: ColorName().appColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Per ${widget.FoodUnit} Price ${widget.FoodSalePrice}৳",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 2, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                
                  ],
                ),

                SizedBox(
                  height: 15,
                ),




                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.discount,
                            size: 16,
                            color: ColorName().appColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Discount Price: ${widget.FoodDiscountPrice}৳",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 2, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                    
                  ],
                ),

              SizedBox(
                  height: 15,
                ),


                Row(
                  
                      children: [


                      Text(
                          "Rating:(${allRatingAdd/double.parse(AllReviewsCount)}) ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 2, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),


                       AllReviewsCount =="0"?Text(""):RatingBarIndicator(
                            rating: allRatingAdd/double.parse(AllData.length.toString()),
                            itemCount: 5,
                            itemSize: 18.0,
                            itemBuilder: (context, _) =>  Icon(
                                  Icons.star,
                                  color: ColorName().appColor,
                                )),
                        SizedBox(
                          width: 5,
                        ),
                   



                      SizedBox(
                          width: 10,
                        ),
                   






                      ],
                    ),

                SizedBox(
                  height: 15,
                ),


                  Row(
                    children: [
                      Text(
                              "Reviews: ${AllReviewsCount.toString()}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 2, 56),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                    ],
                  ),


                 SizedBox(
                  height: 15,
                ),

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
                  height: 20,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Description",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 2, 56),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "${widget.FoodDescription}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),


                Text("FoodTag: ${widget.FoodTag.toString()}"),

                

                SizedBox(
                  height: 20,
                ),

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
                  height: 20,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Reviews",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 2, 56),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),



           if( DataLoad == "")...[

                for (var item in AllData)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RatingBarIndicator(
                                  rating: double.parse(
                                      item["rating"].toString()),
                                  itemCount: 5,
                                  itemSize: 10.0,
                                  itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.purple,
                                      )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${item["CustomerName"]}",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 2, 56),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          Text(
                            "${item["Date"].toString().split("T")[0].toString()} ${item["Date"].toString().split("T")[1].toString().split(".")[0]}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "${item["ReviewMsg"]}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  
                  ]
                  
                  
                  

                else...[Text("No Review Available")]
                  


              

              ],
            )),
      ),
     
    );
  }
}
