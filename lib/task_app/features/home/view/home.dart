import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/error_notifier.dart';
import '../../authentication/controller/service/auth_service.dart';
import '../../authentication/controller/state/auth_state_provider.dart';
import '../controller/state/home_state_provider.dart';
import 'edit_task.dart';

class HomeView extends StatefulWidget {
  static const path = '/home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authProvider = TaskAppAuthServiceProvider();

  @override
  void initState() {
    final user = authProvider.getCurrentUser();
    setState(() {
      Provider.of<HomeStateProvider>(context, listen: false).fetchTasksForHome(user.uid);
    });
    super.initState();
  }

  _deleteTask({required String taskId}) {
    context.read<HomeStateProvider>().deleteTaskOnHome(taskId);
  }

  _signOut() {
    context.read<AuthStateProvider>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<HomeStateProvider>();
    final tasks = taskProvider.tasks;
    final errorMessage = taskProvider.errorMessage;
    final user = authProvider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: (){
            _signOut;
            Navigator.of(context).pop;
          },
              icon: Icon(Icons.logout))
        ]
      ),
      body: errorMessage != null
          ? ErrorNotifier(
              message: errorMessage,
              onTap: () {
                taskProvider.clearError();
                taskProvider.fetchTasksForHome(user.uid);
              })
          : tasks.isEmpty
              ? const Center(
                  child: Text('No Tasks'),
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
