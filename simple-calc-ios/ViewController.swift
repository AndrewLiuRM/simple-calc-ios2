//
//  ViewController.swift
//  simple-calc-ios
//
//  Created by 刘睿铭 on 10/21/17.
//  Copyright © 2017 Andrew Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var times:Int = 0
    public var data:[String] = [];
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TableController
        {
            let vc = segue.destination as? TableController
            vc?.data = self.data;
        }
    }
    
    @IBAction func goBack(unwindSegue: UIStoryboardSegue) {
        
    }
    @IBAction func spaceClick(_ sender: Any) {
        getBorder.text = "\(getBorder.text!) "
    }
    @IBOutlet weak var bar: UISegmentedControl!
    @IBAction func factClick(_ sender: Any) {
        if bar.selectedSegmentIndex == 0 {
            var record: String
            var result: String
            var scan = MyScanner(getBorder.text!);
            result = String(fact(Int(Double(scan.next())!)))
            record = getBorder.text! + " Fact = " + result;
            data.append(record);
            getBorder.text = result;
        } else {
            getBorder.text = "\(getBorder.text!) Fact"
        }


    }
    @IBAction func calculate(_ sender: UIButton) {
        var record: String
        var result: String
        if bar.selectedSegmentIndex == 0 {
            result = String(process())

        } else {
            result = String(rpn())
        }
        record = getBorder.text! + " = " + result;
        data.append(record);
        getBorder.text = result;
        if (times == 4) {
            times = 0;
            self.performSegue(withIdentifier: "showAd", sender: self)
        } else {
            times = times + 1;
        }
    }
    
    func rpn() -> Double {
        var data = getBorder.text!.split(separator: " ");
        switch data[data.count - 1] {
        case "Count":
            return Double(data.count - 1);
        case "Avg":
            var result = 0.0
            for num in 0...(data.count - 2) {
                result = result + Double(data[num])!
            }
            return result / Double(data.count - 1);
        case "+":
            var result = 0.0
            for num in 0...(data.count - 2) {
                result = result + Double(data[num])!
            }
            return result
        case "-":
            var result = Double(data[0])
            for num in 1...(data.count - 2) {
                result = result! - Double(data[num])!
            }
            return result!
        case "*":
            var result = Double(data[0])
            for num in 1...(data.count - 2) {
                result = result! * Double(data[num])!
            }
            return result!
        case "/":
            var result = Double(data[0])
            for num in 1...(data.count - 2) {
                result = result! / Double(data[num])!
            }
            return result!
        case "%":
            var result = Double(data[0])
            for num in 1...(data.count - 2) {
                result = Double(Int(result!) % Int(Double(data[num + 1])!))
            }
            return result!
        case "Fact":
            return Double(fact(Int(Double(data[0])!)))
        default:
            return 0.0;
        }
    }
    
    func process() -> Double {
        
        var scan = MyScanner(getBorder.text!);
        var result = Double(scan.next());
        var count = 1.0;
        while (scan.hasNext()) {
            NSLog("execute")
            var input = scan.next()
            NSLog(input)
            switch input {
            case "Count":
                NSLog("Count")
                while (scan.hasNext()) {
                    var current = scan.next();
                    if current != "Count" {
                        count = count + 1;
                    }
                }
                return count;
            case "Avg":
                NSLog("avg")
                while (scan.hasNext()) {
                    var current = scan.next();
                    if current != "Avg" {
                        result = result! + Double(current)!;
                        count = count + 1;
                    }
                }
                return result! / count;
            case "+":
                result = result! + Double(scan.next())!
            case "-":
                result = result! - Double(scan.next())!
            case "*":
                result = result! * Double(scan.next())!
            case "/":
                result = result! / Double(scan.next())!
            case "%":
                result = Double(Int(result!) % Int(Double(scan.next())!))
            default:
                return 0.0;
            }
        }
        return result!;
    }
    
    func fact(_ input: Int) -> Int{
        if input == 0 {
            return 0;
        }
        var current = input;
        var result = 1;
        while current != 0 {
            result = result * current;
            current = current - 1;
        }
        return result;
    }
    
    @IBAction func backClick(_ sender: UIButton) {
        getBorder.text! = "0"
    }
    @IBAction func operatorClick(_ sender: UIButton) {
        getBorder.text! = "\(getBorder.text!) \(sender.currentTitle!) "
    }
    
    @IBAction func numberClick(_ sender: UIButton) {
        if getBorder.text! != "0" {
            getBorder.text! = "\(getBorder.text!)\(sender.currentTitle!)";
        } else {
            getBorder.text! = sender.currentTitle!;
        }
    }

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var getBorder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttons {
            button.layer.cornerRadius = 10
        }
        getBorder.layer.cornerRadius = 10
        getBorder.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class MyScanner {
    private var target: [String] = []
    private let length:Int
    private var current:Int = 0
    init(_ string: String) {
        var data = string.split(separator: " ");
        for one in data {
            target.append(String(one));
        }
        length = target.count;
    }
    
    public func next() -> String {
        var result = target[current]
        current = current + 1;
        return result;
    }
    
    public func hasNext() -> Bool {
        NSLog(String(current < length))
        return current < length
    }
}

