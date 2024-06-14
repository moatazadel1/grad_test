import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:new_app/core/constants/validators.dart';
import 'package:new_app/core/helper/api.dart';
import 'package:new_app/home/homescreen.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final FocusNode _titleFocusNode;
  late final FocusNode _descriptionFocusNode;
  late final _formKey = GlobalKey<FormState>();
  // bool _isLoading = false;

  @override
  void initState() {
    _title = TextEditingController();
    _description = TextEditingController();
    // Focus Nodes
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    // Focus Nodes
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  bool showDataError = false;
  DateTime? selectedData;

  bool isValidForm() {
    bool isValid = true;
    if (_formKey.currentState?.validate() == false) {
      setState(() {
        showDataError = true;
      });
      isValid = false;
    }
    if (selectedData == null) {
      setState(() {
        showDataError = true;
      });
      isValid = false;
    }
    return isValid;
  }

  Future<void> showData() async {
    var data = await showDatePicker(
      context: context,
      initialDate: selectedData ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    setState(() {
      selectedData = data;
      if (selectedData != null) {
        showDataError = false;
      }
    });
  }

  void addTask() async {
    if (isValidForm()) {
      try {
        await ApiService.addTask(_title.text, _description.text);
        // log(response.toString()); // Handle the response as needed
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        // Close the sheet on success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task added successfully'),
            duration: Duration(seconds: 2), // Adjust duration as needed
          ),
        );
      } catch (error) {
        log(error.toString());
        // Display an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add task: Title cannot be empty'),
            duration: Duration(seconds: 2), // Adjust duration as needed
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  "Add New Task",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(
                controller: _title,
                focusNode: _titleFocusNode,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
                validator: (value) {
                  return Validators.titleValidator(value);
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _description,
                focusNode: _descriptionFocusNode,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                validator: (value) {
                  return Validators.descriptionValidator(value);
                },
              ),
              InkWell(
                onTap: () {
                  showData();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    selectedData == null
                        ? "Select Date"
                        : "${selectedData?.day} / ${selectedData?.month} / ${selectedData?.year}",
                    style: const TextStyle(),
                  ),
                ),
              ),
              Visibility(
                visible: showDataError,
                child: Text(
                  "Please select Task date",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  onPressed: addTask,
                  child: const Text("Add Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
