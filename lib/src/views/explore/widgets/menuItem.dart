import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/widgets/circleIner.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';

// class MenuItem extends StatelessWidget {
//   const MenuItem(
//       {super.key,
//       required this.urlIcon,
//       required this.color,
//       required this.position,
//       required this.title,
//       this.onTap,
//       required this.length});
//   final String urlIcon;
//   final Color color;
//   final int position;
//   final String title;
//   final Function()? onTap;
//   final int length;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       // alignment: Alignment.bottomCenter,
//       children: [
//         Card(
//           color: Colors.white,
//           margin: EdgeInsets.all(10),
//           // elevation: 0,
//           child: Container(
//             padding: EdgeInsets.all(10),
//             height: 80,
//             width: screen(context).width / 2 - 25,
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               // gradient: LinearGradient(
//               //     colors: [color, color.withOpacity(.6)],
//               //     begin: Alignment.topLeft,
//               //     end: Alignment.bottomRight),
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(15),
//               // boxShadow: [
//               //   BoxShadow(
//               //       color: Colors.black12, blurRadius: 30, offset: Offset(3, 10))
//               // ],
//             ),
//             child: CustomPaint(
//               painter: NestedCirclesPainter(
//                 color: color.withOpacity(.07),
//                 posX: 10,
//                 posY: 20,
//                 radiusParent: 3,
//                 radiusChild: 6,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Image.asset(urlIcon, width: 40),
//         ),
//         Container(
//           padding: EdgeInsets.all(10),
//           height: 80,
//           width: screen(context).width / 2 - 30,
//           margin: EdgeInsets.all(10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Countup(
//                     begin: 0,
//                     end: length / 1,
//                     style: TextStyle(
//                       color: Theme.of(context)
//                           .textTheme
//                           .displayMedium!
//                           .color!
//                           .withOpacity(.2),
//                       fontWeight: FontWeight.w900,
//                       fontSize: 30,
//                       // shadows: [
//                       //   Shadow(
//                       //     offset: Offset(-3, 3),
//                       //     blurRadius: 10,
//                       //     color: Colors.black26,
//                       //   )
//                       // ],
//                     ),
//                     duration: Duration(milliseconds: 1000),
//                     curve: Curves.fastEaseInToSlowEaseOut,
//                   )
//                 ],
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 width: screen(context).width / 2 - 30,
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: color,
//                     fontSize: 17,
//                     // shadows: [
//                     //   Shadow(
//                     //     offset: Offset(-4, 5),
//                     //     blurRadius: 10,
//                     //     color: Colors.black26,
//                     //   )
//                     // ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Card(
//           elevation: 0,
//           margin: EdgeInsets.all(10),
//           color: Colors.transparent,
//           clipBehavior: Clip.hardEdge,
//           child: InkWell(
//             onTap: onTap,
//             child: Container(
//               height: 80,
//               width: screen(context).width / 2 - 30,
//               clipBehavior: Clip.hardEdge,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.urlIcon,
      required this.color,
      required this.position,
      required this.title,
      this.onTap,
      required this.length});
  final String urlIcon;
  final Color color;
  final int position;
  final String title;
  final Function()? onTap;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen(context).width / 2 - 15,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  urlIcon,
                  width: 70,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        // padding: EdgeInsets.all(5),
                        // width: 200,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15,
                                offset: Offset(-4, 8),
                              )
                            ]),
                        alignment: Alignment.center,
                        child: Countup(
                          begin: 0,
                          end: length / 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          duration: Duration(milliseconds: 1500),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
