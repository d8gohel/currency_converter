import 'package:currency_converter/functions/fetch_rates.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map curruncies;
  const AnyToAny({Key? key, required this.rates, required this.curruncies}) : super(key: key);

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {

  TextEditingController amountController = TextEditingController();
  String answer = 'Converted Currency will be Shown here :)';
  String  dropdownValue1 = 'USD';
  String dropdownValue2 = 'PKR';

  @override
  Widget build(BuildContext context) {
    
    var w = MediaQuery.of(context).size.width;
   
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text('Convert Any Currency',
              style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 20),),

            SizedBox(height: 20,),

            TextFormField(
              controller: amountController,
              key: const ValueKey('amount'),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter amount',
              ),
            ),

            const SizedBox(height: 10,),

            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue1,
                      icon: Icon(Icons.arrow_drop_down,),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,color: Colors.grey,

                      ),

                      onChanged: (String? newValue){
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                      },
                      items: widget.curruncies.keys.toSet().toList().map<DropdownMenuItem<String>>((value)  {
                          return DropdownMenuItem(
                            value: value,
                              child: Text(value));
                        }).toList(),

                    )
                ) ,
                Container(
                  padding: EdgeInsets.all(20),
                  child: const Text('To'),
                ),

                Expanded(child: DropdownButton<String>(
                  value: dropdownValue2,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 2,color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: widget.curruncies.keys.toList().toList().map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value));
                  }).toList(),
                )
                )
              ],
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer = amountController.text +
                        ' ' +
                        dropdownValue1 +
                        ' = ' +
                        convertAny(widget.rates, amountController.text,
                        dropdownValue1, dropdownValue2) +
                        ' ' + dropdownValue2;
                  });
                },
                child: Text('Convert',style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
              )
            ),
            SizedBox(height: 10,),

            Container(child: Text(answer)),
          ],
        ),

      ),
    );
  }
}
