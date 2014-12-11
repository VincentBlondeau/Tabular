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
	| cell |
	cell := cells at: coord ifAbsent: [ ^ nil ].
	^ cell data
]

{ #category : #accessing }
TabularWorksheet >> at: coord putData: anObject [
| cell |
	anObject ifNil: [ ^ self eraseCellAt: coord ].
	cell := cells at: coord ifAbsentPut: [ TabularCell new ].
	cell data: anObject.
]

{ #category : #accessing }
TabularWorksheet >> cells [
	^cells
]

{ #category : #accessing }
TabularWorksheet >> col: col row: row [
	^self at: (col @ row).

]

{ #category : #accessing }
TabularWorksheet >> col: col row: row putData: anObject [
	^self at: (col @ row) putData: anObject.

]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TabularWorksheet >> name [
	^ self attributeAt: #name 
]

{ #category : #'as yet unclassified' }
TabularWorksheet >> name: aString [ 
	self attributeAt: #name put: aString
]

{ #category : #'as yet unclassified' }
TabularWorksheet >> printOn: aStream [
	super printOn: aStream.
	aStream << ' "' .
	aStream << self name.
	aStream << '"' 
]

{ #category : #accessing }
TabularWorksheet >> rID [
	^ (self attributeAt: #rID) copyWithoutAll: 'rId'
]

{ #category : #'as yet unclassified' }
TabularWorksheet >> rID: aString [
	self attributeAt: #rID put: aString
]

{ #category : #accessing }
TabularWorksheet >> rows [
	^(cells keys collect: [ :coord| coord y]) asSet asOrderedCollection sort
	
]

{ #category : #'as yet unclassified' }
TabularWorksheet >> sheetId: aString [ 
	self attributeAt: #sheetId put: aString
]
