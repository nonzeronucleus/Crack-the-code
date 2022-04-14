import ReSwift

//
//
//let mainStore2 = Store<AppState>(
//    reducer: reducer,
//    state: nil
//)

func createStore(state:AppState? = nil) -> ObservableState<AppState>{
    let mainStore = Store<AppState>(
        reducer: reducer,
        state: state
    )

    return ObservableState(store: mainStore)
}

