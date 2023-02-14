library recipes;

import 'package:grate_mate/models/recipe.dart';


//main colors of the app: https://coolors.co/606c38-283618-fefae0-dda15e-bc6c25

final List<Recipe> recipes = [
Recipe(name: "Crepes",description:  "Original french dessert",
steps: ["Prepare ingredients","Finish recipe"],
difficulty: 1,time:  30,
imageURL: 'assets/crepes.jpg')
//imageURL: "https://vod-hogarmania.atresmedia.com/hogarmania/images/images01/2019/05/20/5ce265e7fa7dec0001ed6f24/1239x697.jpg")
,
Recipe(name: "burger",description:  "Real texas burger",
steps: ["Prepare ingredients","Finish recipe"], difficulty: 3, time:  60,
    imageURL: 'assets/burger.png')
  //imageURL: "https://www.bergfest.de/wp-content/uploads/2021/03/texasburger_klein1.jpg")
,
Recipe(name: "Tortilla",description:  "Tipical spanish tortilla",
    steps: ["Prepare ingredients","Do the dish"],difficulty:  5, time: 30,
    imageURL: 'assets/tortilla.png')
    //    imageURL: "https://mim.p7s1.io/pis/ld/12a9zChLCVyZ-c1vEwXZAanB-DJ78rnq2V2gRWTHzVV6NywNWMSJCEGmZ4YSENP-WRL0b9lo2z_IfGOSZ1UVCV30P-oV4svvpu1HJ79dtfYLCCYEG8TLB0rgYmJE20-bJL5er23WDdQ/profile:original")
];