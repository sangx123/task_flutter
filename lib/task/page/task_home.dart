
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TaskHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TaskHomeStatePage();
  }

}

class TaskHomeStatePage extends State<TaskHomePage> with AutomaticKeepAliveClientMixin<TaskHomePage>, SingleTickerProviderStateMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context,int index){
        return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
      },
      itemCount: 3,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
    );
  }

}