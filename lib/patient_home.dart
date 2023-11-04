import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kode_rx/category_cell.dart';
import 'package:kode_rx/doctor_cell.dart';
import 'app_colors.dart';

class PatientHome extends StatelessWidget {
  bool appBarSearchShow = false;
  final TextEditingController _filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.backgroundColor,
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
              collapsedHeight: 130,
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
                    left: 40, // Adjust the left position as needed
                    bottom: 65, // Adjust the bottom position as needed
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
                      expandedTitleScale: 1.3,
                      title: Container(
                        //margin: EdgeInsets.symmetric(horizontal: 10),
                        constraints:
                            const BoxConstraints(minHeight: 35, maxHeight: 35),
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Catageroies",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    )
                  ],
                ), // )
              ),
            ),

            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 170.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return CatageroieCell();
                  },
                ),
              ),
            )),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Top ',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          TextSpan(text: 'Docters'),
                        ],
                      ),
                    ),
                    const Text(
                      "See All",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    )
                  ],
                ), // )
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return DoctorCell();
                },
                childCount: 10, // The number of items
              ),
            ),

// ...

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 100,
                    color: AppColors.customBackground,
                    child: Center(
                      child: Text(
                        'Hello World',
                        style: TextStyle(fontSize: 24, color: Colors.amber),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Container(
            //         height: 100,
            //         color: AppColors.customBackground,
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(20.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Container(
            //         height: 400,
            //         color: AppColors.customBackground,
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(20.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Container(
            //         height: 400,
            //         color: AppColors.customBackground,
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(20.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Container(
            //         height: 400,
            //         color: AppColors.customBackground,
            //       ),
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(20.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Container(
            //         height: 400,
            //         color: AppColors.customBackground,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
