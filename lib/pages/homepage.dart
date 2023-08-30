import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:snaphere/pages/imagepage.dart';
import 'package:snaphere/services/auth.dart';
import 'package:snaphere/services/image_api_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin{
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String? email;

  Future<void> getName() async {
    user = _auth.currentUser;
    email = user.email;
  }

  Future<void> isFetching() async {
    await Future.delayed(const Duration(seconds: 2));
    final imageList = Provider.of<ImageApiServices>(context, listen: false);
    imageList.fetchImage();
  }

  @override
  void initState(){
    super.initState();
    isFetching();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    final getData = Provider.of<ImageApiServices>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              overlayColor: MaterialStateProperty.all(Colors.white),
              tabs: const [
                Tab(text: "Explore"),
                Tab(text: "Account"),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          dragStartBehavior: DragStartBehavior.down,
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: [
            getData.imageList != null
            ? MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                itemCount: getData.imageList == null?0 : getData.imageList?.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(top: 10.0, left: 18.0, right: 18.0, bottom: 10.0),
                cacheExtent: 1980,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(builder: (_) =>
                            Imagepage(
                              name: getData.imageList![index]['user']['username'],
                              profile: getData.imageList![index]['user']['profile_image']['medium'],
                              description: getData.imageList![index]['description'],
                              url: getData.imageList![index]['urls']['full']),
                        )
                      );
                    },
                    borderRadius: BorderRadius.circular(15.0),
                    overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.8)),
                    highlightColor: Colors.grey.withOpacity(0.8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(getData.imageList![index]['urls']['regular'], fit: BoxFit.cover),
                    ),
                  );
                }
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWanderingCubes(color: Colors.black.withOpacity(0.8), size: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('Please wait', style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w500, fontSize: 14)),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.black,
                    child: Icon(FeatherIcons.user, color: Colors.white, size: 50),
                  ),
                ),
                FutureBuilder(
                    future: getName(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(top : 10.0),
                        child: Text('$email', style: const TextStyle(color: Colors.black, fontSize: 18),),
                      );
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: 80,
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        AuthenticationService().signOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
