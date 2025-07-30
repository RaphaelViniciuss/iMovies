# iMovies

A sample app that introduces some iOS development techniques.
<center>
<img src="https://github.com/RaphaelViniciuss/iMovies/blob/main/screenshots/movie_details.png?raw=true" width="200"/>
</center>

## Objective 🎯
The main objective of the project is to build a visually functional application that uses good user experience practices following the [Human Interface Guidelines (HIG)](https://developer.apple.com/design/human-interface-guidelines), using the latest technologies for iOS development and a solid architecture capable of scaling according to project needs.

## Tech Stack 🛠️

This project uses the following technologies:
- SwiftUI
- Modular Architecture + Clean
- MVVM Pattern
- Generic Network package using [async/await](https://developer.apple.com/videos/play/wwdc2021/10132/)
- Dependency Injection pattern
- Navigation with Router pattern
- Observation framework (iOS 17)

The project has support for:
- Landscape orientation
- Dark mode

### Architecture 🏗️

Clean architecture is a very famous architecture used in several projects today. It is a very solid architecture with great expandability, we can also add to its qualities the ease of testing it and its fragmentation makes it easier to divide responsibilities within the project.

Together, we can adopt a modular architecture to decouple code that doesn't necessarily need to be project-dependent. This way, we leave tools completely independent and generic, such as Networking.
The benefits of this approach mean that changes to the package don't directly impact the entire application, and the application only knows abstractions that the availability package (SRP and DIP) provides.

## Known issues bug 🐛
- Currently the tests are triggering the API every run This is not a good behavior since the objective of testing is to test small blocks or code integrations totally isolated from API, in addition to significantly increasing server consumption.

## What's next 📌
#### Features

- Enable users to search a movie by name, genres, year
- Enable users mark movies as favorite, so that the app can provide a personalized contents
- Add trailer and user comments in Movie details view
- Add a content that tell for user where the movie can be seen (Cinema or streaming)

#### Tech

- Solve TODO flags in the app
- Add Localization for other languages
- Enable Accessibility support

## References
[The Clean Code Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

[Clean Architecture for SwiftUI](https://nalexn.github.io/clean-architecture-swiftui/)

[Human Interface Guidelines](https://developer.apple.com/design/)

[AppRouter by Dimillian](https://github.com/Dimillian/AppRouter.git)
