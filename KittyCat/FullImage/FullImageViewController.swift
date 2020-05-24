//
//  FullImageViewController.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol FullImageViewDisplayLogic: class {
    func displayImage(viewModel: FullImageView.GetImage.ViewModel)
}

class FullImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageToDisplay: String?
    var interactor: FullImageBusinessLogic?
    
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
        let interactor = FullImageViewInteractor()
        let presenter = FullImageViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = imageToDisplay {
            imageView.loadImage(from: image)
        }
    }
}

extension FullImageViewController: FullImageViewDisplayLogic {
    
    func displayImage(viewModel: FullImageView.GetImage.ViewModel) {
        imageView.loadImage(from: viewModel.url)
        if imageView.image == nil {
            imageView.image = UIImage(named: "if_no_image")
        }
    }
}

