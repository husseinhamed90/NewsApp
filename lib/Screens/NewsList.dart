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
              title: Container(
                height: 45,
                alignment: Alignment.center,
                child: Text("Latest News",style: TextStyle(
                    color: Color(0xfff292929),fontSize: 14,fontWeight: FontWeight.w600
                ),),
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                InkWell(onTap: () {
                  appCubit.increasePageNumber();
                },child: Image.asset("images/search.png",height: 18,width: 16,)),
                SizedBox(width: 10,),
              ],
//              leading: InkWell(onTap: () => Navigator.pop(context),child: Icon(Icons.arrow_back_ios,color: Color(0xff3D3D3D),size: 16,)),
            ),
          ),
          body: Container(
            color: Color(0xfFEFEFE),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  padding: EdgeInsets.all(10),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                     // return BuildCategoryItem(AppCubit.get(context).categories[index],index);
                      return InkWell(
                          onTap: () {
                            appCubit.changeCurrentCategory(index);
                          },
                          child: Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: (appCubit.selectedCategoryIndex!=index)?Colors.white:Color(0xff23b845),
                               // border: Border.all(color: Colors.grey,width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              alignment: Alignment.center,child: Text(AppCubit.get(context).categories[index],style: TextStyle(
                              color: (appCubit.selectedCategoryIndex!=index)?Colors.black:Colors.white,fontSize: 16
                          ),)));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 22,
                      );
                    },
                    itemCount: AppCubit.get(context).categories.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                buildRowOfButtons(),
                Expanded(child: buildListViewOfNews(appCubit.newsApi))
              ],
            ),
          ),
        );
      },
    );
  }




}
