import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Cubits/CategoriesCubit/CategoriesCubitStates.dart';

class CategoriesCubit extends Cubit<CategoriesCubitStates> {
  CategoriesCubit() : super(initialState());

  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);

  List<String>categories =["business" ,"entertainment" ,"general", "health" ,"science" ,"sports" ,"technology"];
  int selectedCategoryIndex =0;
  Future<void> changeCurrentCategory(int index,AppCubit appCubit)async{
    selectedCategoryIndex=index;
    appCubit.resetNumberOfPagesCount();
    emit(PositionChanged());
    appCubit.loadData(this);
  }

  void resetSelectedIndex(){
     selectedCategoryIndex=-1;
     emit(selectedIndexResetState());
  }
}
