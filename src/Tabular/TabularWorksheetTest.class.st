Class {
	#name : #TabularWorksheetTest,
	#superclass : #TestCase,
	#instVars : [
		'ws'
	],
	#category : #'Tabular-Tests'
}

{ #category : #setUp }
TabularWorksheetTest >> setUp [
	ws := TabularWorksheet new.
]

{ #category : #'tests-accessing' }
TabularWorksheetTest >> testCellAt [

| w |
w := TabularWorksheet new.
w at: 1 @ 1 putData: 12.
self assert: (w at: 1 @ 1) data equals: 12.

self assert: ((w cellAt: 1 @ 1) isKindOf: TabularXLSXCell).
self assert: (w cellAt: 1 @ 1) data equals: 12.
]

{ #category : #'tests-accessing' }
TabularWorksheetTest >> testCells [

 self assert: (ws allCoord notNil).  
]

{ #category : #tests }
TabularWorksheetTest >> testCellsReadingEmptyCell [
     
	self assert: ((ws col: 100 row: 100) isNil).  
	
	
	
	
	
]

{ #category : #tests }
TabularWorksheetTest >> testCellsReadingEmptyCell0 [
      "accessing a cell without data"

       ws col: 1 row: 1 putData: 11.
       ws col: 2 row: 1 putData: 21.

	self assert: (ws col: 1 row: 1) data equals: 11.
	self assert: (ws col: 2 row: 1) data equals: 21.
	
      self assert: ((ws col: 3 row: 1) isNil).   "Is this OK to have nil returned?"
	
]

{ #category : #tests }
TabularWorksheetTest >> testCellsReadingWritingDate [
	| endOfTheWorld |
	
	endOfTheWorld := Date year: 2020 month: 12 day: 31.
	ws col: 7 row: 12 putData: endOfTheWorld.
	self assert: (ws col: 7 row: 12) data equals: endOfTheWorld
]

{ #category : #tests }
TabularWorksheetTest >> testCellsReadingWritingInteger [

	ws col: 7 row: 12 putData: 1234567890.
	self assert: (ws col: 7 row: 12) data equals: 1234567890.
	
]

{ #category : #tests }
TabularWorksheetTest >> testCellsReadingWritingString [

	ws col: 7 row: 12 putData: 'aTest'.
	self assert: ((ws col: 7 row: 12) data = 'aTest').
	
]

{ #category : #'tests-removing' }
TabularWorksheetTest >> testCompactify [

ws at: 2@2 putData: 1. ws at: 5@2 putData: 2.
ws at: 4@4 putData: 3. ws at: 6@4 putData: 4.

ws compactify.

self assert: ((ws dataAt: 1@1) = 1). self assert: ((ws dataAt: 3@1) = 2).
self assert: ((ws dataAt: 2@2) = 3). self assert: ((ws dataAt: 4@2) = 4).


]

{ #category : #'tests-removing' }
TabularWorksheetTest >> testEraseCellAt [

| w |
w := TabularWorksheet new.
w at: 1 @ 1 putData: 12.
self assert: (w at: 1 @ 1) data equals: 12.
w eraseCellAt: 1 @ 1.
self assert: (w at: 1 @ 1) equals: nil.

]

{ #category : #'tests-accessing' }
TabularWorksheetTest >> testFindCellsWithContent [

    | result |
    ws col: 1 row: 1 putData: 'Lille'.
    ws col: 2 row: 1 putData: 'Rosario'.
    ws col: 3 row: 1 putData: 'Berne'.
    ws col: 4 row: 1 putData: 'Lille'.

    result := ws findCellsWithContent: 'Lille'.
    self assert: (result isKindOf: Dictionary).
    self assert: (result size =2).


]

{ #category : #'tests-accessing' }
TabularWorksheetTest >> testFindCellsWithContent2 [

    | result |
    ws col: 1 row: 1 putData: 'Lille'.
    ws col: 2 row: 1 putData: 'Rosario'.
    ws col: 3 row: 1 putData: 'Berne'.
    ws col: 4 row: 1 putData: 'Lille'.

    result := ws findCellsWithContent: 'll'.
    self assert: (result isKindOf: Dictionary).
    self deny: (result size =2).


]

{ #category : #tests }
TabularWorksheetTest >> testMaxNumberOfColumns [

       ws col: 1 row: 1 putData: 11.
       ws col: 2 row: 1 putData: 21.

	self assert: ws maxNumberOfColumns equals: 2.

]

{ #category : #tests }
TabularWorksheetTest >> testMaxNumberOfColumns0 [

	self assert: ws maxNumberOfColumns equals: 0.



]

{ #category : #'tests-accessing' }
TabularWorksheetTest >> testName [

 self assert: (ws name notNil).  
 self assert: (ws name = 'New sheet').  

]

{ #category : #tests }
TabularWorksheetTest >> testNameToStringConversion [
	
	ws name: (Date current).
	self assert: (ws name isKindOf: String).
	

]

{ #category : #'expected failures' }
TabularWorksheetTest >> testRID [
 <expectedFailure>
self assert: (ws rID notNil).  

"what should be the default value? Or is it OK to have it nil?"
"ws rID inspect"
 
]

{ #category : #tests }
TabularWorksheetTest >> testReadingFromEmptyTable [

     "this is similar to testCellsReadingEmptyCell0"

	self assert: (ws col: 1 row: 10) isNil
]

{ #category : #'expected failures' }
TabularWorksheetTest >> testResizingOnTableFillingByData [
	<expectedFailure>
	self assert: ws sizeOfWorksheet equals: 0 @ 0.
	ws col: 2 row: 100 putData: 1.
	self assert: ws sizeOfWorksheet equals: 100 @ 2.
	ws col: 2 row: 100 putData: 2.
	self assert: ws sizeOfWorksheet equals: 100 @ 100
]

{ #category : #'expected failures' }
TabularWorksheetTest >> testSheetId [
 <expectedFailure>
 self assert: (ws sheetId notNil).  

"What should this return?"
]

{ #category : #'expected failures' }
TabularWorksheetTest >> testSizeOfEmptyTable [
<expectedFailure>
"all methods below are not implemented"
	self assert: ws maxNumOfColumns equals: 0.
	self assert: ws maxNumOfRows equals: 0.
	self assert: ws sizeOfWorksheet equals: 0 @ 0
]

{ #category : #tests }
TabularWorksheetTest >> testValueErasing [
	ws at: 4@3 putData: 'test'.
	self assert: (ws allCoord includes: 4@3).

	"Nil writing should erase the data"
	ws col: 4 row: 3 putData: nil. 
	self deny: (ws allCoord includes: 4@3).

]

{ #category : #tests }
TabularWorksheetTest >> testValueWriting [
	ws at: 4 @ 3 putData: 'test'.
	ws col: 5 row: 3 putData: 777.
	self assert: (ws at: 5 @ 3) data equals: 777.
	self assert: (ws col: 4 row: 3) data equals: 'test'
]
