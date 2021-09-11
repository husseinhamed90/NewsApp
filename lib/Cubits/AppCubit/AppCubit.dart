import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import '../CategoriesCubit/CategoriesCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/CubitStates.dart';
import 'package:loginpagechallenge/Models/NewsAPI.dart';
import 'package:loginpagechallenge/Models/UserAccount.dart';
import 'package:loginpagechallenge/Network/Remote/DioHelper.dart';
import 'package:loginpagechallenge/Network/Remote/FireBaseAPIs.dart';

class AppCubit extends Cubit<CubitState>{

  AppCubit() : super(InitialState());
  UserAccount ?account;
  NewsApi newsApi=new NewsApi();
  double numberOfPages=0;
  int count =1;

  String searchedText ="";
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  Future checkValidSignUpInputs(String username,String password,String confirmPassword,String name,String phoneNumber,CategoriesCubit categoriesCubit)async{
    emit(CheckForValidDataAndValidNumber());
    if(username==""||password ==""|| confirmPassword==""||phoneNumber==""||name==""){
      emit(EmptyFieldsFound());
    }
    else{
      if(password ==confirmPassword){
        UserAccount userAccount =new UserAccount(username, password, name, phoneNumber);
        await register(userAccount,categoriesCubit);
      }
      else{
        emit(InvalidRegistration());
      }
    }
  }

  Future<void> register (UserAccount userAccount,CategoriesCubit categoriesCubit)async{

    emit(LoadingIndicator());

    account =await FirebaseAPIs.register(userAccount)??null;
    if(account!=null){
      await loadData(categoriesCubit).then((value) {
        emit(ValidUserState());
      });
    }
    else{
      emit(InvalidUserState());
    }
  }

  void login(String username,String password,CategoriesCubit categoriesCubit)async{
    if(username==""||password ==""){
      emit(EmptyFieldsFound());
    }
    else{
      emit(LoadingIndicator());

      account  =await FirebaseAPIs.login(username, password)??null;
      if(account!=null){
        await loadData(categoriesCubit).then((value) async {
          emit(ValidUserState());
        });
      }
      else{
        emit(InvalidUserState());
      }
    }
  }

  void setSearchedText(String text){
    searchedText=text;
    emit(SearchedTextState());
  }

  Future loadData(CategoriesCubit categoriesCubit)async{
    emit(LoadingIndicator());

    if(searchedText==""){
      newsApi =await DioHelper.getNews(count,categoriesCubit.categories[categoriesCubit.selectedCategoryIndex]);
    }
    else{
      newsApi =await DioHelper.getNewsWithSearchedText(count,searchedText);

    }
    emit(DataIsInLoadingPhase());
    numberOfPages = (newsApi.totalResults!/20);
  }

  Future getNewsWithSearchedText(String searchedText,CategoriesCubit categoriesCubit)async{
    emit(LoadingIndicator());
    categoriesCubit.resetSelectedIndex();
    count=1;
    newsApi =await DioHelper.getNewsWithSearchedText(count,searchedText);
    numberOfPages = (newsApi.totalResults!/20);
    emit(DataIsInLoadingPhase());
  }

  void resetNumberOfPagesCount(){
    count=1;
    setSearchedText("");
    emit(ResetNumberOfPagesCountState());
  }

  void increasePageNumber(CategoriesCubit categoriesCubit){
    if(count<=numberOfPages){
      count++;
      loadData(categoriesCubit);
    }
    else{
      count=1;
      loadData(categoriesCubit);
    }
  }
}
