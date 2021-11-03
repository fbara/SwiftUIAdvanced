//
//  ButtonStyleBootcamp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/1/21.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.05 : 0.0)
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

extension View {
    
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("click me")
                .font(.headline)
                .withDefaultButtonFormatting()

        })
            .withPressableStyle(scaledAmount: 0.9)
            .padding(40)

    }

}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
