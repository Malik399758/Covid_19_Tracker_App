import 'package:covid_19_app/Services/states_services.dart';
import 'package:covid_19_app/View/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                FutureBuilder(
                  future: statesServices.fetchWorldStateapi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            child: PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                          ),
                          SizedBox(height: 15),
                          Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: Text('No data available'),
                        ),
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CountriesScreen();

                    }));

                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff1aa240),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Track Countries'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
