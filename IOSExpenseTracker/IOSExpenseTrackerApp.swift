//
//  IOSExpenseTrackerApp.swift
//  IOSExpenseTracker
//
//  Created by dremobaba on 2022/12/26.
//

import SwiftUI

@main
struct IOSExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
