//
//  DetailViewController.swift
//  CollectionViewInteractiveSortSample
//
//  Created by 平松　亮介 on 2016/07/20.
//  Copyright © 2016年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak private var imageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
