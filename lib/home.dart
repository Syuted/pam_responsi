import 'package:flutter/material.dart';
import 'package:pam_responsi/API/api_service.dart';
import 'package:pam_responsi/categories_meals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get data from API
  Future<Map<String, dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = APIService.instance.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEAL CATEGORIES'),
        backgroundColor: Colors.brown[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!['categories'];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealsPage(
                          category: data[index]['strCategory'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.brown[100]),
                    child: Column(
                      children: [
                        Image.network(data[index]['strCategoryThumb']),
                        SizedBox(height: 10),
                        Text(
                          data[index]['strCategory'],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(data[index]['strCategoryDescription'])
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
