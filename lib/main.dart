import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final regController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  String? bloodGroup;
  String? gender;

  Map<String, String> submittedData = {};

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        submittedData = {
          "Name": nameController.text,
          "Roll": rollController.text,
          "Registration": regController.text,
          "Blood Group": bloodGroup ?? "",
          "Gender": gender ?? "",
          "Phone": phoneController.text,
          "About": aboutController.text,
        };
      });

      // Clear form
      nameController.clear();
      rollController.clear();
      regController.clear();
      phoneController.clear();
      aboutController.clear();

      setState(() {
        bloodGroup = null;
        gender = null;
      });
    }
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value!.isEmpty ? "Required" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Practice")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField("Name", nameController),

                    const SizedBox(height: 10),

                   
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField("Roll", rollController),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildTextField("Registration", regController),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      value: bloodGroup,
                      hint: const Text("Blood Group"),
                      items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                          .map((bg) => DropdownMenuItem(
                        value: bg,
                        child: Text(bg),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          bloodGroup = value;
                        });
                      },
                      validator: (value) =>
                      value == null ? "Select blood group" : null,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Text("Gender: "),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text("Male"),
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text("Female"),
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    buildTextField("Phone Number", phoneController),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: aboutController,
                      decoration: const InputDecoration(labelText: "About Me"),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: handleSubmit,
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              
              if (submittedData.isNotEmpty)
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: submittedData.entries
                          .map((e) => Text("${e.key}: ${e.value}"))
                          .toList(),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
