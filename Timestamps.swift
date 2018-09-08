//
//  Timestamps.swift
//  Created by Jasper Yiu on 2017-09-03.
//

import UIKit
class TimeStamps: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var stamps = [String]()
    
    let btn: UIButton = {
        let view = UIButton()
        view.setTitle("Add Stamp", for: .normal)
        view.addTarget(self, action: #selector(addTimeStamp(_:)), for: .touchUpInside)
        view.setTitleColor(UIColor.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let tableView: UITableView = {
        let view = UITableView()
        view.isScrollEnabled = false
        view.separatorColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rowHeight = 40
    var tableViewHeight: NSLayoutConstraint? = nil
    
    
    func addTimeStamp(_ sender : UIButton) {
        let date = Date()
        let formatter = ISO8601DateFormatter()
        
        stamps.append(formatter.string(from: date))
        tableView.reloadData()
        
        self.view.setNeedsLayout() // make sure previously queued changes are completed
        
        UIView.animate(withDuration: 0.7, animations: {
            
            self.tableViewHeight?.constant = CGFloat(self.rowHeight*self.stamps.count)
            self.view.setNeedsLayout()
        })
        
    }
    
    func setupViews() {
        self.view.addSubview(backgroundView)
        self.view.addSubview(btn)
        backgroundView.addSubview(tableView)
        
        
        let views = [
            "view" : backgroundView,
            "tableView": tableView,
            "btn": btn
        ]
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[view]-15-|", options: [], metrics: nil, views: views) +
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[view]-15-[btn(30)]", options: [], metrics: nil, views: views) +
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[btn]-15-|", options: [], metrics: nil, views: views) +
                
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[tableView]-15-|", options: [], metrics: nil, views: views) +
                NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views)
        )
        
        // Set value of our variable constraint
        tableViewHeight = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(rowHeight*stamps.count))
        view.addConstraint(tableViewHeight!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false // if this value is true, the tableView will not conform properly to our constraints
        view.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 232/255, alpha: 1)
        self.title = "Time Stamps"
        
        setupViews()
        
        // Register the Table View
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stamps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
        
        cell?.textLabel?.text = stamps[indexPath.row]
        cell?.textLabel?.textAlignment = NSTextAlignment.center
        
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(rowHeight)
    }
    
    
}
