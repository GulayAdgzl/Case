import 'package:flutter/material.dart';
import 'package:flutter_full_learn/features/BkMobil/Const/Project_text.dart';
import 'package:flutter_full_learn/features/BkMobil/service/person_network_service.dart';
import 'package:provider/provider.dart';

import '../Const/Project_color.dart';
import '../model/name_model.dart';
import '../model/person_model.dart';
import '../viewModel/Button_viewModel.dart';
import 'card_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            appBar: AppBar(leading: _loadingWidget()),
            body: Container(
              child: SafeArea(
                child: FutureBuilder(
                  future: personService.fetchPersons(50),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PersonModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: _cardDetail(snapshot),
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

                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(StringText.loading)
                      ],
                    ));
                  },
                ),
              ),
            ),
          );
        });
  }

  Card _cardDetail(AsyncSnapshot<List<PersonModel>> snapshot) {
    return Card(
      color: Colors.black.withOpacity(0.5),
      child: ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (BuildContext context, int index) {
            var currentPerson = snapshot.data![index];

            return ListTile(
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [_detailButton(context)]),
              // title: Text(currentPerson.email),
              title:
                  Text(currentPerson.name.first + "" + currentPerson.name.last),

              leading: CircleAvatar(
                backgroundImage: NetworkImage(currentPerson.picture.thumbnail),
              ),
              subtitle:
                  Text("Phone: ${currentPerson.phone}" + currentPerson.email),
            );
          }),
    );
  }

  TextButton _detailButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CardScreen();
          }));
        },
        child: Text(StringText.DetailButton,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: ColorsItems.red)));
  }

  Widget _loadingWidget() {
    return Selector<ButtonViewModel, bool>(
      selector: (context, viewModel) {
        return viewModel.isLoading;
      },
      builder: (context, value, child) {
        return value
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox();
      },
    );
  }
}
