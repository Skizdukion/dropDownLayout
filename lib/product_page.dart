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

class _SaleProductState extends State<SaleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: Colors.grey.shade300, // background
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Trên 1 triệu",
                        style: TextStyle(color: Colors.grey),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: Colors.grey.shade300, // background
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Trên 1 triệu",
                        style: TextStyle(color: Colors.grey),
                      )),
                  const MyDropdownButton(
                    label: "Flash Sale",
                    position: DropdownPosition.BELOW,
                  )
                ],
              )),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
          TextButton(onPressed: (){}, child: const Text('child')),
        ],
      ),
    );
  }
}
