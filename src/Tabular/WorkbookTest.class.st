Class {
	#name : #WorkbookTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
WorkbookTest >> testCreation [
|w|
	w := Workbook withSheets: 5.
	self assert: (w worksheets size = 5).
	
]

{ #category : #'as yet unclassified' }
WorkbookTest >> testCreationEmpty [
|w|
	w := Workbook withSheets: 0.
	self assert:  (w worksheets isEmpty).
	
]

{ #category : #'as yet unclassified' }
WorkbookTest >> testNew [
|w|
	w := Workbook new.
	self assert:  (w worksheets isEmpty).
	
]
