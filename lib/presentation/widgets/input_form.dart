import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_text_button.dart';

class InputForm extends StatefulWidget {
  final Function addTx;

  InputForm(this.addTx);

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _pickedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);
    final enteredDate = _pickedDate;

    if (enteredTitle.isEmpty || enteredAmount! <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      enteredDate ?? DateTime.now(),
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  contentPadding: EdgeInsets.only(left: 8),
                  // focusColor: Colors.indigo,
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  contentPadding: EdgeInsets.only(left: 8),
                  // focusColor: Colors.lime,
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      _pickedDate == null
                          ? 'No date chosen!'
                          : DateFormat.yMd().format(_pickedDate!),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Spacer(),
                  AdaptiveTextButton(
                      title: 'Choose data', handler: _presentDatePicker),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    'Add transaction',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  onPressed: _submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
