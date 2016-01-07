//import UIKit
//
//class LogViewController: UIViewController  {
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var foundDino: String?
//    
//    
//    let dinos = buildDinos()
//    let loader = loadObjects()
//    
//    var selectedDino: Dino?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if let foundDino = foundDino {
//            loader.saveObject(foundDino)
//        }
//        
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowDino" {
//            let vc = segue.destinationViewController as! DetailViewController
//            vc.dinoName = selectedDino!.name
//            vc.buttonHidden = true
//        }
//    }
//    
//}
//
//extension LogViewController: UITableViewDataSource {
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dinos.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
//        let dino = dinos[indexPath.row]
//        
//        let titleLabel = cell?.viewWithTag(1) as! UILabel
//        titleLabel.text = dino.name
//        
//        let imageView = cell?.viewWithTag(2) as! UIImageView
//        
//        
//        if loader.hasFoundObject(dino.name) {
//            cell?.accessoryType = .Checkmark
//            imageView.image = UIImage(named: dino.name + "Colour")
//        } else {
//            titleLabel.alpha = 0.3
//            imageView.image = UIImage(named: dino.name + "Grey")
//        }
//        
//        return cell!
//    }
//    
//}
//
//extension LogViewController: UITableViewDelegate {
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let dino = dinos[indexPath.row]
//        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        if loader.hasFoundObject(dino.name) {
//            selectedDino = dinos[indexPath.row]
//            performSegueWithIdentifier("ShowDino", sender: self)
//        }
//        selectedDino = dinos[indexPath.row]
//    }
//    
//}
