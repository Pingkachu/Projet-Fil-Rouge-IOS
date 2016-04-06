//
//  AnnonceTableTableViewController.swift
//  JSON
//
//  Created by Matthieu Hannequin on 09/03/2016.
//  Copyright © 2016 Matthieu. All rights reserved.
//

import UIKit

class AnnonceTableTableViewController: UITableViewController {
    
    @IBOutlet var button : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string:"Update")
        self.refreshControl?.addTarget(self, action: "updateTable", forControlEvents: .ValueChanged)


        startDownloadJSON()
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func updateTable()
    {
        // test si mise à jour dispo
        
        // oui -> startDownloadJSON
        // non
        print("up to date")
        self.refreshControl?.attributedTitle? = NSAttributedString(string: "up to date")
        
        self.refreshControl?.endRefreshing()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    
    func startDownloadJSON()
    {
        if let url = NSURL(string: URL.jsonURL)
        {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler:
                {
                    (data, response, error) -> Void in
                    guard let data = data where error == nil else
                    {
                        Annonce.loadData()
                        return
                    }
                    Annonce.parseJSON(data)
                    
                    
                    dispatch_async(dispatch_get_main_queue(),
                        { () -> Void in
                            self.tableView.reloadData()
                        }
                    )


            })
            task.resume()
        }
    }
    
    func downloadImage (url : String, cell : AnnonceTableViewCell)-> Bool
    {
        if let urlImage = NSURL(string: url)
        {
            let task = NSURLSession.sharedSession().dataTaskWithURL(urlImage)
                {
                    (data, response, error) -> Void in
                    guard let data = data where error == nil else
                    {
                        print("Download error \(error?.code) \(url)")
                        return
                    }
                    if let img = UIImage(data: data)
                    {
                        dispatch_async( dispatch_get_main_queue(), { () -> Void in cell.imageAnnonce.image = img
                        })
                        
                    }
            }
            task.resume()
            return true
        }
        
        return false
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Annonce.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("annonce", forIndexPath: indexPath) as! AnnonceTableViewCell

        cell.labelMarque.text = "Marque : \(Annonce.list[indexPath.row].marque)"
        cell.labelEtat.text = "Etat : \(Annonce.list[indexPath.row].etat)"
        cell.labelPrix.text = "Prix : \(Annonce.list[indexPath.row].prix)"
        cell.labelTel.text = "Telephone : \(Annonce.list[indexPath.row].telephone)"
        downloadImage(Annonce.list[indexPath.row].image, cell: cell)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
