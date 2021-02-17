//
//  NetworkManager.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import Foundation
import RxSwift
import RxCocoa


protocol NetworkingService {
    
    func loadPosts() -> Single<[Post]>
    func loadUsers() -> Single<[User]>
    func loadComments() -> Single<[Comment]>
    
    func loadUser(with id: Int) -> Single<User>
    func loadComments(forPostWithID id: Int) -> Single<[Comment]>
}

class NetworkManager: NetworkingService {
    static let shared: NetworkManager = { .init() }()
    
    
    func loadPosts() -> Single<[Post]> {
        load(.posts)
    }
    
    func loadUsers() -> Single<[User]> {
        load(.users)
    }
    func loadComments() -> Single<[Comment]> {
        load(.comments)
    }
    
    func loadUser(with id: Int) -> Single<User> {
        loadUsers().flatMap { users in
            Single<User>.create { single in
                if let user = users.first(where: {$0.id == id}) {
                    single(.success(user))
                } else {
                    single(.failure(RxError.noElements))
                }
                return Disposables.create {}
            }
        }
    }
    func loadComments(forPostWithID id: Int) -> Single<[Comment]> {
        loadComments().map {
            $0.filter{$0.postId == id}
        }
    }
    
    func load<T: Decodable>(_ endPoint: EndPoint) -> Single<T> {
        let request = endPoint.makeURLRequest()
        return URLSession.shared.rx
            .response(request: request)
            .map{ _, data in data }
            .decode(type: T.self, decoder: JSONDecoder()).asSingle()
    }
}

