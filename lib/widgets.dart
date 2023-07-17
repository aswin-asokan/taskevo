import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/notes/notesEdit.dart';

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
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
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

Widget Notes(BuildContext context, String head, String desc, Function() delete,
    Function(String hN, String dN) update) {
  return GestureDetector(
    onTap: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => edit(
                  head: head,
                  desc: desc,
                )),
      );
      if (result['action'] == 'delete') {
        delete();
      } else {
        update(result['heading'], result['description']);
      }
    },
    child: Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Container(
        child: Container(
          constraints: BoxConstraints(minHeight: 70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  head,
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  child: Text(
                    desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
