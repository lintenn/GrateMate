import 'package:flutter/material.dart';
import 'package:grate_mate/widgets/mate_text_h3.dart';
import '../global_information/colors_palette.dart';
import 'package:grate_mate/global_information/global_users.dart' as Users;

import '../widgets/mate_text_h1.dart';
import '../widgets/mate_text_p.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GrateMate.grayGrateMate,
        body: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: const MateTextH1(text: 'Bookmarks'),
              ),
              Users.isLogged
                  ? Users.userLogged.bookmarks.isEmpty
                      ? const MateTextH3.normal(
                          text:
                              'You don\'t have any bookmark yet. Go to the recipes and add some!',
                        )
                      : Flexible(
                          child: ListView.builder(
                            itemCount: Users.userLogged.bookmarks.length,
                            itemBuilder: (context, index) {
                              return recipeCard(
                                  Users.userLogged.bookmarks[index]);
                            },
                          ),
                        )
                  : const MateTextH3.normal(
                text: 'Log in to have bookmarks',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recipeCard(recipe) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, '/recipe', arguments: recipe);
          setState(() {});
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: MateTextH3.bold(
                  text: recipe.name,
                ),
              ),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(recipe.imageURL, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: MateTextP(text: recipe.description),
              ),
              //This code create a bar instead of a rectangles
              /*Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 20, 8),
                child:  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: recipe.difficulty / 5,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: _getDifficultyColors(recipe.difficulty),
                        ),
                      ),
                    )
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: getDfficultyBar(recipe.difficulty),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 5),
                    MateTextP(text: "${recipe.time} min"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getDfficultyBar(int difficulty) {
    return Row(
      children: List.generate(
        difficulty,
        (index) => Container(
          width: 30,
          height: 15,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: _getDifficultyColors(index + 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  /*List<Color> _getDifficultyColors(int difficulty) {
    switch (difficulty) {
      case 1:
        return [Colors.green, Colors.green];
      case 2:
        return [Colors.green, const Color(0xffC6CE00)];
      case 3:
        return [Colors.green, const Color(0xffC6CE00), Colors.yellow];
      case 4:
        return [Colors.green, const Color(0xffC6CE00), Colors.yellow, Colors.orange];
      case 5:
        return [Colors.green, const Color(0xffC6CE00), Colors.yellow, Colors.orange, Colors.red];
      default:
        return [Colors.grey, Colors.grey];
    }
  }*/

  Color _getDifficultyColors(int difficulty) {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return const Color(0xffC6CE00);
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
