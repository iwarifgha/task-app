import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/error_notifier.dart';
import '../../authentication/controller/service/auth_service.dart';
import '../../authentication/controller/state/auth_state_provider.dart';
import '../controller/state/projects_state_provider.dart';
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
      Provider.of<ProjectsStateProvider>(context, listen: false)
          .fetchProjects(user.uid);
    });
    super.initState();
  }

  _deleteTask({required String taskId}) {
    context.read<ProjectsStateProvider>().deleteProject(taskId);
  }

  _signOut() {
    context.read<AuthStateProvider>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = context.watch<ProjectsStateProvider>();
    final projects = projectProvider.projects;
    final errorMessage = projectProvider.errorMessage;
    final user = authProvider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [
        IconButton(
            onPressed: () {
              _signOut;
              Navigator.of(context).pop;
            },
            icon: Icon(Icons.logout))
      ]),
      body: errorMessage != null
          ? ErrorNotifier(
              message: errorMessage,
              onTap: () {
                projectProvider.clearError();
                projectProvider.fetchProjects(user.uid);
              })
          : projects.isEmpty
              ? const Center(
                  child: Text('No Tasks'),
                )
              : ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return ListTile(
                      title: Text(project.title),
                      subtitle: Text(project.goal),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  projectProvider.clearError();
                                  _deleteTask(
                                    taskId: project.projectId,
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
