Class {
	#name : #TabularWorkbookTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

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
