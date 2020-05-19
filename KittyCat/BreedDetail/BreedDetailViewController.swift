//
//  BreedDetailViewController.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol BreedDetailViewDisplayLogic: class {
    func displayImage(viewModel: BreedDetailView.GetImage.ViewModel)
}

class BreedDetailViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var hypoallergenicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var breedToDisplay: BreedModel?
    
    var interactor: BreedDetailBusinessLogic?
    
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
        let interactor = BreedDetailViewInteractor()
        let presenter = BreedDetailViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let breed = breedToDisplay {
            self.navigationItem.title = breed.name
            getImageUrl(breedId: breed.id)
            temperamentLabel.text = "Temperament: \(breed.temperament)"
            originLabel.text = "Origin: \(breed.origin)"
            if breed.hypoallergenic == 1 {
                hypoallergenicLabel.text = "HypoallergenicLabel: Yes"
            } else {
                hypoallergenicLabel.text = "HypoallergenicLabel: No"
            }
            descriptionLabel.text = breed.description
        }
    }
    
    func getImageUrl(breedId: String) {
        let request = BreedDetailView.GetImage.Request(breedId: breedId)
        interactor?.getImageUrl(request: request)
    }

}

extension BreedDetailViewController: BreedDetailViewDisplayLogic {
    
    func displayImage(viewModel: BreedDetailView.GetImage.ViewModel) {
        catImageView.loadImage(from: viewModel.imageUrl)
    }
}
