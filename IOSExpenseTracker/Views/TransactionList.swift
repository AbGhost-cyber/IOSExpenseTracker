//
//  TransactionList.swift
//  IOSExpenseTracker
//
//  Created by dremobaba on 2022/12/27.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject private var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key){
                    month, transactions in
                    Section {
                        ForEach(transactions) {transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                    }
//                    .listSectionSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    } ()
    
    static var previews: some View {
        NavigationView {
            TransactionList()
                .environmentObject(transactionListVM)
        }
    }
}
