import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) => Card(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              "https://cdn.pixabay.com/photo/2022/03/01/02/51/galaxy-7040416__340.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Moon is the only one who will stay with you tonight!!"),
                        )
                      ],
                    )),
              )),
    );
  }
}
