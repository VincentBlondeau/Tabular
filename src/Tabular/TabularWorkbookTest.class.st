Class {
	#name : #TabularWorkbookTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

{ #category : #'tests-as yet unclassified' }
TabularWorkbookTest >> testAccessToSecondWorksheet [

| wbk wsheet |
wbk := TabularWorkbook new.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet'.
wbk addSheet: wsheet.

wsheet := TabularWorksheet new.
wsheet name: 'mySecondSheet'.
wbk addSheet: wsheet.

self assert:  wbk worksheets size equals: 2.
self assert: ((wbk worksheetNamed: 'mySecondSheet') isKindOf:  TabularWorksheet)
]

{ #category : #'tests-as yet unclassified' }
TabularWorkbookTest >> testContainsWorksheetNamed [

| wbk wsheet |
wbk := TabularWorkbook new.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet'.
wbk addSheet: wsheet.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet2'.
wbk addSheet: wsheet.
self assert: (wbk containsWorksheetNamed: 'mySheet')

]

{ #category : #tests }
TabularWorkbookTest >> testCreation [
|w|
	w := TabularWorkbook withSheets: 5.
	self assert: (w worksheets size = 5).
	
]

{ #category : #tests }
TabularWorkbookTest >> testCreationEmpty [
|w|
	w := TabularWorkbook withSheets: 0.
	self assert:  (w worksheets isEmpty).
	
]

{ #category : #tests }
TabularWorkbookTest >> testNew [
|w|
	w := TabularWorkbook new.
	self assert:  (w worksheets isEmpty).
	
]

{ #category : #'tests-finding' }
TabularWorkbookTest >> testWorksheetNamed [

| wbk wsheet |
wbk := TabularWorkbook new.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet'.
wbk addSheet: wsheet.
self assert: (wbk worksheetNamed: 'mySheet') notNil.

]

{ #category : #'tests-finding' }
TabularWorkbookTest >> testWorksheetNamedIfNone [

| wbk wsheet |
wbk := TabularWorkbook new.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet'.
wbk addSheet: wsheet.
self assert: (wbk worksheetNamed: 'mySheet2' ifNone: 'not found') ='not found'.

]
