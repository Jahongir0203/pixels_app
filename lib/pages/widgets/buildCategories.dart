import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixels_app/pages/search_page.dart';

import '../../service/category_service.dart';

Padding buildCategories() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) {
                    return SearchPage(query: categories[index].text);
                  },
                ));
              },
              child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(categories[index].imgUrl),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${categories[index].text}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      ),
    ),
  );
}
