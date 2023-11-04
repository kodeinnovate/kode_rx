import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kode_rx/category_cell.dart';
import 'package:kode_rx/doctor_cell.dart';
import 'app_colors.dart';

class CatageroiesData {
  String? title;
  String? image;

  CatageroiesData({
    this.title,
    this.image,
  }); // Constructor
}

class DoctersData {
  String? name;
  String? profession;
  String? image;

  DoctersData({this.name, this.image, this.profession}); // Constructor
}

List<CatageroiesData> catdata = [
  CatageroiesData(title: 'Checkup', image: 'assets/images/kodeinnovate.png'),
  CatageroiesData(title: 'Lungs', image: 'assets/images/kodeinnovate.png'),
  CatageroiesData(title: 'Kidney', image: 'assets/images/kodeinnovate.png'),
  CatageroiesData(title: 'Heart', image: 'assets/images/kodeinnovate.png'),
];

List<DoctersData> docdata = [
  DoctersData(
      name: 'Dr. Ryleigh Dunker',
      profession: 'Gynaecologist',
      image: 'assets/images/kodeinnovate.png'),
  DoctersData(
      name: 'Dr. Corbin Melle',
      profession: 'Pediatrician',
      image: 'assets/images/kodeinnovate.png'),
  DoctersData(
      name: 'Dr. Scarlett Dena',
      profession: 'Psychiatrist',
      image: 'assets/images/kodeinnovate.png'),
  DoctersData(
      name: 'Dr. Angela Littrell',
      profession: 'Anesthesiologist',
      image: 'assets/images/kodeinnovate.png'),
  DoctersData(
      name: 'Dr Melba Knobloch',
      profession: 'Dermatologist',
      image: 'assets/images/kodeinnovate.png'),
  DoctersData(
      name: 'Dr Shayla Naveed',
      profession: 'Neurologist',
      image: 'assets/images/kodeinnovate.png'),
];

// ignore: must_be_immutable
class PatientHome extends StatelessWidget {
  
  bool appBarSearchShow = false;
  final TextEditingController _filter = TextEditingController();

  PatientHome({super.key});
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
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              leading: const Icon(Icons.menu),
              backgroundColor: AppColors.customBackground,
              // title: Text('Find Your Desired Doctor'),
              expandedHeight: 200,
              collapsedHeight: 130,
              floating: true,
              pinned: true,
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(top:10.0, right: 10.0),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/kodeinnovate.png'),
                    radius: 28, // Adjust the size as needed
                  ),
                ),
              ],

              flexibleSpace: Stack(
                children: [
                  // Title(color: Colors.black87, child: Text('Hello World')),
                  Positioned(
                    left: 65, // Adjust the left position as needed
                    bottom: 75, // Adjust the bottom position as needed
                    child: 
                    RichText(text: const TextSpan(
                      style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(text:
                      'Find ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'your desired doctor', 
                        style: TextStyle(fontWeight: FontWeight.w300)
                      )
                      ]
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
                            const BoxConstraints(minHeight: 40, maxHeight: 45),
                        width: 300,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 5.0),
                          ],
                        ),
                        child: CupertinoTextField(
                          controller: _filter,
                          keyboardType: TextInputType.text,
                          placeholder: 'Looking for...',
                          placeholderStyle: const TextStyle(
                            color: Color(0xffC4C6CC),
                            fontSize: 16.0,
                            fontFamily: 'Brutal',
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xffC4C6CC),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
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
                  itemCount: catdata.length,
                  itemBuilder: (context, index) {
                    return CatageroieCell(
                        title: catdata[index].title!,
                        image: catdata[index].image!);
                  },
                ),
              ),
            )),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
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
                          TextSpan(text: 'Doctors'),
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
                  return DoctorCell(
                    name: docdata[index].name!,
                    profession: docdata[index].profession!,
                    image: docdata[index].image!,
                  );
                },
                childCount: docdata.length, // The number of items
              ),
            ),

            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Container(
            //         height: 100,
            //         color: AppColors.customBackground,
            //         child: const Center(
            //           child: Text(
            //             'Hello World',
            //             style: TextStyle(fontSize: 24, color: Colors.amber),
            //           ),
            //         ),
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
