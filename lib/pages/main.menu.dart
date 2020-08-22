import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import '../services/request.dart';
import '../widget/getlkn.dart';
import './profile.dart';
import 'package:auto_size_text/auto_size_text.dart';

final List<String> imageList = [
  'assets/images/bnn.jpeg',
  'assets/images/bnn2.jpeg'
];
class MainMenu extends StatefulWidget{  
  @override
  _MainMenuState createState() => _MainMenuState();
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'profile', icon: Icons.directions_boat),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
class _MainMenuState extends State<MainMenu>{
  var data;
  String next;
  var keyword;
  var lknCount;
  var pnkpCount;
  var tskCount;
  var bbCount;

  void _select(Choice choice) async {
    final response = await verifyToken();
    data = response['data']['user'];
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(data: data,)));
  }

   @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      
      body: 
      Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.2),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ListView(
          children:<Widget>[
            Column(children: <Widget>[
              AppBar(
                title: Text('Menu'),
                actions: <Widget>[
                    PopupMenuButton<Choice>(
                      onSelected: _select,
                      itemBuilder: (BuildContext context) {
                        return choices.map((Choice choice) {
                          return PopupMenuItem<Choice>(
                            value: choice,
                            child: Text(choice.title),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              SizedBox(height: 30),
          GFCarousel(
            viewportFraction: 1.0,
            items: imageList.map(
            (url) {
            return Container(
                margin: EdgeInsets.only(top: 1.0, bottom: 1.0, right: 1.0, left: 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Image.asset(
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
          Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 4.0),
                child:  TextFormField(
                       onChanged: (val) {
                        setState(() {
                          keyword = val.toString();
                        });
                      },
                      focusNode: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        // labelText: '    Input Pencarian',
                        hintText: '    Input Pencarian',
                        fillColor: Colors.white.withOpacity(0.7),
                        filled: true,
                      ),
                      style: TextStyle(
                  color: Colors.black,
              ),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              lkn(null, null, keyword: keyword).then((response){
                 if (response['results'] != null){
                    setState(() {
                      lknCount = response['count']; 
                    });
                 }
              });
              pnkp(null, null, keyword: keyword).then((response){
                if (response['results'] != null){
                  setState(() {
                    pnkpCount = response['count'];
                  });                }
              });
              bb(null, null, keyword: keyword).then((response){
                 if (response['results'] != null){
                    setState(() {
                      bbCount = response['count']; 
                    });
                 }
              });
              tsk(null, null, keyword: keyword).then((response){
                 if (response['results'] != null){
                    setState(() {
                      tskCount = response['count']; 
                    });
                 }
              });

              if(keyword==''){
                final snackBar = SnackBar(content: Text('reset keyword'));
                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                final snackBar = SnackBar(content: Text('set $keyword sebagai keyword'));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            child: Text(
              "Cari Data",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Container(
          height:600,
          child: CustomScrollView(
          slivers:<Widget>[
            SliverList(
          delegate: SliverChildListDelegate([
          GridView.count(
            padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: Colors.blue[800],
                            width: lknCount!=null ? 0 : 7
                          ),
                        ),
                        child: new IconButton(icon: new Icon(Icons.assignment),
                          color: Colors.white,
                          iconSize: 25,
                          onPressed: () {
                            lkn(null, null, keyword: keyword).then((response){
                              if (response['results'] != null){
                                setState(() {
                                  data = response['results'];
                                  next = response['next'];
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'LKN',created:'created', title:'LKN', next: next)));
                              }
                            });
                          }
                        )
                      ),
                    ),
                    SizedBox(height: 15),
                    AutoSizeText('LKN',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                    if(lknCount!=null)
                    AutoSizeText('$lknCount Berkas',style: TextStyle(fontWeight: FontWeight.w300),maxLines: 1,),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: Colors.blue[800],
                            width: pnkpCount!=null ? 0 : 7
                          ),
                        ),
                        child: new IconButton(icon: new Icon(Icons.search),
                          color: Colors.white,
                          iconSize: 25,
                          onPressed: () {
                            pnkp(null, null, keyword: keyword).then((response){
                              if (response['results'] != null){
                                setState(() {
                                data = response['results'];
                                next = response['next'];
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'no_penangkapan', created:'tanggal_penangkapan', title:'PENANGKAPAN', next: next)));
                              }
                            });
                          }
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    AutoSizeText('SP KAP',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                    if(pnkpCount!=null)
                    AutoSizeText('$pnkpCount berkas',style: TextStyle(fontWeight: FontWeight.w300),maxLines: 1,),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: Colors.blue[800],
                            width: bbCount!=null ? 0 : 7
                          ),
                        ),
                        child: new IconButton(icon: new Icon(Icons.business_center),
                          color: Colors.white,
                          iconSize: 25,
                          onPressed: () {
                            bb(null, null, keyword: keyword).then((response){
                              if (response['results'] != null){
                                setState(() {
                                  data = response['results'];
                                  next = response['next'];
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'nama_barang', created:'jenis_barang', title:'BARANG BUKTI', next: next,)));
                              }
                            });
                          }
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    AutoSizeText('BB',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                    if(bbCount!=null)
                    AutoSizeText('$bbCount Berkas',style: TextStyle(fontWeight: FontWeight.w300),maxLines: 1,),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Expanded(
                      child:Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(1000),
                          border: Border.all(
                            color: Colors.blue[800],
                            width: tskCount!=null ? 0 : 7
                          ),
                        ),
                        child: new IconButton(icon: new Icon(Icons.person_pin),
                          color: Colors.white,
                          iconSize: 25,
                          onPressed: () {
                            tsk(null, null, keyword: keyword).then((response){
                              if (response['results'] != null){
                                setState(() {
                                data = response['results'];
                                next = response['next'];
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'nama_tersangka', created:'jenis_kelamin', title:'TERSANGKA', next: next,)));
                              }
                            });
                          }
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    AutoSizeText('Tersangka',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                    if(tskCount!=null)
                    AutoSizeText('$tskCount Berkas',style: TextStyle(fontWeight: FontWeight.w300),maxLines: 1,),
                  ]
                ),
              ),
            ],
          )  
        ])
        ),
          ]
        ),

        )
            ],)
            
        
          ]
          
        
        ),
      )
      );
    
  }
}