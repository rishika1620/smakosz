import 'package:flutter/material.dart';
import 'package:smakosz/Screens/sign_up.dart';
import 'package:smakosz/Widgets/content_model.dart';
import 'package:smakosz/Widgets/widget_support.dart';
class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: contents.length,
                controller: _pageController,
                onPageChanged: (int index){
                  setState(() {
                    currentIndex = index;
                  });
                }, 
                itemBuilder: (_,i){
                  return Container(
                    margin: EdgeInsets.only(top:  150),
                    child: Padding(padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Image.asset(contents[i].image, height: 300, width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.fill,),
                          SizedBox(height: 40,),
                          Text(contents[i].title, style: AppWidget.semiBoldTextFieldStyle(),),
                          SizedBox(height: 20,),
                          Text(contents[i].description, style: AppWidget.lightTextFieldStyle() ,)
                        ],
                      ),
                    ),
                  );
            }),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(contents.length, (index) =>
                  buildDot(index, context),
                ),
            ),
          ),

          GestureDetector(
            onTap: (){
              if(currentIndex == contents.length-1){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
              }
              
              _pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 60,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child:Center(child: Text(

                  currentIndex == contents.length-1?"start":"Next", style: AppWidget.semiBoldTextFieldStyle())),
              
            ),
          ),
        ],
      ),
    );
  }


  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10,
      width: currentIndex == index?18:7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.black38,
      ),
    );
  }
}
