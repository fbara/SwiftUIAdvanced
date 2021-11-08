//
//  CustomNavBarContainerView.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/8/21.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = "Title"
    @State private var subTitle: String? = "Subtitle"
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subTitle: subTitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: { value in
            self.subTitle = value
        })
        
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                Text("Hello world")
                    .foregroundColor(.white)
                    .customNavigationTitle("New title")
                    .customNavigationSubtitle("New subtitle")
                    .customNavigationBarBackButtonHidden(true)
            }
        }
    }
}
