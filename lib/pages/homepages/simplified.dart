import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// For kIsWeb

class SimplifiedPage extends StatefulWidget {
  const SimplifiedPage({super.key});

  @override
  SimplifiedPageState createState() => SimplifiedPageState();
}

class SimplifiedPageState extends State<SimplifiedPage> {
  late YoutubePlayerController _youtubeController;

  final List<Map<String, String>> videos = [
    {
      'title': 'Flutter Tutorial for Beginners',
      'description': 'An introduction to the Flutter framework.',
      'url': 'https://youtu.be/CD1Y2DmL5JM?t=3',
      'pdf': 'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf',
      'thumbnail': 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg',
    },
    {
      'title': 'State Management in Flutter',
      'description': 'Learn state management techniques in Flutter.',
      'url': 'https://youtu.be/3tm-R7ymwhc',
      'pdf': 'https://www.theseus.fi/bitstream/handle/10024/355086/Dmitrii_Slepnev.pdf',
      'thumbnail': 'https://img.youtube.com/vi/R9C5KMJKluE/0.jpg',
    },
    // Additional video entries can be added here.
    {
      'title': 'Email Login & Logout. Flutter Auth Tutorial',
      'description': 'Learn Firebase Email Authentication.',
      'url': 'https://youtu.be/_3W-JuIVFlg?t=405',
      'pdf': 'https://firebase.flutter.dev/docs/auth/email-link-auth/',
      'thumbnail': 'https://youtu.be/_3W-JuIVFlg.jpg',
    },
    
    {
      'title': 'Google Sign In. Flutter Auth Tutorial',
      'description': 'Learn Firebase Google Authentication.',
      'url': 'https://youtu.be/1U8_Mq1QdX4?t=235',
      'pdf': 'https://ijrpr.com/uploads/V5ISSUE4/IJRPR24883.pdf',
      'thumbnail': 'https://img.youtube.com/vi/R9C5KMJKluE/0.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videos.first['url']!)!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2), // Shadow color with transparency
                offset:
                    const Offset(0, 4), // Horizontal and vertical shadow offset
                blurRadius: 8.0, // Softness of the shadow
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'Simplified study materials',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 15, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0, // Disable default shadow
          ),
        ),
      ),
      body: Column(
        children: [
          // Display YouTube video player
          YoutubePlayer(controller: _youtubeController),

          // List of videos
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 5,
                  child: ListTile(
                    leading: Image.network(
                      video['thumbnail']!,
                      width: 100,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image,
                            size: 60, color: Colors.grey);
                      },
                    ),
                    title: Text(video['title']!),
                    subtitle: Text(video['description']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.picture_as_pdf),
                      onPressed: () {
                        _downloadPDF(video['pdf']!);
                      },
                    ),
                    onTap: () {
                      _changeVideo(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to change video when tapped
  void _changeVideo(int index) {
    final videoUrl = videos[index]['url']!;
    _youtubeController.load(YoutubePlayer.convertUrlToId(videoUrl)!);
  }

  // Method to download PDF associated with the video
  Future<void> _downloadPDF(String pdfUrl) async {
    final Uri uri = Uri.parse(pdfUrl);
    try {
      // Check if the widget is still mounted before using BuildContext
      if (mounted) {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('Could not launch $pdfUrl');
        }
      }
    } catch (e) {
      // Check if the widget is still mounted before showing SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open PDF: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }
}
