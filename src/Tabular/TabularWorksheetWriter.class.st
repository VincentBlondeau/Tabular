"
I am TabularWorksheetWriter and generate the XML for a worksheet.

IMPLEMENTATION STARTED BUT NOT TESTED YET.


For the Class part:  State the name of the class with one line description: For example, I'm xxx the root of the hierarchy of visitor objects.

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #TabularWorksheetWriter,
	#superclass : #Object,
	#instVars : [
		'worksheet',
		'writer'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #'as yet unclassified' }
TabularWorksheetWriter class >> for: aWorkSheet [

	| twriter |
	twriter := self new worksheet: aWorkSheet.
	twriter renderWorksheet.
	^twriter contents
]

{ #category : #utilities }
TabularWorksheetWriter >> cellName: coord [
	^((self columnName: coord x), (coord y asString))
]

{ #category : #utilities }
TabularWorksheetWriter >> columnName: n [
	(n <= 26) ifTrue: [^(Character value: 64 + n) asString].
	
	^(self columnName: ((n-1) quo: 26)), (self columnName: ((n-1) rem: 26) +1 )
]

{ #category : #rendering }
TabularWorksheetWriter >> contents [

    ^ writer write contents convertToEncoding: 'utf-8'
]

{ #category : #initalize }
TabularWorksheetWriter >> initialize [

	writer := XMLWriter new.
	writer xml standalone: true.
	writer enablePrettyPrinting.
	

]

{ #category : #rendering }
TabularWorksheetWriter >> mergeCells [
|res|
	res := Dictionary new.
	worksheet cellsKeysAndValuesDo: [:coord :cell|
		(cell colspan notNil | cell rowspan notNil) ifTrue:[ |offset|
			offset := (cell colspan ifNil:[0]) @ (cell rowspan ifNil:[0]). "Should upgrade it with Protected Arithmetic"
			res at: coord put: (coord + offset).
		].
	].
	^res.
]

{ #category : #rendering }
TabularWorksheetWriter >> renderCell: coord [
	| cell |
	cell := worksheet cellAt: coord.
	^ cell data isNumber
		ifTrue: [ self renderCellWithNumber: coord ]
		ifFalse: [ 
			(cell data isKindOf: Date)
				ifTrue: [ self renderCellWithDate: coord ]
				ifFalse: [ self renderCellWithString: coord ] ]
]

{ #category : #rendering }
TabularWorksheetWriter >> renderCellWithDate: coord [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((worksheet cells at: coord) data ddmmyyyy)]]
]

{ #category : #rendering }
TabularWorksheetWriter >> renderCellWithNumber:  coord [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'n';
		with:[ writer tag: 'v' with: ((worksheet cellAt: coord) data asString)]
]

{ #category : #rendering }
TabularWorksheetWriter >> renderCellWithString: coord [
"do NOT use the construction of a file sharedStrings.xml at the moment; all strings are inlineStr"

	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((worksheet cellAt: coord) data asString)]]
]

{ #category : #rendering }
TabularWorksheetWriter >> renderMergeCells [
	self mergeCells ifNotEmptyDo: [ : mergeCells |
		writer tag: 'mergeCells' with:[
			mergeCells keysAndValuesDo: [:topleft :bottomright|
				writer tag
					name: 'mergeCell';
					attributeAt: 'ref' put: ((self cellName: topleft),':', (self cellName: bottomright)).
			]
		]
	 ]

]

{ #category : #rendering }
TabularWorksheetWriter >> renderRow: rowN [
	| keys |
	keys := (worksheet allCoord
	select: [ :coord | coord y = rowN ]) 
	sort: [ :coord1 :coord2 | coord1 x < coord2 x ].	
		
	"cells must be sorted by column in the file"
	keys do: [ :coord | self renderCell: coord ]
]

{ #category : #rendering }
TabularWorksheetWriter >> renderRows [
	worksheet rows do:[:rowN|
		writer tag
			name: 'row';
			attributeAt: 'r' put: rowN asString;
			with:[ self renderRow: rowN]
	] 
]

{ #category : #rendering }
TabularWorksheetWriter >> renderSheetData [

    writer tag: 'sheetData' with: [ self renderRows ]
]

{ #category : #rendering }
TabularWorksheetWriter >> renderWorksheet [
	writer tag
		name: 'worksheet';
		attributeAt: 'xmlns' put: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		attributeAt: 'xmlns:r' put: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
		with: [ 
					self renderSheetData.
					self renderMergeCells ]
]

{ #category : #accessing }
TabularWorksheetWriter >> worksheet [
	^ worksheet
]

{ #category : #accessing }
TabularWorksheetWriter >> worksheet: anObject [
	worksheet := anObject.
	
]
