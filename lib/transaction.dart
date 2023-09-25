import 'package:flutter/material.dart';

class MyTransssaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenceOrIncome;
  MyTransssaction({
     required this.transactionName,
    required this.expenceOrIncome,
    required this.money,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:12.0),
      child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.grey[100],
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,color: Colors.grey[500],
                                    
                                  ),
                                  child: Center(
                                    child: Icon(Icons.attach_money_outlined,color: Colors.white,),
                                  ),
    
                                ),
                                SizedBox(width: 6,),
                                Text(transactionName),
                              ],
                            ),
                            Text((expenceOrIncome == 'expense'?'-':'+') +' \$'+ money,style: TextStyle(
                              color: (expenceOrIncome=='expense'?Colors.red:Colors.green),)
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
    );
               
  }
}