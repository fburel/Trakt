//
//  Poster.swift
//  Trakt
//
//  Created by Florian BUREL on 05/06/2014.
//  Copyright (c) 2014 Florian Burel. All rights reserved.
//

import Foundation

class Show : NSObject
{
    var title : String;
    var overview : String?;
    var posterURL : String?;
    var imageData : NSData?;
    
    init(title:String, overview:String? = "", posterURL:String? = "")
    {
        self.title = title;
        self.overview = overview;
        self.posterURL = posterURL;
    }
}