//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Dzvinka Koman on 9/27/20.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    // creates the property called movie
    var movie: [String:Any]!

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie["title"] as? String
        // before autolayout is configured, use sizeToFit()
        // configures the label so that all the text fits in the label field
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        // w185 sets the width
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        // type url() ensures that that the string is formated in the appropriate way (as a real url)
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        // type url() ensures that that the string is formated in the appropriate way (as a real url)
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af_setImage(withURL: backdropUrl!)
        
    }

}
