//
//  KeyRecorder.swift
//
//
//  Created by Bean John on 26/7/2024.
//

import SwiftUI

public struct KeyRecorder: View {

	public init(keys: Binding<[KeyEvent.Key]>, modifiers: Binding<[KeyEvent.Modifier]>) {
		self._keys = keys
		self._modifiers = modifiers
	}
	
	@State private var keyDownMonitor: Any? = nil
	
	@Binding public var keys: [KeyEvent.Key]
	@Binding public var modifiers: [KeyEvent.Modifier]
	
	var keysString: String {
		let keys: String = keys.map({ $0.stringValue }).joined()
		let modifiers: String = modifiers.map({ $0.stringValue }).joined()
		return keys + modifiers
	}
	
	public var body: some View {
		GroupBox {
			HStack {
				Text(keysString)
					.frame(minWidth: 200, minHeight: 50)
				resetButton
			}
		}
		.onAppear {
			addKeyDownMonitor()
		}
		.onDisappear {
			removeMonitors()
		}
	}
	
	private var resetButton: some View {
		Button {
			resetKeys()
		} label: {
			Label("Reset", systemImage: "xmark.circle.fill")
				.labelStyle(.iconOnly)
		}
	}
	
	private func addKeyDownMonitor() {
		keyDownMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
			// Remove all keys
			resetKeys()
			// Identify keys
			for key in KeyEvent.Key.allCases {
				if event.keyCode == key.rawValue {
					// Add key
					keys.append(key)
				}
			}
			// Identify modifiers
			for modifier in KeyEvent.Modifier.allCases {
				if event.cgEvent?.flags.contains(modifier.rawValue) ?? false {
					// Add modifier
					modifiers.append(modifier)
				}
			}
			return event
		}
	}
	
	private func resetKeys() {
		keys = []
		modifiers = []
	}
	
	private func removeMonitors() {
		keyDownMonitor = nil
	}
	
}

#Preview {
	KeyRecorder(
		keys: .constant([.a]),
		modifiers: .constant([.command, .shift])
	)
}
