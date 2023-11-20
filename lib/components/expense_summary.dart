import 'package:expense_tracker/bargraph/bargraph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/datetimehelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});
 
 double calculateMax(
  ExpenseData value,
  String sunday,
  String monday,
  String tuesday,
  String wednesday,
  String thursday,
  String friday,
  String saturday
){
  double? max = 500;
  List<double> values = [
    value.calculateDailyExpenseSummary()[sunday]?? 0,
     value.calculateDailyExpenseSummary()[monday]?? 0,
    value.calculateDailyExpenseSummary()[tuesday]?? 0,
    value.calculateDailyExpenseSummary()[wednesday]?? 0,
     value.calculateDailyExpenseSummary()[thursday]?? 0,
     value.calculateDailyExpenseSummary()[friday]?? 0,
     value.calculateDailyExpenseSummary()[saturday]?? 0,
  ];
  values.sort();

  max = values.last * 1.1;
  return max ==0 ? 500: max;
}

// week total
String calculateWeekTotal(
   ExpenseData value,
  String sunday,
  String monday,
  String tuesday,
  String wednesday,
  String thursday,
  String friday,
  String saturday
){
  List<double> values = [
    value.calculateDailyExpenseSummary()[sunday]?? 0,
     value.calculateDailyExpenseSummary()[monday]?? 0,
    value.calculateDailyExpenseSummary()[tuesday]?? 0,
    value.calculateDailyExpenseSummary()[wednesday]?? 0,
     value.calculateDailyExpenseSummary()[thursday]?? 0,
     value.calculateDailyExpenseSummary()[friday]?? 0,
     value.calculateDailyExpenseSummary()[saturday]?? 0,
  ];
  double total = 0;
  for (int i = 0; i<values.length; i++){
  total +=  values[i];
  }
  return total.toStringAsFixed(2);

}


  @override
  Widget build(BuildContext context) {
     
     String sunday = convertDateTime(startOfWeek.add(const Duration(days: 0)));
     String monday = convertDateTime(startOfWeek.add(const Duration(days: 1)));
     String tuesday = convertDateTime(startOfWeek.add(const Duration(days: 2)));
     String wednesday = convertDateTime(startOfWeek.add(const Duration(days: 3)));
     String thursday = convertDateTime(startOfWeek.add(const Duration(days: 4)));
     String friday = convertDateTime(startOfWeek.add(const Duration(days: 5)));
     String saturday = convertDateTime(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(builder: (context, value, child) => 
     Column(
       children: [
          Padding(
           padding: const  EdgeInsets.only(left: 30,top: 10,bottom: 10),
           child: Row(children: [
             Text("Week Total :",style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500)),
            Text("₹${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}",
            style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500))
           ],),
         ),

         SizedBox(height: 200,
    child: MyBarGraph(maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
    sunAmount: value.calculateDailyExpenseSummary() [sunday] ?? 0, 
    monAmount: value.calculateDailyExpenseSummary() [monday] ?? 0, 
    tueAmount: value.calculateDailyExpenseSummary() [tuesday] ?? 0, 
    wedAmount: value.calculateDailyExpenseSummary() [wednesday] ?? 0, 
    thuAmount: value.calculateDailyExpenseSummary() [thursday] ?? 0, 
    friAmount: value.calculateDailyExpenseSummary() [friday] ?? 0, 
    satAmount: value.calculateDailyExpenseSummary() [saturday] ?? 0),),
       ],
     )
    ,);
  }
}