import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';
import 'package:webtester/search.dart';
import 'package:webtester/theme.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key: key);

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'web tester',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget{
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isnull = false;

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  void onSearch() async {
    if(searchController.value.text.isNotEmpty){
      if(searchController.value.text.contains(RegExp(r'\.'))){
        Navigator.of(context).push(Transition(child: OnSearchPage(link: searchController.value.text,), transitionEffect: TransitionEffect.FADE));
      } else {
        print(false);
        _showAlert(title: '알림', message: '\n형 링크 주소 다시한번만 확인해보셈\n');
      }
    } else {
      setState(() {
        isnull = true;
      });
    }
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ready to go', textAlign: TextAlign.center, style: TextStyle(fontSize: 40),),
              const SizedBox(height: 20,),
              TextField(
                controller: searchController,
                textInputAction: TextInputAction.go,
                onSubmitted: (value){onSearch();},
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: '형 파이팅...',
                  prefixIcon: InkWell(onTap: onSearch, borderRadius: BorderRadius.circular(30), splashColor: Colors.deepPurpleAccent, child: const Icon(CupertinoIcons.search, color: Colors.deepPurpleAccent,),),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  enabledBorder: isnull ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)) : null,
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0))
                ),
              ),
            ],
          ),
          ),
      ),
    );
  }

  void _showAlert({required String title, required String message}) {
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
            CupertinoDialogAction(isDefaultAction: true, child: const Text("확인"), onPressed: () {
              Navigator.pop(context);
            })
        ],
      );
    });
  }
}