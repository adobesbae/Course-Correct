import 'package:flutter/material.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  RecommendationState createState() => RecommendationState();
}

class RecommendationState extends State<Recommendation> {
  final List<Map<String, dynamic>> recommendations = [
    {
      'icon': Icons.phone_android,
      'label': 'Mobile application dev.',
      'languages': ['Dart', 'Kotlin', 'Java', 'Swift']
    },
    {
      'icon': Icons.desktop_windows,
      'label': 'Desktop application dev.',
      'languages': ['C#', 'Java', 'Python', 'C++']
    },
    {
      'icon': Icons.videogame_asset,
      'label': 'Games development',
      'languages': ['C++', 'C#', 'Python', 'Lua']
    },
    {
      'icon': Icons.web,
      'label': 'Web development',
      'languages': ['JavaScript', 'Python', 'PHP', 'Ruby']
    },
    {
      'icon': Icons.memory,
      'label': 'Machine learning',
      'languages': ['Python', 'R', 'Java', 'C++']
    },
    {
      'icon': Icons.code,
      'label': 'Frontend Development',
      'languages': ['HTML', 'CSS', 'JavaScript', 'TypeScript']
    },
    {
      'icon': Icons.cloud,
      'label': 'Cloud Development',
      'languages': ['Python', 'Go', 'Java', 'Ruby']
    },
  ];

  int? _expandedIndex;

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
              'Recommendations',
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
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];
          final isExpanded = _expandedIndex == index;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(recommendation['icon'], color: Colors.white),
                      const SizedBox(width: 16),
                      Text(
                        recommendation['label'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recommendation['languages']
                        .map<Widget>((language) => Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '- $language',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
