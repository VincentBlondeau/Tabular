Class {
	#name : #WorkbookTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

{ #category : #tests }
WorkbookTest >> testCreation [
|w|
	w := TabularWorkbook withSheets: 5.
	self assert: (w worksheets size = 5).
	
]

{ #category : #tests }
WorkbookTest >> testCreationEmpty [
|w|
	w := TabularWorkbook withSheets: 0.
	self assert:  (w worksheets isEmpty).
	
]

{ #category : #tests }
WorkbookTest >> testNew [
|w|
	w := TabularWorkbook new.
	self assert:  (w worksheets isEmpty).
	
]
