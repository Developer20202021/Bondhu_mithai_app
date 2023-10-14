import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class createBazarList extends StatefulWidget {
  const createBazarList({super.key});

  @override
  State<createBazarList> createState() => _createBazarListState();
}

class _createBazarListState extends State<createBazarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.purple),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: const Text(
            "Create Bazar List",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                
                children: [
              
              
                  TextField(
                 
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Product Name',
                        
                        hintText: 'Enter Product Name',
                        
                        //  enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                        //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                        
                        
                        ),
                 
                  ),
              
                  SizedBox(height: 10,),


                  TextField(
                 
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Product Amount',
                        
                        hintText: 'Enter Product Amount',
                        
                        //  enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                        //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                        
                        
                        ),
                 
                  ),
              
              
              
                         Container(width: 150, child:TextButton(onPressed: (){


                           final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Successfully Added',
                    message:
                        'Your Product is Added Successfully',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);




                         }, child: Text("Add", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                          ),),),
              
              
              
              
                  
                         
              
              
              
                        
                        
                        
              
              
              
              
              
              
              
              
              
              
              
              
                         
              ])),
        ));
  }
}
