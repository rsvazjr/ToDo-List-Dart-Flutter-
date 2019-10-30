import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_list/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _priority = null;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Task _currentTask = Task();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _currentTask = Task.fromMap(widget.task.toMap());
    }

    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
    _priority = _currentTask.priority;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
  }

  Widget buildSaveButton(){
    return FlatButton(
        child: Text('Salvar'),
        onPressed: () {
          if(_formKey.currentState.validate()){
            setState(() {
              _currentTask.title = _titleController.value.text;
              _currentTask.description = _descriptionController.text;
              _currentTask.priority = _priority;
              Navigator.of(context).pop(_currentTask);
            });
          }
        },
      );
  }

  Widget buildCancelButton(){
    return FlatButton(
        child: Text('Cancelar'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
  }

  Widget buildtextField({TextEditingController controller, String labelText, String validatorMessage, bool autoFocus}){
      return 
       TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: controller,
              decoration: InputDecoration(labelText: labelText),
              autofocus: autoFocus,
              validator: (text) {
                return text.isEmpty ? validatorMessage : null;
              }
      ); 
  }
  
  Widget buildDropdown() {
  return DropdownButtonFormField<int>(
        hint: new Text("Escolha a Prioridade"),
        value: _priority,
        onChanged: (int newValue) {
          setState(() {
            _priority = newValue;
          });
        },
        validator: (int value){
          if(value == null){
            return "Selecione uma prioridade";
          }
          else if(value <= 0 || value >=5){
              return "A prioridade deve estar entre 0 e 5";
          }
        },
        items: _currentTask.getPriorities()
          .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          })
          .toList(),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.task == null ? 'Nova tarefa' : 'Edite a Tarefa'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildtextField(controller: _titleController, labelText: 'Título', validatorMessage: 'Insira o título', autoFocus: true),
                  buildtextField(controller: _descriptionController, labelText: 'Descrição', validatorMessage: 'Insira a descrição', autoFocus: true),
                  buildDropdown(),
                  buildCancelButton(),
                  buildSaveButton()
                ],
              ),
            ) 
          ],
        ),
      )
    );
  }
}
