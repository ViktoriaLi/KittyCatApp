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
    func showErrorView(viewModel: BreedsListView.GetErrorView.ViewModel)
}

class BreedsListViewController: UITableViewController {

    var breeds = [BreedModel]()
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
        let storyboard = UIStoryboard(name: "BreedDetail", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "breedDetailID") as? BreedDetailViewController
        if let vc = controller, indexPath.row < breeds.count {
            vc.breedToDisplay = breeds[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BreedsListViewController: BreedsListViewDisplayLogic {
    
    func fillBreedsList(viewModel: BreedsListView.GetBreeds.ViewModel) {
        breeds = viewModel.breeds
        tableView.separatorStyle = .singleLine
        tableView.reloadData()
    }

    func showErrorView(viewModel: BreedsListView.GetErrorView.ViewModel) {
        DispatchQueue.main.async {
            self.tableView.backgroundView = SomethingWrongView(delegate: self, frame: CGRect(x: self.tableView.frame.minX, y: self.tableView.frame.minY, width: self.tableView.frame.width, height: self.tableView.frame.height))
            self.tableView.separatorStyle = .none
            self.tableView.reloadData()
        }
    }
}

extension BreedsListViewController: ErrorViewDelegate {
    
    func tryAgain() {
        getBreeds()
    }
}
