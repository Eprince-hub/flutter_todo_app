import 'package:flutter/material.dart';
import 'package:flutter_todo_app/util/my_text.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 22,
        right: 22,
        top: 20,
      ),
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: taskCompleted ? Colors.teal[800] : Colors.teal[400],
        backgroundBlendMode: taskCompleted ? BlendMode.overlay : BlendMode.src,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // checkbox
          Checkbox(
            value: taskCompleted,
            onChanged: onChanged,
            activeColor: Colors.deepPurple,
          ),

          // task name
          MyText(
            overflow: TextOverflow.ellipsis,
            text: taskName,
            color: Colors.black,
            fontSize: 18,
            taskCompleted: taskCompleted,
          ),

          // Keep the delete button at the end
          const Expanded(child: SizedBox()),

          // delete button
          IconButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(0),
              ),
            ),
            onPressed: () {
              if (!taskCompleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: MyText(
                        text: 'Please complete the task before deleting it.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              deleteFunction!(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}