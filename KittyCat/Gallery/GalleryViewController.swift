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
        /*if indexPath.row == imagesUrls.count - 1 {
            getImages(ifFirstSearch: false)
        }*/
        //if imagesUrls.count > indexPath.row {
            let image = imagesUrls[indexPath.row]
            cell.configure(cat: image)
            return cell
        //} else {
           // return GalleryCollectionViewCell()
        //}
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            /*let storyboard = UIStoryboard(name: "BookDetails", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "bookDetailsID") as? BookDetailsViewController
            if let controller = controller {
                controller.takeBookButtonStatus = .booking
                if let cell = booksCollectionView.cellForItem(at: indexPath) as? FoundBookCollectionViewCell, let bookId = cell.bookID {
                    controller.bookID = String(bookId)
                    //collectionView.cellForItem(at: indexPath)?.isUserInteractionEnabled = false
                    controller.selectedCell = indexPath.row
                    controller.searchPage = self
                    navigationController?.pushViewController(controller, animated: true)
                }
            }*/
        
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: view.bounds.width / 2 - collectionView.contentInset.left * 2 - collectionView.contentInset.right * 2, height: 150)
        return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width / 2 - 20) , height: 150)
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
        imagesUrls += viewModel.imageUrls
        collectionView.reloadData()
    }
}
