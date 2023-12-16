import 'package:flutter/material.dart';

class List extends StatefulWidget {
  const List({Key? key});

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  var arrnames = ['rashid', 'shoeb', 'mohsin', 'anas', 'o', 'x', 'y', 'z'];
  var filteredNames = <String>[];

  @override
  void initState() {
    super.initState();
    filteredNames.addAll(arrnames);
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredNames = arrnames
            .where((name) => name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredNames = [...arrnames];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rx History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.7),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2.0,
                  ),
                ),
                hintText: 'Search Medicine',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: const Color.fromARGB(255, 238, 238, 238),
              ),
              onChanged: filterSearchResults,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Center(
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          filteredNames[index],
                          style: const TextStyle(fontSize: 22),
                        ),
                        trailing: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/5847.jpg'),
                          radius: 30,
                        ),
                        subtitle: const Text(
                          'Date',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: filteredNames.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 25,
                  thickness: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}