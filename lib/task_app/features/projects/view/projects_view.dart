import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/task_app/features/authentication/view/sign_in.dart';

import '../../../utils/error_notifier.dart';
import '../../authentication/controller/service/auth_service.dart';
import '../../authentication/controller/state/auth_state_provider.dart';
import '../controller/state/projects_state_provider.dart';

class ProjectsView extends StatefulWidget {
  static const path = '/projects';
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
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
    context.go(SignInView.path);
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = context.watch<ProjectsStateProvider>();
    final projects = projectProvider.projects;
    final errorMessage = projectProvider.errorMessage;
    final user = authProvider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
          title: const Text('Projects'),
          actions: [IconButton(onPressed: _signOut, icon: Icon(Icons.logout))]),
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
