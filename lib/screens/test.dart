import 'package:flutter/material.dart';

class FoundCourses extends StatefulWidget {
  @override
  _FoundCoursesState createState() => _FoundCoursesState();
}

class _FoundCoursesState extends State<FoundCourses> {
  // bool _applied = false;
  List<int> selectedIndexList = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:GridView.builder(
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // What do i do here?
                  if (!selectedIndexList.contains(index)) {
                    selectedIndexList.add(index);
                  } else {
                    selectedIndexList.remove(index);
                  }
                  setState(() {

                  });
                },
                child: Container(
                  height: 350,
                  width: 170,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 15.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 10.0, left: 30.0, bottom: 3.0),
                        child: Text(
                          "$index",
                          style: TextStyle(
                              color: Color(0xff00315C),
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Instructor \nMahfuz A.",
                          style: TextStyle(
                            color: Color(0xff00315C),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
 ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            if (!selectedIndexList.contains(index)) {
                              selectedIndexList.add(index);
                            } else {
                              selectedIndexList.remove(index);
                            }
                            setState(() {

                            });
                          }, //or what do i here},
                          color: selectedIndexList.contains(index) ? Colors.green : Color(0xff940D5A),
                          padding: EdgeInsets.symmetric(horizontal: 65.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(17))),
                          child: selectedIndexList.contains(index) ? Icon(Icons.check, color: Colors.white, size: 35.0,) : Text(
                            "Apply",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    )
    );
  }
}