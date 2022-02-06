import XCTest
import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        let number = 8

        let expectation = XCTestExpectation(description: "We asked about the number 8 and heard back 🎄")
        var isLuckyNumber: Bool?
        print("One")

        // When
        myLibrary.isLucky(number, completion: { lucky in
            print("Two")
            isLuckyNumber = lucky
            expectation.fulfill()
        })

        print("Three")

        wait(for: [expectation], timeout: 5)

        print("Four")

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsLuckyBecauseWeatherHasAnEight() throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        let number = 0
        let expectation = XCTestExpectation(description: "We asked about the number 8 and heard back 🎄")
        var isLuckyNumber: Bool?
        print("Five")
        

        // When
        myLibrary.isLucky(number, completion: { lucky in
            print("Six")
            isLuckyNumber = lucky
            expectation.fulfill()
        })
        print("Seven")

        wait(for: [expectation], timeout: 5)
        print("Eight")

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        let number = 7
        let expectation = XCTestExpectation(description: "We asked about the number 7 and heard back 🌲")
        var isLuckyNumber: Bool?

        // When
        myLibrary.isLucky(number, completion: { lucky in
            isLuckyNumber = lucky
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 5)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        let number = 7
        let expectation = XCTestExpectation(description: "We asked about the number 7 but the service call failed 🤖💩")
        var isLuckyNumber: Bool?

        // When
        myLibrary.isLucky(number, completion: { lucky in
            isLuckyNumber = lucky
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 5)

        // Then
        XCTAssertNil(isLuckyNumber)
    }

}
