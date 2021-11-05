//
//  ScrollViewOffsetPreferenceKey.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/4/21.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "New title here"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63.0)
                    .onScrollViewOffsetChange { value in
                        self.scrollViewOffset = value
                    }
                
                contentLayer
                
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay(navBarLayer
                    .opacity(scrollViewOffset < 49 ? 1.0 : 0.0),
                 alignment: .top)
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootcamp()
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    private var titleLayer: some View {
        
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}
