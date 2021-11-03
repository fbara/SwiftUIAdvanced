//
//  CustomShapesBootcamp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/3/21.
//

import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
    
}

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        }
    }
    
}

struct Trapazoid: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizOffset, y: rect.minY))


        }
    }
}

struct CustomShapesBootcamp: View {
    
    var body: some View {
        
        ZStack {
//            Image("cubs")
//                .resizable()
//                .scaledToFill()
            
            //Triangle()
                //.stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [10]))
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
//            Diamond()
            Trapazoid()
                .frame(width: 300, height: 100)
//                .clipShape(Triangle())
        }
    }
}

struct CustomShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesBootcamp()
    }
}
