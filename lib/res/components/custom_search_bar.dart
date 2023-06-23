import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({Key? key}) : super(key: key);

  // final controller = Get.put(searchController());

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(color: Colors.black38)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10 ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                autofocus: false,
                enableSuggestions: false,
                // controller: controller.textEditingController,
                style: const TextStyle(
                    fontSize: 15
                ),
                decoration: const InputDecoration(
                  hintText: "Search Here...",
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if(value.isNotEmpty){
                    print("---------------");
                    print(value);
                    // controller.getSearchResult(value.toString());
                  }

                },
              ),
            ),
            InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(query: controller.textEditingController.text)));
              },
              child:  const Icon(Icons.search),
            ),


          ],
        ),
      ),
    );
  }
}