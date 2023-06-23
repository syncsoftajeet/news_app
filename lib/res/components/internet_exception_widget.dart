import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternertExceptionWidget extends StatefulWidget {
  const InternertExceptionWidget({Key? key}) : super(key: key);

  @override
  State<InternertExceptionWidget> createState() => _InternertExceptionWidgetState();
}

class _InternertExceptionWidgetState extends State<InternertExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_connected_no_internet_4,size: 50,),
            SizedBox(
              height: 20,
            ),
            Text('internet'.tr,style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Retry",style: TextStyle(
                  fontSize: 15,color: Colors.white
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
