//
//  ContentView.swift
//  Bullseye
//
//  Created by Sebastian San Blas on 18/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var totalRound = 1
    
    let midMightBlue = Color(red: 0.0 / 255.0 , green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .modifier(Shadow())
        }
    }
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y:2)
        }
    }
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        NavigationView {
        VStack {
            Spacer()
            
            // Target
            HStack {
                Text("Coloca el ojo tan cerca como puedas de:").modifier(LabelStyle())
                Text("\(targetValue)").modifier(ValueStyle())
            }
            
            // Deslizador
            Spacer()
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(.green)
                Text("100").modifier(LabelStyle())
            }
            
            // Boton Hit me
            Spacer()
            Button(action: {
                print("Botón presionado")
                alertIsVisible = true
            }) {
                Text("Hit Me!").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert(title: Text("\(alertTitle())"),
                             message: Text("El valor seleccionado fue \(sliderRoundedValue()).\n" +
                                            "Tu puntaje fue de \(pointForCurrentPoint())."),
                             dismissButton: .default(Text("OK")){
                                totalScore += pointForCurrentPoint()
                                targetValue = Int.random(in: 1...100)
                                totalRound += 1
                             })
            }
            .background(Image("Button"), alignment: .center).modifier(Shadow())
            
            // Puntaje
            Spacer()
            HStack {
                Button(action: {
                    print("Reinicio del juego")
                    restartGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Reiniciar").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"), alignment: .center).modifier(Shadow())
                Spacer()
                Text("Puntaje:").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                Spacer()
                Text("Ronda:").modifier(LabelStyle())
                Text("\(totalRound)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: About()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info").modifier(ButtonSmallTextStyle())
                        }
                }.background(Image("Button"), alignment: .center).modifier(Shadow())
            }.padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midMightBlue)
        .navigationBarTitle(Text("Bullseye"))
        }
    }
    
    func sliderRoundedValue() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        return abs(sliderRoundedValue() - targetValue)
    }
    
    func pointForCurrentPoint() -> Int {
        if amountOff() == 0 {
            return 200
        } else if amountOff() == 1 {
            return 150
        } else {
            return 100 - amountOff()
        }
    }
    
    func restartGame() {
        totalScore = 0
        totalRound = 1
        sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfecto"
        } else if difference < 5 {
            title = "Casi"
        } else if difference <= 10 {
            title = "Nada mal"
        } else {
            title = "¿Al menos lo estas intentando?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDisplayName("Principal")
            About().previewDisplayName("About")
        }.previewLayout(.fixed(width: 568, height: 320))
    }
}
