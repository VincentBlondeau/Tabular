Class {
	#name : #WorksheetTest,
	#superclass : #TestCase,
	#instVars : [
		'w'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
WorksheetTest >> setUp [
	w := TabularWorksheet new.
]

{ #category : #testing }
WorksheetTest >> testCellsReadingWriting [
| endOfTheWorld|

	ws addNewCellWithRowIndex: 7 columnIndex: 12 withCellValue: 'aTest' .
	self assert: (ws cellWithRowIndex:7 columnIndex:12) cellValue= 'aTest'.

	ws addNewCellWithRowIndex: 7 columnIndex: 12 withCellValue: 666 .
	self assert: (ws cellWithRowIndex:7 columnIndex:12) cellValue= 666.

	endOfTheWorld:=Date year: 2012 month: 12 day: 21.	
	ws addNewCellWithRowIndex: 7 columnIndex: 12 withCellValue: endOfTheWorld .
	self assert: (ws cellWithRowIndex:7 columnIndex:12) cellValue= endOfTheWorld.

]

{ #category : #testing }
WorksheetTest >> testReadingFromEmptyTable [
	self assert: (ws cellWithRowIndex:1 columnIndex:10) isNil.

]

{ #category : #testing }
WorksheetTest >> testResizingOnTableFillingByData [

	self assert: ws sizeOfWorksheet  = (0@0).

	ws addNewCellWithRowIndex: 100 columnIndex: 2 withCellValue: 1.
	self assert: ws sizeOfWorksheet  = (100@2).

	ws addNewCellWithRowIndex: 2 columnIndex: 100 withCellValue: 2.
	self assert: ws sizeOfWorksheet  = (100@100).

]

{ #category : #testing }
WorksheetTest >> testSizeOfEmptyTable [

	self assert: (ws maxNumOfColumns = 0).
	self assert: (ws maxNumOfRows = 0).
	self assert: (ws sizeOfWorksheet  = (0@0)).

]

{ #category : #testing }
WorksheetTest >> testTitle [

	ss spreadsheetTitle:'Test Title'.
	self assert: ss spreadsheetTitle = 'Test Title'.
	
	ss spreadsheetTitle: 'Another'.
	self assert: ss spreadsheetTitle = 'Another'.

]

{ #category : #testing }
WorksheetTest >> testTitleToStringConversion [

	ss spreadsheetTitle: (Date current).
	self assert: (ss spreadsheetTitle isKindOf: String).
	

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
