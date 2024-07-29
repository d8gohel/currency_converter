import 'package:currency_converter/components/any_to_any.dart';
import 'package:currency_converter/components/usd_to_any.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../functions/fetch_rates.dart';
import '../models/rates_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // initail Variables
  Future<RatesModel>? results;
  Future<Map>? allCurrencies;
  final formkey = GlobalKey<FormState>();

  // Gettings RatesModels And all currencies

  @override
  void initState() {

      results =  fetchRates();
      allCurrencies = fetchCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      appBar: AppBar(
        title: Text('Currency Converter',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 2),).animate().move(begin: Offset(-400, 0),duration: 600.ms),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: FutureBuilder<RatesModel>(
            future: results,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return SizedBox(
                  height: MediaQuery.of(context).size.height *.5,
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
              return Center(
                child: FutureBuilder<Map>(
                  future: allCurrencies,
                  builder: (context, currSnapshot) {
                    if(!currSnapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }return Column(
                      children: [

                        SizedBox(height: 20,),

                        UsdToAny(
                            rates: snapshot.data?.rates,
                            currencies: currSnapshot.data).animate().move(duration: 600.ms,begin: Offset(-400, 0)),

                        SizedBox(height: 20,),

                        AnyToAny(
                            rates: snapshot.data?.rates,
                            curruncies: currSnapshot.data!).animate().move(duration: 600.ms,begin: Offset(-400, 0)),

                        SizedBox(height: 20,),

                        Lottie.asset('images/curruncy.json',height: 150)
                      ],
                    );
                  },
                ),
              );
            },
          ),

        ),
      ),
    );
  }
}
