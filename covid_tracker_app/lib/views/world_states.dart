import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Models/world_states_model.dart';
import '../Services/WorldServices.dart';
import 'Countries.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with  TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(
    duration:const Duration(seconds: 3),
    vsync: this)..repeat();
@override
  void dispose(){
  super.dispose();
  _controller.dispose();
}
final colorlist=<Color>[

const Color(0xff4285f4),
const Color(0xff1aa268),
const Color(0xffde5246),

];

WorldServices worldServices= WorldServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height*.01),
            FutureBuilder(
              future: worldServices.getWorld(),
              builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
              if(!snapshot.hasData){
              return Expanded(
                flex: 1,
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  controller: _controller,
                  size: 50,),
                  );
              }
              else{
                return Column(
                  children: [
                  PieChart(
                    dataMap:  {
              "Total":double.parse(snapshot.data!.cases.toString()),
             "Recovered":double.parse(snapshot.data!.recovered.toString()),
             "Deaths":double.parse(snapshot.data!.deaths.toString()) },
             chartType: ChartType.ring,
             chartRadius: MediaQuery.of(context).size.width/3.2,
             animationDuration:const Duration(milliseconds: 1200),
             colorList: colorlist,
            legendOptions:const LegendOptions(legendPosition: LegendPosition.left),
             chartValuesOptions:const ChartValuesOptions(showChartValuesInPercentage: true),
             ),
             Padding(
               padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
               child: Card(
                child: Column(
                children: [
                Reusable(title: "Total", value:snapshot.data!.cases.toString()),
                Reusable(title: "Deaths", value:snapshot.data!.deaths.toString()),
                Reusable(title: "Recovered", value:snapshot.data!.recovered.toString() ),
                Reusable(title: "Active", value:snapshot.data!.active.toString() ),
                Reusable(title: "Critical", value:snapshot.data!.critical.toString() ),
                Reusable(title: "Today Deaths ", value:snapshot.data!.todayDeaths.toString() ),
                 Reusable(title: "Today Recovered", value:snapshot.data!.todayRecovered.toString() ),
             
               ],),),
             )
          ,
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>const CountriesScreen()));
            },
            child: Container(height: 50,
                width: 200,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color:const Color(0xff1aa260),),
            child:const Center(child: Text('Track Countries')),
                
            ),
          )

                ],);
              }
            },),
            
          ],),
        ),
      ),
    );
  }

}
class Reusable extends StatelessWidget {
   Reusable({super.key,required this.title,required this.value});
 String title,value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(title),
              Text(value),
             
          ],),
         const SizedBox(height: 5,),
           const Divider()
        ],
      ),
    );
    
    
  
  }
}