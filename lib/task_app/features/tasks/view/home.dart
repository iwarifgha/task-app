import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/error_notifier.dart';
import '../../authentication/controller/service/auth_service.dart';
import '../controller/state/task_provider.dart';
import 'edit_task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authProvider = TodoAuthProvider();

  @override
  void initState() {
    final user = authProvider.getCurrentUser();
    setState(() {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks(user.uid);
    });
    super.initState();
  }

  _deleteTask({required String taskId}) {
    context.read<TaskProvider>().deleteTask(taskId);
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;
    final errorMessage = taskProvider.errorMessage;
    final user = authProvider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: errorMessage != null
          ? ErrorNotifier(
              message: errorMessage,
              onTap: () {
                taskProvider.clearError();
                taskProvider.fetchTasks(user.uid);
              })
          : tasks.isEmpty
              ? const Center(
                  child: Text('No tasks'),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                           builder: (BuildContext context) =>
                                              EditTaskView(task: task))));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  taskProvider.clearError();

                                  _deleteTask(
                                    taskId: task.id,
                                  );

                                  if (errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(errorMessage)));
                                    return;
                                  }
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                      ),
                    );
                  }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
