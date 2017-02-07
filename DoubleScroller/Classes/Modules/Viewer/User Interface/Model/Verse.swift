//
//  Verse.swift
//  DoubleScroller
//
//  Created by Jahid on 2/7/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import Foundation

struct Verse: Equatable {
    let DatabaseID: Int
    let SuraID: Int
    let VerseID: Int
    let AyahText: String
}

func == (leftSide: Verse, rightSide: Verse) -> Bool {
    
    if rightSide.DatabaseID != leftSide.DatabaseID || rightSide.SuraID != leftSide.SuraID || rightSide.VerseID != leftSide.VerseID {
        return false
    }
    
    return rightSide.AyahText == rightSide.AyahText
}

extension Verse: CustomStringConvertible {
    var description : String {
        return "Verse \(SuraID):\(VerseID) - \(AyahText)"
    }
}
