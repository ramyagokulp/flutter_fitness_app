import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_flutter/videos/video_player_screen.dart';
import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late TextEditingController searchController = TextEditingController();
  bool isSearchBarVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isClicked =false;
    return SafeArea(
      child: Column(
        children: [
         Padding(
           padding: const EdgeInsets.all(26.0),
           child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
           // borderOnForeground: RoundedRectangleBorder(),
            elevation: 56,
           shadowColor: Colors.white,
             child: TextField(
               
             
                     
               controller: searchController,
               onChanged: (query) {
                 setState(() {});
               },
               cursorColor: Colors.black,
               decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(width: 1.6,color: Colors.indigoAccent),
                   borderRadius: BorderRadius.circular(26)
                 ),
                 
                 iconColor: Colors.black,
                 hintText: 'Search videos',
                 // ignore: dead_code
                 suffixIcon: Icon(Icons.search,size: 30,color: isClicked ? Colors.indigoAccent : Colors.indigo,),
                 
                
                 focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
                   color: Colors.indigoAccent
                 ))
                     
               ),
             ),
           ),
         ),
            
          




          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('videos').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading videos'),
                  );
                }
    
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
    
                List<VideoData> videos = snapshot.data!.docs
                    .map((doc) => VideoData.fromSnapshot(doc))
                    .toList();
    
                // Filter videos based on the search query
                if (searchController.text.isNotEmpty) {
                  final query = searchController.text.toLowerCase();
                  videos = videos.where((video) {
                    return video.title.toLowerCase().contains(query);
                  }).toList();
                }
    
                return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return VideoListItem(videoData: videos[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class VideoData {
  final String title;
  final String videoUrl;
  final String previewImageUrl;

  VideoData({required this.title, required this.videoUrl,required this.previewImageUrl});

  factory VideoData.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return VideoData(
      title: data['title'],
      videoUrl: data['video_url'],
      previewImageUrl:data['img_url']
    );
  }
}



class VideoListItem extends StatelessWidget {
  final VideoData videoData;

  VideoListItem({required this.videoData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
        
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 46,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(videoData.previewImageUrl,
                  height: 150,width: double.infinity,
                  fit: BoxFit.cover,),
                  SizedBox(height: 10,),
                  Text(videoData.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  
                  SizedBox(height: 10,)
            ],),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                     builder: (context) => VideoPlayerScreen(videoData: videoData),
                  
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}