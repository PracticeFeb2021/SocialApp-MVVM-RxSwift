//
//  PostListVC.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import UIKit
import RxSwift
import RxCocoa


class PostListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel: PostListViewModel!
    
    var netService: NetworkingService!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    func setupUI(){
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Posts"
        
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: PostCell.cellReuseId)
        
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    //MARK: - Setup
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.posts.asDriver()
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .drive(tableView.rx.items(cellIdentifier: PostCell.cellReuseId, cellType: PostCell.self)) { _, post, cell in
                cell.configure(with: post)
            }
            .disposed(by: disposeBag)
        
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Post.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] selectedPost in
                guard let weakSelf = self else {
                    return
                }
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PostVC") as! PostVC
                vc.viewModel = PostViewModel(weakSelf.netService, selectedPost)
                weakSelf.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}
