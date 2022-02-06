//
//  NetworkService.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 08.01.2022.
//  Copyright © 2022 Vladimir Bulakhov. All rights reserved.
//

import Foundation

class NetworkService {
    
    static func getBlockChain(completion: @escaping ((Blockchain)->())) {
        
        let url = URL(string: "http://localhost:5000/chain")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            guard let blockChain = try? decoder.decode(Blockchain.self, from: data) else { return }
            completion(blockChain)
        }.resume()
        
    }
    
    static func checkHash(uniqID: String, completion: @escaping ((Transaction?)->())) {
        let url = URL(string: "http://localhost:5000/chain")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let blockChain = try? decoder.decode(Blockchain.self, from: data)
            let block = blockChain?.chain.first { $0.transactions.first?.uniqID == uniqID }
            completion(block?.transactions.first { $0.uniqID == uniqID } )
        }.resume()
    }
    
    static func sendNewTransaction(transation: Transaction) {
        
        let url = URL(string: "http://localhost:5000/transactions/new")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try! encoder.encode(transation)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let stringData = String(data: data, encoding: .utf8)
            print(stringData)
        }.resume()
        
    }
    
}
