//
//  PhotoCellViewModel.swift
//  nasa_app
//
//  Created by Grady Jenkins on 12/22/18.
//  Copyright © 2018 Grady Jenkins. All rights reserved.
//

import Foundation
class PhotoCellViewModel {
    
    // MARK: - Private variables
    private let photo: Photo
    
    // MARK: - Events
    var imageUrlDidUpdate: (() -> Void)?
    
    // MARK: - Properties
    var imageUrl: URL? {
        didSet {
            imageUrlDidUpdate?()
        }
    }
    
    // MARK: - Setup/initializers
    init(photo: Photo) {
        self.photo = photo
    }
    
    func setupProperties() {
        imageUrl = URL(string: photo.hdurl)
    }
}
