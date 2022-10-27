import 'package:flutter/material.dart';
import 'package:flutter_full_learn/features/BkMobil/service/person_network_service.dart';
import 'package:provider/provider.dart';

import '../Const/Project_color.dart';
import '../Const/Project_text.dart';
import '../model/person_model.dart';
import '../viewModel/Button_viewModel.dart';

class CardScreen extends StatefulWidget {
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final PersonNetworkService personService = PersonNetworkService();
  late final ButtonViewModel _buttonViewModel;
  @override
  void initState() {
    super.initState();
    _buttonViewModel = ButtonViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _buttonViewModel,
        builder: (context, child) {
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
                                        color:
                                            Color.fromARGB(255, 107, 102, 102)
                                                .withOpacity(0.5),
                                        child: ListView.builder(
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
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
                            return Center(child: _loadingWidget());
                          }))));
        });
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

  Widget _loadingWidget() {
    return Consumer<ButtonViewModel>(builder: (context, value, child) {
      return value.isLoading
          ? Center(child: CircularProgressIndicator())
          : SizedBox();
    });
  }
}
