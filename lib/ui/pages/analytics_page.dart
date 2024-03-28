import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_state.dart';
import '../../bloc/appbar_menu/appbar_menu_event.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';
import 'search_page.dart';

class AnalyticsPage extends StatelessWidget {
  AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBarMenuBloc>(
      create: (context) => AppBarMenuBloc(),
      child: BlocBuilder<AppBarMenuBloc, AppBarMenuState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<AppBarMenuBloc>(context);
          final isMenuOpen = state is AppBarMenuOpenState;

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leadingWidth: 320,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                      'assets/images/cubtale-logo1.png'), 
                  Image.asset(
                      'assets/images/Cubtale-watermark.png'),
                ],
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
                  onOpened: () => bloc.add(AppBarMenuToggleEvent()),
                  icon: isMenuOpen
                      ? Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              3,
                              (_) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
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
            body: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (1 / 0.46),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                _buildTodaysNewUsersCard(context),
                _buildDummyCard(context, "Dummy Card 2"),
                _buildDummyCard(context, "Dummy Card 3"),
                _buildDummyCard(context, "Dummy Card 4"),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildDummyCard(BuildContext context, String title) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget _buildTodaysNewUsersCard(BuildContext context) {
  final List<Map<String, String>> users = [
    {"Name": "John Doe", "Email": "johndoe@gmail.com"},
    {"Name": "Sammy Johnson", "Email": "sammyjohnson@gmail.com"},
    {"Name": "Pricila Miller", "Email": "pricilamiller@gmail.com"},
  ];

  List<Widget> userTiles = users
      .map(
        (user) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  user['Name']!,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                child: Text(
                  user['Email']!,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Expanded(
                child: Text(
                  ' >',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      )
      .toList();

  userTiles = List.generate(4, (_) => userTiles).expand((x) => x).toList();

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAYS NEW USERS',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: userTiles,
                alignment: WrapAlignment.start,
                spacing: 8, 
                runSpacing: 8,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
