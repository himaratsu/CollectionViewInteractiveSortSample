//
//  ViewController.swift
//  CollectionViewInteractiveSortSample
//
//  Created by 平松　亮介 on 2016/07/20.
//  Copyright © 2016年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var scrollModeButton: UIBarButtonItem!
    
    var photos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPhotos()
    }
    
    private func setUpPhotos() {
        photos = []
        for i in 0...20 {
            if let image = UIImage(named: "photo\(i % 10)") {
                photos.append(image)
            }
        }
    }
    
    @IBAction private func scrollModeSwtichButtonTouched(_ sender: AnyObject) {
        collectionView.isPagingEnabled = !collectionView.isPagingEnabled
        scrollModeButton.title = collectionView.isPagingEnabled ? "Paging" : "Normal"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let destVC = segue.destinationViewController as? DetailViewController,
                cell = sender as? PhotoCell,
                indexPath = collectionView.indexPath(for: cell) {
                destVC.image = photos[indexPath.row]
            }
        }
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.delegate = self
        let identifier = NSString(format: "%.3ld", indexPath.row) as String
        cell.configure(collectionView: collectionView, image: photos[indexPath.row], identifier: identifier)
        return cell
    }
    
    @objc(collectionView:canMoveItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        // update model
        let targetPhoto = photos[sourceIndexPath.row]
        photos.remove(at: sourceIndexPath.row)
        photos.insert(targetPhoto, at: destinationIndexPath.row)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.bounds.size
        if indexPath.row == 0 {
            return CGSize(width: collectionViewSize.width, height: collectionViewSize.height/4)
        } else {
            return CGSize(width: collectionViewSize.width/2, height: collectionViewSize.height/4)
        }
    }
}

extension ViewController: PhotoCellDelegate {
    func didStartLongPress(position: CGPoint) {
        if let indexPath = collectionView.indexPathForItem(at: position) {
            let success = collectionView.beginInteractiveMovementForItem(at: indexPath)
            print("success is \(success)")
        }
    }
    
    func didChangeLongPress(position: CGPoint) {
        collectionView.updateInteractiveMovementTargetPosition(position)
    }
    
    func didEndLongPress(position: CGPoint) {
        collectionView.endInteractiveMovement()
    }
    
    func didCancelLongPress(position: CGPoint) {
        collectionView.endInteractiveMovement()
    }
}
