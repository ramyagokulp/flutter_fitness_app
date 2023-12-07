
import 'package:fitness_app_flutter/screens/profile.dart';


import 'package:fitness_app_flutter/screens/expandable_cards.dart';

import 'package:fitness_app_flutter/screens/bmicalculator.dart';
import 'package:fitness_app_flutter/videos/videos_search.dart';

//import 'package:fitness_app_flutter/screens/diet_cards.dart';
import 'package:flutter/material.dart';


class Bottom_nav extends StatefulWidget {
  @override
  State<Bottom_nav> createState() => _Bottom_navState();
}

class _Bottom_navState extends State<Bottom_nav> {
  
int pageIndex = 0;

final pages = [
	ExpandableCardList(),
  VideoList(),
  BMICalculator(),
	Profile(),
];


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       

backgroundColor:const Color.fromARGB(255, 197, 204, 248),
	
	body: pages[pageIndex],
	bottomNavigationBar: buildMyNavBar(context),


    
    );
  }




  Container buildMyNavBar(BuildContext context) {
	return Container(
	height: 60,
	decoration: BoxDecoration(
		color: Theme.of(context).primaryColor,
		borderRadius: const BorderRadius.only(
		topLeft: Radius.circular(20),
		topRight: Radius.circular(20),
		),
	),
	child: Row(
		mainAxisAlignment: MainAxisAlignment.spaceAround,
		children: [
		IconButton(
			enableFeedback: false,
			onPressed: () {
			setState(() {
				pageIndex = 0;
			});
			},
			icon: pageIndex == 0
				? const Icon(
					Icons.home_filled,
					color: Colors.white,
					size: 35,
				)
				: const Icon(
					Icons.home_outlined,
					color: Colors.white,
					size: 35,
				),
		),
		IconButton(
			enableFeedback: false,
			onPressed: () {
			setState(() {
				pageIndex = 1;
			});
			},
			icon: pageIndex == 1
				? const Icon(
					Icons.sports_gymnastics_sharp,
					color: Colors.white,
					size: 35,
				)
				: const Icon(
					Icons.sports_gymnastics_outlined,
					color: Colors.white,
					size: 35,
				),
		),
		IconButton(
			enableFeedback: false,
			onPressed: () {
			setState(() {
				pageIndex = 2;
			});
			},
			icon: pageIndex == 2
				? const Icon(
					Icons.widgets_outlined,
					color: Colors.white,
					size: 35,
				)
				: const Icon(
					Icons.widgets_outlined,
					color: Colors.white,
					size: 35,
				),
		),
		IconButton(
			enableFeedback: false,
			onPressed: () {
			setState(() {
				pageIndex = 3;
			});
			},
			icon: pageIndex == 3
				? const Icon(
					Icons.person,
					color: Colors.white,
					size: 35,
				)
				: const Icon(
					Icons.person_outline,
					color: Colors.white,
					size: 35,
				),
		),
		],
	),
	);
}
}

