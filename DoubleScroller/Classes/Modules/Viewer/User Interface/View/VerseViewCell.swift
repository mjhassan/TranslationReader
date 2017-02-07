//
//  VerseViewCell.swift
//  DoubleScroller
//
//  Created by Jahid Hassan on 2/6/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import UIKit

class VerseViewCell: UICollectionViewCell {

    @IBOutlet weak var tvVerseView: UITextView!

    var setVerse: String? {
        set {
            tvVerseView.text = newValue
            
            alignTextVerticalInTextView(textView: tvVerseView)
        }
        get {
            return tvVerseView.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    func alignTextVerticalInTextView(textView :UITextView) {
        
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat(MAXFLOAT)))
        
        var topOffset = (textView.bounds.size.height - size.height * textView.zoomScale) / 2.0
        topOffset = topOffset < 0.0 ? 0.0 : topOffset
        
        DispatchQueue.main.async {
            textView.contentOffset = CGPoint(x: 0, y: -topOffset)
        }
    }
    

}
