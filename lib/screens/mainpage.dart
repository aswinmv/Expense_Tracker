import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expenseitem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final expenseName = TextEditingController();
  final expenseAmount = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Expense"),
        content: SizedBox(
          height: 200,
          child: Form(
            key: formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                controller: expenseName,
                decoration: const InputDecoration(
                    hintText: "Expense Name", border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r"^[a-z]").hasMatch(value)) {
                    return 'Expense Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: expenseAmount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Prize", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return "Expense Amount";
                  }
                  return null;
                },
              ),
            ]),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              bool isValid = formkey.currentState!.validate();
              if (isValid) {
                save();
              } else {
                if (kDebugMode) {
                  print("error");
                }
              }
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              cancel();
            },
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }

  void save() {
    if (expenseName.text.isNotEmpty && expenseAmount.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
          name: expenseName.text,
          amount: expenseAmount.text,
          dateTime: DateTime.now());

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.of(context).pop();
      expenseName.clear();
      expenseAmount.clear();
      expenseAmount.clear();
    }
  }

  void cancel() {
    expenseName.clear();
    expenseAmount.clear();
    Navigator.of(context).pop();
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addNewExpense();
            },
            backgroundColor: Colors.black.withOpacity(.7),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          body: ListView(
            children: [
              // bar graph
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              const SizedBox(
                height: 20,
              ),
              // listview
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getallExpenselist().length,
                itemBuilder: (context, index) {
                  return ExpenseTile(
                    name: value.getallExpenselist()[index].name,
                    amount: value.getallExpenselist()[index].amount,
                    dateTime: value.getallExpenselist()[index].dateTime,
                    delete: (p0) =>
                        value.deleteExpense(value.getallExpenselist()[index]),
                  );
                },
              ),
            ],
          )),
    );
  }
}
