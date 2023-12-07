import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(                    
      // appBar: AppBar(
      //   title: Text('Vertical Cards Example'),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all( 16.0),
          child: ListView(
            
            
          //  padding: EdgeInsets.all(15),
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildVerticalCard('Diet', 'assets/images/diet.jpg'),
              buildVerticalCard('Workouts', 'assets/images/workouts.jpg'),
              buildVerticalCard('Mudras', 'assets/images/mudra1.jpg'),
              buildVerticalCard('BMI Calculator', 'assets/images/bmi.jpg'),
              
            ],
          ),   
         
        ),
      ),
    );
  }

  Widget buildVerticalCard(String title, String imagePath) {
    return Column(
      children: [
        SizedBox(height: 15,),
        GestureDetector(
          onTap: (){},
          child: Column(
            children: [
              
              Card(
                shadowColor: Colors.indigoAccent,
                elevation: 34.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 150,
                      child: Image.asset(
                        imagePath,
                        height: 120,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



























