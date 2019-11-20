//
//  Extensions.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Time
struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var miliSeconds: Int
}

#if os(iOS)
// MARK: - UIView
extension UIView {
    /// cleanin subviews
    func removeSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// adding UIActivityIndicatorView for image
    func appendDowloadView(style: UIActivityIndicatorView.Style = .medium) {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.center = self.center
        spinner.startAnimating()
        self.addSubview(spinner)
    }
}
#endif

// MARK: - Array
extension Array {
    
    func chunk(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map({ startIndex -> [Element] in
            let endIndex = (startIndex.advanced(by: chunkSize) > self.count) ? self.count - startIndex : chunkSize
            return Array(self[startIndex..<startIndex.advanced(by: endIndex)])
        })
    }
}

// MARK: - Int
extension Int {
    
    var isFirst: Bool {
        return self == 0
    }
    
    var timeInterval: String {
        let minutes = Int(self / 60)
        let seconds = Int(Double(self).truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d",
                      arguments: [minutes, seconds])
    }
    
    var timeView: String {
        if self < 10 {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
    
    var timeIntervalInMilliSec: Date {
        let interval = self / 1_000
        return Date(timeIntervalSince1970: Double(interval))
    }
    
    var miliSec: Int {
        return self * 1_000
    }
    
    func getReadableDate() -> String? {
        let date = Date(timeIntervalSince1970: TimeInterval(self / 1_000))
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow".localized
        } else if Calendar.current.isDateInYesterday(date) {
            dateFormatter.dateFormat = "h:mm a"
            return "Yesterday, ".localized + dateFormatter.string(from: date)
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return "Today, ".localized + dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE, h:mm a"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    
    func getCount() -> String {
        if self > 99 {
            return "99+".localized
        } else {
            return "\(self)"
        }
    }
    
    /// secondsToHoursMinutesSeconds convertor
    ///
    /// - Returns: Time
    var secondsToHoursMinutesSeconds: Time {
        return Time(hours: self / 3_600, minutes: (self % 3_600) / 60, seconds: (self % 3_600) % 60, miliSeconds: ((self % 3_600) % 60) / 1_000)
    }
    
    /// miliSecondsToHoursMinutesSeconds convertor
    ///
    /// - Returns: Time
    var miliSecondsToHoursMinutesSeconds: Time {
        let seconds = self / 1_000
        return seconds.secondsToHoursMinutesSeconds
    }
}

// MARK: - Date
extension Date {
    
    var intMillisecondsSince1970: Int {
        return Int(self.timeIntervalSince1970 * 1_000.0)
    }
    
    var millisecondsSince1970: Int {
        return Int((self.timeIntervalSince1970 * 1_000.0).rounded())
    }
    
    func formattedTime(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

// MARK: - String
extension String {
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,24}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: self)
        return result
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    var isValidUserName: Bool {
        let userNameRegEx = "^\\w{5,30}$"
        let userNameText = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        let result = userNameText.evaluate(with: self)
        return result
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    static func objectId() -> String {
        let time = String(Int(NSDate().timeIntervalSince1970), radix: 16, uppercase: false)
        let machine = String(arc4random_uniform(900_000) + 100_000)
        let pid = String(arc4random_uniform(9_000) + 1_000)
        let counter = String(arc4random_uniform(900_000) + 100_000)
        return time + machine + pid + counter
    }
}

// MARK: - Encodable
extension Encodable {
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
}

// MARK: - UIImage
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

// MARK: - CALayer
extension CALayer {
    
    /// Add layer transition without using duration and animations
    ///
    /// - Parameter actionsWithoutAnimation: clouser for action
    func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void) {
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
}
