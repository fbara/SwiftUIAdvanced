//
//  CustomNavBarView.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/8/21.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let showBackButton: Bool
    let title: String
    let subTitle: String?
    
    var body: some View {
        
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            
            titleSection
            
            Spacer()
            if showBackButton {
                backButton
                    .opacity(0)
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundColor(Color.white)
        .font(.headline)
        .background(Color.blue.ignoresSafeArea(edges: .top))
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showBackButton: true, title: "Title here", subTitle: "Subtitle here")
            Spacer()
        }
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            if let subTitle = subTitle {
                Text(subTitle)
            }
        }
    }
}
