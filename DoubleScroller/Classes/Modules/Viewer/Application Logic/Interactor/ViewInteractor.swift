//
//  ViewInteractor.swift
//  DoubleScroller
//
//  Created by Jahid on 2/8/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import UIKit

class ViewInteractor: NSObject, ViewInteractorInput {
    var output: ViewInteractorOutput?
    
    let dataManager: ViewDataManager
    
    init(dataManager: ViewDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchDataItems() {
        
    }
}
