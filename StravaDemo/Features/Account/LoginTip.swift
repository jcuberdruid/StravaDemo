//
//  LoginTip.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import TipKit

struct LoginTip: Tip {
    var title: Text {
        Text("You’re browsing demo data!")
    }
    var message: Text? {
        Text("Check it out! Then login with your Strava account to personalize your experience.")
    }
    var image: Image? {
        Image(systemName: "person.crop.rectangle.badge.plus.fill")
    }
}
