//
//  TransactionListViewModel.swift
//  IOSExpenseTracker
//
//  Created by dremobaba on 2022/12/26.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String,Double)]

final class TransactionListViewModel : ObservableObject {
    
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data,response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: {[weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
        
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        //returns an empty dictionary if transaction is empty
        guard !transactions.isEmpty else {return [:]}
        
        let groupTransactions = TransactionGroup(grouping: transactions, by: {$0.month})
        return groupTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("accumulateTransactions")
        guard !transactions.isEmpty else {return []}
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval",dateInterval)
        
        var sum:Double  = .zero
        var cummulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter({ $0.isExpense  && $0.dateParsed == date})
            let dailyTotal = dailyExpenses.reduce(0, {$0 - $1.signedAmount})
            
            sum += dailyTotal
            sum = sum.roundToTwoDecima()
            cummulativeSum.append((date.formatted(), sum))
            print("\(date.formatted()) dailyTotal \(dailyTotal) sum: \(sum)")
        }
        return cummulativeSum
        
    }
}
