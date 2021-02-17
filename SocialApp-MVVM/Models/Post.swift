//
//  Post.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import Foundation

//{
//    "userId": 1,
//    "id": 1,
//    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
//},
struct Post: Decodable {
    
    let id: Int
    
    let userId: Int
    
    let title: String
    
    let body: String
}
