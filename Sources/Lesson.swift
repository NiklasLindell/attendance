import PerfectHTTP

public class Lesson {
    
    var data = [Student]()
    
    // Populating with a mock data object
    init(){
        data = [
            Student(firstName: "Niklas", lastName: "Lindell", studentID: "01", attendance: "Närvarande" ),
            Student(firstName: "Matilda", lastName: "Dahlberg", studentID: "02", attendance: "Närvarande" ),
            Student(firstName: "Pelle", lastName: "Pelleson", studentID: "03", attendance: "Närvarande" )
        ]
    }
    // A simple JSON encoding function for listing data members.
    // Ordinarily in an API list directive, cursor commands would be included.
    public func list() -> String {
        return toString()
    }
    
    public func removeStudent(studentID: String) {
        if let ID = searchForStudentID(studentId : studentID) {
            data.remove(at: ID)
        }
    }

    public func adjustAttendance(studentId: String) {
        for student in data {
            if (student.studentID == studentId) {
                if (student.attendance == "Närvarande"){
                    student.attendance = "Icke närvarande"
                } else {
                    student.attendance = "Närvarande"
                }
            }
        }
    }
    
    func searchForStudentID(studentId: String) -> Int? {
        var i = 0
        for student in data {
            if (student.studentID == studentId){
                return i
            }
            i += 1
        }
        return nil
    }
    
    // Accepts the HTTPRequest object and adds a new student from post params.
    public func add(_ request: HTTPRequest) -> String{
        let new = Student(
            firstName: request.param(name: "firstName") ?? "",
            lastName: request.param(name: "lastName") ?? "",
            studentID: request.param(name: "studentID") ?? "",
            attendance: request.param(name: "attendance") ?? ""
        )
        data.append(new)
        return toString()
    }
    
    // Accepts raw JSON string, to be converted to JSON and consumed.
    public func add(_ json: String) -> String {
        do {
            let incoming = try json.jsonDecode() as! [String: String]
            let new = Student(
                firstName: incoming["firstName"] ?? "",
                lastName: incoming["lastName"] ?? "",
                studentID: incoming["studentID"] ?? "",
                attendance: incoming["attendance"] ?? ""
            )
            data.append(new)
        } catch {
            return "ERROR"
        }
        return toString()
    }
    // Convenient encoding method that returns a string from JSON objects.
    private func toString() -> String {
        var out = [String]()
        
        for m in self.data {
            do {
                out.append(try m.jsonEncodedString())
            } catch {
                print(error)
            }
        }
        return "[\(out.joined(separator: ","))]"
    }
}
