import 'package:flutter/material.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'package:loginpagechallenge/Models/NewsAPI.dart';
import 'package:url_launcher/url_launcher.dart';


Text customHeader({String ?text}) {
  return Text(text!,style: TextStyle(
      fontSize: 26,fontWeight: FontWeight.bold,color: Color(0xff151515)
  ),);
}

Text customParagraph({String ?text}) {
  return Text(text!,style: TextStyle(
      fontSize: 13,fontWeight: FontWeight.w500,color: Color(0xff979797)
  ),);
}

Widget buildSmallText(BuildContext context,String text,Alignment alignment,double rightPadding,Color color){
  return Container(
    color:Color(0xfff6f6f6),
    padding: EdgeInsets.only(right: rightPadding),
    alignment: alignment,
    child: Text(text,style: TextStyle(
        color: color,fontSize: 13,fontWeight: FontWeight.w500
    ),),
  );
}

Container buildContainerOfCategory(String? text) {
  return Container(
    decoration: BoxDecoration(
        color: Color(0xff23b845),
        borderRadius: BorderRadius.all(Radius.circular(30))
    ),
    child: Text(text!,style: TextStyle(
        color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400
    ),),
  //  width: 50,
    alignment: Alignment.center,
  );
}

Row buildLowerCategories(String text,String imageUrl) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Image.asset(imageUrl,height: 12,),
      SizedBox(width: 8,),
      Text(text,style: TextStyle(color: Color(0xff7385a2),
          fontSize: 10,
          fontWeight: FontWeight.w500),),
    ],
  );
}


ListView buildListViewOfNews(NewsApi newsApi,AppCubit appCubit) {

  return ListView.separated(
    separatorBuilder: (context, index) => Divider(color: Color(0xffF2F2F2),height: 1.5,),
    itemBuilder:(context, index) => buildNewItem(newsApi.articles![index],appCubit,index),
    itemCount: newsApi.articles!.length,);
}

InkWell buildNewItem(Article article,AppCubit appCubit,int index)  {

  return InkWell(

    onTap: (){
      try{
        launch("${article.url}");
      }
      catch(e){
      }
    },
    child: Container(
          height: 150,
          color: Colors.white,
          padding: EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${article.urlToImage}",
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                       // width: double.infinity,
                        child: buildContainerOfCategory(article.source!.name),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15,bottom: 10),
                        child: Text("${article.title}",style: TextStyle(
                            fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600
                        ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text("${article.publishedAt!.day} / ${article.publishedAt!.month} / ${article.publishedAt!.year}",style: TextStyle(
                            fontSize: 12,color: Color(0xff8b9cae),fontWeight: FontWeight.w600
                        )),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildLowerCategories("Logan","images/feather.png"),
                            SizedBox(width: 10,),
                            buildLowerCategories("5","images/message.png"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
  );
}

Container buildRowOfButtons() {
  return Container(
    padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
    color: Color(0xfff3f2f2),
    child: Row(
      children: [
        buildTextButton(imageName: "images/bar.png",label: "Sort",),
        SizedBox(width: 15,),
        buildTextButton(imageName: "images/sliders.png",label: "Refine",onTap: (){
          print("Refine");
        }),
        Spacer(),
        buildButtonsOnTheRight(),
      ],
    ),
  );
}

Row buildButtonsOnTheRight() {
  return Row(
        children: [
          Icon(Icons.crop_square_rounded,color: Color(0xff768293),size: 20,),
          SizedBox(width: 10,),
          Image.asset("images/list.png",height: 17,),
        ],
      );
}

InkWell buildTextButton({String? imageName,String ?label,Function ?onTap}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Row(
      children: [
        Image.asset(imageName!,height: 16,),
        SizedBox(width: 8,),
        Text(label!,style: TextStyle(color: Color(0xff6d7e95),fontSize: 13,fontWeight: FontWeight.w400)),
      ],
    ),
  );
}


Container buildCustomButton(BuildContext context,String text,Color buttonColor,String iconUrl,double iconSize) {
  return Container(
    height: 35,
    width: MediaQuery.of(context).size.width*0.33,
    child: ElevatedButton.icon(onPressed: () {},
        icon: Padding(
          padding:  EdgeInsets.only(bottom: 2),
          child: Image.asset(iconUrl,height: iconSize,),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )
          ),
        ), label: Text(text,style: TextStyle(
            fontSize: 12,fontWeight: FontWeight.w600
        ),)),
  );
}

Container buildMainButton(BuildContext context,String text,Function onPressed) {
  return Container(
    height: 49,
    decoration: BoxDecoration(

      boxShadow: [
        BoxShadow(
          color: Color(0xffbed0f0).withOpacity(0.55),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(2, 2),
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width-190,
    child: ElevatedButton(onPressed: (){
      onPressed();
    }, child: Text(text,style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w900
    ),),style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff0148a4)),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
        )
    )),
  );
}
