//
//  PostViewModel.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import UIKit
import RxSwift
import RxCocoa


class PostViewModel {
    
    //MARK: - Inputs
    
    private let _post: BehaviorRelay<Post>
    var post: Driver<Post> {
        return _post.asDriver()
    }
    
    //MARK: - Outputs
    
    let reload = PublishSubject<Void>()
    
    let user: Observable<User>
    let comments: Driver<[Comment]>
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Dependencies
    
    let netService: NetworkingService
    
    init(_ netService: NetworkingService, _ post: Post) {
        self.netService = netService
        
        self._post = .init(value: post)
        
        user = _post.flatMap { post in
            netService.loadUser(with: post.userId)
        }
        
        comments = _post.flatMap { post in
            netService.loadComments(forPostWithID: post.id)
        }.asDriver(onErrorJustReturn: [])
    }
}

