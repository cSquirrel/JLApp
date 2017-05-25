
# Status
# Design and development decisions
* network layer is made of [service provider](https://github.com/cSquirrel/JLApp/blob/master/DishwashersApp/DishwashersApp/Networking/NetworkServicesProvider.swift) and [operations executor](https://github.com/cSquirrel/JLApp/blob/master/DishwashersApp/DishwashersApp/Networking/NetworkOperationsExecutor.swift)
  * protocols allowed for mock implementation to be used during testing
  * separation of both allows to implement custom network operations execution strategies if needed
  * [DefaultServicesProvider](https://github.com/cSquirrel/JLApp/blob/master/DishwashersApp/DishwashersApp/Networking/DefaultServicesProvider.swift) implements basics of HTTP communication. Should the server require custom headers or any other customisation a custom provider can be implemented.
* use of IBDesignable for UI components; this allows for clean Interface Builder work, cleaner UI code and better separation views
* due to the nature of the app [the model objects](https://github.com/cSquirrel/JLApp/blob/master/DishwashersApp/DishwashersApp/API/JohnLewisModel.swift) are close to API hence they contain code for creating them from JSON. Would the model be internal to the app I would extract this code to JohnLewisModelBuilder to keep the model JSON agnostic.
* Since prices are used for nothing but displaying in UI they are kept as strings. I the future, when improving the app, it would be worth to have a designated "Price" model object and "PriceFormatter" class which would format the price according to the value and currency code
* [ApplicationConfiguration](https://github.com/cSquirrel/JLApp/blob/master/DishwashersApp/DishwashersApp/Core/ApplicationConfiguration.swift) is created in Interface Builder and injected into [ProductsGridViewController](https://github.com/cSquirrel/JLApp/blob/master/DishwashersApp/DishwashersApp/UI/ProductsGridViewController.swift). This is good enough for this exercise. In long term there would be an entity responsible for creating and providing the configuration, i.e. initial screen downloading additional settings from server.

## Well known issues
* basic network error handling
* no advanced network operations queueing
* in-memory data caching; can be improved by using filesystem and if ETag header would be sent by server
* on product details page status the UI is at bare minimum; photos carousel is not implemented due to limited time

# Released Versions

## [Version 0.3.2](https://github.com/cSquirrel/JLApp/releases/tag/0.3.2)
Bugfixes and improvements:
* Xcode scheme is shared now. UI autmation tests are excluded
* scale and display images preserving aspect ratio

## [Version 0.3.1](https://github.com/cSquirrel/JLApp/releases/tag/0.3.1)
Hotfix:
* added unmerged commit

## [Version 0.3](https://github.com/cSquirrel/JLApp/releases/tag/0.3)
Maintenance:
* Added loading spinner to provide UI feedback when connecting to API
* Added primitive network error handling
* code review and improvements

## [Version 0.2](https://github.com/cSquirrel/JLApp/releases/tag/0.2)
Optimisations and improvements:
* prevent products grid controller from reloading every time viewDidAppear,
* use NSCache to cache images and api responses,
* scale down images to reduce memory footprint,
* code cleanup

## [Version 0.1](https://github.com/cSquirrel/JLApp/releases/tag/0.1)
Minimum Viable Product:
* happy path only,
* the app communicates with the server to fetch data and images,
* no error handling, no visual feedback when data is loading,
* images are not cached nor scaled,
* basic UI enough to present interaction and live data
