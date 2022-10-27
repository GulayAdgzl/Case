import 'package:flutter/material.dart';
import 'package:flutter_full_learn/features/BkMobil/service/person_network_service.dart';

import '../Const/Project_color.dart';
import '../Const/Project_text.dart';
import '../model/person_model.dart';

class CardScreen extends StatefulWidget {
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final PersonNetworkService personService = PersonNetworkService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: SafeArea(
                child: FutureBuilder(
                    future: personService.fetchPersons(1),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PersonModel>> snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Card(
                                  color: ColorsItems.black.withOpacity(0.5),
                                  child: ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var currentPerson =
                                            snapshot.data![index];
                                        return _CardDetail(currentPerson);
                                      }),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Icon(
                          Icons.error,
                          color: ColorsItems.red,
                          size: 82.0,
                        ));
                      }
                      return Center(child: _loadingColumn());
                    }))));
  }

  Column _loadingColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 20.0,
        ),
        Text(StringText.loading)
      ],
    );
  }

  Card _CardDetail(PersonModel currentPerson) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(currentPerson.picture.thumbnail),
            ),
            title: Text(currentPerson.name.first + currentPerson.name.last),
            subtitle: const Text(StringText.lorem),
          ),
        ],
      ),
    );
  }
}
