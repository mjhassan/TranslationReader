//
//  ViewPresenter.swift
//  DoubleScroller
//
//  Created by Jahid on 2/7/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.
//

import UIKit

class ViewPresenter: NSObject, ViewInteractorOutput, ViewModuleInterface {
    var viewInteractor: ViewInteractorInput?
    var userInterface: ViewInterface?
    
    weak var viewWireframe: ViewWireframe?
    
    func updateView() {
        
    }
}
