//
//  CreateSingularGoalViewController.swift
//  Ghosting Connector
//
//  Created by Varun Chitturi on 6/8/20.
//  Copyright © 2020 Squash Dev. All rights reserved.
//

import UIKit
import CoreData
import CoreBluetooth
class CreateSingularGoalViewController: UIViewController, UITextFieldDelegate {
    var mainSetGoalsView: SetYourGoalsViewController!
    var goalArray = [Goal]()
    @IBOutlet weak var numGhostsField: UITextField!
    @IBOutlet weak var numMinutesField: UITextField!
    @IBOutlet weak var numSecondsField: UITextField!
	@IBOutlet weak var numSetsField: UITextField!
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
		if numGhostsField.text == ""{
			numGhostsField.text = "0"
		}
		if numMinutesField.text == ""{
			numMinutesField.text = "0"
		}
		if numSecondsField.text == ""{
			numSecondsField.text = "0"
		}
		if numSetsField.text == ""{
			numSetsField.text = "0"
		}
		
    }
	@IBAction func setFieldSelected(_ sender: Any) {
		if numGhostsField.text == ""{
			numGhostsField.text = "0"
		}
		if numMinutesField.text == ""{
			numMinutesField.text = "0"
		}
		if numSecondsField.text == ""{
			numSecondsField.text = "0"
		}
		if numSetsField.text == ""{
			numSetsField.text = "0"
		}
		numSetsField.text = ""
	}
	@IBAction func ghostFieldSelected(_ sender: Any) {
		if numGhostsField.text == ""{
			numGhostsField.text = "0"
		}
		if numMinutesField.text == ""{
			numMinutesField.text = "0"
		}
		if numSecondsField.text == ""{
			numSecondsField.text = "0"
		}
		if numSetsField.text == ""{
			numSetsField.text = "0"
		}
		numGhostsField.text = ""
	}
	@IBAction func minuteFieldSelected(_ sender: Any) {
		if numGhostsField.text == ""{
			numGhostsField.text = "0"
		}
		if numMinutesField.text == ""{
			numMinutesField.text = "0"
		}
		if numSecondsField.text == ""{
			numSecondsField.text = "0"
		}
		if numSetsField.text == ""{
			numSetsField.text = "0"
		}
		numMinutesField.text = ""
	}
	
	@IBAction func secondFieldSelected(_ sender: Any) {
		if numGhostsField.text == ""{
			numGhostsField.text = "0"
		}
		if numMinutesField.text == ""{
			numMinutesField.text = "0"
		}
		if numSecondsField.text == ""{
			numSecondsField.text = "0"
		}
		if numSetsField.text == ""{
			numSetsField.text = "0"
		}
		numSecondsField.text = ""
	}
	func textFieldDidEndEditing(_ textField: UITextField) {
		if numGhostsField.text == ""{
			numGhostsField.text = "0"
		}
		if numMinutesField.text == ""{
			numMinutesField.text = "0"
		}
		if numSecondsField.text == ""{
			numSecondsField.text = "0"
		}
		if numSetsField.text == ""{
			numSetsField.text = "0"
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard (_:)))
               self.view.addGestureRecognizer(tapGesture)
               numGhostsField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
           numGhostsField.resignFirstResponder()
       }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 124)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction func addGoal(_ sender: Any) {
		if(((numSecondsField.text! as NSString).integerValue) < 60 && ((numSecondsField.text! as NSString).integerValue) >= 0 && ((numMinutesField.text! as NSString).integerValue) < 60 && ((numMinutesField.text! as NSString).integerValue) >= 0 && numMinutesField.text! != "" && numSecondsField.text! != "" && numGhostsField.text! != "" && numGhostsField.text != "0" && numSetsField.text != "0" && numSetsField.text != ""){
            
        
        self.dismiss(animated: true, completion: nil)
			if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let goal = Goal(context: context)
            goal.seconds = Int64((numSecondsField.text! as NSString).integerValue)
            goal.minutes = Int64((numMinutesField.text! as NSString).integerValue)
            goal.ghosts = Int64((numGhostsField.text! as NSString).integerValue)
			goal.sets = Int64((numSetsField.text! as NSString).integerValue)
            goal.isCompleted = false
            goal.order = Int64(goalArray.count+1)
            }
            //let finalData = joke()
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        mainSetGoalsView.getGoals()
        mainSetGoalsView.childView?.tableView.reloadData()
        }
        else{
             let alertVC = UIAlertController(title: "Values not in range", message: "Make sure that your minutes and seconds are between 0 and 59 and your ghosts and sets are greater than 0.", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) -> Void in
                alertVC.dismiss(animated: true, completion: nil)
                //add segue
            })
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
