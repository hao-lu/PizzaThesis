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
    // MARK: Properties
    // TableView in ViewController
    @IBOutlet weak var meatsTableView: UITableView!
    @IBOutlet weak var veggiesTableView: UITableView!
    @IBOutlet weak var saucesTableView: UITableView!
    @IBOutlet weak var cheesesTableView: UITableView!
    @IBOutlet weak var halfOrWholeSegmentedControl: UISegmentedControl!
    
    // Constants
    let LEFT = 0
    let WHOLE = 1
    let RIGHT = 2
    
    // TODO: make an array of the image names and use string methods to make it to label names
    // TODO: add toppingdatasource file
    var meatsToppingImageName = ["pepperoni", "ham"]
    var veggiesToppingImageName = ["sauteed_onions", "jalapenos"]
    var saucesToppingImageName = ["red_sauce", "spicy_red_sauce"]
    var cheesesToppingImageName = ["mozzarella", "gorgonzola"]
    
    // Initialize array of Topping Arrays
    var meatToppingsOnPizza = [[Topping](), [Topping](), [Topping]()]
    var veggieToppingsOnPizza = [[Topping](), [Topping](), [Topping]()]
    var sauceToppingsOnPizza = [[Topping](), [Topping](), [Topping]()]
    var cheeseToppingsOnPizza = [[Topping](), [Topping](), [Topping]()]

    
    @IBAction func orderConfirmedButton(sender: AnyObject) {
        for meatTopping in meatToppingsOnPizza {
            for topping in meatTopping {
                print("\(topping.name) : \(topping.amount)")
            }
        }
        for meatTopping in veggieToppingsOnPizza {
            for topping in meatTopping {
                print("\(topping.name) : \(topping.amount)")
            }
        }
        for meatTopping in sauceToppingsOnPizza {
            for topping in meatTopping {
                print("\(topping.name) : \(topping.amount)")
            }
        }

        for meatTopping in cheeseToppingsOnPizza {
            for topping in meatTopping {
                print("\(topping.name) : \(topping.amount)")
            }
        }
    }

    @IBAction func toppingAmountSegmentedControlAction(segment: UISegmentedControl) {
        // Downcast twice (first downcast gave UITableViewContentCell
        let cell = segment.superview!.superview as! ToppingTableViewCell
        // The index of the ToppingTableViewCell in the TableView
        // let indexPathInt = meatsTableView.indexPathForCell(cell)?.row
        
        // Get the TableView from the cell (reference)
        let toppingTableView = cell.superview?.superview as! UITableView
        let toppingTableViewCellIndex = toppingTableView.indexPathForCell(cell)!.row
        
        switch toppingTableView {
        case meatsTableView:
            print("MEATS")
            meatToppingsOnPizza[halfOrWholeSegmentedControl.selectedSegmentIndex][toppingTableViewCellIndex].amount = segment.selectedSegmentIndex
        case veggiesTableView:
            print("VEGGIE")
            veggieToppingsOnPizza[halfOrWholeSegmentedControl.selectedSegmentIndex][toppingTableViewCellIndex].amount = segment.selectedSegmentIndex
        case saucesTableView:
            print("VEGGIE")
            sauceToppingsOnPizza[halfOrWholeSegmentedControl.selectedSegmentIndex][toppingTableViewCellIndex].amount = segment.selectedSegmentIndex
        case cheesesTableView:
            print("VEGGIE")
            cheeseToppingsOnPizza[halfOrWholeSegmentedControl.selectedSegmentIndex][toppingTableViewCellIndex].amount = segment.selectedSegmentIndex
        default:
            print("No type")
        }
        
        // TODO: need to catch the nil (ERROR: cause you're passing a veggie cell into the meatTableView)
        print("NAME AND AMOUNT: \(cell.toppingLabel.text)", terminator: " : ")
        print(segment.titleForSegmentAtIndex(segment.selectedSegmentIndex))
        
    }
    
    @IBAction func halfOfWholeSegmentedControlAction(segment: UISegmentedControl) {
        changeToppingAmountBasedOnSide(meatToppingsOnPizza[segment.selectedSegmentIndex], toppingTableView: meatsTableView)
        changeToppingAmountBasedOnSide(veggieToppingsOnPizza[segment.selectedSegmentIndex], toppingTableView: veggiesTableView)
        changeToppingAmountBasedOnSide(sauceToppingsOnPizza[segment.selectedSegmentIndex], toppingTableView: saucesTableView)
        changeToppingAmountBasedOnSide(cheeseToppingsOnPizza[segment.selectedSegmentIndex], toppingTableView: cheesesTableView)

    }
    
    func changeToppingAmountBasedOnSide(toppingAmountArray: Array<Topping>, toppingTableView: UITableView) {
        for index in 0..<toppingAmountArray.count {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            let cell = toppingTableView.cellForRowAtIndexPath(indexPath) as! ToppingTableViewCell
            let topping = toppingAmountArray[indexPath.row]
            cell.toppingAmountSegmentedControl.selectedSegmentIndex = topping.amount
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMeatToppingsIntoArrays()
        loadVeggieToppingsIntoArrays()
        loadSauceToppingsIntoArrays()
        loadCheeseToppingsIntoArrays()

        // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.meatsTableView.registerClass(ToppingTableViewCell.self, forCellReuseIdentifier: "ToppingTableViewCell")
        self.veggiesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        self.saucesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")
        self.cheesesTableView.registerClass((ToppingTableViewCell.self), forCellReuseIdentifier: "ToppingTableViewCell")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMeatToppingsIntoArrays() {
        let defaultAmount = 0
        for imageName in meatsToppingImageName {
            // let arrayToppingImageName = toppingImageName.characters.split("_")
            let imageNameSplit = imageName.componentsSeparatedByString("_")
            
            var toppingName = ""
            for imageName in imageNameSplit {
                toppingName += imageName.capitalizedString
            }
            let toppingOnWholePizza = Topping(name: toppingName, image: UIImage(named: imageName), amount: defaultAmount)!
            let toppingOnLeftPizza = Topping(name: toppingName + " LEFT", image: nil, amount: defaultAmount)!
            let toppingOnRightPizza = Topping(name: toppingName + " RIGHT", image: nil, amount: defaultAmount)!
            
            meatToppingsOnPizza[LEFT] += [toppingOnLeftPizza]
            meatToppingsOnPizza[WHOLE] += [toppingOnWholePizza]
            meatToppingsOnPizza[RIGHT] += [toppingOnRightPizza]
        }
    }
    
    func loadVeggieToppingsIntoArrays() {
        let defaultAmount = 0
        for imageName in veggiesToppingImageName {
            // let arrayToppingImageName = toppingImageName.characters.split("_")
            let imageNameSplit = imageName.componentsSeparatedByString("_")
            
            var toppingName = ""
            for imageName in imageNameSplit {
                toppingName += imageName.capitalizedString
            }
            let toppingOnWholePizza = Topping(name: toppingName, image: UIImage(named: imageName), amount: defaultAmount)!
            let toppingOnLeftPizza = Topping(name: toppingName + " LEFT", image: nil, amount: defaultAmount)!
            let toppingOnRightPizza = Topping(name: toppingName + " RIGHT", image: nil, amount: defaultAmount)!
            
            veggieToppingsOnPizza[LEFT] += [toppingOnLeftPizza]
            veggieToppingsOnPizza[WHOLE] += [toppingOnWholePizza]
            veggieToppingsOnPizza[RIGHT] += [toppingOnRightPizza]
        }

    }
    
    func loadSauceToppingsIntoArrays() {
        let defaultAmount = 0
        for imageName in saucesToppingImageName {
            // let arrayToppingImageName = toppingImageName.characters.split("_")
            let imageNameSplit = imageName.componentsSeparatedByString("_")
            
            var toppingName = ""
            for imageName in imageNameSplit {
                toppingName += imageName.capitalizedString
            }
            let toppingOnWholePizza = Topping(name: toppingName, image: UIImage(named: imageName), amount: defaultAmount)!
            let toppingOnLeftPizza = Topping(name: toppingName + " LEFT", image: nil, amount: defaultAmount)!
            let toppingOnRightPizza = Topping(name: toppingName + " RIGHT", image: nil, amount: defaultAmount)!
            
            sauceToppingsOnPizza[LEFT] += [toppingOnLeftPizza]
            sauceToppingsOnPizza[WHOLE] += [toppingOnWholePizza]
            sauceToppingsOnPizza[RIGHT] += [toppingOnRightPizza]
        }
        
    }
    
    func loadCheeseToppingsIntoArrays() {
        let defaultAmount = 0
        for imageName in cheesesToppingImageName {
            // let arrayToppingImageName = toppingImageName.characters.split("_")
            let imageNameSplit = imageName.componentsSeparatedByString("_")
            
            var toppingName = ""
            for imageName in imageNameSplit {
                toppingName += imageName.capitalizedString
            }
            let toppingOnWholePizza = Topping(name: toppingName, image: UIImage(named: imageName), amount: defaultAmount)!
            let toppingOnLeftPizza = Topping(name: toppingName + " LEFT", image: nil, amount: defaultAmount)!
            let toppingOnRightPizza = Topping(name: toppingName + " RIGHT", image: nil, amount: defaultAmount)!
            
            cheeseToppingsOnPizza[LEFT] += [toppingOnLeftPizza]
            cheeseToppingsOnPizza[WHOLE] += [toppingOnWholePizza]
            cheeseToppingsOnPizza[RIGHT] += [toppingOnRightPizza]
        }
    }

    // Methods for UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // RETURN THE RIGHT COUNT IF 0 TABLE VIEW WILL NOT RUN
        // return meatsOnWhole.count
        // return the number of table views
        // return meatToppingsOnPizza[WHOLE].count
        switch tableView {
        case meatsTableView:
            return meatToppingsOnPizza[WHOLE].count
        case veggiesTableView:
            return veggieToppingsOnPizza[WHOLE].count
        case saucesTableView:
            return sauceToppingsOnPizza[WHOLE].count
        case cheesesTableView:
            return cheeseToppingsOnPizza[WHOLE].count
        default:
            print("EMPTY TABLE VIEW")
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Use different name for the identifier. (Think it uses the .swift from the dequeue not the identifer)
        let cell = tableView.dequeueReusableCellWithIdentifier("ToppingTableViewCellIdentifier", forIndexPath: indexPath) as! ToppingTableViewCell
        
        // Rename toppingTableView variable for clarity
        let toppingTableView: Array<Topping>
        switch tableView {
        case meatsTableView:
            toppingTableView = meatToppingsOnPizza[WHOLE]
        case veggiesTableView:
            toppingTableView = veggieToppingsOnPizza[WHOLE]
        case saucesTableView:
            toppingTableView = sauceToppingsOnPizza[WHOLE]
        case cheesesTableView:
            toppingTableView = cheeseToppingsOnPizza[WHOLE]
        default:
            toppingTableView = []
            print("No type")
        }
        
        let topping = toppingTableView[indexPath.row]
        cell.toppingLabel.text = topping.name
        cell.toppingImage.image = topping.image
        cell.toppingAmountSegmentedControl.selectedSegmentIndex = topping.amount

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }

}

