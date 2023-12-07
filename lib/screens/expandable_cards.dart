


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ExpandableCardList extends StatefulWidget {
  @override
  _ExpandableCardListState createState() => _ExpandableCardListState();
}

class _ExpandableCardListState extends State<ExpandableCardList> {
  List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirestore();
  }

  Future<void> _fetchDataFromFirestore() async {
    final collection = FirebaseFirestore.instance.collection('diet_cards');
    final querySnapshot = await collection.get();

    setState(() {
      _data = querySnapshot.docs.map((doc) {
        String contentWithLineBreaks = doc['content'].replaceAll(r'\n', '\n');
        
        return Item(
          headerValue: doc['title'] ?? '',
          expandedValue: contentWithLineBreaks,
          isExpanded: false, // Initialize all cards as collapsed
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 87, 107, 218),
        title: Text('Healthy Diet'),
      ),
      body: ListView(
        
        children: _data.map<Widget>((Item item) {
          return Card(
            
            
            elevation: 36,
            margin: EdgeInsets.all(10),
            child: ExpansionTile(
              tilePadding: EdgeInsets.all(26),
              
              title: Text(
                item.headerValue,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, 
                color: item.isExpanded ? Color.fromARGB(255, 97, 118, 236) : Colors.black),
              ),
              leading: _getLeadingForItem(item),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item.expandedValue,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
              initiallyExpanded: item.isExpanded,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  item.isExpanded = expanded;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _getLeadingForItem(Item item) {
    // Replace this logic with your custom leading widget selection based on the item
    if (item.headerValue == 'Card 1') {
      return Icon(Icons.star);
    } else if (item.headerValue == 'Card 2') {
      return Icon(Icons.favorite);
    } else {
      return Icon(Icons.food_bank,color: item.isExpanded ? const Color.fromRGBO(255, 110, 64, 1) : Colors.black,);
    }
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.isExpanded,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
 