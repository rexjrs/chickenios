//
//  MediaController.swift
//  chickenapp
//
//  Created by Thomas on 8/29/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MediaController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!
    
    var images = [] as Array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingSpinner.hidesWhenStopped = true
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        getMedia(){success in
            for item in success{
                if let url = item["image"]{
                    self.images.append(url)
                }
            }
            self.loadingSpinner.stopAnimating()
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCells", for: indexPath) as! MediaCell
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowRadius = 2
        cell.mediaImage.sd_setImage(with: URL(string: images[indexPath.row] as! String))
        return cell
    }
    
}
