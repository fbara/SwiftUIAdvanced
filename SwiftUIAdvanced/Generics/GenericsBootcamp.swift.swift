//
//  GenericsBootcamp.swift.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/4/21.
//

import SwiftUI

struct StringModel {
    
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "hello world!")
    @Published var genericStringModel = GenericModel(info: "hello")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
    }
}

struct GenericModel<T> {
    
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
    
}

struct GenericView<T: View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        
        VStack {
            GenericView(content: Text("custom content"), title: "new view")
//            GenericView(title: "New view")
            Text(vm.stringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
                .onTapGesture {
                    vm.removeData()
                }
        }
    }
}

struct GenericsBootcamp_swift_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
