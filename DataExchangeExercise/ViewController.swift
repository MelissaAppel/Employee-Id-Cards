//
//  ViewController.swift
//  DataExchangeExercise
//
//  Created by Melissa Appel on 1/13/21.
//

import Cocoa
import PythonKit



class ViewController: NSViewController {
    
    let dirPath = "" //FIXME : Add project directory path e.g.: /Users/melissaappel/Admin/EmployeeIDCards/EmployeeIDCards/
    let jsonFileName = "UserData"
    var swiftUserData : Data?
    var users : [Users]?
    var pageNum = 0
    let employeeCount = 10
    
    @IBOutlet weak var employeePhoto: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var ageLabel: NSTextField!
    @IBOutlet weak var hireDateLabel: NSTextField!
    @IBOutlet weak var salaryLabel: NSTextField!
    
    
    override func viewDidLoad() {
        PythonLibrary.useVersion(3, 9)
        super.viewDidLoad()
        runPythonCode()
        swiftUserData = readLocalFile(forName: jsonFileName)
        parseJSON()
        populateTextFields(pageNumber: pageNum, employees: users)
        selectImage(element: pageNum)
    }
    
    //run python file which export data to UserData.json
    func runPythonCode(){
      let sys = Python.import("sys")
      sys.path.append(dirPath)
      let pythonFile = Python.import("Users")
      pythonFile.writeToJSONFile()
    }
    
    //Obtain JSON data from UserData.json
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("error")
        }
        return nil
    }
    
    //Decode JSON data
    func parseJSON() {
        users = try? JSONDecoder().decode([Users].self, from: swiftUserData!)
    }
    
    //Update Employee Photo
    func selectImage(element : Int) {
        let imageLocation = Bundle.main.path(forResource: String(element), ofType: "png", inDirectory: "icons/")
        employeePhoto.image = NSImage (contentsOfFile: imageLocation!)
    }
    
    //Update Employee Information
    func populateTextFields(pageNumber : Int, employees : [Users]?) {
        
        nameLabel.stringValue = users![pageNumber].name
        ageLabel.stringValue = users![pageNumber].age
        hireDateLabel.stringValue = users![pageNumber].hiredate
        salaryLabel.stringValue = users![pageNumber].salary
        selectImage(element: pageNum)
    }
    
    //Changes employee to display when next button is pressed
    @IBAction func nextPagePressed(_ sender: NSButtonCell) {
        if pageNum < employeeCount - 1 {
            pageNum += 1
            populateTextFields(pageNumber: pageNum, employees: users)
        } else {
            pageNum = 0
            populateTextFields(pageNumber: pageNum, employees: users)
        }
    }
    
}

