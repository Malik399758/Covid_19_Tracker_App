import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String? image;
  final String? name;
  final int? totalCases;
  final int? totalDeaths;
  final int? totalRecovered;
  final int? active;
  final int? critical;
  final int? todayRecovered;
  final int? test;

  DetailScreen({
    this.image,
    this.name,
    this.totalCases,
    this.totalDeaths,
    this.totalRecovered,
    this.active,
    this.critical,
    this.todayRecovered,
    this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name ?? 'Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    margin: EdgeInsets.only(top: 60),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 50), // Space for the CircleAvatar
                          ReuseableRow(title: 'Total Cases', value: (widget.totalCases ?? 0).toString()),
                          ReuseableRow(title: 'Total Deaths', value: (widget.totalDeaths ?? 0).toString()),
                          ReuseableRow(title: 'Total Recovered', value: (widget.totalRecovered ?? 0).toString()),
                          ReuseableRow(title: 'Active', value: (widget.active ?? 0).toString()),
                          ReuseableRow(title: 'Critical', value: (widget.critical ?? 0).toString()),
                          ReuseableRow(title: 'Today Recovered', value: (widget.todayRecovered ?? 0).toString()),
                          ReuseableRow(title: 'Total Tests', value: (widget.test ?? 0).toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image ?? 'https://via.placeholder.com/150'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  ReuseableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value.isNotEmpty ? value : 'N/A'),
        ],
      ),
    );
  }
}
