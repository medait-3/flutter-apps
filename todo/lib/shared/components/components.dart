import 'package:todo/shared/todo_cubit/todo_cubit.dart';
import 'package:flutter/material.dart';

Widget defaultTextField({
  required TextEditingController controller,
  bool isPassword = false,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function? suffixFunction,
  String textForUnValid = 'this element is required',
  //required Function validate,
}) =>
    Container(
      child: TextFormField(
        autocorrect: true,
        controller: controller,
        onTap: () {
          onTap!();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return textForUnValid;
          }
          return null;
        },
        onFieldSubmitted: (value) {
          onSubmit!(value);
        },
        obscureText: isPassword ? true : false,
        onChanged: (value) {
          onChange!(value);
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: () {
              suffixFunction!();
            },
            icon: Icon(suffix),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: const BorderSide(),
              gapPadding: 4),
        ),
      ),
    );

Widget showTask(Map model, context, currentIndex) {
  late Color avatarColor;
  late Widget icon1;
  late Widget icon2;

  //new tasks
  if (currentIndex == 0) {
    avatarColor = Color(0xffF34A53);
    icon1 = IconButton(
      onPressed: () {
        TodoCubit.get(context).updateDatabase(status: 'done', id: model['id']);
      },
      icon: Icon(
        Icons.check_box_outlined,
        color: Colors.black54,
      ),
    );
    icon2 = IconButton(
      onPressed: () {
        TodoCubit.get(context)
            .updateDatabase(status: 'archived', id: model['id']);
      },
      icon: Icon(
        Icons.archive_outlined,
        color: Colors.black54,
      ),
    );
  }
  //done tasks
  else if (currentIndex == 1) {
    avatarColor = Color(0xff437356);
    icon1 = Container();
    icon2 = IconButton(
      onPressed: () {
        TodoCubit.get(context)
            .updateDatabase(status: 'archived', id: model['id']);
      },
      icon: Icon(
        Icons.archive_outlined,
        color: Colors.black54,
      ),
    );
  }
  //archived
  else {
    avatarColor = Color(0xff287D7D);
    icon1 = IconButton(
      onPressed: () {
        TodoCubit.get(context).updateDatabase(status: 'done', id: model['id']);
      },
      icon: Icon(
        Icons.check_box_outlined,
        color: Colors.black54,
      ),
    );
    icon2 = Container();
  }
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: avatarColor,
            child: Text(
              '${model['time']}',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 220,
                  child: Text(
                    '${model['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1E4147)),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: avatarColor,
                  ),
                ),
              ],
            ),
          ),
          icon1,
          icon2,
        ],
      ),
    ),
    onDismissed: (direction) {
      TodoCubit.get(context).deleteDatabase(id: model['id']);
    },
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
