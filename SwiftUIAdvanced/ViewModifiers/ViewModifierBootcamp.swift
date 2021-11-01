//
//  ViewModifierBootcamp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/1/21.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(radius: 10)
    }
    
}

extension View {
    
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
        
    }
    
}

struct ViewModifierBootcamp: View {
        
    var body: some View {
        
        VStack(spacing: 10) {
            Text("HI There!")
                .font(.headline)
                .withDefaultButtonFormatting(backgroundColor: .pink)
            
            Text("Howdy!!")
                .font(.subheadline)
                .withDefaultButtonFormatting()

            Text("What's Up?")
                .font(.title)
                .modifier(DefaultButtonViewModifier(backgroundColor: .red))
        }
        .padding()
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
