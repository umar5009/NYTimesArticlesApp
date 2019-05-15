//
//  Globals.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/14/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import Foundation
import SKActivityIndicatorView

var urlLink = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=iBr5vFYmta2Z8NAgTuGQQa2x7lsSFYTK"
//?apikey=Jj7pRJV1jp1IggounblnobvMeAxFbIdz
var apiCalledOnce = false

let defaults = UserDefaults.standard

public func startActivityIndicator(_ message: String)
{
    // default is darkGray
    SKActivityIndicator.spinnerColor(UIColor.black)
    SKActivityIndicator.show(message)
}

public func stopActivityIndicator()
{
    SKActivityIndicator.dismiss()
}
