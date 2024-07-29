import 'package:currency_converter/functions/fetch_rates.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final currencies;

  const UsdToAny({Key? key, required this.rates, required this.currencies}) : super(key: key);

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {

  TextEditingController usdController = TextEditingController();
  String dropDownValue = 'PKR';
  String answer = 'Converted Currency Will Be Shown Here :)';

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Card(

      child: Container(
        padding: EdgeInsets.all(20),

        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text('Usd To Any Currency',
              style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 20),),

            SizedBox(height: size.height * .02,),

            TextFormField(
              key: ValueKey('usd'),
              controller: usdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter amount of USD'),
            ),

            SizedBox(height: size.height * .02,),

            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                      value: dropDownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                      items: widget.currencies.keys.toSet().toList().map<DropdownMenuItem<String>>((value){
                        return DropdownMenuItem<String>(
                          value: value,
                            child: Text(value));
                          }).toList(),
                    )
                ),
                SizedBox(width: 10,),

                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer = usdController.text + 'USD = '+ convertUsd(widget.rates, usdController.text, dropDownValue);

                      });
                      },
                    child: Text('Convert',style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
            SizedBox(height: 10,),

            Container(child: Text(answer),)

          ],
        ),
      ),
    );
  }
}
