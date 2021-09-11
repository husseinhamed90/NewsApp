import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/CategoriesCubit/CategoriesCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/CubitStates.dart';
import 'package:loginpagechallenge/CustomTextFeild.dart';
import 'package:loginpagechallenge/ResuabilityWidgets.dart';
import 'package:loginpagechallenge/Screens/NewsList.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userName =new TextEditingController();
  TextEditingController passWord =new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<AppCubit,CubitState>(
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
            return Container(
              child:  Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height-7,
              width: MediaQuery.of(context).size.width-7,
              decoration: BoxDecoration(
                gradient:LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xfff6f6f6)
                    ]
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff8ca6c5).withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 6,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    Image.asset('images/login.jpg',height: 130,),
                    customHeader(text: "Welcome back!"),
                    SizedBox(height: 9,),
                    customParagraph(text: "Log in to your existant account of Q Allure"),
                    SizedBox(height: 40,),
                    CustomTextFeild(label: "Username", width: MediaQuery.of(context).size.width-60, controller: userName,icon: Icon(Icons.person_outline,size: 20,),),
                    SizedBox(height: 18,),
                    CustomTextFeild(label: "Password", width: MediaQuery.of(context).size.width-60, controller: passWord,icon: Icon(Icons.lock_open_outlined,size: 20),),
                    SizedBox(height:9,),
                    buildSmallText(context,"Forgot Password?",Alignment.topRight,30,Color(0xff343e4a)),
                    SizedBox(height: 25,),
                    buildMainButton(context,"LOG IN",(){
                      appCubit.login(userName.text, passWord.text,CategoriesCubit.get(context));
                    }),
                    SizedBox(height: 35,),
                    Text("Or connect using",style: TextStyle(
                        color: Color(0xffb4b4b4),fontSize: 13,fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCustomButton(context,"Facebook",Color(0xff3b5999),"images/facebooklogo.png",15),
                        SizedBox(width: 15,),
                        buildCustomButton(context,"Google",Color(0xfff14336),"images/googlelogo.png",12)
                      ],
                    ),
                    SizedBox(height: 35,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildSmallText(context,"Don`t have an account?",Alignment.center,0,Color(0xff343e4a)),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                            },
                            child: buildSmallText(context,"SignUp",Alignment.center,0,Color(0xff075dff))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// ignore: must_be_immutable
