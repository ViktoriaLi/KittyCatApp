//
//  GalleryViewController.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol GalleryViewDisplayLogic: class {
    func displayImages(viewModel: GalleryView.GetImages.ViewModel)
    func showErrorView(viewModel: GalleryView.GetErrorView.ViewModel)
}

class GalleryViewController: UICollectionViewController {

    var imagesUrls = [ShortImageModel]()
    var interactor: GalleryBusinessLogic?
    
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
        let interactor = GalleryViewInteractor()
        let presenter = GalleryViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
        getImages(ifFirstSearch: true)
    }
    
    func getImages(ifFirstSearch: Bool) {
        let request = GalleryView.GetImages.Request(ifFirstSearch: ifFirstSearch)
        interactor?.getImages(request: request)
    }
}

extension GalleryViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrls.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? GalleryCollectionViewCell else {
                return GalleryCollectionViewCell()
            }
        let image = imagesUrls[indexPath.row]
        cell.configure(cat: image)
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imagesUrls.count - 2 {
            getImages(ifFirstSearch: false)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "FullImage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "fullImageId") as? FullImageViewController
        if let vc = controller, indexPath.row < imagesUrls.count {
            vc.imageToDisplay = imagesUrls[indexPath.row].url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: (collectionView.frame.width / 2 - layout.minimumInteritemSpacing * 2) , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

extension GalleryViewController: GalleryViewDisplayLogic {
    
    func displayImages(viewModel: GalleryView.GetImages.ViewModel) {
        let lastIndex = imagesUrls.count
        imagesUrls += viewModel.imageUrls
        let indexes = (lastIndex)...(imagesUrls.count - 1)
        let indexPathArray = indexes.map{IndexPath(row: $0, section: 0)}
        self.collectionView.insertItems(at: indexPathArray)
    }
    
    func showErrorView(viewModel: GalleryView.GetErrorView.ViewModel) {
        imagesUrls = []
        DispatchQueue.main.async {
            self.collectionView.backgroundView = SomethingWrongView(delegate: self, frame: CGRect(x: self.collectionView.frame.minX, y: self.collectionView.frame.minY, width: self.collectionView.frame.width, height: self.collectionView.frame.height))
            self.collectionView.reloadData()
        }
    }
}

extension GalleryViewController: ErrorViewDelegate {
    
    func tryAgain() {
        imagesUrls = []
        getImages(ifFirstSearch: true)
    }
}
