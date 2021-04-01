//
//  ViewController.swift
//  ShowJsonDataInList
//
//  Created by macbook on 31/03/2021.
//

import UIKit

struct jsonstruct:Decodable {
    let id:Int
    let name:String
    let age:Int
}
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
  
    @IBOutlet weak var tblView: UITableView!

    var arrdata = [jsonstruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        // Do any additional setup after loading the view.
    }
    func getdata(){
        let url = URL(string: "https://run.mocky.io/v3/ef17aea5-8b21-4016-ae1e-fc443fda72eb")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{if error == nil{
                self.arrdata = try JSONDecoder().decode([jsonstruct].self, from: data!)
                
                for mainarr in self.arrdata{
                    print(mainarr.name,":",mainarr.id,":",mainarr.age)
                    DispatchQueue.main.async {
                         self.tblView.reloadData()
                    }
                   
                }
                }
            
            }catch{
                print("Error in get json data")
            }
            
        }.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tblView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblId.text = "Id : \(arrdata[indexPath.row].id)"
        cell.lblName.text = "Name : \(arrdata[indexPath.row].name)"
        cell.lblAge.text = "Age : \(arrdata[indexPath.row].age)"
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        detail.strregion = "Region :\(arrdata[indexPath.row].age)"
        self.navigationController?.pushViewController(detail, animated: true)
    
        
    }
    */


}

