import 'package:expense_tracker/data/hive_data.dart';
import 'package:expense_tracker/datetime/datetimehelper.dart';
import 'package:expense_tracker/models/expenseitem.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{

// list of all expense
List<ExpenseItem> overallExpenseList = [];
// get all expense
List<ExpenseItem> getallExpenselist(){
  return overallExpenseList;
}
// prepare
final db = HiveDataBase();
void prepareData(){
if(db.readData().isNotEmpty){
  overallExpenseList = db.readData();
}
}



// add new expese
void addNewExpense(ExpenseItem newExpense){
overallExpenseList.add(newExpense);
notifyListeners();
db.saveData(overallExpenseList);
}
// delete expense
void deleteExpense(ExpenseItem expense){
overallExpenseList.remove(expense);
notifyListeners();
db.saveData(overallExpenseList);
}
// get week, day
String getDayName(DateTime daateTime ){
  switch (daateTime.weekday){
  case 1:
  return 'Mon';
  case 2:
  return 'Tue';
  case 3:
  return 'Wed';
  case 4:
  return 'Thu';
  case 5:
  return 'Fri';
  case 6:
  return 'Sat';
  case 7:
  return 'Sun';
  
  default: 
  return '';
  }
}
// get the date
DateTime startOfWeekDate(){
  DateTime? startOfWeek;

  DateTime today = DateTime.now();

  for (int i= 0; i<7; i++){
    if(getDayName(today.subtract(Duration(days: i))) == 'Sun')
    {startOfWeek =today.subtract(Duration(days: i));}
  }
  return startOfWeek!;
}

// convert the expense into summary

// overall expense list



Map<String,double> calculateDailyExpenseSummary()
 {
  Map<String,double> dailyExpenseSummary = {};
 
  for (var expense in overallExpenseList){
    String date = convertDateTime(expense.dateTime);
    double amount = double.parse(expense.amount);
if(dailyExpenseSummary.containsKey(date))
  { double currentamount = dailyExpenseSummary[date]!;
  currentamount += amount;
  dailyExpenseSummary[date] = currentamount;
  } else {dailyExpenseSummary.addAll({date: amount});}

  }return dailyExpenseSummary;
  

 }

}