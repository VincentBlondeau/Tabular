Class {
	#name : #XLSXSheetParser,
	#superclass : #TabularSAXParser,
	#instVars : [
		'rowCounter',
		'colCounter'
	],
	#category : #'Tabular-SAXParser'
}

{ #category : #'as yet unclassified' }
XLSXSheetParser class >> parse: aStringOrStream [
	"Parse document in argument string or stream; method inserted for debugging purposes."

	| sheet |
	sheet := super parse: aStringOrStream.
	"self halt."
	^ sheet
]

{ #category : #initialization }
XLSXSheetParser >> buildRootObject [
	^ TabularWorksheet new.
]

{ #category : #elements }
XLSXSheetParser >> c_end [
	parsingStack pop.
	colCounter := colCounter + 1.
]

{ #category : #elements }
XLSXSheetParser >> c_start: properties [
|cell coord|
	cell := TabularCell new.

	properties at: #s ifPresent:[:styleId| cell style: styleId]. "Should be substituted by actual style upon finalisation"
	properties at: #t ifPresent:[:type| cell attributeAt: 'xlsx:t' put: type].

	properties at: #r ifPresent: [:r| coord := r asPoint].
	coord
		ifNil: [ coord := colCounter @ rowCounter  ]
		ifNotNil: [ colCounter := coord x ]. "It's expected that row of r attribute is always points to current row. If it is not - have no idea how to manage this"
	
	self worksheet at: coord putCell: cell.
		
	parsingStack push: cell.
]

{ #category : #accessing }
XLSXSheetParser >> cell [
| current |
	current := parsingStack top.
	^current isTabularCell
		ifTrue: [ current ]
		ifFalse: [ self error: '(Tabular)Cell expected at this stage of parsing, but found: ', current class name]
]

{ #category : #initialization }
XLSXSheetParser >> initialize [
	super initialize.
	colCounter := 1.
	rowCounter := 1.

]

{ #category : #'as yet unclassified' }
XLSXSheetParser >> parsingResult [
	^ self worksheet
]

{ #category : #'handling - content' }
XLSXSheetParser >> registeredElements [
	^ #(row c v)
]

{ #category : #elements }
XLSXSheetParser >> row_end [
	rowCounter := rowCounter + 1.
]

{ #category : #elements }
XLSXSheetParser >> row_start: properties [
	properties at: 'r' ifPresent: [ :r | rowCounter := r asNumber ].
	colCounter := 1
]

{ #category : #elements }
XLSXSheetParser >> v_characters: aString [
	self cell data: aString.
]

{ #category : #accessing }
XLSXSheetParser >> worksheet [
	| current |
	current := parsingStack top.
	^ current isTabularWorksheet
		ifTrue: [ current ]
		ifFalse: [ self error: '(Tabular)Worksheet expected at this stage of parsing, but found: ' , current class name ]
]
