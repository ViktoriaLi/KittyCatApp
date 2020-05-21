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
    //@IBOutlet weak var scrollView: UIScrollView!
    
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
        //scrollView.delegate = self

        if let image = imageToDisplay {
            imageView.loadImage(from: image)
            /*let widthScale = view.bounds.size.width / imageView.bounds.width
            let heightScale = view.bounds.size.height / imageView.bounds.height
            let scale = min(widthScale,heightScale)
            scrollView.minimumZoomScale = scale
            scrollView.contentSize = .init(width: 2000, height: 2000)*/
            
        }

        /*scrollView.addSubview(imageView)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        view.addSubview(scrollView)*/
    }
    
    func getImages(id: String) {
        //let request = FullImageView.GetImage.Request(id: id)
        //interactor?.getImage(request: request)
    }
}

extension FullImageViewController: FullImageViewDisplayLogic {
    
    func displayImage(viewModel: FullImageView.GetImage.ViewModel) {
        imageView.loadImage(from: viewModel.url)
    }
}

