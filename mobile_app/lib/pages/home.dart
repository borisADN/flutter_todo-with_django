import 'package:flutter/material.dart';
import 'package:mobile_app/models/task.dart';
import 'package:mobile_app/providers/task.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    TextEditingController controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      final task = TaskModel(
                        task: controller.text,
                         done: false,
                         createdAt: DateTime.now().toString(),
                         );
                      taskProvider.addTask(task);
                      // _controller.clear();
                    },
                  )),
            ),
          ),
          const Divider(),
          Expanded(
            child: Consumer<TaskProvider>(builder: (context, provider, child) {
              if (provider.tasks.isEmpty) {
                return Center(child: CircularProgressIndicator.adaptive());
                // return Center(child: Text('No tasks found'));
              } else {
                return ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return ListTile(
                      onLongPress: () {
                        provider.deleteTask(task);
                      },
                      title: Text(task.task),
                      trailing: Checkbox(
                        value: task.done,
                        onChanged: (value) {
                          task.done = !task.done;
                          provider.updateTask(task);
                        },
                      ),
                    );
                  },
                );
              }
            }),
          )
        ]));
  }
}
