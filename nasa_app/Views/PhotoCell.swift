//
//  PhotoCell.swift
//  nasa_app
//
//  Created by Grady Jenkins on 12/22/18.
//  Copyright © 2018 Grady Jenkins. All rights reserved.
//

import Foundation
import UIKit
class PhotoCell: UITableViewCell {
    static let cellId = "PhotoCellId"
    var viewModel: PhotoCellViewModel!
    
    //Item's image
    var photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    // MARK: - Initializers/Setup
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupViewModel() {
        viewModel.imageUrlDidUpdate = { [weak self] in
            guard let url = self?.viewModel.imageUrl else { return }
            self?.photoImageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    // MARK: - Private methods
    
    //Setup for UI. Add view objects to view and create constraints. Add gesture recognizer to imageview.
    private func setupUI() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTap))
        itemImageView.addGestureRecognizer(gestureRecognizer)
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTitleLabel)
        
        if #available(iOS 11.0, *) {
            let guide = contentView.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                itemImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor),
                itemImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                itemImageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                itemImageView.topAnchor.constraint(equalTo: guide.topAnchor),
                itemImageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
                
                itemTitleLabel.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: -5),
                itemTitleLabel.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: -16)
                ])
        } else {
            let guide = contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                itemImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor),
                itemImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                itemImageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                itemImageView.topAnchor.constraint(equalTo: guide.topAnchor),
                itemImageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
                
                itemTitleLabel.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: -5),
                itemTitleLabel.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: -16)
                ])
        }
    }
}
