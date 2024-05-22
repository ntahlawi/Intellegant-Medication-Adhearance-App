import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/Social/PostQuestions.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/Pages/Social/DetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  String _selectedGroup = 'General';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the PostQuestionScreen
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PostQuestionScreen(),
          ));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.titleSmall!.color,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 0.035),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.0075,
                      ),
                      Text(
                        'Ask and Socialize and be Healthy!',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.pointThreeHeight),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.pointThreeWidth),
              child: Container(
                padding: EdgeInsets.only(left: SizeConfig.pointFifteenWidth),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  cursorColor: Theme.of(context).textTheme.headlineSmall?.color,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search For Helpful Posts Here...',
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                    prefixIcon: const Icon(EvaIcons.search),
                    prefixIconColor: Theme.of(context).iconTheme.color,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig.pointFifteenHeight, //align hint text with icon
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.pointThreeHeight),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).colorScheme.primary,
              ),
              child: DropdownButton<String>(
                value: _selectedGroup,
                iconEnabledColor: Theme.of(context).textTheme.titleSmall!.color, // Icon color
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color, // Text color
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGroup = newValue!;
                  });
                },
                items: <String>['Diabetic', 'Pre-Diabetic', 'General']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Questions')
                    .where('group', isEqualTo: _selectedGroup)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong', style: TextStyle(color: Colors.black)); // Text style for error message
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['title'], style: TextStyle(color: Colors.black)), // Text style for title
                        subtitle: Text(data['description'], style: TextStyle(color: Colors.black)), // Text style for subtitle
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(questionId: document.id),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}