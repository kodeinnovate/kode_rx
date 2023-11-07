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
  CatageroiesData(title: 'Physician', image: 'https://images.freeimages.com/clg/istock/previews/1023/102318825-doctor-vector-icon-round.jpg'),
  CatageroiesData(title: 'Peadiatrician', image: 'https://c8.alamy.com/comp/2FM9NW6/handsome-male-doctor-holds-a-newborn-baby-in-her-arms-accoucheur-in-uniform-holding-child-medical-icons-or-signs-health-care-banner-trendy-style-v-2FM9NW6.jpg'),
  CatageroiesData(title: 'Gynaecologist', image: 'https://icon-library.com/images/gynecology-icon/gynecology-icon-8.jpg'),
  CatageroiesData(title: 'Orthopaedic', image: 'https://cdni.iconscout.com/illustration/premium/thumb/female-nurse-looking-at-broken-leg-x-ray-6767090-5649817.png?f=webp'),
];

List<DoctersData> docdata = [
  DoctersData(
      name: 'Dr Ashlynn Crosswhite',
      profession: 'Physician',
      image: 'https://img.freepik.com/premium-photo/photo-female-doctor-physician-medical-uniform-with-stethoscope-cross-arms-chest-smiling_812426-24163.jpg'),
  DoctersData(
      name: 'Dr. Scarlett Theodoropoulo',
      profession: 'Gynaecologist',
      image: 'https://img.freepik.com/premium-photo/photo-female-doctor-physician-medical-uniform-with-stethoscope-cross-arms-chest-smiling_812426-21604.jpg'),
  DoctersData(
      name: 'Dr. Isabella Marabella',
      profession: 'Orthopedic',
      image: 'https://img.freepik.com/premium-photo/photo-female-doctor-physician-medical-uniform-with-stethoscope-cross-arms-chest-smiling_812426-28118.jpg'),
  DoctersData(
      name: 'Dr. Damien Chaffee',
      profession: 'Neuro Physician',
      image: 'https://image.similarpng.com/very-thumbnail/2020/05/Beautiful-doctor-vector-illustration-PNG.png'),
  DoctersData(
      name: 'Dr. Damien Chaffee',
      profession: 'Neuro Physician',
      image: 'https://image.similarpng.com/very-thumbnail/2020/05/Beautiful-doctor-vector-illustration-PNG.png'),
  DoctersData(
      name: 'Dr Ryleigh Jorden',
      profession: 'Urologist',
      image: 'https://img.freepik.com/free-icon/doctor_318-342603.jpg?w=2000'),
  DoctersData(
      name: 'Dr Rebekah Durphey',
      profession: 'Cardiologist',
      image: 'https://static.vecteezy.com/system/resources/thumbnails/007/986/570/small/woman-doctor-icon-doctor-woman-with-stereoscopic-glyph-isolated-blue-background-vector.jpg'),
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

              flexibleSpace: Stack(
                children: [
                  // Title(color: Colors.black87, child: Text('Hello World')),
                  Positioned(
                    left: 45, // Adjust the left position as needed
                    bottom: 85, // Adjust the bottom position as needed
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
                      title: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding here
                          child:Container(
                        //margin: EdgeInsets.symmetric(horizontal: 10),
                        constraints:
                            const BoxConstraints(minHeight: 30, maxHeight: 35),
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
                      )),),
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
