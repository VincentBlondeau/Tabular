Class {
	#name : #WorksheetTest,
	#superclass : #TestCase,
	#instVars : [
		'ws'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
WorksheetTest >> setUp [
	ws := TabularWorksheet new.
]

{ #category : #tests }
WorksheetTest >> testCellsReadingWriting [
	| endOfTheWorld |
	ws col: 7 row: 12 putData: 'aTest'.
	self assert: ((ws col: 7 row: 12) data = 'aTest').
	ws col: 7 row: 12 putData: 666.
	self assert: (ws col: 7 row: 12) data equals: 666.
	endOfTheWorld := Date year: 2012 month: 12 day: 21.
	ws col: 7 row: 12 putData: endOfTheWorld.
	self assert: (ws col: 7 row: 12) data equals: endOfTheWorld
]

{ #category : #tests }
WorksheetTest >> testReadingFromEmptyTable [
	self assert: (ws col: 1 row: 10) isNil
]

{ #category : #tests }
WorksheetTest >> testResizingOnTableFillingByData [
	<expectedFailure>
	self assert: ws sizeOfWorksheet equals: 0 @ 0.
	ws col: 2 row: 100 putData: 1.
	self assert: ws sizeOfWorksheet equals: 100 @ 2.
	ws col: 2 row: 100 putData: 2.
	self assert: ws sizeOfWorksheet equals: 100 @ 100
]

{ #category : #tests }
WorksheetTest >> testSizeOfEmptyTable [
	<expectedFailure>
	self assert: ws maxNumOfColumns equals: 0.
	self assert: ws maxNumOfRows equals: 0.
	self assert: ws sizeOfWorksheet equals: 0 @ 0
]

{ #category : #tests }
WorksheetTest >> testTitleToStringConversion [
	<expectedFailure>
	| ss |
	ss spreadsheetTitle: (Date current).
	self assert: (ss spreadsheetTitle isKindOf: String).
	

]

{ #category : #tests }
WorksheetTest >> testValueErasing [
	ws at: 4@3 putData: 'test'.
	self assert: (ws cells keys includes: 4@3).

	"Nil writing should erase the data"
	ws col: 4 row: 3 putData: nil. 
	self deny: (ws cells keys includes: 4@3).

]

{ #category : #tests }
WorksheetTest >> testValueWriting [
	ws at: 4 @ 3 putData: 'test'.
	ws col: 5 row: 3 putData: 777.
	self assert: (ws at: 5 @ 3) data equals: 777.
	self assert: (ws col: 4 row: 3) data equals: 'test'
]
