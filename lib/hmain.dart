
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import 'package:trackeradmin/mappage.dart';

class HMain extends StatefulWidget {
  const HMain({super.key});

  @override
  State<HMain> createState() => _HMainState();
}

class _HMainState extends State<HMain> {

  final formkey=GlobalKey<FormState>();
  var an=true;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  late ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,Colors.lightBlueAccent
                      ],begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  )
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 150),
                child: Image.asset("assests/user.png",width: 100,),
              ),

            ),
            Container(
              margin: EdgeInsets.all(20)
              ,
              transform: Matrix4.translationValues(0.0, -100.0, 0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(


                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Form(
                      key:formkey,
                      child: Column(

                        children: [
                          Text("LOGIN",style: GoogleFonts.allerta(
                              fontSize: 20
                          ),),
                          SizedBox(height: 30,),

                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey
                                    ,width: 2
                                ),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue
                                    ,width: 2
                                ),

                              ),
                              hintText: "ENTER YOUR EMAIL ID",
                              labelText: "EMAIL ID",
                              suffixIcon: IconButton(onPressed: (){
                                email.text="";
                              },icon: Icon(Icons.explore_off_rounded),),


                            ),
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "PLSE FILL THIS FIELD";
                              }

                            },


                          ),

                          SizedBox(height: 20,),

                          TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey
                                    ,width: 2
                                ),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue
                                    ,width: 2
                                ),

                              ),
                              hintText: "ENTER YOUR PASSWORD",
                              labelText: "PASSWORD",


                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  if(an)
                                  {
                                    an=false;
                                  }
                                  else
                                  {
                                    an=true;
                                  }
                                });
                              },icon: Icon(Icons.remove_red_eye),),


                            ),
                            obscureText: an,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "PLSE FILL THIS FIELD ";
                              }

                            },


                          ),

                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),


                ),
              ),
            )
            ,Container(transform: Matrix4.translationValues(0, -155, 0),
                width: 250,
                height: 50,
                child: ElevatedButton(onPressed: ()
                {

                  if(formkey.currentState!.validate())
                  {
                    progressDialog=ProgressDialog(context,type: ProgressDialogType.normal);
                    progressDialog.style(
                        message: "PLSE WAIT WHILE PROCESSING"
                    );
                    progressDialog.show();
                    String a=email.text;
                    String b=password.text;

                    login(a, b);
                  }

                }

                  , child: Text("LOGIN"),style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),))


          ],
        ),
      ),


      // body: SingleChildScrollView(
      //
      //   child: Container(
      //
      //     margin: EdgeInsets.only(left: 15,right: 15),
      //     child: Form(
      //       key: formkey,
      //       child: Column(
      //         children: [
      //
      //           Container(
      //             height: 250,
      //             width: double.infinity,
      //           ),
      //           SingleChildScrollView(
      //
      //             child: Card(
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(40.0)),
      //               child: Container(
      //                 width: double.infinity,
      //
      //                 child: Column(children: [
      //                   Container(
      //                     margin: EdgeInsets.only(top: 20),
      //                     child: Text("LOGIN",
      //                         style: GoogleFonts.aBeeZee(
      //                             fontWeight: FontWeight.bold,
      //                             fontSize: 30,
      //                             color: Colors.deepPurple)),
      //                   ),
      //                   SizedBox(height: 40),
      //                   Container(
      //                     padding: EdgeInsets.only(left: 20.0, right: 20.0),
      //                     child: TextFormField(
      //
      //                       controller: email ,
      //                       decoration: InputDecoration(
      //                           hintText: 'E-Mail:',
      //                           labelText: 'E-mail',
      //                           prefixIcon: Icon(Icons.mail_lock_outlined)
      //                       ),validator: (value){
      //                       if(value!.isEmpty)
      //                       {
      //                         return "PLEASE FILL THIS FIELD";
      //                       }
      //                     },
      //
      //                     ),
      //                   ),
      //                   SizedBox(height: 30),
      //                   Container(
      //                     padding: EdgeInsets.only(left: 20.0, right: 20.0),
      //                     child: TextFormField(
      //                       controller: password,
      //                       decoration: InputDecoration(
      //                           hintText: 'Password:',
      //                           labelText: 'Password',
      //                           prefixIcon: Icon(Icons.password_outlined)
      //                       ),validator: (value){
      //                       if(value!.isEmpty)
      //                       {
      //                         return "PLEASE FILL THIS FIELD";
      //                       }
      //                     },
      //                     ),
      //
      //                   ),
      //                   SizedBox(height: 40),
      //                   Container(
      //                     child: ElevatedButton(
      //
      //                       onPressed: (){
      //                         if(formkey.currentState!.validate())
      //                         {
      //                           print("CLICKED login without error");
      //                           login(email.text,password.text);
      //
      //                         }
      //
      //
      //                       },
      //                       child: Text("SUBMIT"),
      //
      //                       style: ElevatedButton.styleFrom(
      //                           shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      //                           )
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(height:20),
      //
      //
      //
      //
      //
      //                 ]),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
  Future<void> login(String email,String password) async
  {
    try{
      User user=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user!;
      if(user!=null)
      {
        print("USER LOGEED IN SUCCESSFULLY");
        print(user.photoURL);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>hmain()));
      }

    }
    catch(e){
      print(e);
    }
  }

}