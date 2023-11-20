import 'package:expense_tracker/screens/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey[300],
      body: Column(children: [
      
        SizedBox(
          height: 350,
          width: double.infinity,         
         
          child: Center(child: Lottie.asset("assets/lot.json")),),
           Text("Your Budget",style: GoogleFonts.poppins(fontSize: 40,fontWeight: FontWeight.w500),),
           Text("Companion",style: GoogleFonts.poppins(fontSize: 35,fontWeight: FontWeight.w500),),
          const SizedBox(height: 30,),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width*.8,
            child: Text(
              textAlign: TextAlign.center,
              
              "Track Your Daily Expense and achieve financial goals with ease",
              maxLines: 2,overflow: TextOverflow.clip,
              style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400),
              )),
              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainPage(),));
                },
                child: Container(height: 70,
                width: MediaQuery.of(context).size.width*.7,
                
                decoration: BoxDecoration(
                 color: Colors.grey[900],
                borderRadius: BorderRadius.circular(18)
                ),
                child: Center(child: Text("Track  iT",style:
                 GoogleFonts.poppins(fontSize: 35,fontWeight: FontWeight.w500,color: Colors.white),)),
                ),
              )
      ]),
    );
  }
}