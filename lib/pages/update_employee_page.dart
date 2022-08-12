import 'package:employee_information/models/employee.dart';
import 'package:employee_information/services/api_service.dart';
import 'package:employee_information/widgets/text_form.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    final employeeData = ModalRoute.of(context)!.settings.arguments as Employee;
    final nameController = TextEditingController();
    nameController.text = employeeData.name;
    final positionController = TextEditingController();
    positionController.text = employeeData.position;
    final avatarController = TextEditingController();
    avatarController.text = employeeData.avatar;
    ApiService apiService = ApiService();
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Update Employee Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(employeeData.avatar),
              radius: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            TextForm(dataController: nameController, title: ''),
            const SizedBox(
              height: 10,
            ),
            TextForm(
              dataController: avatarController,
              title: '',
            ),
            const SizedBox(
              height: 10,
            ),
            TextForm(
              dataController: positionController,
              title: '',
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Confirmation',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: const Text(
                          'Are you sure want to update this employee information?'),
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
                            bool isUpdated = await apiService.updateData(
                                employeeData.id,
                                nameController.text,
                                avatarController.text,
                                positionController.text);

                            if (isUpdated) {
                              Navigator.popAndPushNamed(context, '/');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text('Employee was successfully updated'),
                                ),
                              );
                            } else {
                              Navigator.pop(context, false);
                            }
                            nameController.clear();
                            avatarController.clear();
                            positionController.clear();
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
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
