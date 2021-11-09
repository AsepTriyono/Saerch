import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Model/search_model.dart';
import 'package:untitled3/Search%20Api/search_api.dart';
import 'package:untitled3/Search/FillterVIew.dart';
import 'package:untitled3/Search/detail_page.dart';

class SearchDege extends StatefulWidget {
  const SearchDege({Key? key}) : super(key: key);

  @override
  _SearchDegeState createState() => _SearchDegeState();
}

class _SearchDegeState extends State<SearchDege> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Search"),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          }, icon: Icon(Icons.search))
        ],
      ),
    );
  }
}
class DataSearch extends SearchDelegate<String>{

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(color: Colors.orange,fontSize: 14.0);


  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.amber,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
        textTheme: theme.textTheme,
      ),
        inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            // contentPadding: EdgeInsets,,
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),

            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: OutlineInputBorder(
              gapPadding: 0,

                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30)),
          ),
    );

  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [ IconButton(onPressed: (){
      query="";
    }, icon: Icon(Icons.clear))];

  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, '');
        }, icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder<List<NewDataSearch>>(
        future: SearchApi.getSearchData(searchName: query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/image/noResultSearch.png"),
                      SizedBox(height: 15,),
                      Text(
                        'Maaf, Jasa yang kamu cari\ntidak ditemukan. Buat Misi dan\ntemukan orang yang cocok.',
                        style: TextStyle(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.w600),textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                // print("data ada ${snapshot.data?.length}" );
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5,15,5,15),
                              child: Text("Hasil Pencarian Jasa", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            )),
                          Spacer(),

                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () => showModalBottomSheet(backgroundColor: Colors.transparent,
                                    context: context, builder: (context){
                                  return FillterView();
                                },isScrollControlled: true),
                                child: Row(
                                  children: [
                                    Text("Filter",),
                                    SizedBox(width: 5,),
                                    Icon(Icons.filter_alt_outlined),

                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                          Row(
                            children: [
                              Card(
                                color: Colors.amberAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(40,8,40,8),
                                  child: Text("Semua",style: TextStyle(fontSize: 18),),
                                ),
                              ),Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(40,8,40,8),
                                  child: Text("Desain & Program",style: TextStyle(fontSize: 18),),
                                ),
                              ),Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(40,8,40,8),
                                  child: Text("Elekronik",style: TextStyle(fontSize: 18),),
                                ),
                              ),
                            ]
                          ),
                      ),

                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPageView(data: snapshot.data![i].name.toString()),
                                    ),
                                  );},
                                child: Card(

                                  child: Container(
                                    height: MediaQuery.of(context).size.width*0.30,
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.asset("assets/image/sky.jpeg",width: 130, height: 130, fit: BoxFit.cover,),),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 15),
                                          width: MediaQuery.of(context).size.height*0.35,
                                          // color: Colors.amber,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Align(alignment:Alignment.topRight,
                                                  child: Text('11 km',style: TextStyle(fontSize: 12),)),
                                              Text('${snapshot.data?[i].name}',style: TextStyle(fontWeight: FontWeight.bold),),
                                              Row(
                                                children: [
                                                  Icon(Icons.account_circle_rounded,size: 15,),
                                                  SizedBox(width: 3,),
                                                  Text('${snapshot.data?[i].ownerServiceItem?.nama}',style: TextStyle(fontSize: 12),),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(

                                              ),
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Text("Nego",style: TextStyle(fontSize: 12)),
                                                      ),
                                                      Text('${snapshot.data?[i].price}',style: TextStyle(fontSize: 12),),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? SearchApi.suges
        : SearchApi.suges.where((p) => p.startsWith(query)).toList();
  return Container(
    width: double.infinity,

      child: FutureBuilder<List<NewDataSearch>>(
        future: SearchApi.getSearchData(searchName: query),
        builder: (context, snapshot) {

        if (query.isEmpty) return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              //search quey
            },
            title:Text(suggestionList[index])
          ),
          itemCount: suggestionList.length,
        );

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError || snapshot.data!.isEmpty) {
                print("has error");
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/noSuges.png"),
                    SizedBox(height: 15,),
                    Text(
                      'Jasa atau Misi telah dihapus. Silahkan\ncari Jasa atau Misi lainnya',
                      style: TextStyle(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.w600),textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else {
                return Text("OK");
              }
          }
        },
      ),

    );



  }

}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.black,fontSize: 15.0),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.amber,);
  }
}


