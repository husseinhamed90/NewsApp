import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/CubitStates.dart';
import 'package:loginpagechallenge/Models/NewsAPI.dart';
import 'package:loginpagechallenge/Models/UserAccount.dart';
import 'package:loginpagechallenge/Network/Remote/DioHelper.dart';
import 'package:loginpagechallenge/Network/Remote/FireBaseAPIs.dart';

class AppCubit extends Cubit<CubitState>{

  AppCubit() : super(InitialState());

  UserAccount ?account;
  List<String>categories =["business" ,"entertainment" ,"general", "health" ,"science" ,"sports" ,"technology"];
  double numberOfPages=0;
  int selectedCategoryIndex =0;
  NewsApi newsApi=new NewsApi();
  int count =1;
  bool focusState = false;
  void textFormFocusState(bool b) {
    focusState = b;
    emit(tetxformfoucesState());
  }


  void reset(){
    focusState=false;
    emit(SearchBarStateIsChanged());
  }
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  Future checkValidSignUpInputs(String username,String password,String confirmPassword,String name,String phoneNumber)async{
    emit(CheckForValidDataAndValidNumber());
    if(username==""||password ==""|| confirmPassword==""||phoneNumber==""||name==""){
      emit(EmptyFieldsFound());
    }
    else{
      if(password ==confirmPassword){
        UserAccount userAccount =new UserAccount(username, password, name, phoneNumber);
        await register(userAccount);
      }
      else{
        emit(InvalidRegistration());
      }
    }
  }

  Future<void> register (UserAccount userAccount)async{

    emit(LoadingIndicator());

    account =await FirebaseAPIs.register(userAccount)??null;
    if(account!=null){
      await loadData().then((value) {
        emit(ValidUserState());
      });
    }
    else{
      emit(InvalidUserState());
    }
  }

  void login(String username,String password)async{
    if(username==""||password ==""){
      emit(EmptyFieldsFound());
    }
    else{
      emit(LoadingIndicator());

      account  =await FirebaseAPIs.login(username, password)??null;
      if(account!=null){
        await loadData().then((value) async {
          emit(ValidUserState());
        });
      }
      else{
        emit(InvalidUserState());
      }
    }
  }


  void removeNewFromList(int index){
    newsApi.articles!.removeAt(index);
    emit(articleremoved());
  }

  Future loadData()async{
    emit(LoadingIndicator());
    newsApi =await DioHelper.getNews(count,categories[selectedCategoryIndex]);
    emit(DataIsInLoadingPhase());
    numberOfPages = (newsApi.totalResults!/20);
  }

  Future getNewsWithSearchedText(String searchedText)async{
    emit(LoadingIndicator());
    selectedCategoryIndex=-1;
    newsApi =await DioHelper.getNewsWithSearchedText(count,searchedText);
    emit(DataIsInLoadingPhase());
    numberOfPages = (newsApi.totalResults!/20);
  }

  Future<void> changeCurrentCategory(int index)async{
    selectedCategoryIndex=index;
    count=1;
    emit(PositionChanged());
    loadData();
  }

  void increasePageNumber(){
    if(count<=numberOfPages){
      count++;
      loadData();
    }
    else{
      count=1;
      loadData();

    }
  }

}
