Class {
	#name : #WorksheetTest,
	#superclass : #TestCase,
	#instVars : [
		'w'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
WorksheetTest >> setUp [
	w := TabularWorksheet new.
]

{ #category : #'as yet unclassified' }
WorksheetTest >> testValueErasing [
	w at: 4@3 putData: 'test'.
	self assert: (w cells keys includes: 4@3).

	"Nil writing should erase the data"
	w col: 4 row: 3 putData: nil. 
	self deny: (w cells keys includes: 4@3).

]

{ #category : #'as yet unclassified' }
WorksheetTest >> testValueWriting [
	w at: 4@3 putData: 'test'.
	w col: 5 row: 3 putData: 777.

	self assert: ((w at: 5@3) = 777).
	self assert: ((w col: 4 row: 3 ) = 'test').
]
