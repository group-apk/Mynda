import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynda/model/article_model.dart';
import 'package:mynda/provider/article_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class EditArticleScreen extends StatefulWidget {
  const EditArticleScreen({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  State<EditArticleScreen> createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  Future deleteArticle(ArticleModel currentArticleModel) async {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    await deleteCurrentArticle(currentArticleModel);
    getArticle(articleNotifier);
  }

  Future updateArticle(ArticleModel currentArticleModel) async {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    currentArticleModel = await updateCurrentArticle(currentArticleModel);
    getArticle(articleNotifier);
  }

  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    ArticleModel currentArticleModel = articleNotifier.currentArticleModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Article"),
        backgroundColor: Colors.blue,
      ),
      body: _uiWidget(currentArticleModel),
    );
  }

  Widget _uiWidget(ArticleModel currentArticleModel) {
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
                    currentArticleModel.title = onSavedVal,
                  },
                  initialValue: currentArticleModel.title as String,
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
                    currentArticleModel.author = onSavedVal,
                  },
                  initialValue: currentArticleModel.author as String,
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
                  categoryContainerUI(currentArticleModel),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Body(s)",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  bodyContainerUI(currentArticleModel),
                  Row(
                    children: [
                      Expanded(
                        child: FormHelper.submitButton(
                          "Update Article",
                          btnColor: Colors.blue,
                          borderColor: Colors.blue,
                          () async {
                            if (validateAndSave()) {
                              updateArticle(currentArticleModel).then((value) {
                                Fluttertoast.showToast(msg: "Successfully updated article");
                                Navigator.of(context).pop();
                              });
                            }
                          },
                        ),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.all(13),
                        minWidth: 0,
                        // height: 55,
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: const CircleBorder(),
                        onPressed: () {
                          deleteArticle(currentArticleModel).then((value) {
                            Fluttertoast.showToast(msg: "Successfully deleted article");
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryContainerUI(ArticleModel currentArticleModel) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: currentArticleModel.category!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: categoryUI(index, currentArticleModel),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget bodyContainerUI(ArticleModel currentArticleModel) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: currentArticleModel.body!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: bodyUI(index, currentArticleModel),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget categoryUI(index, ArticleModel currentArticleModel) {
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
                currentArticleModel.category![index] = onSavedVal,
              },
              initialValue: currentArticleModel.category![index],
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
            visible: index == currentArticleModel.category!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addCategoryControl(currentArticleModel);
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
                  removeCategoryControl(index, currentArticleModel);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bodyUI(index, ArticleModel currentArticleModel) {
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
                currentArticleModel.body![index] = onSavedVal,
              },
              isMultiline: true,
              initialValue: currentArticleModel.body![index],
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
            visible: index == currentArticleModel.body!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addBodyControl(currentArticleModel);
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
                  removeBodyControl(index, currentArticleModel);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void addCategoryControl(ArticleModel currentArticleModel) {
    setState(() {
      if (currentArticleModel.category!.length >= 3) {
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
      currentArticleModel.category!.add("");
    });
  }

  void addBodyControl(ArticleModel currentArticleModel) {
    setState(() {
      if (currentArticleModel.body!.length >= 3) {
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
      currentArticleModel.body!.add("");
    });
  }

  void removeCategoryControl(index, ArticleModel currentArticleModel) {
    setState(() {
      if (currentArticleModel.category!.length > 1) {
        currentArticleModel.category!.removeAt(index);
      }
    });
  }

  void removeBodyControl(index, ArticleModel currentArticleModel) {
    setState(() {
      if (currentArticleModel.body!.length > 1) {
        currentArticleModel.body!.removeAt(index);
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
