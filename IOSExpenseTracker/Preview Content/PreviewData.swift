//
//  PreviewData.swift
//  IOSExpenseTracker
//
//  Created by dremobaba on 2022/12/26.
//

import Foundation
var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "ok", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: false, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
