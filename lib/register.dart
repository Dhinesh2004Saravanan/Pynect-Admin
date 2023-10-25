import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:trackeradmin/homepage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';




class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  late XFile file;
  final list=[];
  TextEditingController cname=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController uname=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController mail=TextEditingController();
  TextEditingController password=TextEditingController();


  late ProgressDialog dialog;
  late ProgressDialog dialogImage;


  final formkey= GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.indigo,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formkey,
            child: Column(

              children: [


                SizedBox(height: 300,),




            SingleChildScrollView(
              child: Container(

                width: double.infinity,

                child:Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                    ),
                    child: Column(
                      children: [

                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("CREATE YOUR OWN PROFILE",style: GoogleFonts.aBeeZee(
                            fontSize: 25
                          ),),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: cname,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                                prefixIcon: Icon(FontAwesomeIcons.building),

                              hintText: "ENTER YOUR COMPANY NAME",
                              labelText: "COMPANY NAME :"
                            ),validator: (value){
                              if(value!.isEmpty)
                                {
                                  return "PLEASE FILL THIS FIELD";
                                }

                          },

                          ),
                        ),
                        SizedBox(height: 20,),

                        Container(

                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: "ENTER YOUR PHONE NUMBER",
                                labelText: "PHONE NUMBER :",
                              prefixIcon: Icon(FontAwesomeIcons.phone)
                            ),validator: (value){
                            if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }

                          },

                          ),
                        ),
                        SizedBox(height: 20,),



                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: uname,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: "ENTER YOUR PROPERITOR  NAME",
                                labelText: "NAME :",
                              prefixIcon: Icon(FontAwesomeIcons.user),
                            ),validator: (value){
                            if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }
                          },

                          ),
                        ),
                SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: mail,
                            decoration: InputDecoration(

                                border: UnderlineInputBorder(),
                                hintText: "ENTER YOUR EMAIL ID",
                                labelText: "EMAIL ID :",
                              prefixIcon: Icon(Icons.mail_lock)
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "PLEASE FILL THIS FIELD";
                              }

                            },

                          ),

                        ),
                        SizedBox(height: 20,),

                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: "ENTER YOUR PASSWORD",
                                labelText: "PASSWORD :"
                                ,prefixIcon: Icon(Icons.password_outlined)
                            ),validator: (value){
                            if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }

                          },

                          ),
                        ),
                        SizedBox(height: 20,),


                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: description,
                            minLines: 3,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: "DESCRIPTION OF THE COMPANY",
                              labelText: "DESCRIPTION :",
                              prefixIcon: Icon(FontAwesomeIcons.dailymotion)

                            ),validator: (value){
                            if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }

                          },

                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: address,
                            minLines: 3,
                            maxLines: 10,
                            decoration: InputDecoration(

                                hintText: "ENTER THE COMPANY ADDRESS",
                                labelText: "COMPANY ADDRESS :",
                              prefixIcon: Icon(FontAwesomeIcons.addressCard)
                            ),validator: (value){
                            if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }

                          },

                          ),
                        ),
                        SizedBox(height: 20,),


                       Row(
                         children: [

                           Container(
                             margin: EdgeInsets.only(left: 20),
                             width: 100,
                             height: 100,
                             child: IconButton(onPressed: (){


                               print("ADD images");


                               selectImage();


                               print("HELLO");
                             }, icon: Image.asset("assests/image.png")),
                           ),
                           Expanded(
                             child: Container(
                               margin: EdgeInsets.only(left: 20),
                               child: Text("ADD YOUR IMAGES",style: GoogleFonts.aBeeZee(fontSize: 35),),
                             ),
                           ),
                           SizedBox(width: 20,),


                         ],


                       ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          if(formkey.currentState!.validate())
                            {
                              print("clicked regster without error");
                              register(mail.text,password.text);

                              dialog=ProgressDialog(context,type: ProgressDialogType.normal);
                              dialog.style(
                                message: "PLEASE WAIT WHILE WE PROCESSING"
                              );
                              dialog.show();



                            }

                        }, child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("SUBMIT"),
                        ),style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                        ,

                        )),)








                      ],
                    ),
                  ),
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

  Future<void> selectImage() async{
    ImagePicker imagePicker=new ImagePicker();
    await imagePicker.pickImage(
        source: ImageSource.gallery).then((value){
      print("VALUE is ${value}");
        setState(() {
          file=value!;
        });


    });


 if(file!=null)
   {
     dialogImage=ProgressDialog(context,type: ProgressDialogType.normal);
     dialogImage.style(
         message: "PLEASE WAIT WHILE THE IMAGE IS UPLOADING"
     );

     dialogImage.show();
   }
    UploadImage(file);




    
    
    



  }
  Future<void> UploadImage(XFile fil) async{
    String filename=await Uuid().v4();
    print("file name is ${filename} and file is ${fil}");
    var ref=await FirebaseStorage.instance.ref().child("IMAGES").child("$filename.jpg");
    var put=await ref.putFile(File(fil.path));
    var downloadUrl=await put.ref.getDownloadURL();
    print("DOWNLOAD URL IS $downloadUrl");
    dialogImage.hide();


    list.add(downloadUrl);




  }



Future<void> register (String email,String password) async{


    try{

      User user=(await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user!;
      if(user!=null)
        {
          print("USER ACCOUNT CREATED SUCCESSFULLY");


          user.updatePhotoURL("AGENCY");
          dialog.hide();
          await FirebaseFirestore.instance.collection("ADMIN PROFILE").doc(user.uid).set(
            {
              "company_name":cname.text,
              "phone_number":phone.text,
              "username":uname.text,
              "emailid":email,
              "description":description.text,
              "address":address.text,
              "images":list,
              "userid":user.uid


            }


          ).whenComplete(() {

            Fluttertoast.showToast(msg: "SUCCESSFUL");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          });

        }

    }
    catch(e)
  {

  }

}



}

