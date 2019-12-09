import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
         itemCount: 5,
         itemBuilder: (context, index) => index == 0 ? new SizedBox() : Column(
          //cards
           mainAxisAlignment: MainAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[

             //1st Row
             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Row(
                     children: <Widget>[
                       Container(
                         height: 40.0,
                         width: 40.0,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           image:  DecorationImage(
                             fit:  BoxFit.fill,
                             image: NetworkImage("https://scontent-qro1-1.xx.fbcdn.net/v/t1.0-9/70280246_138757747339462_127735759061909504_n.jpg?_nc_cat=107&_nc_ohc=8eJcklJktlMAQl72cdt8gxgLQ8e_rK6Apvcdy2OZSQZNSVsEXRL4ba-ug&_nc_ht=scontent-qro1-1.xx&oh=9255b3e83b91f9fb913469c4a77a444e&oe=5E6C418D")),
                         ),
                       ),
                       SizedBox(width: 10.0),
                       Text('Alberto DT', style: TextStyle(fontWeight: FontWeight.bold)),
                     ],
                   ),
                   IconButton(
                     icon: Icon(Icons.more_vert),
                     onPressed: null,
                   )
                 ],
               ),
             ),

             //2st Row
             Flexible(
               fit: FlexFit.loose,
               child: new Image.network(
                 'https://scontent-qro1-1.xx.fbcdn.net/v/t1.0-9/70280246_138757747339462_127735759061909504_n.jpg?_nc_cat=107&_nc_ohc=8eJcklJktlMAQl72cdt8gxgLQ8e_rK6Apvcdy2OZSQZNSVsEXRL4ba-ug&_nc_ht=scontent-qro1-1.xx&oh=9255b3e83b91f9fb913469c4a77a444e&oe=5E6C418D',
                 fit: BoxFit.cover,
               ),  
             ),
             //3rd row
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       IconButton(
                         icon: Icon(FontAwesomeIcons.heart,),
                         onPressed: null,
                       ),
                       SizedBox(width: 10.0,),
                      IconButton(
                         icon: Icon(FontAwesomeIcons.comment,),
                         onPressed: null,
                       ),
                        SizedBox(width: 10.0,),
                       IconButton(
                         icon: Icon(FontAwesomeIcons.paperPlane,),
                         onPressed: null,
                       ),
                        SizedBox(width: 10.0,),
                     ],
                   ),
                   IconButton(
                         icon: Icon(FontAwesomeIcons.bookmark,),
                         onPressed: null,
                       ),
                 ],
               ),
             ),
             //4th row
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Text("Liked by beto_dt, pk and 528,331 others",
               style: TextStyle(fontWeight: FontWeight.bold)),
             ),

             //5th row
             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
               child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                 children: <Widget>[
                   Container(
                     height: 40.0,
                     width: 40.0,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         fit: BoxFit.fill,
                         image: NetworkImage(
                           "https://scontent-qro1-1.xx.fbcdn.net/v/t1.0-9/70280246_138757747339462_127735759061909504_n.jpg?_nc_cat=107&_nc_ohc=8eJcklJktlMAQl72cdt8gxgLQ8e_rK6Apvcdy2OZSQZNSVsEXRL4ba-ug&_nc_ht=scontent-qro1-1.xx&oh=9255b3e83b91f9fb913469c4a77a444e&oe=5E6C418D"
                         ),
                       ),
                     ),
                   ),
                   SizedBox(width: 10.0,),
                   Expanded(
                     child: TextField(
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: "Add a comment... ",
                       ),
                     ),
                   )
                 ],
               ),
             ),

             //6th row

             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Text(
                 "1 Day Ago", style: TextStyle(color: Colors.grey),
               ),
             ),


           ],
         ),
    );
  }
}
