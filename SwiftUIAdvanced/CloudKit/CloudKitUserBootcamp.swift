//
//  CloudKitUserBootcamp.swift.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/18/21.
//

import SwiftUI
import CloudKit

class CloudKitUserBootcampViewModel: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    let container = CKContainer.default()
        
    init() {
        
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        
        container.accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .available:
                    self?.isSignedInToiCloud = true
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID() {
        DispatchQueue.main.async {
            self.container.fetchUserRecordID { [ weak self] returnedId, returnedError in
                
                if let id = returnedId {
                    self?.discoveriCloudUser(id: id)
                }
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID) {

        container.discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
                
            }
        }
    }
}

struct CloudKitUserBootcamp: View {
    
    @StateObject private var vm = CloudKitUserBootcampViewModel()
    
    var body: some View {
        
        VStack {
            Text("Is Signed In: \(vm.isSignedInToiCloud.description.uppercased())")
            
            Text(vm.error)
            Text("Permission status: \(vm.permissionStatus.description.uppercased())")
            Text("Name \(vm.userName)")
        }
    }
}

struct CloudKitUserBootcamp_swift_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUserBootcamp()
    }
}

