import 'package:fenchenko_artur_kiuki21_9/models/student.dart';
import 'package:flutter/material.dart';

class NewStudent extends StatefulWidget {
  final Student? studentToEdit;

  const NewStudent({Key? key, this.studentToEdit}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _gradeController;
  Department _selectedDepartment = Department.it;
  Gender _selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.studentToEdit?.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.studentToEdit?.lastName ?? '',
    );
    _gradeController = TextEditingController(
      text: widget.studentToEdit?.grade.toString() ?? '',
    );
    _selectedDepartment = widget.studentToEdit?.department ?? Department.it;
    _selectedGender = widget.studentToEdit?.gender ?? Gender.male;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        department: _selectedDepartment,
        grade: int.parse(_gradeController.text),
        gender: _selectedGender,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.studentToEdit != null ? 'Student updated' : 'Student added')),
      );

      Navigator.of(context).pop(newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentToEdit != null ? 'Edit Student' : 'New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => value!.isEmpty ? 'Please enter first name' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value!.isEmpty ? 'Please enter last name' : null,
              ),
              TextFormField(
                controller: _gradeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Grade'),
                validator: (value) => value!.isEmpty ? 'Please enter grade' : null,
              ),
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                items: const [
                  DropdownMenuItem(value: Gender.male, child: Text('Male')),
                  DropdownMenuItem(value: Gender.female, child: Text('Female')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Male'),
              ),
              DropdownButtonFormField<Department>(
                value: _selectedDepartment,
                items: const [
                  DropdownMenuItem(value: Department.it, child: Text('IT')),
                  DropdownMenuItem(value: Department.law, child: Text('Law')),
                  DropdownMenuItem(value: Department.finance, child: Text('Finance')),
                  DropdownMenuItem(value: Department.medical, child: Text('Medical')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Department'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text(widget.studentToEdit != null ? 'Save Changes' : 'Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}