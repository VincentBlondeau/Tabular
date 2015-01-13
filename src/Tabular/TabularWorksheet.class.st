Class {
	#name : #TabularWorksheet,
	#superclass : #TabularObject,
	#instVars : [
		'cells',
		'rows',
		'cols'
	],
	#category : #'Tabular-Model'
}

{ #category : #accessing }
TabularWorksheet >> at: coord [
	^ cells at: coord ifAbsent: [ ^ nil ].

]

{ #category : #accessing }
TabularWorksheet >> at: coord putData: anObject [
	| cell |
	anObject ifNil: [ ^ self eraseCellAt: coord ].
	cell := cells at: coord ifAbsentPut: [ TabularCell new ].
	cell data: anObject
]

{ #category : #accessing }
TabularWorksheet >> cells [
	^cells
]

{ #category : #accessing }
TabularWorksheet >> cellsAsMatrix [
	| matrix |
	cols := self cells keys max x.
	rows := self cells keys max y.
	matrix := Matrix rows: rows columns: cols.
	cells associationsDo: [ :assoc | matrix at: assoc key y at: assoc key x put: assoc value ].
	^ matrix
]

{ #category : #accessing }
TabularWorksheet >> col: col row: row [
	^self at: (col @ row).

]

{ #category : #accessing }
TabularWorksheet >> col: col row: row putData: anObject [
	^self at: (col @ row) putData: anObject.

]

{ #category : #removing }
TabularWorksheet >> eraseCellAt: coord [
	cells removeKey: coord ifAbsent: [^self].

]

{ #category : #extraction }
TabularWorksheet >> extractCellFromXml: aXMLElement [
	cells
		at: (aXMLElement attributeAt: #r) asPoint
		put:
			((TabularCell newFrom: self workbook)
				extractFromXml: aXMLElement;
				yourself)
]

{ #category : #extraction }
TabularWorksheet >> extractContentsFromXml: aXMLDocument [
	aXMLDocument
		allElementsNamed: 'row'
		do: [ :aRow | 
			(TabularRow newFrom: self workbook) extractFromXml: aRow.
			aRow allElementsNamed: 'c' do: [ :aCell | self extractCellFromXml: aCell ] ]
]

{ #category : #conversion }
TabularWorksheet >> extractFromXml: aXMLElement [
	^ self
		name: (aXMLElement attributeAt: 'name');
		sheetId: (aXMLElement attributeAt: 'sheetId');
		rID: (aXMLElement attributeAt: 'r:id');
		yourself
]

{ #category : #initialization }
TabularWorksheet >> initialize [
	super initialize.
	cells := Dictionary new.

]

{ #category : #accessing }
TabularWorksheet >> name [
	^ self attributeAt: #name 
]

{ #category : #accessing }
TabularWorksheet >> name: aString [ 
	self attributeAt: #name put: aString
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
TabularWorksheet >> rows [
	^(cells keys collect: [ :coord| coord y]) asSet asOrderedCollection sort
	
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
	matrix := self cellsAsMatrix.
	wrapper := GLMWrapper new.
	wrapper
		show: [ :a | 
			table := a table.
			1 to: matrix columnCount do: [ :i | table column: i asString evaluated: [ :col | col at: i ] width: 50 ] ].
	wrapper openOn: ((1 to: matrix rowCount) collect: [ :i | matrix atRow: i ])
]

{ #category : #opening }
TabularWorksheet >> showWithSpec [
	| matrix tree specCols |
	matrix := self cellsAsMatrix.
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
