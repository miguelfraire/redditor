//
//  FeedVC.swift
//  redditor
//
//  Created by Miguel Fraire on 9/4/21.
//

import UIKit

class FeedVC: RDataLoadingVC {
    
    lazy var viewModel = {
        FeedViewModel()
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
        configureTableView()
        initViewModel()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.pinToEdges(of: view)
    }
    
    
    func initViewModel(){
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.showLoading = {
            self.showLoadingView()
        }
        
        viewModel.hideLoading = {
            self.dismissLoadingView()
        }
        
        viewModel.showError = { error in
            self.presentAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Dismiss")
        }
        
        viewModel.getData()
    }
}
//MARK: - UITableView Delegate and DataSource Methods

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.FeedCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: viewModel.posts[indexPath.row].data.url){
            UIApplication.shared.open(url)
        }
    }
}
//MARK: - UIScrollViewDelegate

extension FeedVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height){
            if !viewModel.isLoadingMoredata{
                viewModel.getData()
            }
        }
    }
}
