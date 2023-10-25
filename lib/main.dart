// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:trackeradmin/homepage.dart';
import 'package:trackeradmin/mappage.dart';
import 'package:trackeradmin/register.dart';
import 'package:trackeradmin/hmain.dart';



Future<void> main() async
{

  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Myapp());
}

class Myapp extends StatefulWidget
{
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }






  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:GetStarted(),
    );
  }
}

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Image.asset("assests/new.jpg"),
            Container(height: height/2,
              decoration: BoxDecoration(


              ),
              child: Column(
                children: [


                  Container(height: 100,),
                  Container(


                    margin: EdgeInsets.only(top: 30,left: 20),

                    alignment: Alignment.topCenter,
                    child: Text("WELCOME",style: GoogleFonts.aBeeZee(fontSize: 30,fontWeight: FontWeight.bold),
                    ),


                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text("An App to Promote Puducherry Tourism",style: GoogleFonts.aBeeZee(
                        fontSize: 15
                    ),),
                  ),
                  SizedBox(height:30 ,),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    alignment: Alignment.topLeft,
                    child: Text("Login As ...",style: GoogleFonts.aBeeZee(
                        fontSize: 20,fontWeight: FontWeight.bold
                    ),),),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.topLeft,

                          child:  OutlinedButton(onPressed: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HMain()));

                          }, child: Container(
                              padding: EdgeInsets.all(15),
                              child: Text("CAB DRIVER"))),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.topRight,
                          child:  OutlinedButton(onPressed: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Main()));

                          }, child: Container(
                              padding: EdgeInsets.all(15),
                              child: Text("AGENCIES"))),
                        )






                      ],),
                  )

                ],
              ),

            )






          ],
        ),
      ),
    );
  }
}
































class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

final formkey=GlobalKey<FormState>();
var an=true;
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();

late ProgressDialog progressDialog;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(

        child: Container(

          margin: EdgeInsets.only(left: 15,right: 15),
          child: Form(
            key: formkey,
            child: Column(
              children: [

                Container(
                  height: 250,
                  width: double.infinity,
                ),
                SingleChildScrollView(

                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Container(
                      width: double.infinity,

                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("LOGIN",
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.deepPurple)),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(

                            controller: email ,
                            decoration: InputDecoration(
                              hintText: 'E-Mail:',
                              labelText: 'E-mail',
                              prefixIcon: Icon(Icons.mail_lock_outlined)
                            ),validator: (value){
                            if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }
                          },

                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            obscureText: an,
                            obscuringCharacter: "*",
                            controller: password,
                            decoration: InputDecoration(
                              hintText: 'Password:',
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.password_outlined),
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
                            ),validator: (value){
                              if(value!.isEmpty)
                                {
                                  return "PLEASE FILL THIS FIELD";
                                }






                          },
                          ),

                        ),
                        SizedBox(height: 40),
                        Container(
                          child: ElevatedButton(

                            onPressed: (){
                              if(formkey.currentState!.validate())
                                {
                                  print("CLICKED login without error");
                                  progressDialog=ProgressDialog(context,type: ProgressDialogType.normal);
                                  progressDialog.style(
                                    message: "PLEASE WAIT WHILE WE PROCESSING"
                                  );
                                  progressDialog.show();
                                  login(email.text,password.text);

                                }


                            },
                            child: Text("SUBMIT"),

                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                            )
                          ),
                          ),
                        ),
                        SizedBox(height:20),


                        RichText(text: TextSpan(text: "Dont have an account ? ",style: GoogleFonts.aBeeZee(color: Colors.black),children: [
                          TextSpan(text: "SIGN UP",style:GoogleFonts.aBeeZee(
                              color: Colors.red
                          )

                              ,recognizer:TapGestureRecognizer()
                                ..onTap=(){

                                  print("Sharath");
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));



                                }


                          ),


                        ])),
                        SizedBox(height: 20,)

                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> login(String email,String password) async
  {
    try{
      User user=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user!;
      if(user!=null)
        {
          print("USER LOGEED IN SUCCESSFULLY");
            progressDialog.hide();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));



        }

    }
    catch(e){
      print(e);
    }
  }

}




















