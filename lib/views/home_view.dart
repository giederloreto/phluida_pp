import 'package:flutter/material.dart';
import 'package:phluid_app/data/image_network.dart';
import 'package:phluid_app/models/image_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var getData = ImageNetwork();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: FutureBuilder<List<ImageModel>>(
          future: getData.getImages(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ImageModel>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          image: snapshot.data![index].downloadUrl!,
                        ),
                      ),
                      if (!snapshot.hasData) const CircularProgressIndicator(),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Sorry, Internet Error."),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
