//
//  ViewController.swift
//  InstagramAcademy
//
//  Created by HieuTong on 5/1/21.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNoAuthenticated()
    }
    
    private func createMockModels() {
        let user = User(username: "@joe", name: (first: "", last: ""), birthDate: Date(), profilePhoto: URL(string: "https://www.google.com")!, gender: .female, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createDate: Date(), taggedUsers: [], owner: user)
        
        var comments = [PostComment]()
        for x in 0 ..< 2 {
            comments.append(
                PostComment(
                    identifier: "\(x)",
                    username: "@jenny",
                    text: "This is the best post I've seen",
                    createDate: Date(),
                    likes: []))
        }
        
        for _ in 0 ..< 5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), post: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func handleNoAuthenticated() {
        //Check auth status
        if Auth.auth().currentUser == nil {
            // show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
        let model = feedRenderModels[position]

        let subSection = x % 4
        if subSection == 0 {
            //header
            return 1
        } else if subSection == 1 {
            //post
            return 1
        } else if subSection == 2 {
            //actions
            return 1
        } else {
            //comment
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
        let model = feedRenderModels[position]
        
        let subSection = x % 4
        if subSection == 0 {
            //header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .primaryContent, .actions, .comments: return UITableViewCell()

            }
            
        } else if subSection == 1 {
            //post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .header, .actions, .comments: return UITableViewCell()
            }
        } else if subSection == 2 {
            //actions
            switch model.actions.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .header, .primaryContent, .comments: return UITableViewCell()
            }
        } else {
            //comment
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header, .primaryContent, .actions: UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        switch subSection {
            case 0:
                //header
                return 70
            case 1:
                //post
                return tableView.width
            case 2:
                //actions
                return 60
            case 3:
                //comment
                return 50
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func reportPost() {
        
    }
}

extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
    
}

