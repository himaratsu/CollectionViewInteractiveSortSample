//
//  PhotoCell.swift
//  CollectionViewInteractiveSortSample
//
//  Created by 平松　亮介 on 2016/07/20.
//  Copyright © 2016年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    func didStartLongPress(position: CGPoint)
    func didChangeLongPress(position: CGPoint)
    func didEndLongPress(position: CGPoint)
    func didCancelLongPress(position: CGPoint)
}

class PhotoCell: UICollectionViewCell {
    
    weak var delegate: PhotoCellDelegate?
    private var collectionView: UICollectionView?
    @IBOutlet weak private var thumbImageView: UIImageView!
    @IBOutlet weak private var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        addGestureRecognizer(longPressGesture)
    }
    
    func longPressed(gestureRecognizer: UILongPressGestureRecognizer) {
        let position = gestureRecognizer.location(in: self)
        let convertedPosition = convert(position, to: collectionView)
        
        switch gestureRecognizer.state {
        case .began:
            delegate?.didStartLongPress(position: convertedPosition)
        case .changed:
            delegate?.didChangeLongPress(position: convertedPosition)
        case .ended:
            delegate?.didEndLongPress(position: convertedPosition)
        case .cancelled, .failed:
            delegate?.didCancelLongPress(position: convertedPosition)
        case .possible:
            break   // do nothing
        }
    }
    
    func configure(collectionView: UICollectionView, image: UIImage, identifier: String) {
        self.collectionView = collectionView
        thumbImageView.image = image
        idLabel.text = identifier
    }
}
