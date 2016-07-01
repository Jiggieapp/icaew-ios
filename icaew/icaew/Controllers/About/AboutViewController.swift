//
//  AboutViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 6/29/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import Mantle

class AboutViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MTLJSONSerializing {
    
    @IBOutlet weak var tableView: UITableView!
    
    var aboutDict: [String : AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNavigationBar(title: "About Us")
        self.tableView.tableFooterView = UIView()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data
    func loadData() {
        if let request = NetworkManager.request(.GET, "about") {
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .Success(let jsonResult):
                    print(jsonResult)
                    
                    if let jsonDict = jsonResult as? [String : AnyObject] {
                        if let data = jsonDict["data"] as? [String : AnyObject] {
                            let aboutData = MTLJSON
                            self.aboutDict = data
                            self.tableView.reloadData()
                        }
                    }
                    
                case .Failure(let error):
                    print(error)
                }
            })
        }
    }
    
    // MARK: -  UITableviewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.aboutDict != nil) {
            return 2
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            let imageHeight = 3 / 4 * self.view.bounds.size.width
            return imageHeight
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("image-cell") as UITableViewCell?
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default ,reuseIdentifier: "image-cell")
                
                if let aboutDict = self.aboutDict {
                    if let image = aboutDict["image"] as? String {
                        let imageHeight = 3 / 4 * self.view.bounds.size.width
                        cell!.textLabel?.text = description
                        
                        let aboutImage: UIImageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.size.width, imageHeight))
                        
                        aboutImage.sd_setImageWithURL(NSURL(string: image))
                        cell?.contentView.addSubview(aboutImage)
                    }
                }
                
                let imageHeight = 3 / 4 * self.view.bounds.size.width
                cell!.textLabel?.text = description
                
                let aboutImage: UIImageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.size.width, imageHeight))
                
                aboutImage.sd_setImageWithURL(NSURL(string: "https://s3-ap-southeast-1.amazonaws.com/jiggieimages/venue/1446652444613.jpg"))
                cell?.contentView.addSubview(aboutImage)
                
            }
            
            return cell!
        }
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("text-cell") as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default ,reuseIdentifier: "text-cell")
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
        }
        
        if let aboutDict = self.aboutDict {
            if let description = aboutDict["description"] as? String {
                cell!.textLabel?.text = "Lorem ipsum dolor sit amet, scaevola postulant eu eum. Pertinax efficiantur te nec, choro audiam mea et. Te eam tantas dicunt nusquam, modo adipiscing reformidans ius id. Duo id eros laudem adolescens, pri unum detraxit tractatos no, suas sensibus sit ea.\r\n\r\nEi deserunt repudiare vis, an usu viris nonumy consequuntur. Audiam democritum argumentum ad est. Primis nominati id duo. Vide dicant duo id, nam sumo iriure ocurreret ea, no everti fastidii accommodare duo. Vel diceret offendit in, modus quando dolores eum no, sea reque paulo sonet te. Eu labitur voluptua cum, magna laoreet assentior no sed, in mazim latine pericula qui.\r\n\r\nPericulis dissentiet has ut, tritani moderatius efficiantur te vim. Vis cu erant ancillae recteque. Nisl accusata ullamcorper at cum, in pro omnesque hendrerit disputationi. Vel id dolores conclusionemque, mel ne detracto invidunt probatus. Regione nusquam volumus cum ut, mel meis velit no. Ancillae deserunt periculis ei pri, eu vide civibus nec.\r\n\r\nPaulo mollis eloquentiam ea eam. Eos cu ornatus disputationi, ut vel suscipit mnesarchum moderatius. Atqui percipit interesset cu sed. Prodesset tincidunt has at, ex cum cibo corpora. Vel tantas primis ea, mucius integre an est, ad quo singulis mandamus.\r\n\r\nVirtute accumsan quaerendum ius eu, vulputate eloquentiam signiferumque no eum. Et tation theophrastus qui, ei mei aeque vivendum. An sed hinc commune sapientem, sea no ornatus labores. Et sit noster fierent. Mea no omnes consequat."
            }
            
            if let title = aboutDict["title"] as? String {
                self.setupNavigationBar(title: title)
            }
        }
        
        return cell!
    }
    
    // MARK: -  UITableviewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

}
