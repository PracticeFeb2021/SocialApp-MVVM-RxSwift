//
//  PostVC.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import UIKit
import RxSwift
import RxCocoa


class PostVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var postAuthorLabel: UILabel!
    
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var commentsTableConstraint: NSLayoutConstraint!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel: PostViewModel!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - View lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateScrollViewContentSize()
    }
    
    func setupUI() {
        commentsTableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: CommentCell.cellReuseId)
        commentsTableView.insertSubview(refreshControl, at: 0)
    }
    
    //MARK: - Setup
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        viewModel.post.drive(onNext: { [weak self] post in
            self?.setPost(post)
        }).disposed(by: disposeBag)
        
        
        viewModel.comments
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .drive(commentsTableView.rx.items(cellIdentifier: CommentCell.cellReuseId, cellType: CommentCell.self)) { _, comment, cell in
                cell.configure(with: comment)
            }
            .disposed(by: disposeBag)
        
        
        viewModel.user
            .observe(on: MainScheduler.instance)
            .map{$0.name}
            .bind(to: postAuthorLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    //MARK: - Private
    
    private func updateScrollViewContentSize(){
        
        commentsTableConstraint.constant = commentsTableView.contentSize.height + 20.0
        var heightOfSubViews: CGFloat = 0.0
        contentView.subviews.forEach { subview in
            if let tableView = subview as? UITableView {
                heightOfSubViews += (tableView.contentSize.height + 20.0)
            } else {
                heightOfSubViews += subview.frame.size.height
            }
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: heightOfSubViews)
    }
    
    private func setPost(_ post: Post) {
        postTitleLabel.text = post.title
        postBodyLabel.text = post.body
    }
}
