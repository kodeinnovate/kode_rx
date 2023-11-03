import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class PatientHome extends StatelessWidget {
  bool appBarSearchShow = false;
  final TextEditingController _filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              leading: const Icon(Icons.menu),
              backgroundColor: AppColors.customBackground,
              // title: Text('Find Your Desired Doctor'),
              expandedHeight: 200,
              collapsedHeight: 90,
              floating: true,
              pinned: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/kodeinnovate.png'),
                    radius: 30, // Adjust the size as needed
                  ),
                ),
              ],

              flexibleSpace: Stack(
                children: [
                  // Title(color: Colors.black87, child: Text('Hello World')),
                  const Positioned(
                    left: 50, // Adjust the left position as needed
                    bottom: 55, // Adjust the bottom position as needed
                    child: Text(
                      'Find your desired doctor',
                      style: TextStyle(
                        color: Colors.white, // Adjust the text color
                        fontSize: 24, // Adjust the text size
                      ),
                    ),
                  ),
                  FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      expandedTitleScale: 1.2,
                      title: Container(
                      
                        //margin: EdgeInsets.symmetric(horizontal: 10),
                        constraints:
                            const BoxConstraints(minHeight: 30, maxHeight: 30),
                        width: 300,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(1.2, 1.1),
                                blurRadius: 5.0),
                          ],
                        ),
                        child: CupertinoTextField(
                          controller: _filter,
                          keyboardType: TextInputType.text,
                          placeholder: 'Looking for...',
                          placeholderStyle: const TextStyle(
                            color: Color(0xffC4C6CC),
                            fontSize: 14.0,
                            fontFamily: 'Brutal',
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                            child: Icon(
                              Icons.search,
                              size: 18,
                              color: Color(0xffC4C6CC),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 400,
                    color: AppColors.customBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 400,
                    color: AppColors.customBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 400,
                    color: AppColors.customBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 400,
                    color: AppColors.customBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 400,
                    color: AppColors.customBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 400,
                    color: AppColors.customBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
