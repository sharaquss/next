//
//  ViewController.swift
//  next
//
//  Created by Przemyslaw Jablonski on 25/03/2018.
//  Copyright © 2018 Przemyslaw Jablonski. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    lazy var eventStore: EKEventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("eventStore: %@", eventStore)
        let privacyAuthorized = checkAuthorizationStatus(eventStore: eventStore)
        eventStore.requestAccess(to: EKEntityType.event, completion: { (granted, error) in
            NSLog("requesting access for: event, granted: \(granted), error: \(error)")
        })
        eventStore.requestAccess(to: EKEntityType.reminder, completion: { (granted, error) in
            NSLog("requesting access for: reminder, granted: \(granted), error: \(String(describing: error))")
        })
        let calendars = eventStore.calendars(for: EKEntityType.event)
        NSLog("calendars: %@", calendars)
    }
    
    private func checkAuthorizationStatus(eventStore: EKEventStore) -> Bool {
        let authorizationStatusEvents = EKEventStore.authorizationStatus(for: EKEntityType.event)
        let authorizationStatusReminders = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
        NSLog("EventStore authorization status, events: \(authorizationStatusEvents), reminders: \(authorizationStatusReminders)")
        return authorizationStatusEvents == EKAuthorizationStatus.authorized && authorizationStatusReminders == EKAuthorizationStatus.authorized
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
