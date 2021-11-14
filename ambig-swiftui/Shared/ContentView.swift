//
//  ContentView.swift
//  Shared
//
//  Created by Ryan Lee on 14/11/2021.
//

import SwiftUI
import Combine
import ambig_framework

class ViewModel: ObservableObject {
    @Published var input: String = ""
    @Published var shift: String = ""
    @Published var cipherText: String = ""
    
    init() {
        Publishers.CombineLatest($input, $shift)
            .map { CaesarCipher().encrypt($0, shift: Int($1) ?? 1) }
            .assign(to: &$cipherText)
    }
}

struct ContentView: View {
    @StateObject var model: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter some text", text: $model.input)
            TextField("Shift", text: $model.shift)
            Text("Caesar shifted cipher text: \(model.cipherText)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
