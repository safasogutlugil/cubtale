import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_event.dart';
import '../../bloc/appbar_menu/appbar_menu_state.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';

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
              Image.asset(
                  'assets/images/cubtale-logo1.png'), // Replace with your asset path
              Image.asset(
                  'assets/images/Cubtale-watermark.png'), // Replace with your asset path
            ],
          ),
        ),
        title: Row(
          children: [
            TextButton(
              onPressed: () {
                // Navigate to SearchPage and initiate search by mail
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
                // Navigate to SearchPage and initiate search by ID
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
                // Navigate to SearchPage and initiate search by date
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
          // IconButton or GestureDetector can be used based on your preference
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
                              '../assets/images/vertical-divider.png'), // Make sure you have this asset
                        ),
                      ),
                    ),
                  )
                : Image.asset('assets/images/menu_burger.png'),
            onSelected: (value) {
              // Handle the 'Logout' menu selection
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
                      ), // Replace with actual asset path
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
    return Center(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                searchTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.titleLarge?.fontWeight,
                  color: Colors.black, // Here we set the text color to black
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: inputType,
                decoration: InputDecoration(
                  labelText: 'Enter $searchTitle',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(searchIcon),
                ),
                onSubmitted: (value) {
                  if (searchType == 'mail') {
                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchByMailEvent(email: value));
                  } else if (searchType == 'id') {
                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchByIdEvent(id: value));
                  } else if (searchType == 'date') {
                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchByDateEvent(date: value));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
