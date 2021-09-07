//
//  FeedCellViewModel.swift
//  redditor
//
//  Created by Miguel Fraire on 9/6/21.
//

import Foundation
import UIKit

struct FeedCellViewModel: Equatable {
    let title: String
    let thumbnail: String
    let score: Int
    let numComments: Int
}
