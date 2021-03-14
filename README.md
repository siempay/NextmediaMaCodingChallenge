# NextMedia Coding Challenge

The app is designed in Multi-Layers architecture View-Service-DAO 
to make code as decoupled and maintable as possible.

This approuche can help us create project (pod) for each layer and develop it separatly.

The is not finished in desing due to time limit.

- `App` folder contains the view layer: view controllers
- `Service` folder contains the services used by the view and DAO dose not know about it
- `DAO` folder contains the data access layer which is called only by service and the view dose not know about it

## Installation

locate the project on the terminal and run: 

```bash
pod install
```


## Usage

After installing pods, go to project and open the `NextmediaMaCodingChallenge.xcworkspace` and click on `Run` 

