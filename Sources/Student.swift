import PerfectLib

class Student : JSONConvertibleObject {
    
    static let registerName = "student"
    
    var firstName: String = ""
    var lastName: String = ""
    var studentID: String = ""
    var attendance: String = ""
    
    var student: String {
        return "\(firstName) \(lastName) \(studentID) \(attendance)"
    }
    
    init(firstName: String, lastName: String, studentID: String, attendance: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.studentID = studentID
        self.attendance = attendance

    }
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.firstName = getJSONValue(named: "firstName", from: values, defaultValue: "")
        self.lastName = getJSONValue(named: "lastName", from: values, defaultValue: "")
        self.studentID = getJSONValue(named: "studentID", from: values, defaultValue: "")
        self.attendance = getJSONValue(named: "attendance", from: values, defaultValue: "")
        
        
    }
    override public func getJSONValues() -> [String : Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "studentID": studentID,
            "attendance": attendance
        ]
    }
    
}
