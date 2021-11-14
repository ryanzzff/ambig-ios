//
//  ContentView.swift
//  Shared
//
//  Created by Ryan Lee on 14/11/2021.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var input: String = ""
    @Published var inputLength: Int = 0
    
    init() {
        $input
            .map { $0.count }
            .assign(to: &$inputLength)
    }
}

struct ContentView: View {
    @StateObject var model: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter some text", text: $model.input)
            Text("Input String Length: \(model.inputLength)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
