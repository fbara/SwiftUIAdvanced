//
//  GeometryPreferenceKey.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/4/21.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                        
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometryPreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

struct GeometryPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKey()
    }
}

extension View {
    
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometryPreferenceKey.self, value: size)
    }
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
}
