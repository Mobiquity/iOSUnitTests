//: Playground - noun: a place where people can play

import XCTest

// MARK: Protocols

// A Service contains the code that would make a request to an endpoint, parse the returned values, and pass them along in a completion block
protocol FetchService {
    func get(with completion: (FetchServiceResult) -> Void  )
}

/// A configuration would contain any methods, constants or variables needed for a service to make a request.
protocol FetchConfiguration {
    var service: FetchService { get }
}

/// Payload is a catch-all definition of any object that could be returned by our Fetch Service
protocol Payload { }

/// A generalized return type for any Fetch Service Request.
enum FetchServiceResult {
    case success([Payload])
    case failure(Error)
}

// MARK: - Structs

// The actual Customer object that will be returned from our Fetch Service.
struct Customer: Payload, Equatable {
    let firstName: String
    let lastName: String
    let email: String
    
    // Equatable
    static func ==(lhs: Customer, rhs: Customer) -> Bool {
        return lhs.firstName == rhs.firstName &&
               lhs.lastName == rhs.lastName &&
               lhs.email == rhs.email
    }
}

// The default service that contains actual networking code
struct CustomerService: FetchService {
    
    func get(with completion: (FetchServiceResult) -> Void) {
        // Real network code is written here
    }
    
}

// Our configuration struct that would be needed to support the CustomerService
struct CustomerConfiguration: FetchConfiguration {
    var service: FetchService = CustomerService()
}

// MARK: - Netowkring Layer

// Our networking layer that contains methods with configurations and completion blocks injected.
struct NetworkingLayer {
    
    // Using the default property values, we have our live/real CustomerConfiguration being injected by default
    static func getCustomer(with configuration: FetchConfiguration = CustomerConfiguration(), and completion: (FetchServiceResult) -> Void) {
        configuration.service.get(with: completion)
    }
    
}

// MARK: Mocks

// Our Mock of the FetchService that will always return a success value
struct MockSuccessFetchService: FetchService {
    
    func get(with completion: (FetchServiceResult) -> Void) {
        let fakeCustomer = Customer(firstName: "Johnny", lastName: "Appleseed", email: "jappleseed@mobiquityinc.com")
        let success = FetchServiceResult.success([fakeCustomer])
        completion(success)
    }
    
}

// Our Mock of the FetchService that will always return a failure value
struct MockFailureFetchService: FetchService {
    
    struct FakeError: Error {}
    func get(with completion: (FetchServiceResult) -> Void) {
        let error = FakeError()
        let failure = FetchServiceResult.failure(error)
        completion(failure)
    }
    
}

// Our injectable configuration to force a success
struct MockSuccessConfiguration: FetchConfiguration {
    var service: FetchService = MockSuccessFetchService()
}

// Our injectable configuration to force a failure
struct MockFailureConfiguration: FetchConfiguration {
    var service: FetchService = MockFailureFetchService()
}

// MARK: - Tests

class CustomerFetchTests: XCTestCase {

    func testCustomerFetchService_get_returnsCustomer() {
        
        // Arrange
        let successConfiguration = MockSuccessConfiguration()
        let expectation = XCTestExpectation(description: "Correct Customer struct expectation") // Expectation for asynchronous testing
        let completion: (FetchServiceResult) -> Void = { result in
            
            switch result {
            case .success(let customers) where customers is [Customer]:                         // Verify that our reutrn contains Customer values
                print(customers)
                expectation.fulfill()                                                           // Pass the test
            default:
                break
            }
            
        }
        // Act
        NetworkingLayer.getCustomer(with: successConfiguration, and: completion)                // Call our mock

        // Assert
        let expected = XCTWaiter.Result.completed                                               // Set up our expectation
        let actual = XCTWaiter().wait(for: [expectation], timeout: 5)                           // Our async test with timeout
        XCTAssertEqual(expected, actual, "\(expectation.description) failed")                   // Final assertion
        
    }
    
    func testCustomerFetchService_get_returnsError() {
        
        // Arrange
        let failureConfiguration = MockFailureConfiguration()
        let expectation = XCTestExpectation(description: "Correct error expectation")           // Expectation for asynchronous testing
        let completion: (FetchServiceResult) -> Void = { result in                              // Verify that our reutrn contains Customer values
            
            switch result {
            case .failure(_):
                expectation.fulfill()
            default:
                break
            }
            
        }
        // Act
        NetworkingLayer.getCustomer(with: failureConfiguration, and: completion)                // Call our mock

        // Assert
        let expected = XCTWaiter.Result.completed                                               // Set up our expectation
        let actual = XCTWaiter().wait(for: [expectation], timeout: 5)                           // Our async test with timeout
        XCTAssertEqual(expected, actual, "\(expectation.description) failed")                   // Final assertion
    }
    
}

// Run our test suite
CustomerFetchTests.defaultTestSuite.run()

