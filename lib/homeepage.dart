import 'dart:async';

import 'package:expence_tracker/google_sheets_api.dart';
import 'package:expence_tracker/loadding_circle.dart';
import 'package:expence_tracker/plus_buttonn.dart';
import 'package:expence_tracker/top_card.dart';
import 'package:expence_tracker/transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;


   void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }



   void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text('NEW  TRANSACTION'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'For what?',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  MaterialButton(
                    color: Colors.grey[600],
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[600],
                    child: Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.only(top:30.0),
        child: Column(
          children: [
            TopNewCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                        GoogleSheetsApi.calculateExpense())
                    .toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
              expence: GoogleSheetsApi.calculateExpense().toString(),),
           
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
             
              child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  
                 Expanded(  child:GoogleSheetsApi.loading==true?LoadingCircle(): ListView.builder(
                  itemCount: GoogleSheetsApi.currentTransactions.length,
                  itemBuilder: (context,index){
                  return  MyTransssaction(
                   
                    transactionName: GoogleSheetsApi.currentTransactions[index][0],
                     money: GoogleSheetsApi.currentTransactions[index][1],
                    expenceOrIncome: GoogleSheetsApi.currentTransactions[index][2],
                    );
                   
                 }
                 ), 
                 
                 ),
                
                ],
              ),
              
              ),
            )),
           PlusButton(
            function: _newTransaction,
           )
          ],
        ),
      ),
    );
  }
} 