// import 'package:flutter/material.dart';
// import 'package:world_news/helper/news.dart';
// import 'package:world_news/models/list_item.dart';

// class CountrySelect extends StatefulWidget {
//   @override
//   _CountrySelectState createState() => _CountrySelectState();
// }

// class _CountrySelectState extends State<CountrySelect> {
//   News news=new News();
//   NewsForCategorie catnews = NewsForCategorie();

//   List<ListItem> _dropdownItems = [
//     ListItem("in", "India"),
//     ListItem("ae", "USA"),
//     ListItem("ar", "Argentina"),
//     ListItem("at", "Austria"),
//     ListItem("be", "Belgium"),
//     ListItem("ca", "canada"),
//     ListItem("co", "columbia"),
//     ListItem("za", "South Africa"),
//     ListItem("nz", "New zealand")
//   ];

//   List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
//   ListItem _selectedItem;

//   void initState() {
//     super.initState();
//     _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
//     _selectedItem = _dropdownMenuItems[0].value;
//     news.countryName=_selectedItem.value.toString();
//     catnews.country=_selectedItem.value.toString();

//   }

//   List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
//     List<DropdownMenuItem<ListItem>> items = List();
//     for (ListItem listItem in listItems) {
//       items.add(
//         DropdownMenuItem(
//           child: Text(listItem.name),
//           value: listItem,
//         ),
//       );
//     }
//     return items;
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Dropdown Button"),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.cyan,
//               border: Border.all()),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//                 value: _selectedItem,
//                 items: _dropdownMenuItems,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedItem = value;
//                     // print(_selectedItem.value);
//                     String countryname(){
//                        return _selectedItem.value;
//                     }
//                     news.countryName=_selectedItem.value.toString();
//                     // print(countryname());
//                     catnews.country=_selectedItem.value.toString();
                   
//                   });
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
// }