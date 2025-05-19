import 'package:flutter/material.dart';
import 'package:routas_lapaz/mapa.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  var medio='';
   @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
     
      appBar: AppBar(
        title:Text("Rutas La Paz"),
      ),
      body: 
      
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/lapaz.jpg'),
                fit: BoxFit.cover
                )
            ),
            child: 
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      alignment: Alignment(0, 0),
                      width: screen.width,
                      height: screen.height/3,
                      child: Text("Rutas de Turismo",style: TextStyle(fontSize: 30),),  
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                            medio='foot';
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>MapaLaPaz(medio:medio)));
                          },
                          child: Container(
                            alignment: Alignment(0, 0),
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color:Colors.amber,
                              borderRadius: BorderRadius.circular(100)
                    
                            ),
                            child: Text("A pie")
                          )
                        ),
                        Container(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap:(){
                            medio='car';
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>MapaLaPaz(medio:medio)));

                          },
                          child: Container(
                            alignment: Alignment(0, 0),
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color:Colors.amber,
                              borderRadius: BorderRadius.circular(100)
                    
                            ),
                            child: Text("Movilidad")
                          )
                        )
                      ],
                      )
                  ]
                ),
            
          ),
          );
  }
}