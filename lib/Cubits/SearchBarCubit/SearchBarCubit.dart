import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpagechallenge/Cubits/SearchBarCubit/SearchBarStates.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit() : super(initialState());

  FocusNode myFocusNode=FocusNode();
  static SearchBarCubit get(BuildContext context) => BlocProvider.of(context);


  bool focusState = false;
  void textFormFocusState(bool b) {
    focusState = b;
    emit(tetxformfoucesState());
  }
  void resetFocusState(){
    print("ffffffffffffffffffsssssssssssssssssssss");
    focusState=false;
    emit(SearchBarStateIsChanged());
  }


}