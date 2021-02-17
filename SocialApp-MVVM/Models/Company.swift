//
//  Company.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import Foundation


//    "company": {
//        "name": "Romaguera-Crona",
//        "catchPhrase": "Multi-layered client-server neural-net",
//        "bs": "harness real-time e-markets"
//    }
struct Company: Decodable {
    
    let name: String
    
    let catchPhrase: String
    
    let bs: String
}
