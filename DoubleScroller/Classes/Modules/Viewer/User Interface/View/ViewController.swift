//
//  ViewController.swift
//  DoubleScroller
//
//  Created by Jahid Hassan on 2/6/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController {
    
    var eventHandler: ViewModuleInterface?

    // IBOutlets
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    // Contants
    fileprivate let cellNib = "VerseViewCell"
    fileprivate let cellIdentifier = "VerseCellIdentifier"
    
    // MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstCollectionView.register(UINib(nibName: cellNib, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        secondCollectionView.register(UINib(nibName: cellNib, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        adjustViewOnOrientation()
        eventHandler?.updateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: {
            self.adjustViewOnOrientation()
        })
    }
    
    // MARK:- private methods
    private func adjustViewOnOrientation() {
        let orientation = UIApplication.shared.statusBarOrientation
        
        if orientation == .portrait {
            secondCollectionView <- [
                Left().to(view),
                Top().to(firstCollectionView)
            ]
        } else {
            secondCollectionView <- [
                Left().to(firstCollectionView),
                Top().to((navigationController?.navigationBar)!, .bottom)
            ]
        }
        
        updateCollectionView()
    }
    
    private func updateCollectionView() {
        firstCollectionView.performBatchUpdates({ 
            let layout = self.firstCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            self.firstCollectionView.collectionViewLayout.invalidateLayout()
            
            layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            layout.minimumInteritemSpacing = 0.0
            layout.minimumLineSpacing = 0.0
            
            self.firstCollectionView.setCollectionViewLayout(layout, animated: false)
        }, completion: {
            finish in
            
            self.firstCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: {
                self.synchronizeColloctionViews(self.firstCollectionView)
            })
        })
        
        secondCollectionView.performBatchUpdates({
            let layout = self.secondCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            self.secondCollectionView.collectionViewLayout.invalidateLayout()
            
            layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            layout.minimumInteritemSpacing = 0.0
            layout.minimumLineSpacing = 0.0
            
            self.secondCollectionView.setCollectionViewLayout(layout, animated: false)
        }, completion: {
            finish in
            
            self.secondCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: { 
                self.synchronizeColloctionViews(self.secondCollectionView)
            })
        })
    }
    
    fileprivate func synchronizeColloctionViews(_ collectionView: UICollectionView) {
        print("scrolling: ")
        if let index = collectionView.indexPathsForVisibleItems.first {
            if collectionView == firstCollectionView {
                print("2")
                secondCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            } else if collectionView == secondCollectionView {
                print("1")
                firstCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            } else {
                print("both")
                firstCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                secondCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
            
            print("setting index")
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! VerseViewCell
        
        cell.setVerse = "index: \(indexPath.item)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else {
            print("not convertable")
            return
        }
        
        synchronizeColloctionViews(collectionView)
    }
}

extension ViewController: ViewInterface {
    
}
