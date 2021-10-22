import 'package:flutter/material.dart';
import 'package:recipes/recipe_detail.dart';
import 'recipe.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      theme: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.grey, secondary: Colors.black)),
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // previne alterações fisicas de exibições, como informações muito embaixo
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            //number the lines
            // statics recipes
            itemCount: Recipe.samples.length,
            // whats container a list
            itemBuilder: (BuildContext context, int index) {
              // dectect gestures, example: tap
              return GestureDetector(
                onTap: () {
                  // Navigator manage stack of pages
                  // push a new page on stack
                  Navigator.push(context,
                      // new page
                      MaterialPageRoute(builder: (context) {
                    return RecipeDetail(recipe: Recipe.samples[index]);
                  }));
                },
                child: buildRecipeCard(Recipe.samples[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    return Card(
        //below shadow
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // get file from assets default folder in pubspec.yaml
              Image(image: AssetImage(recipe.imageUrl)),
              const SizedBox(
                height: 14.0,
              ),
              Text(
                recipe.label,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Palatino'),
              )
            ],
          ),
        ));
  }
}
