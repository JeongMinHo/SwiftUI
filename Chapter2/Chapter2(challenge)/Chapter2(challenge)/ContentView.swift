//
//  ContentView.swift
//  Chapter2(challenge)
//
//  Created by USER on 2020/10/19.
//

import SwiftUI

struct ContentView: View {
    
    let targetNumber = Int.random(in: 1...100)
    
    @State var showAlert = false
    @State var value: Double = 0.5

    func computeScore() -> Int {
        let currentValue = value * 100
        let difference = abs(targetNumber - Int(currentValue))
        let points = 100 - difference
        
        return points
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Put the Bull's Eye as close as you can to: ")
                        Text("\(targetNumber)")
                    }.padding()
                }
                HStack {
                    Text("0")
                        .foregroundColor(.black)
                    Slider(value: $value)
                        .background(Color.blue)
                        .opacity(value)
                    Text("100")
                        .foregroundColor(.black)
                }
            }.padding(.horizontal)
            
            Button(action: { self.showAlert = true }) {
                Text("Hit Me!")
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Your Score"), message: Text(String(computeScore())))
            }).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(value: 0.5)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
