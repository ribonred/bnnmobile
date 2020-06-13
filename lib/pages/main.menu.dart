import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class MainMenu extends StatefulWidget{
  
  
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>{
   @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue[300],

      body: ListView(
        children:<Widget>[
          Column(children: <Widget>[
            AppBar(
              title: Text('Menu')
              ,),
            SizedBox(height: 30),
        GFCarousel(
          viewportFraction: 1.0,
    items: imageList.map(
     (url) {
     return Container(
       margin: EdgeInsets.only(top: 1.0, bottom: 1.0, right: 1.0, left: 1.0),
       child: ClipRRect(
         borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Image.network(
             url,
             fit: BoxFit.cover,
              width: 1000.0,
           ),
        ),
      );
      },
     ).toList(),
    onPageChanged: (index) {
      setState(() {
        
      });
    },
 ),

        Container(
        height:600,
        child: CustomScrollView(
        slivers:<Widget>[
           

          SliverList(
        delegate: SliverChildListDelegate([
        GridView.builder(
          padding: const EdgeInsets.only(top: 50, right: 5, left: 5),
          shrinkWrap: true,
          itemBuilder: (BuildContext _, int index){
            return Container(
              decoration: BoxDecoration(
               
              ),
              child: Column(
                children:<Widget>[
                  Icon(
                    Icons.airplay,
                    size: 40,
                    ),
                  Text('Data')
                ]
              ),
            );
          },
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            ),
          )
      ]
      )
      ),
        ]
      ),

      )
          ],)
          
      
        ]
        
      
      )
      );
    
  }
}