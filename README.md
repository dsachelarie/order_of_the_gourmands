# Device-Agnostic Design Course Project II - a9e342e8-ed65-40fe-8da0-93a149d0fe3a

**Name of the application:** Order of the Gourmands

**Brief description of the application:** An application for discovering and creating recipes.

**3 key challenges faced during the project:**
- When using *PagedListView* and *PagedGridView* instead of the regular *ListView* and *GridView*, the state is not automatically updated when the value in a provider changes and affects the page. It was challenging to find a way to trigger a state update manually, 
- When retrieving data from the Firestore database, the error messages are not very descriptive, so it once took me a very long time to realize that the issue was simply caused by declaring a variable with the wrong type;
- Using a *Map* to store ingredient names and their corresponding amounts was quite cumbersome, and at some point I even considered switching to a single *String* for both attributes, which would have involved the use of a *List*. However, by the end of the project, I was glad I stuck with the *Map* approach, as it provided much greater flexibility.

**3 key learning moments from working on the project:**
- I learned how to handle unbounded height or width errors that occur in complex page structures which include *ListViews* or *GridViews*;
- I learned how to structure my code logically across multiple files and folders, ensuring that it remains easy to understand as it grows;
- 

**list of dependencies and their versions (from pubspec.yaml):**
- cupertino_icons: ^1.0.2
- flutter_riverpod: ^2.4.0
- firebase_core: ^2.9.0
- cloud_firestore: ^4.5.1
- firebase_auth: ^4.4.1
- infinite_scroll_pagination: ^4.0.0
