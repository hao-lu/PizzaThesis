//
//  ViewController.swift
//  PizzaThesis
//
//  Created by Hao Lu on 8/4/16.
//  Copyright © 2016 Hao Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pizzaPreview: UIImageView!
    @IBOutlet weak var meatsLabel: UILabel!
    @IBOutlet weak var veggiesLabel: UILabel!
    // MARK: Properties
    // TableView in ViewController
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var veggiesTableView: UITableView!
    
    // The list for the table view
    var toppings = [Topping]()
    
    @IBAction func orderConfirmed(sender: AnyObject) {
        for topping in toppings {
            print("\(topping.name) : \(topping.amount.selectedSegmentIndex)")
        }
    }

    @IBAction func toppingAmountChanged(segment: UISegmentedControl) {
        
        print(segment.titleForSegmentAtIndex(segment.selectedSegmentIndex))
        // Downcast twice (first downcast gave UITableViewContentCell
        let cell = segment.superview!.superview as! ToppingTableViewCell
        // The index of the ToppingTableViewCell in the TableView
        let indexPathInt = tableView.indexPathForCell(cell)?.row
        
        // FIXME: Probably does not need the check if the list is already ordered
        // If the label of the cell is the same as the element in the array
        guard toppings[indexPathInt!].name == cell.toppingLabel.text else {
            return
        }
        
        toppings[indexPathInt!].amount.selectedSegmentIndex = segment.selectedSegmentIndex
        
        
        // Works but loop inefficient
        /*for topping in toppings {
            if topping.name == cell.toppingLabel.text {
                topping.amount.selectedSegmentIndex = segment.selectedSegmentIndex
            }
        }*/
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadSamples()
        // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.tableView.registerClass(ToppingTableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.veggiesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        
        // Link the table view to the view controller
        tableView.delegate = self
        tableView.dataSource = self
        veggiesTableView.delegate = self
        veggiesTableView.dataSource = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initialize array
    func loadSamples() {
        // let defaultAmount = UISegmentedControl()
        let defaultAmount = UISegmentedControl(items: ["None", "Light", "Regular", "Extra"])
        //defaultAmount.selectedSegmentIndex = 0
        
        let image1 = UIImage(named: "pepperoni")
        let topping1 = Topping(name: "Pepperoni", image: image1, amount: defaultAmount)!
        let image2 = UIImage(named: "ham")
        let topping2 = Topping(name: "Ham", image: image2, amount: defaultAmount)!
        
        
        toppings += [topping1, topping2]
    }

    // Methods for UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toppings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ToppingTableViewCell", forIndexPath: indexPath) as UITableViewCell
        // Use different name for the identifier. (Think it uses the .swift from the dequeue not the identifer)
        let cell = tableView.dequeueReusableCellWithIdentifier("ToppingTableViewCellIdentifier", forIndexPath: indexPath) as! ToppingTableViewCell
        
//        cell.textLabel?.text = self.toppings[indexPath.row].name
//        cell.imageView?.image = self.toppings[indexPath.row].image
        
        // Fetches the appropriate meal for the data source layout
        let topping = self.toppings[indexPath.row]
        cell.toppingLabel.text = topping.name
        cell.toppingImage.image = topping.image
        // Links topping element to the topping cell element
        topping.amount = cell.toppingAmount
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }

}

