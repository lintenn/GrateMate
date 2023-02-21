import 'package:flutter/material.dart';
import '../global_information//globalRecipes.dart' as globalRecipes;
import '../global_information/colors_palette.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {

  Widget recipeCard(recipe){
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/recipe', arguments: recipe);
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Text(
                  recipe.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,),
                ),
              ),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(recipe.imageURL,
                      fit: BoxFit.cover
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: Text(recipe.description),
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
                    Icon(Icons.access_time),
                    SizedBox(width: 5),
                    Text("${recipe.time} min"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getDfficultyBar(int difficulty){
    return Row(
      children: List.generate(
        difficulty,
            (index) => Container(
          width: 30,
          height: 15,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: _getDifficultyColors(index+1),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: GrateMate.earthYellow[400],
      backgroundColor: GrateMate.grayGrateMate,
      body: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Row(
                    children: const [
                      // Icon of bookmark
                      Text(
                        'Bookmarks',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'MontserratExtraBold',
                          //color: GrateMate.darkGrateMate
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                itemCount: globalRecipes.recipes.length,
                itemBuilder: (context, index) {
                  return recipeCard(globalRecipes.recipes[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
