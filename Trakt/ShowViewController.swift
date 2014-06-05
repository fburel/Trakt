//
//  ShowViewController.swift
//  Trakt
//
//  Created by Florian BUREL on 05/06/2014.
//  Copyright (c) 2014 Florian Burel. All rights reserved.
//

import Foundation
import UIKit

class ShowViewController : UIViewController
{
    
    @IBOutlet var posterImageView : UIImageView
    @IBOutlet var summaryTextView : UITextView
    var show : Show?;
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        self.posterImageView.image = UIImage(data: self.show?.imageData);
        self.summaryTextView.text = self.show?.overview;
        self.title = self.show?.title;
        
    }
}