//
//  FeedCell.swift
//  redditor
//
//  Created by Miguel Fraire on 9/4/21.
//

import UIKit

class FeedCell: UITableViewCell{
    
    static let identifier = "CustomTableViewCell"
    private let states = ["default", "nsfw", "self", "image"]
    private let padding: CGFloat = 10
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.baselineAdjustment = .none
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let thumbnailView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let scoreLabel = DataLabel()
    private let commentLabel = DataLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(titleLabel, thumbnailView, scoreLabel, commentLabel)
        configureTitle()
        configureThumbnail()
        configureScore()
        configureComment()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    var cellViewModel: FeedCellViewModel! {
        didSet {
            titleLabel.text = cellViewModel.title
            
            downloadImage(fromURL: cellViewModel.thumbnail)
            
            scoreLabel.set(itemInfoType: .scores, string: String(cellViewModel.score))
            
            commentLabel.set(itemInfoType: .comments, string: String(cellViewModel.numComments))
        }
    }
    
    
    private func downloadImage(fromURL url: String) {
        guard !states.contains(url) else{
            thumbnailView.image = Images.placeholder
            return
        }
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.thumbnailView.image = image }
        }
    }
//MARK:- UI Configuration Methods
    
    
    private func configureTitle(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
    }
    

    private func configureThumbnail(){
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            thumbnailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75)
        ])
    }
    

    private func configureScore(){
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -50),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
    }
    
    
    private func configureComment(){
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 20),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 50),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
    }
}

