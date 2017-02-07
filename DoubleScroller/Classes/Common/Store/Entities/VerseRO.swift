//
//  Verse.swift
//  DoubleScroller
//
//  Created by Jahid on 2/6/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import Foundation
import RealmSwift

// RO - RealmObject
class VerseRO: Object {
    dynamic var DatabaseID: Int = 0
    dynamic var SuraID: Int = 0
    dynamic var VerseID: Int = 0
    dynamic var AyahText: String = ""
}
