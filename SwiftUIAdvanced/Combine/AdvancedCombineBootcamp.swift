//
//  AdvancedCombineBootcamp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/15/21.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    //    @Published var basicPublisher: String = "first publish"
    //    let currentValuePublisher = CurrentValueSubject<Int, Error>("first publish")
    let passthruPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passthruPublisher.send(items[x])
                
                // for testing boolPublishser
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passthruPublisher.send(completion: .finished)
                }
            }
        }
    }
    
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    
    let dataService = AdvancedCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        //        dataService.passthruPublisher
        
        // sequence operations
        /*
         //            .first()
         //            .first(where: { $0 > 4 })
         //            .tryFirst(where: { int in
         //
         //                if int == 3 {
         //                    throw URLError(.badServerResponse)
         //                }
         //
         //                return int > 1
         //            })
         //            .last()
         //            .last(where: { $0 < 4 })
         //            .tryLast(where: { int in
         //                if int == 13 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int > 1
         //            })
         //            .dropFirst()
         //            .dropFirst(3)
         //            .drop(while: { $0 < 5 })
         //            .tryDrop(while: { int in
         //                if int == 15 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int < 6
         //            })
         //            .prefix(4)
         //            .prefix(while: { $0 < 5 })
         //            .tryPrefix(while: )
         //            .output(at: 5)
         //            .output(in: 2..<4)
         */
        
        // mathmatic operations
        /*
         //            .max()
         //            .max(by: { int1, int2 in
         //                return int1 < int2
         //            })
         //            .tryMap(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)
         //            .min()
         //            .min(by: )
         //            .tryMin(by: )
         */
        
        // filering/reducing operations
        /*
         //            .map({ String($0) })
         //            .tryMap({ int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return String(int)
         //            })
         //            .compactMap({ int in
         //                if int == 5 {
         //                    return nil
         //                }
         //                return String(int)
         //            })
         //            .tryCompactMap()
         //            .filter({ ($0 > 3 && ($0 < 7)) })
         //            .tryFilter()
         //            .removeDuplicates()
         //            .removeDuplicates(by: { int1, int2 in
         //                return int1 == int2
         //            })
         //            .tryRemoveDuplicates(by: )
         //            .replaceNil(with: <#T##T#>)
         //            .replaceEmpty(with: )
         //            .replaceError(with: )
         //            .scan(0, { existingValue, newValue in
         //                return existingValue + newValue
         //            })
         //            .scan(0, { $0 + $1 })
         //            .scan(0, +)
         //            .tryScan(, )
         //            .reduce(0, { $0 + $1 }
         //            .collect()
         //            .allSatisfy({ $0 < 50 })
         //            .tryAllSatisfy()
         */
        
        // timing operations
        /*
         //            .debounce(for: 1, scheduler: DispatchQueue.main)
         //             .measureInterval(using: DispatchQueue.main)
         //             .map({ stride in
         //                 return "\(stride.timeInterval)"
         //             })
         //            .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
         //            .retry(3)
         //            .timeout(0.75, scheduler: DispatchQueue.main)
         */
        
        // multiple publishers/subscribers
        /*
         // .combineLatest will only publish once we have data for all publishers
         //            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
         //            .compactMap({ (int, bool) in
         //                if bool {
         //                    return String(int)
         //                }
         //                return nil
         //            })
         //            .compactMap({ $1 ? String($0) : "n/a" })
         //            .compactMap({ (int1, bool, int2) in
         //                if bool {
         //                    return String(int1)
         //                }
         //                return "n/a"
         //            })
         //            .removeDuplicates()
         //            .merge(with: dataService.intPublisher)
         //            .zip(dataService.boolPublisher, dataService.intPublisher)
         //            .map({ tuple in
         //                return String(tuple.0) + tuple.1.description + String(tuple.2)
         //            })
         //            .tryMap({ int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int
         //            })
         //            .catch({ error in
         //                return self.dataService.intPublisher
         //            })
         */
        
        //
        
        let sharedPublisher = dataService.passthruPublisher
//            .dropFirst(3)
            .share()
            .multicast {
                PassthroughSubject<Int, Error>()
            }
        
        sharedPublisher
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)
        
        sharedPublisher
            .map({ $0 > 5 ? true : false })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
        
    }
    
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    
    var body: some View {
        
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}
