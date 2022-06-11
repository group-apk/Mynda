import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynda/model/article_model.dart';
import 'package:mynda/provider/article_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late final ArticleModel _currentArticleModel = ArticleModel(
    "",
    "",
    "",
    "",
    0,
    List<String>.empty(growable: true),
    List<String>.empty(growable: true),
    Timestamp.now(),
  );

  Future uploadArticle(ArticleModel currentArticleModel) async {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    currentArticleModel = await uploadNewArticle(currentArticleModel);
    getArticle(articleNotifier);
  }

  @override
  void initState() {
    super.initState();

    _currentArticleModel.category!.add("");
    _currentArticleModel.body!.add("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Form"),
        backgroundColor: Colors.blue,
      ),
      body: _uiWidget(),
    );
  }

  Widget _uiWidget() {
    return Form(
      key: globalFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: FormHelper.inputFieldWidgetWithLabel(
                  context,
                  "title",
                  "Article Title",
                  "",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'Article Title can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    _currentArticleModel.title = onSavedVal,
                  },
                  initialValue: _currentArticleModel.title as String,
                  obscureText: false,
                  borderFocusColor: Theme.of(context).primaryColor,
                  prefixIconColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 2,
                  paddingLeft: 0,
                  paddingRight: 0,
                  showPrefixIcon: false,
                  fontSize: 13,
                  labelFontSize: 13,
                  onChange: (val) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: FormHelper.inputFieldWidgetWithLabel(
                  context,
                  "author",
                  "Author",
                  "",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'Author can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    _currentArticleModel.author = onSavedVal,
                  },
                  initialValue: _currentArticleModel.author as String,
                  obscureText: false,
                  borderFocusColor: Theme.of(context).primaryColor,
                  prefixIconColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 2,
                  paddingLeft: 0,
                  paddingRight: 0,
                  showPrefixIcon: false,
                  fontSize: 13,
                  labelFontSize: 13,
                  onChange: (val) {},
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Category(s)",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  categoryContainerUI(),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Body(s)",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  bodyContainerUI(),
                  Center(
                    child: FormHelper.submitButton(
                      "Create Article",
                      btnColor: Colors.blue,
                      borderColor: Colors.blue,
                      () async {
                        if (validateAndSave()) {
                          uploadArticle(_currentArticleModel).then((value) {
                            Fluttertoast.showToast(msg: "Successfully create article");
                            Navigator.of(context).pop();
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: _currentArticleModel.category!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: categoryUI(index),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget bodyContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: _currentArticleModel.body!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: bodyUI(index),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget categoryUI(index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: FormHelper.inputFieldWidget(
              context,
              "category_$index",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Category ${index + 1} can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                _currentArticleModel.category![index] = onSavedVal,
              },
              initialValue: _currentArticleModel.category![index],
              obscureText: false,
              borderFocusColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 2,
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: false,
              fontSize: 13,
              onChange: (val) {},
            ),
          ),
          Visibility(
            visible: index == _currentArticleModel.category!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addCategoryControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: index > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  removeCategoryControl(index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bodyUI(index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: FormHelper.inputFieldWidget(
              context,
              "Body_$index",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Body ${index + 1} can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                _currentArticleModel.body![index] = onSavedVal,
              },
              initialValue: _currentArticleModel.body![index],
              obscureText: false,
              borderFocusColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 2,
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: false,
              fontSize: 13,
              onChange: (val) {},
            ),
          ),
          Visibility(
            visible: index == _currentArticleModel.body!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addBodyControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: index > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  removeBodyControl(index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void addCategoryControl() {
    setState(() {
      if (_currentArticleModel.category!.length >= 3) {
        Fluttertoast.showToast(
            msg: "Maximum No. of Category is 3",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      _currentArticleModel.category!.add("");
    });
  }

  void addBodyControl() {
    setState(() {
      if (_currentArticleModel.body!.length >= 3) {
        Fluttertoast.showToast(
            msg: "Maximum No. of Body is 3",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      _currentArticleModel.body!.add("");
    });
  }

  void removeCategoryControl(index) {
    setState(() {
      if (_currentArticleModel.category!.length > 1) {
        _currentArticleModel.category!.removeAt(index);
      }
    });
  }

  void removeBodyControl(index) {
    setState(() {
      if (_currentArticleModel.body!.length > 1) {
        _currentArticleModel.body!.removeAt(index);
      }
    });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
