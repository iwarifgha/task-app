// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../controller/state/projects_state_provider.dart';
// import '../../tasks/model/task/task_model.dart';

// class EditTaskView extends StatefulWidget {
//   const EditTaskView({super.key, required this.task});

//   final Task task;

//   @override
//   State<EditTaskView> createState() => _EditTaskViewState();
// }

// class _EditTaskViewState extends State<EditTaskView> {
//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;

//   _editTask() {
//     context.read<HomeStateProvider>().editProject(
//         taskId: widget.task.id,
//         title: _titleController.text.trim(),
//         description: _descriptionController.text.trim());
//   }

//   @override
//   void initState() {
//     _titleController = TextEditingController(text: widget.task.title);
//     _descriptionController =
//         TextEditingController(text: widget.task.description);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = context.read<HomeStateProvider>();
//     final errorMessage = taskProvider.errorMessage;
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Edit Task'),
//         ),
//         body: Column(
//           spacing: 18,
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   taskProvider.clearError();

//                   _editTask();

//                   if (errorMessage != null) {
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(SnackBar(content: Text(errorMessage)));
//                     return;
//                   }

//                   Navigator.pop(context);
//                 },
//                 child: const Text('Save'))
//           ],
//         ));
//   }
// }
