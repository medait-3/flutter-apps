import 'package:flutter/material.dart';
import 'package:news/modules/webview_screen/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: MaterialButton(
          color: color,
          onPressed: () {
            function();
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

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

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Text(
                      '${article['publishedAt']}',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
              image: DecorationImage(
                image: article['urlToImage'] != null? NetworkImage('${article['urlToImage']}'):NetworkImage('https://dm0qx8t0i9gc9.cloudfront.net/thumbnails/video/VCHXZQKsxil3lhgr4/animation-loading-circle-icon-on-white-background-with-alpha-channel-4k-video_signndt9ox_thumbnail-1080_01.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget articleBuilder(list, context, isSearch) {
  if (isSearch) {
    if (list.length > 0) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            right: 15,
            left: 15,
          ),
          child: Container(
            height: 0.3,
            color: Colors.grey,
          ),
        ),
        itemCount: list.length,
      );
    } else {
      return Center(child: Container());
    }
  } else {
    if (list.length > 0) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            right: 15,
            left: 15,
          ),
          child: Container(
            height: 0.3,
            color: Colors.grey,
          ),
        ),
        itemCount: list.length,
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
