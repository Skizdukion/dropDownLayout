import 'package:ecomerce_test/widget/overlay_container.dart';
import 'package:flutter/material.dart';

enum DropdownPosition {
  BELOW,
  RIGHT,
}

class MyDropdownButton extends StatefulWidget {
  final String label;
  final DropdownPosition position;

  const MyDropdownButton({
    Key? key,
    required this.label,
    this.position = DropdownPosition.BELOW,
  }) : super(key: key);

  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton>{
  bool _dropdownShown = false;
  List<bool> isSelected = [false, false, false];
  List<String> listOptions = ["Dưới 1 triệu", "Dưới 5 triệu", "Trên 10 triệu"];

  void _toggleDropdown() {
    setState(() {
      _dropdownShown = !_dropdownShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            primary: Colors.white, // background
          ),
          onPressed: _toggleDropdown,
          child: Row(
            children: <Widget>[
              Text(widget.label, style: const TextStyle(color: Colors.blue)),
              Icon(
                _dropdownShown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.blue,
              )
            ],
          ),
        ),
        OverlayContainer(
          duraion: const Duration(milliseconds: 300),
          materialColor: Colors.white,
          show: _dropdownShown,
          position: widget.position == DropdownPosition.RIGHT
              ? const OverlayContainerPosition(
                  150,
                  45,
                )
              : const OverlayContainerPosition(
                  0,
                  0,
                ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 120,
                  child: GridView.builder(
                    itemCount: listOptions.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          //set the toggle logic
                          setState(() {
                            for (int indexBtn = 0;
                                indexBtn < isSelected.length;
                                indexBtn++) {
                              if (indexBtn == index) {
                                isSelected[indexBtn] = true;
                              } else {
                                isSelected[indexBtn] = false;
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected[index]
                                ? Colors.white
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: isSelected[index]
                                    ? Colors.blue
                                    : Colors.transparent),
                          ),
                          child: Center(
                            child: Text(
                              listOptions[index],
                              style: TextStyle(
                                  color: isSelected[index]
                                      ? Colors.blue
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: _toggleDropdown,
                      child: Text("OK"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: Colors.blue,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
