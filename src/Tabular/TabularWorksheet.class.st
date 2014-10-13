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
	cell:=cells at: coord ifAbsent: [ ^nil].
	^cell data.
	
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

{ #category : #accessing }
TabularWorksheet >> eraseCellAt: coord [
	cells removeKey: coord ifAbsent: [^self].

]

{ #category : #'as yet unclassified' }
TabularWorksheet >> initialize [
	super initialize.
	cells := Dictionary new.

]

{ #category : #accessing }
TabularWorksheet >> rows [
	^(cells keys collect: [ :coord| coord y]) asSet asOrderedCollection sort
	
]
