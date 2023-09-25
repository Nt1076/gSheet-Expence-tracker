import 'package:flutter/material.dart';

class TopNewCard extends StatelessWidget {
final String balance,income,expence;
TopNewCard({required this.balance,required this.expence,required this.income});

  @override
  Widget build(BuildContext context) {
    return Padding
    (
      padding: EdgeInsets.all(8),
      child: Container(
        height: 200,
       // color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Text('B A L A N C E',style: TextStyle(color: Colors.grey[500],fontSize: 16),),
              ),
              Text("\$"+balance,style: TextStyle(color: Colors.grey[800],fontSize: 40),),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.arrow_upward,color: Colors.green,)),
                          SizedBox(width: 6,),
                        Column(
                          children: [
                            Text('Income'),
                           Text('\$'+income,style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)
                          ],
                        ),
                        
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:14),
                      child: Row( 
                        children: [
                          Container(
                             height: 40,
                          width: 40,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                            child: Icon(Icons.arrow_downward,color: Colors.red,)),

                            SizedBox(width: 8,),
                          Column(
                            children: [
                              Text('Expence'),
                               Text('\$'+expence,style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)
                            ],
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
          boxShadow: [BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1
          ),
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1
          )
          ]
        ),
      ),
      );
  }
}