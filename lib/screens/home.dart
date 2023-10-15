import 'package:flutter/material.dart';
import 'package:flutter_task_managment_app/utils/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tmBGColor,
      appBar: _buildAppBar(),
      body: Container(
        child: Text("This is the home screen"),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tmBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tmBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/logo.png",
                ),
              ),
            )
          ],
        ));
  }
}
