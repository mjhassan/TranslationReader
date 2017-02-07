//
//  ViewDataManager.swift
//  DoubleScroller
//
//  Created by Jahid on 2/7/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import UIKit

class ViewDataManager: NSObject {
    weak var dataStore: RealmStore?
    
    func allVerses(at dbId: Int, completion: (([Verse]?) -> Void)?) {
        guard let verses = (dataStore?.verses(at: dbId).map {
            Verse(DatabaseID: $0.DatabaseID,
                  SuraID: $0.SuraID,
                  VerseID: $0.VerseID,
                  AyahText: $0.AyahText)
        }) else {
            completion?(nil)
            return
        }
        
        completion?(Array(verses))
    }
    
    func allVerses(at dbId: Int, suraId: Int, completion: (([Verse]?) -> Void)?) {
        guard let verses = (dataStore?.verses(at: dbId, suraId: suraId).map {
            Verse(DatabaseID: $0.DatabaseID,
                  SuraID: $0.SuraID,
                  VerseID: $0.VerseID,
                  AyahText: $0.AyahText)
            }) else {
                completion?(nil)
                return
        }
        
        completion?(Array(verses))
    }
    
    func verse(at dbId: Int, suraId: Int, verseId: Int, completion: ((Verse?) -> Void)?) {
        guard let verseRO = dataStore?.verse(at: dbId, suraId: suraId, verseId: verseId) else {
            completion?(nil)
            return
        }
        
        let verse = Verse(DatabaseID: verseRO.DatabaseID,
                          SuraID: verseRO.SuraID,
                          VerseID: verseRO.VerseID,
                          AyahText: verseRO.AyahText)
        
        completion?(verse)
    }
    
    func allVerses(contains searchStr: String, completion: (([Verse]?) -> Void)?) {
        guard searchStr.isEmpty == true else {
            completion?(nil)
            return
        }
        
        guard let verseROs = dataStore?.verses(contains: searchStr) else {
            completion?(nil)
            return
        }
        
        let verses = verseROs.map {
            Verse(DatabaseID: $0.DatabaseID,
                  SuraID: $0.SuraID,
                  VerseID: $0.VerseID,
                  AyahText: $0.AyahText)
        }
        
        completion?(Array(verses))
    }
}
