
import 'package:expense_tracker/models/expenseitem.dart';
import 'package:hive/hive.dart';

class HiveDataBase{
// reference
final _myBox = Hive.box("expense_database");


// write data
void saveData(List<ExpenseItem> allExpenses){
  List<List<dynamic>> allExpensesFormated = [];

for (var expense in allExpenses) 
{ 
  List<dynamic>allExpensesFormated = [
    expense.name,
    expense.amount,
    expense.dateTime,
  ];
  allExpensesFormated.add(allExpenses);
}
_myBox.put("ALL_EXPENSES", allExpensesFormated);

}
// read data
List<ExpenseItem> readData(){



  List savedExpenses = _myBox.get("ALL_EXPENSES")?? [];
  List<ExpenseItem> allExpenses = [];
  for (int i= 0; i < savedExpenses.length; i++){
    String name = savedExpenses[0][0];
    String amount = savedExpenses[0][1];
    DateTime dateTime = savedExpenses[0][2];

    ExpenseItem expense = ExpenseItem(name: name, 
    amount: amount, 
    dateTime: dateTime);

    allExpenses.add(expense);
  }
  return allExpenses;
}


}