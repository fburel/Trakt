//
//  TracktService.swift
//  Trakt
//
//  Created by Florian BUREL on 05/06/2014.
//  Copyright (c) 2014 Florian Burel. All rights reserved.
//

import Foundation

class TracktService : NSObject
{
    
    var apiKey : String;
    
    init(apiKey : String)
    {
        self.apiKey = apiKey;
    }
    
    func getAllShows() -> Show[]
    {
        
        // construction de l'url
        let url = NSURL(string: "http://api.trakt.tv/shows/trending.json/\(apiKey)");
        
        // Telechargement des donnees
        let data = NSData(contentsOfURL: url);
        
        // parser - construire le tableau de show
        let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray;
        
        var shows : Show[] = [];
        
        for item : AnyObject  in json
        {
            
            let title = item["title"] as String;
            let overview = item["overview"] as String;
            let poster = item["poster"] as String;
            
            
            var show = Show(title: title, overview: overview, posterURL: poster);
            
            shows.append(show);
        }
    
        return shows;
        
    }
    
}