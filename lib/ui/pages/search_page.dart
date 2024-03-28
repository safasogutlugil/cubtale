import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_event.dart';
import '../../bloc/appbar_menu/appbar_menu_state.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';
import 'package:intl/intl.dart';

import '../../bloc/search/search_state.dart';

class SearchPage extends StatelessWidget {
  final String searchType;

  const SearchPage({Key? key, required this.searchType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppBarMenuBloc appBarBloc = BlocProvider.of<AppBarMenuBloc>(context);
    final bool isMenuOpen = (appBarBloc.state is AppBarMenuOpenState);

    String searchTitle;
    IconData searchIcon;
    TextInputType inputType;

    switch (searchType) {
      case 'mail':
        searchTitle = 'Search by Mail';
        searchIcon = Icons.email;
        inputType = TextInputType.emailAddress;
        break;
      case 'id':
        searchTitle = 'Search by ID';
        searchIcon = Icons.perm_identity;
        inputType = TextInputType.text;
        break;
      case 'date':
        searchTitle = 'Search by Date';
        searchIcon = Icons.calendar_today;
        inputType = TextInputType.datetime;
        break;
      default:
        throw Exception('Unknown search type: $searchType');
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 320,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pushReplacementNamed('/analytics'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/cubtale-logo1.png'),
              Image.asset('assets/images/Cubtale-watermark.png'),
            ],
          ),
        ),
        title: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SearchBloc>(context)
                      ..add(SearchByMailEvent(email: '')),
                    child: const SearchPage(searchType: 'mail'),
                  ),
                ));
              },
              child: Text('Search by Mail'),
            ),
            Image.asset('../assets/images/vertical-divider.png'),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SearchBloc>(context)
                      ..add(SearchByIdEvent(id: '')),
                    child: SearchPage(searchType: 'id'),
                  ),
                ));
              },
              child: Text('Search by ID'),
            ),
            Image.asset('../assets/images/vertical-divider.png'),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SearchBloc>(context)
                      ..add(SearchByDateEvent(date: '')),
                    child: SearchPage(searchType: 'date'),
                  ),
                ));
              },
              child: Text('Search by Date'),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onOpened: () => appBarBloc.add(AppBarMenuToggleEvent()),
            icon: isMenuOpen
                ? Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        3,
                        (_) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Image.asset(
                              '../assets/images/vertical-divider.png'),
                        ),
                      ),
                    ),
                  )
                : Image.asset('assets/images/menu_burger.png'),
            onSelected: (value) {
              if (value == 'Logout') {
                context.read<LoginBloc>().add(LogoutEvent());
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                enabled: false,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/images/profile_image_dark.png'
                            : 'assets/images/profile_image_light.png',
                      ),
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Name: Olivia Starkey'),
                    ),
                    Text('Role: Manager'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'Logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                ),
              ),
            ],
          )
        ],
      ),
      body: SearchWidget(
        searchType: searchType,
        searchTitle: searchTitle,
        searchIcon: searchIcon,
        inputType: inputType,
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final String searchType;
  final String searchTitle;
  final IconData searchIcon;
  final TextInputType inputType;

  const SearchWidget({
    Key? key,
    required this.searchType,
    required this.searchTitle,
    required this.searchIcon,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: '');

    void searchAction() {
      if (searchType == 'mail' && _controller.text != '') {
        BlocProvider.of<SearchBloc>(context)
            .add(SearchByMailEvent(email: _controller.text));
      } else if (searchType == 'id' && _controller.text.isNotEmpty) {
        BlocProvider.of<SearchBloc>(context)
            .add(SearchByIdEvent(id: _controller.text));
      } else if (searchType == 'date' && _controller.text.isNotEmpty) {
        BlocProvider.of<SearchBloc>(context)
            .add(SearchByDateEvent(date: _controller.text));
      }
    }

    return Center(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                searchTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              if (searchType != 'date')
                TextField(
                  controller: _controller,
                  keyboardType: inputType,
                  decoration: InputDecoration(
                    labelText: 'Enter $searchTitle',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(searchIcon),
                  ),
                )
              else
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    _controller.text = DateFormat('dd-MM-yyyy').format(picked!);
                  },
                  child: IgnorePointer(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Enter $searchTitle',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: searchAction,
                child: Text('Search'),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is SearchSuccessState) {
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final user = state.results[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                  '${user['acc_name']} ${user['acc_surname']}'),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ID: ${user['acc_id']}'),
                                    Text('Email: ${user['acc_mail']}'),
                                    Text('Verified: ${user['acc_verified']}'),
                                    Text(
                                        'Creation Date: ${user['acc_creation_date']}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return SizedBox
                        .shrink(); // Fallback for initial or undefined states
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
