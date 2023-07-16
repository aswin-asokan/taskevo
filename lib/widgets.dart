import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget toDO(BuildContext context, bool val, String head,
    Function(bool?)? onChanged, Function() delete, Function() update) {
  void handleClick(int item) {
    switch (item) {
      case 0:
        update();
        break;
      case 1:
        delete();
        break;
    }
  }

  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: Container(
        constraints: BoxConstraints(minHeight: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(shape: CircleBorder(), value: val, onChanged: onChanged),
              Text(
                head,
                style: GoogleFonts.openSans(
                    decoration: val ? TextDecoration.lineThrough : null,
                    fontSize: 20),
              ),
            ],
          ),
          PopupMenuButton(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Edit')),
              PopupMenuItem<int>(value: 1, child: Text('Delete')),
            ],
          ),
        ]),
      ),
    ),
  );
}
