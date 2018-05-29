import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()
let lesson = Lesson()

// Create the container variable for routes to be added to.
var routes = Routes()


// Adding a route to display all students
routes.add(method: .get, uri: "/attendance", handler: {
    request, response in
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: lesson.list())
    response.completed()
    }
)

// Adding a route to post a new student in lesson
routes.add(method: .post, uri: "/attendance", handler: {
    request, response in
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: lesson.add(request))
    response.completed()
    }
)

//Adding a route to delete a student
routes.add(method: .delete, uri: "/attendance/{studentId}", handler: {
    request, response in
    
    if let studentId = request.urlVariables["studentId"] {
        lesson.removeStudent(studentID: studentId)
    }
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: lesson.list())
    response.completed()
    }
)

//Adding a route to adjust attendance on a student
routes.add(method: .put, uri: "/attendance/{studentId}", handler: {
    request, response in
    
     if let studentId = request.urlVariables["studentId"] {
        lesson.adjustAttendance(studentId: studentId)
    }
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: lesson.list())
    response.completed()
    }
)

// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

do {
    // Launch the HTTP server.
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
