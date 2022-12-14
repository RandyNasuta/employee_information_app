import 'package:employee_information/services/api_service.dart';
import 'package:employee_information/widgets/text_form.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final positionController = TextEditingController();
    final avatarController = TextEditingController();
    ApiService apiService = ApiService();

    bool checkController() {
      if ((nameController.text) != '' &&
          (positionController.text != '') &&
          (avatarController.text != '')) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Add Employee Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextForm(dataController: nameController, title: 'Employee name'),
            const SizedBox(
              height: 10,
            ),
            TextForm(
                dataController: avatarController, title: 'Employee avatar'),
            const SizedBox(
              height: 10,
            ),
            TextForm(
                dataController: positionController, title: 'Employee position'),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (checkController()) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Confirmation',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text(
                            'Are you sure want to post this employee information?'),
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
                              bool isPosted = await apiService.postData(
                                  nameController.text,
                                  positionController.text,
                                  avatarController.text);

                              if (isPosted) {
                                Navigator.popAndPushNamed(context, '/');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                        'Employee was successfully posted'),
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
                } else {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Failed',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text(
                            'Post employee failed. Please fill the form correctly'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Back'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
