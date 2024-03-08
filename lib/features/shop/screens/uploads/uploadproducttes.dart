import 'package:flutter/material.dart';

class UploadProductsTest extends StatelessWidget {
  const UploadProductsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Products Upload"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 250,),
            Text("This feature as been disabled due to test mode. Kindly contact Alabi Olayinka Roqeeb on Whatsapp or Phone Call via +2348143036359 or send a mail to olayinkaalabi191@gmail.com for further infromation.", style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}