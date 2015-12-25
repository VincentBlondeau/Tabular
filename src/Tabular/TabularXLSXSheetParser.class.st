"
I am a TabularXLSXSheetParser and parse the XML of a sheet. See test case for an example. I am only interested in certain elements and ignore the rest. The elements I am interested in are defined in #registeredElements. I returen a TabularWorksheet object.


For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

TabularXLSXSheetParser parse: anXMLString.
   
 
Internal Representation and Key Implementation Points.

    Instance Variables
	colCounter:		<Object>
	rowCounter:		<Object>


    Implementation Points
"
Class {
	#name : #TabularXLSXSheetParser,
	#superclass : #TabularSAXParser,
	#instVars : [
		'rowCounter',
		'colCounter',
		'columnAttributes'
	],
	#category : #'Tabular-SAXParser'
}

{ #category : #'as yet unclassified' }
TabularXLSXSheetParser class >> parse: aStringOrStream [
	"Parse document in argument string or stream; method inserted for debugging purposes."

	| sheet |
	sheet := super parse: aStringOrStream.
	"self halt."
	^ sheet
]

{ #category : #initialization }
TabularXLSXSheetParser >> buildRootObject [
	^ TabularWorksheet new.
]

{ #category : #elements }
TabularXLSXSheetParser >> c_end [
	parsingStack pop.
	colCounter := colCounter + 1.
]

{ #category : #elements }
TabularXLSXSheetParser >> c_start: properties [
|cell coord|
	cell := TabularCell new.

	properties at: #s ifPresent:[:styleId| cell style: styleId]. "Should be substituted by actual style upon finalisation"
	properties at: #t ifPresent:[:type| cell attributeAt: 'xlsx:t' put: type. cell type: type].

	properties at: #r ifPresent: [:r| coord := r asPoint].
	coord
		ifNil: [ coord := colCounter @ rowCounter  ]
		ifNotNil: [ colCounter := coord x ]. "It's expected that row of r attribute is always points to current row. If it is not - have no idea how to manage this"
	
	self worksheet at: coord putCell: cell.
		
	parsingStack push: cell.
]

{ #category : #accessing }
TabularXLSXSheetParser >> cell [
| current |
	current := parsingStack top.
	^current isTabularCell
		ifTrue: [ current ]
		ifFalse: [ self error: '(Tabular)Cell expected at this stage of parsing, but found: ', current class name]
]

{ #category : #elements }
TabularXLSXSheetParser >> col_start: properties [
	columnAttributes add: properties.
]

{ #category : #'as yet unclassified' }
TabularXLSXSheetParser >> guessType: aString [
	^NumberParser parse: aString onError: [:e| aString ]
]

{ #category : #initialization }
TabularXLSXSheetParser >> initialize [
	super initialize.
	colCounter := 1.
	rowCounter := 1.
	columnAttributes := OrderedCollection new.

]

{ #category : #'as yet unclassified' }
TabularXLSXSheetParser >> parsingResult [
       | ws |
       ws := self worksheet.
       ws columnAttributes: columnAttributes. 
	^ ws
]

{ #category : #'handling - content' }
TabularXLSXSheetParser >> registeredElements [
	^ #(row c v t col)
]

{ #category : #elements }
TabularXLSXSheetParser >> row_end [
	rowCounter := rowCounter + 1.
]

{ #category : #elements }
TabularXLSXSheetParser >> row_start: properties [
	properties at: 'r' ifPresent: [ :r | rowCounter := r asNumber ].
	colCounter := 1
]

{ #category : #elements }
TabularXLSXSheetParser >> t_characters: aString [
	self cell data: aString.
]

{ #category : #elements }
TabularXLSXSheetParser >> v_characters: aString [
"maybe the test below is not necessary as the type is always number in a v tag?"

	self cell type ifNil: [ self cell data: (self guessType: aString). ^self ].

	(self cell type = 'n') ifTrue: [ self cell data: aString asNumber. ^self ].
	
	
	self cell data: aString.
]

{ #category : #accessing }
TabularXLSXSheetParser >> worksheet [
	| current |
	current := parsingStack top.
	^ current isTabularWorksheet
		ifTrue: [ current ]
		ifFalse: [ self error: '(Tabular)Worksheet expected at this stage of parsing, but found: ' , current class name ]
]
