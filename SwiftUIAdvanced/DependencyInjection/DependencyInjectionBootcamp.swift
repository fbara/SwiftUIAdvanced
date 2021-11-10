//
//  DependencyInjectionBootcamp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/10/21.
//

import SwiftUI
import Combine

/*
 Problems with Singlton:
 1. Singltons are global
 2. Can't customize the init()
 3. Can't swap out services
 */

struct PostsModel: Identifiable, Codable {
    
    let userID: Int
    let id: Int
    let title: String
    let body: String
    
}


protocol DataServiceProtocol {
    
    func getData() -> AnyPublisher<[PostsModel], Error>
    
    
}

class ProductionDataService: DataServiceProtocol {
    // fetches data from repository
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel]
    
    init(data: [PostsModel]?) {
        self.testData = data ?? [
            PostsModel(userID: 1, id: 1, title: "One", body: "One"),
            PostsModel(userID: 2, id: 2, title: "Two", body: "Two")
        ]
        
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap({ $0 }) // just put here because AnyPublisher contains Error
            .eraseToAnyPublisher()
    }
    
    
    
}


class DependencyInjectionViewModel: ObservableObject {
    
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
        
    }
    
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
    
    //    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    static let dataService = MockDataService(data: [
        PostsModel(userID: 1, id: 1, title: "One", body: "One")
    ])
    
    static var previews: some View {
        DependencyInjectionBootcamp(dataService: dataService)
    }
}
