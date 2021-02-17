//
//  PostListViewModel.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import UIKit
import RxSwift
import RxCocoa


class PostListViewModel {
    
    //MARK: - Inputs
    
    let reload = PublishSubject<Void>()

    //MARK: - Outputs

    private let _posts = BehaviorRelay<[Post]>(value: [])
    var posts: Driver<[Post]> {
        return _posts.asDriver()
    }
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Dependencies
    
    let netService: NetworkingService
    
    init(_ netService: NetworkingService) {
        self.netService = netService
        
        reload.flatMapLatest {
            
            netService.loadPosts()
        }.subscribe(onNext: { [weak self] posts in
            
            self?._posts.accept(posts)
        }).disposed(by: disposeBag)
    }
}

