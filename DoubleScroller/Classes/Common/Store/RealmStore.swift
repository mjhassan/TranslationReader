//
//  RealmStore.swift
//  DoubleScroller
//
//  Created by Jahid on 2/7/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import Foundation
import RealmSwift

func realmBundleURL(_ name: String) -> URL? {
    return Bundle.main.url(forResource: name, withExtension: "realm")
}

class RealmStore: NSObject {
    public let shared: RealmStore = RealmStore()
    
    private var realm: Realm;
    
    override init() {
        RealmStore.openRealm()
        realm = try! Realm()
        
        super.init()
    }
    
    private static func openRealm() {
        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        
        if let qURL = realmBundleURL("quran") {
            do {
                try FileManager.default.removeItem(at: defaultURL)
                try FileManager.default.copyItem(at: qURL, to: defaultURL)
            } catch { }
        }
        else {
            print("No realm database found")
        }
    }
    
    private func store(_ object: VerseRO) {
        realm.beginWrite()
        realm.add(object)
        try! realm.commitWrite()
    }
    
    func verses(at dbId: Int) -> [VerseRO] {
        let results = realm.objects(VerseRO.self).filter("DatabaseID == \(dbId)")
        return Array(results)
    }
    
    func verses(at dbId: Int, suraId: Int) -> [VerseRO] {
        let results = realm.objects(VerseRO.self).filter("DatabaseID == \(dbId)").filter("SuraID == \(suraId)")
        return Array(results)
    }
    
    func verse(at dbId: Int, suraId: Int, verseId: Int) -> VerseRO? {
        let results = realm.objects(VerseRO.self)
                            .filter("DatabaseID == \(dbId)")
                            .filter("SuraID == \(suraId)")
                            .filter("VerseID == \(verseId)")
        
        return results.first
    }
    
    func verses(contains searchStr: String?) -> [VerseRO]? {
        guard searchStr?.isEmpty == true else {
            return nil
        }
        
        let results = realm.objects(VerseRO.self).filter(NSPredicate(format: "AyahText contains '%@'", searchStr!))
        
        return Array(results)
    }
    
    func verseCount(at dbId: Int, suraId: Int) -> Int {
        return self.verses(at: dbId, suraId: suraId).count
    }
}
