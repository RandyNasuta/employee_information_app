import 'package:employee_information/models/employee.dart';
import 'package:employee_information/services/api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService _apiService = ApiService();
  late Future<List<Employee>> _employeeData;

  void getData() {
    _employeeData = _apiService.getAllData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Employee Information App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-page');
            },
            icon: Icon(Icons.add_box_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Employee>>(
          future: _employeeData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Employee> dataEmployee = snapshot.data!;
              return ListView.builder(
                itemCount: dataEmployee.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(
                      dataEmployee[index].id,
                    ),
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/update-page', arguments: dataEmployee[index]);
                      },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(dataEmployee[index].avatar),
                          ),
                          title: Text(dataEmployee[index].name),
                          subtitle: Text(dataEmployee[index].position),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Confirmation',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: const Text(
                                'Are you sure want to delete this employee information?'),
                            actions: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  bool _isDeleted = await _apiService
                                      .deleteData(dataEmployee[index].id);

                                  if (_isDeleted) {
                                    Navigator.pop(context, true);
                                  } else {
                                    Navigator.pop(context, false);
                                  }
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
