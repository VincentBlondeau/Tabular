Class {
	#name : #TabularImporterTest,
	#superclass : #TestCase,
	#instVars : [
		'workbook'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
TabularImporterTest >> setUp [
	| file |
	file := TabularRessources testExcelSheet readStream.
	workbook := TabularImporter import: file
]

{ #category : #tests }
TabularImporterTest >> testAccessElementFromASheet [
	self assert: ((workbook worksheetNamed: 'Feuil1') at: 1@1) data equals: 'concatenation table'.

]

{ #category : #tests }
TabularImporterTest >> testAccessSheetByName [
	self assert: (workbook worksheetNamed: 'Feuil1') name equals: 'Feuil1'.
	self assert: (workbook worksheetNamed: 'Feuil2') name equals: 'Feuil2'.
	self assert: (workbook worksheetNamed: 'Feuil3') name equals: 'Feuil3'.
	self should: [ (workbook worksheetNamed: 'Feuil4') name ] raise: NotFound
]

{ #category : #tests }
TabularImporterTest >> testColumnConversion [
	self assert: 'A1' asPoint equals: 1 @ 1.
	self assert: 'B3' asPoint equals: 2 @ 3.
	self assert: 'AA321' asPoint equals: 27 @ 321
]

{ #category : #tests }
TabularImporterTest >> testImport [
	self assert: (workbook isKindOf: TabularWorkbook)
]

{ #category : #tests }
TabularImporterTest >> testNumberOfSheetsIs3 [
	self assert: workbook worksheets size equals: 3
]

{ #category : #tests }
TabularImporterTest >> testStringTableShouldNotBeNil [
	self assert: (workbook stringTable isKindOf: TabularSharedStrings)
]
