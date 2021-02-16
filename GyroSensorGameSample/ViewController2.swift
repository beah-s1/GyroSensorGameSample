//
//  ViewController2.swift
//  GyroSensorGameSample
//
//  Created by Kentaro Abe on 2021/02/16.
//

import UIKit
import RealmSwift

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var data: Results<Score>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dataは、Scoreの配列（ちょっと形が違うけど）
        let database = try! Realm()
        data = database.objects(Score.self).sorted(byKeyPath: "score",ascending: false)
        
        /*
         sortについて
         xx.sorted(byKeyPath: "yy", ascending: false)は、xxの配列を、それぞれのyyでソートしたもの
         ascendingをtrueにすると昇順（1→2→3→4...）、falseにすると降順（...4→3→2→1）となります
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Swift内部で使用されている日付データを、指定した形の文字に変換するためのFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm"
        
        // CellのStyleは標準のままでいいのでそれを使う
        let cell = UITableViewCell()
        cell.textLabel?.text = String(data[indexPath.row].score)
        cell.detailTextLabel?.text = dateFormatter.string(from: data[indexPath.row].date)
        
        return cell
    }
}
