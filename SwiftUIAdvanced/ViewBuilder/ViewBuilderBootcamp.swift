//
//  ViewBuilderBootcamp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/4/21.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}

struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ViewBuilderBootcamp: View {
    
    
    var body: some View {
        
        VStack {
            HeaderViewRegular(title: "new title", description: "hello", iconName: "heart.fill")
            HeaderViewRegular(title: "another title", description: nil, iconName: nil)
            
            HeaderViewGeneric(title: "Generic title") {
                HStack {
                    Text("Hi")
                    Text("Hi")
                    Text("Hi")
                    Text("Hi")
                }
            }
            
            CustomHStack {
                Text("Hi")
                Text("Hi")
            }
            
            Spacer()
        }
        
    }
}

struct ViewBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        //        ViewBuilderBootcamp()
        LocalViewBuilder(type: .one)
    }
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
        
//        if type == .one {
//            viewOne
//        } else if type == .two {
//            viewTwo
//
//        } else if type == .three {
//            viewThree
//        }
    }
    
    private var viewOne: some View {
        Text("one")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("two")
            Image(systemName: "heart.fill")
        }

    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
        
    }
}
