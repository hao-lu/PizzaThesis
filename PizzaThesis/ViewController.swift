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
    @IBOutlet weak var meatsTableView: UITableView!
    @IBOutlet weak var veggiesTableView: UITableView!
    
    // The list for the table view
    var meatsOnWhole = [Topping]()
    var veggiesOnWhole = [Topping]()
    var meatsOnLeft = [Topping]()
    var veggiesOnLeft = [Topping]()
    var toppings: Array<Array<Topping>> = []
    // Index used to initialize the TableViews
    var index: Int = 0
    
    @IBAction func orderConfirmed(sender: AnyObject) {
        for topping in meatsOnWhole {
            print("\(topping.name) : \(topping.amount.selectedSegmentIndex)")
        }
        for topping in veggiesOnWhole {
            print("\(topping.name) : \(topping.amount.selectedSegmentIndex)")
            
        }
    }

    @IBAction func toppingAmountChanged(segment: UISegmentedControl) {
        // Downcast twice (first downcast gave UITableViewContentCell
        let cell = segment.superview!.superview as! ToppingTableViewCell
        
        // The index of the ToppingTableViewCell in the TableView
        // let indexPathInt = meatsTableView.indexPathForCell(cell)?.row
        
        // Get the TableView from the cell (reference)
        let toppingTableView = cell.superview?.superview as! UITableView

        // TODO: need to catch the nil (ERROR: cause you're passing a veggie cell into the meatTableView)
        print(cell.toppingLabel.text, terminator: " : ")
        print(segment.titleForSegmentAtIndex(segment.selectedSegmentIndex))
        
        // Checks if the label for 4 cases instead of nested loop to check every value
        switch cell.toppingLabel.text! {
        case meatsOnWhole[(toppingTableView.indexPathForCell(cell)?.row)!].name:
//            meatsOnWhole[(toppingTableView.indexPathForCell(cell)?.row)!].amount.selectedSegmentIndex = segment.selectedSegmentIndex
            meatsOnWhole[0].amount.selectedSegmentIndex = segment.selectedSegmentIndex
            print("meatsOnWhole")
        case veggiesOnWhole[(toppingTableView.indexPathForCell(cell)?.row)!].name:
            veggiesOnWhole[(toppingTableView.indexPathForCell(cell)?.row)!].amount.selectedSegmentIndex = segment.selectedSegmentIndex
            print("veggiesOnWhole")
        default:
            print("No table view type")
            
        }
        
        // Works but loop inefficient
        /*for topping in toppings {
            if topping.name == cell.toppingLabel.text {
                topping.amount.selectedSegmentIndex = segment.selectedSegmentIndex
            }
        }*/
    
        
    }
    
    @IBAction func sideForToppings(sender: AnyObject) {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = meatsTableView.dequeueReusableCellWithIdentifier("ToppingTableViewCellIdentifier", forIndexPath: indexPath) as! ToppingTableViewCell
        let toppingWhole = meatsOnWhole[indexPath.row]
        print("whole : \(toppingWhole.amount.selectedSegmentIndex)")
        let topping = meatsOnLeft[indexPath.row]
        print(topping.name)
        print("left : \(topping.amount.selectedSegmentIndex)")
        print("cell : \(cell.toppingAmount.selectedSegmentIndex)")
        // cell.toppingLabel.text = topping.name
        // cell.toppingImage.image = topping.image
        // Links topping element to the topping cell element
        // topping.amount = cell.toppingAmount
        // cell.toppingAmount = topping.amount
        cell.toppingAmount.selectedSegmentIndex = topping.amount.selectedSegmentIndex
        print(cell.toppingAmount.selectedSegmentIndex)
        print("cell size : \(cell.toppingAmount.numberOfSegments)")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMeatToppings()
        loadVeggiesTopping()
        // Initializes the last table to the first table
        toppings = [veggiesOnWhole, meatsOnWhole]
        // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.meatsTableView.registerClass(ToppingTableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.veggiesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        
        // Link the table view to the view controller
        meatsTableView.delegate = self
        meatsTableView.dataSource = self
        veggiesTableView.delegate = self
        veggiesTableView.dataSource = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initialize array
    func loadMeatToppings() {
        // let defaultAmount = UISegmentedControl()
        let defaultAmount = UISegmentedControl(items: ["None", "Light", "Regular", "Extra"])
        defaultAmount.selectedSegmentIndex = 0
        
        let image1 = UIImage(named: "pepperoni")
        let topping1 = Topping(name: "Pepperoni", image: image1, amount: defaultAmount)!
        let image2 = UIImage(named: "ham")
        let topping2 = Topping(name: "Ham", image: image2, amount: defaultAmount)!
        
        meatsOnWhole += [topping1, topping2]
        meatsOnLeft += [topping1, topping2]
    }
    
    func loadVeggiesTopping() {
        let defaultAmount = UISegmentedControl(items: ["None", "Light", "Regular", "Extra"])
        defaultAmount.selectedSegmentIndex = 0
        
        let image1 = UIImage(named: "pepperoni")
        let topping1 = Topping(name: "Sauteed Onions", image: image1, amount: defaultAmount)!
        let image2 = UIImage(named: "ham")
        let topping2 = Topping(name: "Jalapenos", image: image2, amount: defaultAmount)!
        
        veggiesOnWhole += [topping1, topping2]
        veggiesOnLeft += [topping1, topping2]
    }

    // Methods for UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meatsOnWhole.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ToppingTableViewCell", forIndexPath: indexPath) as UITableViewCell
        // Use different name for the identifier. (Think it uses the .swift from the dequeue not the identifer)
        let cell = tableView.dequeueReusableCellWithIdentifier("ToppingTableViewCellIdentifier", forIndexPath: indexPath) as! ToppingTableViewCell
        
//        cell.textLabel?.text = self.toppings[indexPath.row].name
//        cell.imageView?.image = self.toppings[indexPath.row].image
        
        
        // Fetches the appropriate meal for the data source layout (initializes the cells)
        let topping = toppings[index][indexPath.row]
        cell.toppingLabel.text = topping.name
        cell.toppingImage.image = topping.image
        // Links topping element to the topping cell element
        topping.amount = cell.toppingAmount
        cell.toppingAmount.selectedSegmentIndex = topping.amount.selectedSegmentIndex
        print("tableView name : \(cell.toppingLabel.text)")
        print("tableView amount : \(cell.toppingAmount.selectedSegmentIndex)")
        
        // Initializes the next table with the next array when the first sarray is done
        if toppings[index].count - 1 == indexPath.row {
            index += 1
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }

}

