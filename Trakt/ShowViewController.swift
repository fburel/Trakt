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
        
        self.summaryTextView.text = self.show?.overview;
        self.title = self.show?.title;
        if(self.show?.imageData)
        {
            self.posterImageView.image = UIImage(data: self.show?.imageData);
        }
        else
        {
            self.posterImageView.image = UIImage(named:"wait");
            show?.addObserver(self, forKeyPath: "imageData", options: NSKeyValueObservingOptions.New, context: nil);
        }
        
    }
    

    override func viewDidDisappear(animated: Bool)
    {
         self.show?.removeObserver(self, forKeyPath:"imageData");
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: NSDictionary!, context: CMutableVoidPointer)
    {
         self.posterImageView.image = UIImage(data: self.show?.imageData);
        
    }
}