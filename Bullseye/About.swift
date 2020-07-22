//
//  About.swift
//  Bullseye
//
//  Created by Sebastian San Blas on 19/07/2020.
//

import SwiftUI

struct About: View {

    let aboutBlackColor = Color(red: 255.0 / 255.0 , green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct AboutTitle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20.0)
                .padding(.bottom, 20.0)
        }
    }
    struct AboutText: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 20.0)
                .padding(.trailing, 20.0)
                .padding(.bottom, 20.0)
        }
    }
    var body: some View {
        Group{
            VStack(alignment: .center) {
                    Text("🎯 Bull's Eye 🎯").modifier(AboutTitle())
                    Group {
                        Text("El objetivo es colocar la barra deslizadora tan cerca del valor solicitado. Mientras más cerca, más puntos.")
                        Text("Enjoy!")
                    }.modifier(AboutText())
                }.navigationBarTitle(Text("Sobre Bull's Eye"))
            .background(aboutBlackColor)
        }.background(Image("Background").blur(radius: 10.0))
    }
}
