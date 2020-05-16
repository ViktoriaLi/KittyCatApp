//
//  FirstViewController.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit


protocol BreedsListViewDisplayLogic: class {
    func fillBreedsList(viewModel: BreedsListView.GetBreeds.ViewModel)
}

class BreedsListViewController: UITableViewController {

    var breeds = [ShortBreedModel]()
    var interactor: BreedsListBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = BreedsListViewInteractor()
        let presenter = BreedsListViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBreeds()
        
    }

    func getBreeds() {
        let request = BreedsListView.GetBreeds.Request()
        interactor?.getBreeds(request: request)
    }

}

extension BreedsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel!.text = breeds[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BreedsListViewController: BreedsListViewDisplayLogic {
    
    func fillBreedsList(viewModel: BreedsListView.GetBreeds.ViewModel) {
        breeds = viewModel.breeds
        tableView.reloadData()
    }

}
