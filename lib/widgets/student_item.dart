
import 'package:fenchenko_artur_kiuki21_9/models/student.dart';
import 'package:fenchenko_artur_kiuki21_9/widgets/students.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  Color _getBackgroundColor(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Colors.blue.shade100;
      case Gender.female:
        return Colors.pink.shade100;
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return _buildStudentCard(student);
        },
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 4,
      color: _getBackgroundColor(student.gender),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          '${student.firstName} ${student.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(departmentIcons[student.department], size: 20),
            const SizedBox(width: 8),
            Text(
              '${student.grade}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}