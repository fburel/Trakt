//
//  ShowsTableViewController.swift
//  Trakt
//
//  Created by Florian BUREL on 05/06/2014.
//  Copyright (c) 2014 Florian Burel. All rights reserved.
//

import Foundation
import UIKit

class ShowsTableViewController : UIViewController, UITableViewDataSource
{
    var shows : Show[]?;
    
    @IBOutlet var tableView : UITableView
    
    let API_KEY = "306de5efc644610713876fd622780172";
    
   override func viewDidLoad()
   {
    
        super.viewDidLoad();
        var service = TracktService(apiKey: API_KEY);
    
    
    self.shows = [];
    
    
        println("j'ai recuperé \(self.shows?.count) series");
    
    
    self.tableView.hidden = true;

    
        self.tableView.dataSource = self;
    
   
    dispatch_async(dispatch_get_main_queue(), {
        self.shows = service.getAllShows();
        self.tableView.reloadData();
        self.tableView.hidden = false;
    });
    
    
    
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.shows!.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        
       
        
        var position = indexPath.row;
        
        var show = self.shows?[position];
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell;
        
        
        cell.textLabel.text = show?.title;
       
        if show?.imageData != nil
        {
            // image déjà téléchargé
             cell.imageView.image = UIImage(data: show?.imageData);
        }
        else
        {
            
            // Presente mon UI d'attente
            cell.imageView.image = UIImage(named: "wait");
            
            // download l'image
            
            var thread = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            
            dispatch_async(thread, {
                
                show!.imageData = NSData(contentsOfURL: NSURL(string: show?.posterURL));
                
                
                var mainThread = dispatch_get_main_queue();
                
                dispatch_async(mainThread, {

                    
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None);
                    
                    
                    
                    });
                
                
            });
        }
        
        return cell;
        
        
    }
    
    
    // Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        if segue?.identifier == "SHOW_SELECTED"
        {
            // recuperation du show selectionné
            var indexPath = self.tableView.indexPathForSelectedRow();
            
            var show = self.shows?[indexPath.row];
            
            println("show name : \(show?.title)");
            
            var nextScreen = segue.destinationViewController as ShowViewController;
            
            nextScreen.show = show;
        }
    
    }
    
    
}












