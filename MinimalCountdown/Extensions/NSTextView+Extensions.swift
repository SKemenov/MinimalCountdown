//
//  NSTextView+Extensions.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov on 03.03.2024.
//

import AppKit

extension NSTextView {
    // I have no storyboards so I need this code to enable keyboard shortcuts work with NSTextView
    override open func performKeyEquivalent(with event: NSEvent) -> Bool {
        let commandKey = NSEvent.ModifierFlags.command.rawValue
        let commandShiftKey = NSEvent.ModifierFlags.command.rawValue | NSEvent.ModifierFlags.shift.rawValue
        let pressedButtonFlag = event.modifierFlags.rawValue & NSEvent.ModifierFlags.deviceIndependentFlagsMask.rawValue
        if event.type == NSEvent.EventType.keyDown {
            guard let pressedButton = event.charactersIgnoringModifiers else { return false }
            if pressedButtonFlag == commandKey {
                switch pressedButton {
                case "x": if NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: self) { return true }
                case "c": if NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: self) { return true }
                case "v": if NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: self) { return true }
                case "a": if NSApp.sendAction(#selector(NSResponder.selectAll(_:)), to: nil, from: self) { return true }
                case "z": if NSApp.sendAction(Selector(("undo:")), to: nil, from: self) { return true }
                default: break
                }
            } else if pressedButtonFlag == commandShiftKey {
                if pressedButton == "Z" {
                    if NSApp.sendAction(Selector(("redo:")), to: nil, from: self) { return true }
                }
            }
        }
        return super.performKeyEquivalent(with: event)
    }
}
