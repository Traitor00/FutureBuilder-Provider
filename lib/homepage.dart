import 'package:bbuilder/Api/dataprovider.dart';
import 'package:bbuilder/Modal/modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Vanila Test'),
      ),
      body: Column(
        children: [
          FutureBuilder<DataModel>(
            future: dataProvider.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Display a loading indicator when our data is loading
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); //will return error to screen
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        data.name,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.country.length,
                      itemBuilder: (context, index) {
                        final country = data.country[index];
                        return ListTile(
                          title: Text(country.countryId),
                          subtitle: Text(country.probability.toString()),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
