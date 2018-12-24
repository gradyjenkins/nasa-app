//
//  CollectionListViewModel.swift
//  nasa_app
//
//  Created by Grady Jenkins on 12/20/18.
//  Copyright © 2018 Grady Jenkins. All rights reserved.
//

import Foundation
class PhotoListViewModel {
    
    private(set) var client: QueryService
    
    private(set) var photos: [Photo]? {
        didSet {
            didPhotosUpdate?()
        }
    }
    
    init(client: QueryService) {
        self.client = client
    }
    
    var didPhotosUpdate: (() -> Void)?
    var didError: ((String?) -> Void)?
    
    // MARK: - Networking
    func fetchData() {
        client.fetch(url: Constants.apiEndpoint, completion: { [weak self] (data: [Photo]) in
            self?.photos = data
            }, onError: { [weak self] (error) in
                self?.photos = []
                self?.didError?(error)
        })
    }
}
