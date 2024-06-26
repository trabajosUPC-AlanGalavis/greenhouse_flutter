import 'package:flutter/material.dart';
import 'package:greenhouse/models/company.dart';
import 'package:greenhouse/widgets/bottom_navigation_bar.dart';
import 'package:greenhouse/widgets/editing_textForm.dart';
import 'package:greenhouse/widgets/message_response.dart';

class EditCompanyScreen extends StatefulWidget {
  const EditCompanyScreen({
    super.key,
    required this.company,
    required this.updateCompany,
  });

  final Company company;
  final Function(Company) updateCompany;

  @override
  State<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  late TextEditingController _nameController;
  late TextEditingController _tinController;
  late TextEditingController _iconUrlController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _tinController = TextEditingController();
    _iconUrlController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go back', style: TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.company.iconUrl),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditingTextForm(
                        hintText: "Name",
                        valueController: _nameController,
                        placeholderText: widget.company.name,
                      ),
                      EditingTextForm(
                        hintText: "Tin",
                        valueController: _tinController,
                        placeholderText: widget.company.tin,
                      ),
                      EditingTextForm(
                        hintText: "Image",
                        valueController: _iconUrlController,
                        placeholderText: widget.company.iconUrl,
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Color(0xFF67864A),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Color(0xFF4C6444),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            String name = _nameController.text.isEmpty
                                ? widget.company.name
                                : _nameController.text;
                            String tin = _tinController.text.isEmpty
                                ? widget.company.tin
                                : _tinController.text;
                            String iconUrl = _iconUrlController.text.isEmpty
                                ? widget.company.iconUrl
                                : _iconUrlController.text;

                            if (name.isNotEmpty ||
                                tin.isNotEmpty ||
                                iconUrl.isNotEmpty) {
                              Company updatedCompany = Company(
                                name: name,
                                tin: tin,
                                iconUrl: iconUrl,
                              );

                              void editCompany() {
                                try {
                                  widget.updateCompany(updatedCompany);
                                  Navigator.pop(context, updatedCompany);
                                } catch (e) {
                                  print('Failed to update company: $e');
                                }
                              }

                              messageResponse(
                                context,
                                "Are you sure you want to\nedit ${widget.company.name} profile?",
                                "Yes, Edit",
                                editCompany,
                              );
                            }
                          },
                          child: Text(
                            "Edit company profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GreenhouseBottomNavigationBar(),
    );
  }
}
