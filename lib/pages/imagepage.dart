import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:snaphere/pages/homepage.dart';

class Imagepage extends StatefulWidget {
  final dynamic url;
  final dynamic profile;
  final dynamic name;
  final dynamic description;

  const Imagepage({Key? key, this.url, this.profile, this.name, this.description}) : super(key: key);

  @override
  State<Imagepage> createState() => _ImagepageState();
}

class _ImagepageState extends State<Imagepage> {

  @override
  void didChangeDependencies() {
    precacheImage(NetworkImage(widget.url), context);
    super.didChangeDependencies();
  }

  _showModalBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(widget.profile),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(widget.name, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
                widget.description != null
                ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Text(widget.description,overflow: TextOverflow.ellipsis, softWrap: true, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w200))),
                  ),
                )
                : const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text('No Description', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w200),),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            transitionOnUserGestures: true,
            tag: 'Full',
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.url), fit: BoxFit.cover)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 18.0, right: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.white.withAlpha(30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center
                  ),
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Homepage())
                    );
                  },
                  icon: const Icon(Icons.arrow_back, size: 15, color: Colors.white),
                  label: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                IconButton(
                  onPressed: (){
                    _showModalBottomSheet(context);
                  },
                  icon: const Icon(FeatherIcons.info, color: Colors.white, size: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

