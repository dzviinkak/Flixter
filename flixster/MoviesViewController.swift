//
//  MoviesViewController.swift
//  flixster
//
//  Created by Dzvinka Koman on 9/27/20.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var movies = [[String:Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calls on 2 functions for tableview
        tableView.dataSource = self
        tableView.delegate = self
        print("Hello")
        // download the array of moview
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            // store the downloaded data in the array
            // use type casting to avoid an error
            self.movies = dataDictionary["results"] as![[String:Any]]
            // makes the functions below (tableviews) be called again and again
            self.tableView.reloadData()
            print(dataDictionary)

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    // this function asks for the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // movies.count returns the number of elements in movies
        return movies.count
    }
    // provide the cell content for a particular row
    // executes number of times set(returned) in(by) previous function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // shortcut to using less memory by reusing cells that have been previously used but are not in the screen atm
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        // indexPath.row allows to access each row of movies and retract the new movie each time the funciton is called
        let movie = movies[indexPath.row]
        // as! tells that it wants movie["title"] to be passed as a string
        let title = movie["title"] as! String
        // sets the titleLabel to show title
        cell.titleLabel.text = title
        
        let synopsis = movie["overview"] as! String
        // sets the synopsisLabel to show synopsis from the initial file
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        // type url() ensures that that the string is formated in the appropriate way (as a real url)
        let posterUrl = URL(string: baseUrl + posterPath )
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
