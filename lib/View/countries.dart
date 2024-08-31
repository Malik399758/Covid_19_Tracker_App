import 'package:covid_19_app/Services/states_services.dart';
import 'package:covid_19_app/View/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search with country name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.fetchCountriesapi(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          String name = snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                               onTap : (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context){
                                   return DetailScreen(
                                     image: snapshot.data![index]['countryInfo']['flag'],
                                     name: snapshot.data![index]['countries'],
                                     totalCases: snapshot.data![index]['cases'],
                                     totalRecovered: snapshot.data![index]['recovered'],
                                     totalDeaths: snapshot.data![index]['deaths'],
                                     active: snapshot.data![index]['active'],
                                     test: snapshot.data![index]['test'],
                                     todayRecovered: snapshot.data![index]['todayRecovered'],
                                     critical: snapshot.data![index]['critical'],
                                   );
                                 }));
                            },
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']),
                                    subtitle:Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag'],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );

                          }else if(name.toLowerCase().contains(searchController.text.toString())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return DetailScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['countries'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['test'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'],
                                      );
                                    }));


                            },
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']),
                                    subtitle:Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag'],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );

                          }else{
                            return Container();
                          }
                        });
                  }else{
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder:(context,index){
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child:Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height:10,
                                    width:89,
                                    color:Colors.white,
                                  ),
                                  subtitle:Container(
                                    height:10,
                                    width:89,
                                    color:Colors.white,
                                  ),
                                  leading: Container(
                                    height:50,
                                    width:50,
                                    color:Colors.white,
                                  ),
                                )

                              ],
                            ),
                          );
                        }
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
