import 'dart:core';

import 'package:ecomerce_test/widget/animated_dropdown.dart';
import 'package:ecomerce_test/widget/custom_dropdown_btn.dart';
import 'package:ecomerce_test/widget/dropdown_button.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
                decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ), // icon is 48px widget.
            )),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
          bottom: const TabBar(
              indicatorWeight: 10,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.blue, width: 3),
                insets: EdgeInsets.symmetric(horizontal: 20),
              ),
              tabs: [
                Text(
                  "A",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  "B",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  "C",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ]),
        ),
        body: TabBarView(
          children: [const SaleProduct(), Container(), Container()],
        ),
      ),
    );
  }
}

class SaleProduct extends StatefulWidget {
  const SaleProduct({Key? key}) : super(key: key);

  @override
  State<SaleProduct> createState() => _SaleProductState();
}

class Model{
  Model({required this.text, this.isSelected = false});
  String text;
  bool isSelected;
}  

class _SaleProductState extends State<SaleProduct> {

  bool dropDown = false;
  List<Model> list = [
    Model(text: 'tren 1 trieu'),
    Model(text: 'tren 2 trieu'),
    Model(text: 'tren 3 trieu'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white, border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomDropDownBtn(text: 'text', onPress: onDropDown),
                    CustomDropDownBtn(text: 'text', onPress: onDropDown),
                    CustomDropDownBtn(text: 'text', onPress: onDropDown),
                  ],
                )),
            ),
            const Positioned(
              child: Text("Center Text", style: TextStyle(color: Colors.black),),
              top: 100,
              left: 200,
            ),
            const Positioned(
              child: Text("Center Text", style: TextStyle(color: Colors.black),),
              top: 130,
              left: 200,
            ),
            const Positioned(
              child: Text("Center Text", style: TextStyle(color: Colors.black),),
              top: 150,
              left: 200,
            ),
            const Positioned(
              child: Text("Center Text", style: TextStyle(color: Colors.black),),
              top: 200,
              left: 200,
            ),
            const Positioned(
              child: Text("Center Text", style: TextStyle(color: Colors.black),),
              top: 300,
              left: 200,
            ),
            Positioned(
              top: 70,
              child: AnimatedDropdown(
                display: dropDown,
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                list[index].isSelected = !list[index].isSelected;
                              });                                
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: list[index].isSelected
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: list[index].isSelected
                                        ? Colors.blue
                                        : Colors.transparent),
                              ),
                              child: Center(child: Text(list[index].text),),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            dropDown = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text('OK'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: InkWell(
                    onTap: (){
                      onDropDown(false);
                    },
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onDropDown(bool isDropDown){
    setState(() {
      dropDown = isDropDown;
    });
  }
}
