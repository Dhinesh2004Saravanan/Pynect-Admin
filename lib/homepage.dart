import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: m()
    );
  }




}


class m extends StatefulWidget {
  const m({super.key});

  @override
  State<m> createState() => _mState();
}

class _mState extends State<m> {

  bool visible=true;
  TextEditingController name=TextEditingController();
  TextEditingController mail=TextEditingController();

  TextEditingController pass=TextEditingController();
  late ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("HOME PAGE"),

      actions: [

      ],
    ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        showModalBottomSheet(context: context, builder: (BuildContext context){
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children:
                [
                  SizedBox(height: 20,),
                  Text("ADD YOUR EMPLOYEE DETAILS",style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),


                  SizedBox(height: 20,),
                  Form(child: Column(
                    children:
                    [
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),

                        child: TextFormField(
                          controller: name,

                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2
                                  )

                              ),hintText: "ENTER YOUR EMPLOYEE NAME",
                              labelText: "NAME",
                              prefixIcon: Icon(Icons.mail)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),

                        child: TextFormField(
                          controller: mail,

                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2
                                  )

                              ),hintText: "ENTER YOUR EMPLOYEE NAME",
                              labelText: "EMAIL ID",
                              prefixIcon: Icon(Icons.mail)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),


                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),

                        child: TextFormField(
                          controller: pass,
                          obscuringCharacter: '*',
                          obscureText: visible,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2
                                  )

                              ),hintText: "ENTER YOUR EMPLOYEE PASSWORD",
                              labelText: "PASSWORD",
                              prefixIcon: Icon(Icons.mail),
                              suffixIcon: IconButton(icon: Icon(FontAwesomeIcons.eye),onPressed: (){
                                setState(() {
                                  visible=!visible;
                                  print(visible);
                                });


                              },)
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){

                        progressDialog=ProgressDialog(context,type: ProgressDialogType.normal);

                        progressDialog.style(child: Text("PLEASE WAIT WHILE WE PROCESS"));
                        progressDialog.show();

                        print("clicked");
                        login(mail.text, pass.text);

                      }
                        , child: Container(
                            child: Text("REGISTER")),style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)
                                )
                            )

                        ),)




                    ],
                  ))

                ],
              ),
            ),
          );


        });

      },child: Icon(Icons.add),tooltip: "ADD USERS ",),




      body: StreamBuilder(
        
        stream: FirebaseFirestore.instance.collection("CAB USERS").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData)
              {
                return ListView.builder(itemBuilder: (context,index){
                  final DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                    return Container(
                      margin: EdgeInsets.all(20),
                      child:Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),

                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text("NAME : ${documentSnapshot["name"]}\n\nEMAIL ID : ${documentSnapshot["email"]}",style: GoogleFonts.aBeeZee(
                            fontSize: 15

                          ),),
                        ),

                      ),
                    );


                },itemCount: snapshot.data!.docs.length,);

              }

            return SizedBox(height: 20,);

      },
        
      ),





    );
  }



  Future<void> login(String email,String password) async{
    try{

      User user=(await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user!;
      if(user!=null)
      {

        print("USER OBJECT CREATED SUCCESSFULLY");
        user.updateEmail(email);
        user.updateDisplayName(name.text);
        user.updatePhotoURL("CABDRIVER");
        await FirebaseFirestore.instance.collection("CAB USERS").doc(user.uid).set({

          "name":name.text,
          "email":email,
          "userid":user.uid,
          "location_lat":"",
          "location_lon":""

        }).whenComplete(() {
          progressDialog.hide();
          Fluttertoast.showToast(msg: "USER SUCCESSFULLY ADDED");
          name.clear();
          mail.clear();
          pass.clear();

        });

      }

    }
    catch(e) {
      print(e);
    }
  }


}
