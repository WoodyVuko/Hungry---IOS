//
//  Threading.swift
//  Hungry
//
//  Created by Goran Vukovic on 17.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import Foundation

infix operator ~> {}

/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
*/
func ~> (
    backgroundClosure: () -> (),
    mainClosure:       () -> ())
{
    dispatch_async(queue) {
        backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), mainClosure)
    }
}

/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
Passes the background closure's output to the main closure.
*/
func ~> <R> (
    backgroundClosure: () -> R,
    mainClosure:       (result: R) -> ())
{
    dispatch_async(queue) {
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), {
            mainClosure(result: result)
        })
    }
}

/** Serial dispatch queue used by the ~> operator. */
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)