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

{ #category : #testing }
WorksheetTest >> testCellsReadingWriting [
	| endOfTheWorld |
	ws col: 7 row: 12 putData: 'aTest'.
	self assert: (ws col: 7 row: 12)  = 'aTest'.
	ws col: 7 row: 12 putData: 666.
	self assert: (ws col: 7 row: 12)  = 666.
	endOfTheWorld := Date year: 2012 month: 12 day: 21.
	ws col: 7 row: 12 putData: endOfTheWorld.
	self assert: (ws col: 7 row: 12)  = endOfTheWorld
]

{ #category : #testing }
WorksheetTest >> testReadingFromEmptyTable [
	self assert: (ws col: 1 row: 10) isNil
]

{ #category : #testing }
WorksheetTest >> testResizingOnTableFillingByData [

	self assert: ws sizeOfWorksheet  = (0@0).

	ws col: 2 row: 100 putData: 1.
	self assert: ws sizeOfWorksheet  = (100@2).

	ws col: 2 row: 100 putData:  2.
	self assert: ws sizeOfWorksheet  = (100@100).

]

{ #category : #testing }
WorksheetTest >> testSizeOfEmptyTable [
	self assert: ws maxNumOfColumns = 0.
	self assert: ws maxNumOfRows = 0.
	self assert: ws sizeOfWorksheet = (0 @ 0)
]

{ #category : #testing }
WorksheetTest >> testTitleToStringConversion [

	ss spreadsheetTitle: (Date current).
	self assert: (ss spreadsheetTitle isKindOf: String).
	

]

{ #category : #'as yet unclassified' }
WorksheetTest >> testValueErasing [
	ws at: 4@3 putData: 'test'.
	self assert: (ws cells keys includes: 4@3).

	"Nil writing should erase the data"
	ws col: 4 row: 3 putData: nil. 
	self deny: (ws cells keys includes: 4@3).

]

{ #category : #'as yet unclassified' }
WorksheetTest >> testValueWriting [
	ws at: 4@3 putData: 'test'.
	ws col: 5 row: 3 putData: 777.

	self assert: ((ws at: 5@3) = 777).
	self assert: ((ws col: 4 row: 3 ) = 'test').
]
