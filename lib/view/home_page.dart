import 'package:bai_tap_1/model/todo_model.dart';
import 'package:bai_tap_1/view_model/todo_viewmodel.dart';
import 'package:bai_tap_1/widgets/dialogs/dialog.dart';
import 'package:bai_tap_1/widgets/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoViewModel todoViewModel = TodoViewModel();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<ToDoModel> listData = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      ToDoModel toDoModel = ToDoModel("title ${i + 1}", "description ${i + 1}");
      listData.add(toDoModel);
    }
    todoViewModel.addData(listData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("ListView"),
          centerTitle: true,
        ),
        body: StreamBuilder<List<ToDoModel>>(
            stream: todoViewModel.listTodoStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<ToDoModel> list = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 70),
                itemExtent: 100,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        titleController.text = listData[index].title;
                        descriptionController.text =
                            listData[index].description;
                        showAddOrUpdateDialog(
                          context,
                          'Update Data',
                          titleController,
                          descriptionController,
                          () {
                            listData.removeAt(index);
                            String title = titleController.text;
                            String description = descriptionController.text;
                            listData.insert(
                                index, ToDoModel(title, description));
                            todoViewModel.addData(listData);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Chỉnh sửa thành công'),
                              ),
                            );
                            titleController.text = '';
                            descriptionController.text = '';
                          },
                        );
                      },
                      title: Text(
                        listData[index].title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        listData[index].description,
                        style: const TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ),
                      trailing: IconButton(
                        onPressed: () => showDeleteDialog(context, () {
                          ToDoModel toDoModelOld = listData[index];
                          listData.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Text('You deleted title ${index + 1}'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  debugPrint('click undo');
                                  listData.insert(index, toDoModelOld);
                                  todoViewModel.addData(listData);
                                },
                              ),
                            ),
                          );
                          todoViewModel.addData(listData);
                          debugPrint('delete title ${index + 1}');
                        }),
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add data",
          onPressed: () => showAddOrUpdateDialog(
            context,
            'Add Data',
            titleController,
            descriptionController,
            () {
              String title = titleController.text;
              String description = descriptionController.text;
              listData.insert(listData.length, ToDoModel(title, description));
              todoViewModel.addData(listData);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thêm thành công'),
                ),
              );
              titleController.text = '';
              descriptionController.text = '';
            },
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
