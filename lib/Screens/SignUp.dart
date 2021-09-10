import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpagechallenge/Screens/NewsList.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/CubitStates.dart';
import 'package:loginpagechallenge/CustomTextFeild.dart';
import 'LoginPage.dart';
import 'package:loginpagechallenge/ResuabilityWidgets.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName =new TextEditingController();
  TextEditingController passWord =new TextEditingController();
  TextEditingController email =new TextEditingController();
  TextEditingController confirmPassword =new TextEditingController();
  TextEditingController phone =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,CubitState>(
      listener: (context, state) {
        if(state is ValidUserState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsList(),));
        }
        else if(state is InvalidRegistration || state is InvalidUserState){
          final snackBar = SnackBar(content: Text('Invalid Data'),backgroundColor: Colors.orange,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if(state is EmptyFieldsFound){
          final snackBar = SnackBar(content: Text('Some Input Fields Found'),backgroundColor: Colors.orange,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);

        if(state is LoadingIndicator){
          return Scaffold(
            body: Container(
              child:  Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading:IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
                )
            ),
            body: Container(
              height: MediaQuery.of(context).size.height-10,
              width: MediaQuery.of(context).size.width-10,

              decoration: BoxDecoration(
                  gradient:LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Color(0xfff6f6f6)
                      ]
                  )
              ),
              child: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        customHeader(text: "Lets`s Get Started!"),
                        SizedBox(height: 9,),
                        customParagraph(text: "Create an account to Q Allure to get all features"),
                        SizedBox(height: 40,),
                        CustomTextFeild(label: "Username", width: MediaQuery.of(context).size.width-60, controller: userName,icon: Icon(Icons.person_outline,size: 20,),),
                        SizedBox(height: 18,),
                        CustomTextFeild(label: "Email", width: MediaQuery.of(context).size.width-60, controller: email,icon: Icon(Icons.email,size: 20),),
                        SizedBox(height: 18,),
                        CustomTextFeild(label: "Phone", width: MediaQuery.of(context).size.width-60, controller: phone,icon: Icon(Icons.phone,size: 20),),
                        SizedBox(height: 18,),
                        CustomTextFeild(label: "Password", width: MediaQuery.of(context).size.width-60, controller: passWord,icon: Icon(Icons.lock_open_outlined,size: 20),),
                        SizedBox(height: 18,),
                        CustomTextFeild(label: "Confirm Password", width: MediaQuery.of(context).size.width-60, controller: confirmPassword,icon: Icon(Icons.lock_open_outlined,size: 20),),
                        SizedBox(height: 40,),
                        buildMainButton(context,"CREATE",(){
                          appCubit.checkValidSignUpInputs(email.text, passWord.text, confirmPassword.text, userName.text, phone.text);
                        }),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildSmallText(context,"Already have an account?",Alignment.center,0,Color(0xff343e4a)),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                              },
                              child:  buildSmallText(context,"Login here",Alignment.center,0,Color(0xff075dff)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
