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
    @IBOutlet weak var saucesTableView: UITableView!
    @IBOutlet weak var cheesesTableView: UITableView!

    @IBOutlet weak var sideOfPizzaSegmentControl: UISegmentedControl!
    // The list for the table view
    var meatsOnWhole = [Topping]()
    var veggiesOnWhole = [Topping]()
    var saucesOnWhole = [Topping]()
    var cheesesOnWhole = [Topping]()
    
    var meatsOnLeft = [Topping]()
    var veggiesOnLeft = [Topping]()
    
    var meatsOnRight = [Topping]()
    var veggiesOnRight = [Topping]()
    
    // TODO: make an array of the image names and use string methods to make it to label names
    var meatsToppingImageName = ["pepperoni", "ham"]
    var veggiesToppingImageName = ["sauteed_onions", "jalapenos"]
    var saucesToppingImageName = ["red_sauce", "spicy_red_sauce"]
    var cheesesToppingImageName = []
//    var cheesesToppingImageName = ["sauteed_onions", "jalapenos"]

    
    @IBAction func orderConfirmed(sender: AnyObject) {
        for topping in meatsOnWhole {
            print("\(topping.name) : \(topping.amount)")
        }
        for topping in veggiesOnWhole {
            print("\(topping.name) : \(topping.amount)")
            
        }
        for topping in meatsOnLeft {
            print("\(topping.name) : \(topping.amount)")
        }
        for topping in veggiesOnLeft {
            print("\(topping.name) : \(topping.amount)")
            
        }
        for topping in meatsOnRight {
            print("\(topping.name) : \(topping.amount)")
        }
        for topping in veggiesOnRight {
            print("\(topping.name) : \(topping.amount)")
            
        }
    }

    @IBAction func toppingAmountChanged(segment: UISegmentedControl) {
        // Downcast twice (first downcast gave UITableViewContentCell
        let cell = segment.superview!.superview as! ToppingTableViewCell
        // The index of the ToppingTableViewCell in the TableView
        // let indexPathInt = meatsTableView.indexPathForCell(cell)?.row
        
        // Get the TableView from the cell (reference)
        let toppingTableView = cell.superview?.superview as! UITableView
        let toppingTableViewCellIndex = toppingTableView.indexPathForCell(cell)!.row

    
        let meatsToppingAmountArray: Array<Topping>
        let veggiesToppingAmountArray: Array<Topping>
        switch sideOfPizzaSegmentControl.selectedSegmentIndex {
        case 0:
            print("LEFT")
            meatsToppingAmountArray = meatsOnLeft
            veggiesToppingAmountArray = veggiesOnLeft
        case 1:
            print("WHOLE")
            meatsToppingAmountArray = meatsOnWhole
            veggiesToppingAmountArray = veggiesOnWhole
        case 2:
            print("RIGHT")
            meatsToppingAmountArray = meatsOnRight
            veggiesToppingAmountArray = veggiesOnRight
        default:
            print("No type")
            meatsToppingAmountArray = []
            veggiesToppingAmountArray = []
        }

        switch toppingTableView {
        case meatsTableView:
            print("MEATS")
            meatsToppingAmountArray[toppingTableViewCellIndex].amount = segment.selectedSegmentIndex
        case veggiesTableView:
            print("VEGGIE")
            veggiesToppingAmountArray[toppingTableViewCellIndex].amount = segment.selectedSegmentIndex
        default:
            
            print("No type")
        }
        
        // TODO: need to catch the nil (ERROR: cause you're passing a veggie cell into the meatTableView)
        print("NAME AND AMOUNT: \(cell.toppingLabel.text)", terminator: " : ")
        print(segment.titleForSegmentAtIndex(segment.selectedSegmentIndex))
        
    }
    
    @IBAction func sideForToppings(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            print("CHANGING TO LEFT")
            changeToppingAmountBasedOnSide(meatsOnLeft, toppingTableView: meatsTableView)
            changeToppingAmountBasedOnSide(veggiesOnLeft, toppingTableView: veggiesTableView)
        case 1:
            print("CHANGING TO WHOLE")
            changeToppingAmountBasedOnSide(meatsOnWhole, toppingTableView: meatsTableView)
            changeToppingAmountBasedOnSide(veggiesOnWhole, toppingTableView: veggiesTableView)
        case 2:
            print("CHANGING TO RIGHT")
            changeToppingAmountBasedOnSide(meatsOnRight, toppingTableView: meatsTableView)
            changeToppingAmountBasedOnSide(veggiesOnRight, toppingTableView: veggiesTableView)
        default:
            print("No type")
        }
    }
    
    func changeToppingAmountBasedOnSide(toppingAmountArray: Array<Topping>, toppingTableView: UITableView) {
        for index in 0..<toppingAmountArray.count {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            let cell = toppingTableView.cellForRowAtIndexPath(indexPath) as! ToppingTableViewCell
            let topping = toppingAmountArray[indexPath.row]
            cell.toppingAmount.selectedSegmentIndex = topping.amount
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMeatToppingsIntoArrays()
        // loadMeatToppings()
        loadVeggiesTopping()
        loadSaucesTopping()
        loadCheesesTopping()
        // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.meatsTableView.registerClass(ToppingTableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.veggiesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        self.saucesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        self.cheesesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        
        // Link the table view to the view controller
        meatsTableView.delegate = self
        meatsTableView.dataSource = self
        veggiesTableView.delegate = self
        veggiesTableView.dataSource = self
        
        saucesTableView.delegate = self
        saucesTableView.dataSource = self
        
        cheesesTableView.delegate = self
        cheesesTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMeatToppingsIntoArrays() {

        let defaultAmount = 0
        for toppingImageName in meatsToppingImageName {
            // let arrayToppingImageName = toppingImageName.characters.split("_")
            let imageNameSplit = toppingImageName.componentsSeparatedByString("_")
            
            var toppingName = ""
            for imageName in imageNameSplit {
                toppingName += imageName.capitalizedString
            }

            let toppingOnWholePizza = Topping(name: toppingName, image: UIImage(named: toppingImageName), amount: defaultAmount)!
            let toppingOnLeftPizza = Topping(name: toppingName + " LEFT", image: nil, amount: defaultAmount)!
            let toppingOnRightPizza = Topping(name: toppingName + " RIGHT", image: nil, amount: defaultAmount)!

            meatsOnWhole += [toppingOnWholePizza]
            meatsOnLeft += [toppingOnLeftPizza]
            meatsOnRight += [toppingOnRightPizza]
            
        }
        
    }
    
    
    
    // Initialize array
    func loadMeatToppings() {
        // let defaultAmount = UISegmentedControl()
        // let defaultAmount = UISegmentedControl(items: ["None", "Light", "Regular", "Extra"])
        // defaultAmount.selectedSegmentIndex = 0
        let defaultAmount: Int = 0
        
        let topping1 = Topping(name: "Pepperoni", image: UIImage(named: "pepperoni"), amount: defaultAmount)!
        let topping2 = Topping(name: "Ham", image: UIImage(named: "ham"), amount: defaultAmount)!
        
        let topping1Left = Topping(name: "Pepperoni (LEFT)", image: nil, amount: defaultAmount)!
        let topping2Left = Topping(name: "Ham (LEFT)", image: nil, amount: defaultAmount)!
        
        let topping1Right = Topping(name: "Pepperoni (RIGHT)", image: nil, amount: defaultAmount)!
        let topping2Right = Topping(name: "Ham (RIGHT)", image: nil, amount: defaultAmount)!
    
        meatsOnWhole += [topping1, topping2]
        meatsOnLeft += [topping1Left, topping2Left]
        meatsOnRight +=  [topping1Right, topping2Right]
    }
    
    func loadVeggiesTopping() {
        // let defaultAmount = UISegmentedControl(items: ["None", "Light", "Regular", "Extra"])
        // defaultAmount.selectedSegmentIndex = 0
        let defaultAmount = 0
        
        let image1 = UIImage(named: "sauteed_onions")
        let topping1 = Topping(name: "Sauteed Onions", image: image1, amount: defaultAmount)!
        let image2 = UIImage(named: "jalapenos")
        let topping2 = Topping(name: "Jalapenos", image: image2, amount: defaultAmount)!
        
        let topping3 = Topping(name: "Sauteed Onions (LEFT)", image: image1, amount: defaultAmount)!
        let topping4 = Topping(name: "Jalapenos (LEFT)", image: image2, amount: defaultAmount)!
        
        let topping3a = Topping(name: "Sauteed Onions (RIGHT)", image: image1, amount: defaultAmount)!
        let topping4a = Topping(name: "Jalapenos (RIGHT)", image: image2, amount: defaultAmount)!
        
        veggiesOnWhole += [topping1, topping2]
        veggiesOnLeft += [topping3, topping4]
        veggiesOnRight += [topping3a, topping4a]
    }
    
    func loadSaucesTopping() {
        let defaultAmount = 0
        
        let image1 = UIImage(named: "red_sauce")
        let topping1 = Topping(name: "Red Sauce", image: image1, amount: defaultAmount)!
        let image2 = UIImage(named: "spicy_red_sauce")
        let topping2 = Topping(name: "Spicy Red Sauce", image: image2, amount: defaultAmount)!
        
        saucesOnWhole += [topping1, topping2]

    }
    
    func loadCheesesTopping() {
        let defaultAmount = 0
        
        let image1 = UIImage(named: "red_sauce")
        let topping1 = Topping(name: "Mozzarella", image: image1, amount: defaultAmount)!
        let image2 = UIImage(named: "spicy_red_sauce")
        let topping2 = Topping(name: "Gorgonzola", image: image2, amount: defaultAmount)!
        
        cheesesOnWhole += [topping1, topping2]
        
    }

    // Methods for UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meatsOnWhole.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Use different name for the identifier. (Think it uses the .swift from the dequeue not the identifer)
        let cell = tableView.dequeueReusableCellWithIdentifier("ToppingTableViewCellIdentifier", forIndexPath: indexPath) as! ToppingTableViewCell
        
        // Rename toppingTableView variable for clarity
        let toppingTableView: Array<Topping>
        switch tableView {
        case meatsTableView:
            toppingTableView = meatsOnWhole
        case veggiesTableView:
            toppingTableView = veggiesOnWhole
        case saucesTableView:
            toppingTableView = saucesOnWhole
        case cheesesTableView:
            toppingTableView = cheesesOnWhole
        default:
            toppingTableView = []
            print("No type")
        }
        
        let topping = toppingTableView[indexPath.row]
        cell.toppingLabel.text = topping.name
        cell.toppingImage.image = topping.image
        cell.toppingAmount.selectedSegmentIndex = topping.amount

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }

}

