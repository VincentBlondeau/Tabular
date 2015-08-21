Class {
	#name : #TabularXMLWriter,
	#superclass : #Object,
	#instVars : [
		'worksheet',
		'writer'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #'as yet unclassified' }
TabularXMLWriter class >> for: aWorkSheet [

	| twriter |

	twriter := self new worksheet: aWorkSheet.
	twriter renderWorksheet.
	^twriter contents
]

{ #category : #utilities }
TabularXMLWriter >> cellName: coord [
	^((self columnName: coord x), (coord y asString))
]

{ #category : #utilities }
TabularXMLWriter >> columnName: n [
	(n <= 26) ifTrue: [^(Character value: 64 + n) asString].
	
	^(self columnName: ((n-1) quo: 26)), (self columnName: ((n-1) rem: 26) +1 )
]

{ #category : #rendering }
TabularXMLWriter >> contents [

    ^ writer write contents convertToEncoding: 'utf-8'
]

{ #category : #initalize }
TabularXMLWriter >> initialize [

	writer isNil ifTrue: [writer := XMLWriter new].
	writer enablePrettyPrinting.
	writer xml standalone: true.
	

]

{ #category : #rendering }
TabularXMLWriter >> renderCell: coord [
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
TabularXMLWriter >> renderCellWithDate: coord [

	self subclassResponsibility 
]

{ #category : #rendering }
TabularXMLWriter >> renderCellWithNumber:  coord [

	self subclassResponsibility 
]

{ #category : #rendering }
TabularXMLWriter >> renderCellWithString: coord [

	self subclassResponsibility 
]

{ #category : #rendering }
TabularXMLWriter >> renderRow: rowN [
	| keys |
	keys := (worksheet allCoord
	select: [ :coord | coord y = rowN ]) 
	sort: [ :coord1 :coord2 | coord1 x < coord2 x ].	
		
	"cells must be sorted by column in the file"
	keys do: [ :coord | self renderCell: coord ]
]

{ #category : #rendering }
TabularXMLWriter >> renderRows [

	self subclassResponsibility 
]

{ #category : #rendering }
TabularXMLWriter >> renderSheetData [

	self subclassResponsibility 
]

{ #category : #rendering }
TabularXMLWriter >> renderWorksheet [

	self subclassResponsibility 
]

{ #category : #accessing }
TabularXMLWriter >> worksheet [
	^ worksheet
]

{ #category : #accessing }
TabularXMLWriter >> worksheet: anObject [
	worksheet := anObject.
	
]
