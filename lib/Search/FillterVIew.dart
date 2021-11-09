import 'package:flutter/material.dart';
import 'package:untitled3/Search/search_dege.dart';

class FillterView extends StatefulWidget {
  const FillterView({Key? key}) : super(key: key);

  @override
  _FillterViewState createState() => _FillterViewState();
}

class _FillterViewState extends State<FillterView> {
  double value=50;
  double min=0;
  double max=1000;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("FILTER", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text("RESET", style: TextStyle(fontSize: 10, color: Colors.white),),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: 20,),
                  Text("Urutkan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0,15,0,15),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 3,
                        children: [
                          filterChipWidget(chipName: 'Harga Terendah'),
                          filterChipWidget(chipName: 'Ratting Tertinggi'),
                          filterChipWidget(chipName: 'Paling Baru'),
                          filterChipWidget(chipName: 'Paling Lama'),
                          filterChipWidget(chipName: 'Paling Sesuai'),
                        ],
                      )
                  ),
                  Text("Jarak Lokasi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Jarak Maksimum",style: TextStyle(fontSize: 16),),
                        SizedBox(width: 15,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("${value.round().toString()} km", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${min.round().toString()} km", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text("${max.round().toString()} km", style: TextStyle(fontSize: 15, color: Colors.amber),),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.blue,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0)
                    ),
                    child: Slider(
                        value: this.value,
                        min:this.min, max: this.max ,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.amber.shade100,
                        divisions: 1000,
                        onChanged: (value) => setState(()=> this.value = value)
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)

                      ),
                      child: Align(
                          alignment:Alignment.center,
                          child: Text("Tampilkan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),
                  )
                ],
              ),
            )

          ],
        )
    );
  }
}
