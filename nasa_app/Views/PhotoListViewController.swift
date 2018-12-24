//
//  CollectionViewController.swift
//  nasa_app
//
//  Created by Grady Jenkins on 12/20/18.
//  Copyright © 2018 Grady Jenkins. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel: PhotoListViewModel!
    
    // MARK: - Initializer
    required convenience init(viewModel: PhotoListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Properties
    private let itemsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.cellId)
        table.separatorStyle = .none
        return table
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error occurred."
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.textAlignment = NSTextAlignment.center
        label.accessibilityIdentifier = "errorLabel"
        return label
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.accessibilityIdentifier = "tableView"
        setupViewModel()
        setupTableView()
        setupUI()
        viewModel.fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.viewModel.photos else {
            return 0
        }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.cellId, for: indexPath) as! PhotoCell
        guard let photo = self.viewModel.photos?[indexPath.row] else {
            return UITableViewCell()
        }
        let viewModel = PhotoCellViewModel(photo: photo)
        cell.viewModel = viewModel
        cell.delegate = self
        cell.setupViewModel()
        viewModel.setupProperties()
        return cell
    }
    
    // MARK: - Private methods
    private func setupViewModel() {
        viewModel.didPhotosUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.itemsTableView.reloadData()
            }
        }
        
        viewModel.didError = { [weak self] (error) in
            self?.presentViewModelError(error: error)
        }
    }
    
    private func setupTableView() {
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self
    }
    
    private func presentViewModelError(error: String?) {
        guard let message = error else {
            return
        }
        self.setupErrorMessage(message)
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.addSubview(self.itemsTableView)
        
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                itemsTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                itemsTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                itemsTableView.topAnchor.constraint(equalTo: guide.topAnchor),
                itemsTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
                ])
        } else {
            let guide = view.layoutMarginsGuide
            NSLayoutConstraint.activate([
                itemsTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                itemsTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                itemsTableView.topAnchor.constraint(equalTo: guide.topAnchor),
                itemsTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
                ])
        }
    }
    
    private func setupErrorMessage(_ error: String) {
        errorMessageLabel.text = error
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        self.itemsTableView.backgroundView = errorMessageLabel
    }
}
