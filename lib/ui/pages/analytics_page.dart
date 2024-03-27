import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_bloc.dart';
import '../../bloc/appbar_menu/appbar_menu_state.dart';
import '../../bloc/appbar_menu/appbar_menu_event.dart';

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
                      'assets/images/cubtale-logo1.png'), // Update the path as needed
                  Image.asset(
                      'assets/images/Cubtale-watermark.png'), // Update the path as needed
                ],
              ),
              title: Row(
                children: [
                  Expanded(child: Text(''), flex: 3),
                  TextButton(
                    onPressed: () {},
                    child: Text('Search by Mail'),
                  ),
                  Image.asset('../assets/images/vertical-divider.png'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Search by ID'),
                  ),
                  Image.asset('../assets/images/vertical-divider.png'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Search by Date'),
                  ),
                  Expanded(child: Text(''), flex: 1),
                ],
              ),
              actions: [
                // IconButton or GestureDetector can be used based on your preference
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
                                    '../assets/images/vertical-divider.png'), // Make sure you have this asset
                              ),
                            ),
                          ),
                        )
                      : Image.asset('assets/images/menu_burger.png'),
                  onSelected: (value) {
                    // Handle the 'Logout' menu selection
                    if (value == 'Logout') {
                      // TODO: Implement logout logic
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
    child: Center(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 500,
            height: 250,
            decoration: BoxDecoration(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTodaysNewUsersCard(BuildContext context) {
  // Define the inner padding for the inner card
  const double innerPadding = .0;

  // Calculate the total horizontal padding for the grid
  const double gridHorizontalPadding = innerPadding * 2;

  // Calculate the aspect ratio for the items based on screen width
  double screenWidth = MediaQuery.of(context).size.width;
  double itemHeight = 60.0; // Fixed height for each user list item
  double itemWidth = (screenWidth - gridHorizontalPadding) / 2; // Two columns
  double childAspectRatio = itemWidth / itemHeight;

  return Card(
    margin: EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'TODAYS NEW USERS',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(innerPadding),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: innerPadding,
                mainAxisSpacing: innerPadding,
                children: List.generate(
                  4, // The number of times the user list is repeated
                  (index) => _buildUserList(context),
                ).expand((element) => element).toList(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildUserList(BuildContext context) {
  // Sample data, you can replace this with actual user data.
  List<Map<String, String>> users = [
    {"Name": "John Doe", "Email": "johndoe@gmail.com"},
    {"Name": "Sammy Johnson", "Email": "sammyjohnson@gmail.com"},
    {"Name": "Pricila Miller", "Email": "pricilamiller@gmail.com"},
  ];

  return users
      .map((user) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(user['Name'] ?? ''),
                Text(user['Email'] ?? ''),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ))
      .toList();
}
