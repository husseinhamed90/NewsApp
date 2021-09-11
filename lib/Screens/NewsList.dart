import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/CubitStates.dart';
import 'package:loginpagechallenge/ResuabilityWidgets.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  TextEditingController searchBar=TextEditingController();
  FocusNode myFocusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,CubitState>(
      listener: (context, state) {

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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.white,
              title: Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: (appCubit.focusState)?FocusScope(
                    child: Focus(
                      focusNode: myFocusNode,
                      onFocusChange: (value) {
                        appCubit.textFormFocusState(value);
                      },
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          appCubit.reset();
                          appCubit.getNewsWithSearchedText(value);
                          searchBar.text="";
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
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                InkWell(onTap: () {
                  appCubit.textFormFocusState(!appCubit.focusState);
                  searchBar.text="";
                },child: (appCubit.focusState)?Icon(Icons.clear,color: Colors.black,size: 20,):Image.asset("images/search.png",height: 18,width: 16,)),
                SizedBox(width: 10,),
              ],
            ),
          ),
          body: Container(
            color: Color(0xfFEFEFE),
            child: Column(
              children: [
                buildCategoriesList(appCubit, context),
                buildRowOfButtons(),
                Expanded(child: buildListViewOfNews(appCubit.newsApi,appCubit,))
              ],
            ),
          ),
        );
      },
    );
  }
}
