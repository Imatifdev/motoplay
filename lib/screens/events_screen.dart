import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Events Screen",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              const Chip(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  label: Text("NO OLVIDES QUE PUEDES AJUSTAR LA CALIDAD")),
              SizedBox(
                height: 1000,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          child: // Padding(
                              //padding: const EdgeInsets.all(20.0),
                              //child:
                              Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/event-logo.png"),
                              const Text(
                                "D4ZN",
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                              ),
                              const Text(
                                "Disponible solo en Europa",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
