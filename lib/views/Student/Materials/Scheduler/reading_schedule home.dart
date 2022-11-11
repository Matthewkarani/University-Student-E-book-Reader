
import 'package:flutter/material.dart';

import '../../../../api/notification _api.dart';
import '../../../../widgets/widgets.dart';
import 'createReadingSchedule.dart';


class PlantStatsPage extends StatelessWidget {
  const PlantStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>
              CreateReadingSchedule())
        ); },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Plant Stats',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 45,
              ),
              SizedBox(
                  height:10 ,
                  child: PlantImage()),
              SizedBox(
                height: 25,
              ),
              HomePageButtons(
                onPressedOne: () async {
                  createPlantFoodNotification();
                },
                onPressedTwo: () async {},
                onPressedThree: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
