"
I am TabularWorksheet, the model of a sheet in a spreadsheet file.


For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part:  I keep a dictionary of cells with TabularCell objects, TabularColumn and TabularRow objects


Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	cells:		<Object>
	cols:		<Object>
	rows:		<Object>


    Implementation Points
"
Class {
	#name : #TabularWorksheet,
	#superclass : #TabularObject,
	#instVars : [
		'cells',
		'rowStyles',
		'colStyles',
		'columnAttributes'
	],
	#category : #'Tabular-Model'
}

{ #category : #accessing }
TabularWorksheet >> allCoord [
	^cells keys
]

{ #category : #accessing }
TabularWorksheet >> at: coord [
	^ cells at: coord ifAbsent: [ ^ nil ].

]

{ #category : #accessing }
TabularWorksheet >> at: coord putCell: aCell [
	aCell isTabularCell ifFalse: [ self error: 'Expected a TabularCell' ].
	cells at: coord put: aCell.
	^aCell
]

{ #category : #accessing }
TabularWorksheet >> at: coord putData: anObject [
	| cell |
	anObject ifNil: [ ^ self eraseCellAt: coord ].
	cell := cells at: coord ifAbsentPut: [ TabularXLSXCell new ].
	cell data: anObject
]

{ #category : #accessing }
TabularWorksheet >> atColumn: colNum [
	| lastRow column |
	lastRow := self maxNumberOfRows.
	column := Array new: lastRow.
	1 to: lastRow do: [ :idx | 
		column at: idx put: (self col: colNum row: idx) value.
		].
	^column
]

{ #category : #accessing }
TabularWorksheet >> atRow: rowNum [

	| lastColumn row arrayIdx |
	lastColumn := self columns last.
	row := Array new: lastColumn.
	arrayIdx := 1.
	1 to: lastColumn do: [ :idx | 
		row at: arrayIdx put: (self col: idx row: rowNum) value.
		arrayIdx := arrayIdx + 1].
	^row.
]

{ #category : #accessing }
TabularWorksheet >> cellAt: coord [
	^ cells at: coord ifAbsent: [ ^ nil ].

]

{ #category : #accessing }
TabularWorksheet >> cellValuesAsMatrix [
	| matrix rowMax colMax |
	colMax := self maxNumberOfColumns.
	rowMax := self maxNumberOfRows.
	matrix := Matrix rows: rowMax columns: colMax.
	cells associationsDo: [ :assoc | matrix at: assoc key y at: assoc key x put: assoc value value ].
	^ matrix
]

{ #category : #accessing }
TabularWorksheet >> cellsAsMatrix [
	| matrix rowMax colMax |
	colMax := self maxNumberOfColumns.
	rowMax := self maxNumberOfRows.
	matrix := Matrix rows: rowMax columns: colMax.
	cells associationsDo: [ :assoc | matrix at: assoc key y at: assoc key x put: assoc value ].
	^ matrix
]

{ #category : #'iterating elements' }
TabularWorksheet >> cellsDo: aBlock [
	^ cells do: aBlock

]

{ #category : #'iterating elements' }
TabularWorksheet >> cellsKeysAndValuesDo: aBlock [
	^ cells keysAndValuesDo: aBlock

]

{ #category : #removing }
TabularWorksheet >> cleanup [
"Removes the cells without data.
MIND: empty cells may still contain formatting"
	cells keysAndValuesRemove: [ :coord :cell| cell data isNil ].

]

{ #category : #accessing }
TabularWorksheet >> col: colIndex row: rowIndex [
	^self at: (colIndex @ rowIndex).

]

{ #category : #accessing }
TabularWorksheet >> col: colIndex row: rowIndex putData: anObject [
	^self at: (colIndex @ rowIndex) putData: anObject.

]

{ #category : #accessing }
TabularWorksheet >> colStyleAt: aString [
	^colStyles at: aString
]

{ #category : #accessing }
TabularWorksheet >> colStyleAt: aString put: anElement [
	^colStyles at: aString put: anElement
]

{ #category : #accessing }
TabularWorksheet >> cols [
	^self columns
]

{ #category : #accessing }
TabularWorksheet >> columnAttributes [
	^ columnAttributes
]

{ #category : #accessing }
TabularWorksheet >> columnAttributes: anObject [
	columnAttributes := anObject
]

{ #category : #accessing }
TabularWorksheet >> columns [
	^(cells keys collect: [ :coord| coord x]) asSet asOrderedCollection sort
	"ToDo: It's neccessary to avoid code dublication with #rows"
	
]

{ #category : #removing }
TabularWorksheet >> compactify [
"Removes rows and columns without cells.
MIND: 'empty' cells may still contain formatting. in this case they will not be removed. If you need to remove them, use #cleanup beforehead"
| colsSubst rowsSubst |	
	colsSubst := (self cols collectWithIndex: [ :col :i | col->i]) asDictionary.
	rowsSubst := (self rows collectWithIndex: [ :row :i | row->i]) asDictionary.
	
	cells := cells associationsCollect:[:assoc|
		assoc key: 
			(colsSubst at: (assoc key x) ifAbsent: assoc key x)
			@
			(rowsSubst at: (assoc key y) ifAbsent: assoc key y).
		assoc
	]
]

{ #category : #accessing }
TabularWorksheet >> dataAt: aPoint [
	^(self at: aPoint) ifNotNil:[:cell| cell data]
]

{ #category : #accessing }
TabularWorksheet >> dataAtCol: col row: row [
	^(self col: col row: row) ifNotNil: [:cell| cell data].

]

{ #category : #removing }
TabularWorksheet >> eraseCellAt: coord [
	cells removeKey: coord ifAbsent: [^self].

]

{ #category : #'extraction - not used' }
TabularWorksheet >> extractCellFromXml: aXMLElement [
	cells
		at: (aXMLElement attributeAt: #r) asPoint
		put:
			((TabularXLSXCell newFrom: self workbook)
				extractFromXml: aXMLElement;
				yourself)
]

{ #category : #conversion }
TabularWorksheet >> extractFromXml: aXMLElement [
	^ self
		name: (aXMLElement attributeAt: 'name');
		sheetId: (aXMLElement attributeAt: 'sheetId');
		rID: (aXMLElement attributeAt: 'r:id');
		yourself
]

{ #category : #'accessing selection' }
TabularWorksheet >> findCellsWithContent: aContent [
	^ cells select: [ :cell | cell data = aContent ]
]

{ #category : #initialization }
TabularWorksheet >> initialize [
	super initialize.
	cells := Dictionary new.
	rowStyles := Dictionary new.
	colStyles := Dictionary new.
	columnAttributes  := OrderedCollection  new.
	self name: 'New sheet'.
]

{ #category : #testing }
TabularWorksheet >> isTabularWorksheet [
	^true
]

{ #category : #accessing }
TabularWorksheet >> maxNumberOfColumns [

	(cells keys size = 0) ifTrue: [ ^0 ] ifFalse:  [	^ cells keys max x  ]


]

{ #category : #accessing }
TabularWorksheet >> maxNumberOfRows [
	(cells keys size = 0) ifTrue: [ ^0 ] ifFalse:  [^(cells keys collect: #y) max]
]

{ #category : #accessing }
TabularWorksheet >> name [
	^ self attributeAt: #name 
]

{ #category : #accessing }
TabularWorksheet >> name: anObject [ 
	self attributeAt: #name put: anObject asString
]

{ #category : #printing }
TabularWorksheet >> printOn: aStream [
	super printOn: aStream.
	aStream << ' ''' .
	aStream << self name.
	aStream << '''' 
]

{ #category : #accessing }
TabularWorksheet >> rID [
	^ (self attributeAt: #rID) copyWithoutAll: 'rId'
]

{ #category : #accessing }
TabularWorksheet >> rID: aString [
	self attributeAt: #rID put: aString
]

{ #category : #accessing }
TabularWorksheet >> rowStyleAt: aString [
	^rowStyles at: aString
]

{ #category : #accessing }
TabularWorksheet >> rowStyleAt: aString put: anElement [
	^rowStyles at: aString put: anElement
]

{ #category : #accessing }
TabularWorksheet >> rows [
	^(cells keys collect: [ :coord| coord y]) asSet asOrderedCollection sort
	"ToDo: It's neccessary to avoid code dublication with #columns"
	
]

{ #category : #accessing }
TabularWorksheet >> sheetId: aString [ 
	self attributeAt: #sheetId put: aString
]

{ #category : #opening }
TabularWorksheet >> show [
	self showWithGlamour
]

{ #category : #opening }
TabularWorksheet >> showWithGlamour [
	| wrapper matrix table |
	matrix := self cellValuesAsMatrix.
	wrapper := GLMWrapper new.
	wrapper
		show: [ :a | 
			table := a table.
			1 to: matrix columnCount do: [ :i | table column: i asString evaluated: [ :col | col at: i ] width: 50 ] ].
	wrapper title: 'Worksheet: ', self name asString.
	wrapper openOn: ((1 to: matrix rowCount) collect: [ :i | matrix atRow: i ])
]

{ #category : #opening }
TabularWorksheet >> showWithSpec [
	| matrix tree specCols |
	matrix := self cellValuesAsMatrix.
	tree := TreeModel new.
	specCols := (1 to: matrix columnCount)
		collect: [ :i | 
			TreeColumnModel new
				displayBlock: [ :node | (node content at: i) asString ];
				headerLabel: i asString;
				yourself ].
	tree columns: specCols.
	tree roots: ((1 to: matrix rowCount) collect: [ :i | matrix atRow: i ]).
	tree openWithSpec.

]
