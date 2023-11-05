import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Medicene {
  final int id;
  final String name;
  final MediceneCategory category;
  bool isSelected;

  Medicene({required this.id, required this.name, required this.category, this.isSelected = false});
}

class MediceneCategory {
  final int id;
  final String name;

  MediceneCategory({required this.id, required this.name});
}

class MediceneListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => MediceneListProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Medicine List'),
          ),
          body: MediceneList(),
        ),
      ),
    );
  }
}


class MediceneList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediceneProvider = Provider.of<MediceneListProvider>(context);

    return Column(
      children: [
        Container(
          color: Colors.blue, // Set the background color to blue
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Set the input field background color to white
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CupertinoTextField(
              placeholder: 'Search Medicene', // Set the placeholder text
              prefix: Icon(
                CupertinoIcons.search,
                color: Colors.black,
              ),
              onChanged: (query) {
                mediceneProvider.filterMediceneList(query);
              },
              style: TextStyle(color: Colors.black), // Set text color to black
              padding: EdgeInsets.all(10),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: mediceneProvider.filteredMediceneList.length,
            itemBuilder: (context, index) {
              final medicene = mediceneProvider.filteredMediceneList[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    medicene.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Checkbox(
                    value: medicene.isSelected,
                    onChanged: (value) {
                      mediceneProvider.toggleSelection(medicene);
                    },
                    visualDensity: VisualDensity.comfortable,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MediceneListProvider with ChangeNotifier {
  final List<Medicene> mediceneList = [
    Medicene(id: 1, name: 'Medicene 1', category: MediceneCategory(id: 1, name: 'Category 1')),
    Medicene(id: 2, name: 'Medicene 2', category: MediceneCategory(id: 2, name: 'Category 2')),
    // Add more medicines here
  ];

  List<Medicene> _filteredMediceneList = [];

  List<Medicene> get filteredMediceneList => _filteredMediceneList;

  MediceneListProvider() {
    _filteredMediceneList = mediceneList;
  }

  void filterMediceneList(String query) {
    _filteredMediceneList = mediceneList
        .where((medicene) => medicene.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void toggleSelection(Medicene medicene) {
    medicene.isSelected = !medicene.isSelected;
    notifyListeners();
  }
}

void main() => runApp(MaterialApp(
  home: MediceneListScreen(),
));
