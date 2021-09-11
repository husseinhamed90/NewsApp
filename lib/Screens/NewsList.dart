import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpagechallenge/Cubits/CategoriesCubit/CategoriesCubitStates.dart';
import 'package:loginpagechallenge/Cubits/SearchBarCubit/SearchBarCubit.dart';
import 'package:loginpagechallenge/Cubits/SearchBarCubit/SearchBarStates.dart';
import '../Cubits/CategoriesCubit/CategoriesCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/CubitStates.dart';
import 'package:loginpagechallenge/ResuabilityWidgets.dart';


class NewsList extends StatelessWidget {
  TextEditingController searchBar=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BlocConsumer<SearchBarCubit,SearchBarState>(
          listener: (context, state) {},
          builder: (context, state) {
            print("searchBarCubit is rebuild");
            SearchBarCubit searchBarCubit = SearchBarCubit.get(context);
            return AppBar(
              backgroundColor: Colors.white,
              title: Container(
                alignment: Alignment.center,
                child: (AppCubit.get(context).searchedText!=""||searchBarCubit.focusState)?FocusScope(
                  child: Focus(
                    focusNode: searchBarCubit.myFocusNode,
                    onFocusChange: (value) {
                      searchBarCubit.textFormFocusState(value);
                    },
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        AppCubit.get(context).setSearchedText(value);
                        AppCubit.get(context).getNewsWithSearchedText(value,CategoriesCubit.get(context));
                      },
                      controller: searchBar,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search bar"),
                    ),
                  ),
                ):Text("Latest News",style: TextStyle(
                    color: Color(0xfff292929),fontSize: 14,fontWeight: FontWeight.w600
                ),),
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                InkWell(onTap: () {
                  if(searchBarCubit.focusState||AppCubit.get(context).searchedText!=""){
                    AppCubit.get(context).setSearchedText("");
                    searchBar.text="";
                    searchBarCubit.resetFocusState();
                    CategoriesCubit.get(context).changeCurrentCategory(0, AppCubit.get(context));
                  }
                  else{
                    searchBarCubit.textFormFocusState(!searchBarCubit.focusState);
                  }

                },child: (searchBarCubit.focusState||AppCubit.get(context).searchedText!="")?Icon(Icons.clear,color: Colors.black,size: 20,):Image.asset("images/search.png",height: 18,width: 16,)),
                SizedBox(width: 10,),
              ],
            );
          },
        ),
      ),
      body: Container(
        color: Color(0xfFEFEFE),
        child: Column(
          children: [
            BlocConsumer<CategoriesCubit,CategoriesCubitStates>(
              listener: (context, state) {},
              builder: (context, state) {
                print("Categories Cubit is rebuild now");
                return  buildCategoriesList(CategoriesCubit.get(context),AppCubit.get(context));
              },
            ),
            buildRowOfButtons(AppCubit.get(context),CategoriesCubit.get(context)),
            BlocConsumer<AppCubit,CubitState>(
              listener: (context, state) {},
              builder: (context, state) {
                print("AppCubit is rebuild now");
                AppCubit appCubit = AppCubit.get(context);
                if(state is LoadingIndicator){
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(child: buildListViewOfNews(appCubit.newsApi,appCubit,));
              },
            )
          ],
        ),
      ),
    );
  }
}

