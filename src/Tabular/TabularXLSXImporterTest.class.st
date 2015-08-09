Class {
	#name : #TabularXLSXImporterTest,
	#superclass : #TestCase,
	#instVars : [
		'workbook'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
TabularXLSXImporterTest >> setUp [
	| file |
	file := TabularResources testExcelSheet readStream.
	workbook := XLSXImporter import: file
]

{ #category : #tests }
TabularXLSXImporterTest >> testAccessElementFromASheet [
	self assert: (((workbook worksheetNamed: 'Feuil1') at: 1@1) data = 'concatenation table').

]

{ #category : #tests }
TabularXLSXImporterTest >> testAccessSheetByName [
	self assert: (workbook worksheetNamed: 'Feuil1') name equals: 'Feuil1'.
	self assert: (workbook worksheetNamed: 'Feuil2') name equals: 'Feuil2'.
	self assert: (workbook worksheetNamed: 'Feuil3') name equals: 'Feuil3'.
	self should: [ (workbook worksheetNamed: 'Feuil4') name ] raise: NotFound
]

{ #category : #tests }
TabularXLSXImporterTest >> testColumnConversion [
	self assert: 'A1' asPoint equals: 1 @ 1.
	self assert: 'B3' asPoint equals: 2 @ 3.
	self assert: 'AA321' asPoint equals: 27 @ 321
]

{ #category : #tests }
TabularXLSXImporterTest >> testImport [
	self assert: (workbook isKindOf: TabularWorkbook)
]

{ #category : #tests }
TabularXLSXImporterTest >> testNumberOfSheetsIs3 [
	self assert: workbook worksheets size equals: 3
]
