# aibuzzassgin

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Output/screenshot/video/apk is in the output folder

Architecture Overview
This app follows a Clean Architecture with Bloc approach:
lib/
    presentation/
                auth/
                    bloc/     //conatin logic/bloc of auth screen
                    model/    //conatin model class
                    view/     //contain UI part of loginscreen
                news/ 
                    bloc/     //conatin logic/bloc of newspage screen
                    model/    //conatin model class
                    view/     //contain UI part of newspagescreen
                bookmark/ 
                    bloc/     //conatin logic/bloc of bookmark screen
                    model/    //conatin model class
                    view/     //contain UI part of bookmarkscreen
    widget/
          naviagtion_bar      //contain code of Navigation  ar used in newspage screen and bookmark screen
          webview             //contain code webview used to show every news on web
    main.dart

4)Packages Used

flutter_bloc	           Bloc pattern for state management
http	                   API requests to fetch news
shared_preferences	       Persistent storage for login & bookmarks
webview_flutter	           Displaying full news articles in-app
intl	                   Formatting published dates in readable format