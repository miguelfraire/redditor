//
//  FeedViewModel.swift
//  redditor
//
//  Created by Miguel Fraire on 9/6/21.
//

import Foundation

class FeedViewModel {
    
    var pageString: String?
    var isLoadingMoredata: Bool = false
    
    var reloadTableView: (()->Void)?
    var showError: ((RError)->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var posts = [Child]()
    
    var FeedCellViewModels = [FeedCellViewModel]() {
        didSet{
            reloadTableView?()
        }
    }
    
    func getData(){
        isLoadingMoredata = true
        showLoading?()
        NetworkManager.shared.getData(page: pageString) {[weak self] result in
            guard let self = self else { return }
            self.hideLoading?()
            switch result{
                case .success(let collection):
                    self.pageString = collection.data.after
                    self.posts.append(contentsOf: collection.data.children)
                    self.FeedCellViewModels.append(contentsOf: collection.data.children.map({return self.createCellModel(post: $0.data)}))
                case .failure(let error):
                    self.showError?(error)
            }
            self.isLoadingMoredata = false
        }
    }
    
    func createCellModel(post: ChildData) -> FeedCellViewModel{
        let title = post.title
        let thumbnail = post.thumbnail ?? "default"
        let numComments = post.numComments
        let score = post.score
        
        return FeedCellViewModel(title: title, thumbnail: thumbnail, score: score, numComments: numComments)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FeedCellViewModel{
        return FeedCellViewModels[indexPath.row]
    }
}
