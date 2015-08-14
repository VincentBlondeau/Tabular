Class {
	#name : #TabularXLSXImporterTest2,
	#superclass : #TestCase,
	#instVars : [
		'workbook'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
TabularXLSXImporterTest2 >> setUp [
	| file |
	file := TabularResources testExcelFile2withThreeSheets readStream.
	workbook := XLSXImporter import: file
]

{ #category : #tests }
TabularXLSXImporterTest2 >> testAccessElementFromASheet [

     | worksheet |
worksheet := workbook worksheetNamed: 'Feuil1'.
	self assert: ((worksheet at: 1@1) data = 'concatenation table').

]

{ #category : #tests }
TabularXLSXImporterTest2 >> testAccessNumberElementFromASheet [

     | worksheet cell |

	worksheet := workbook worksheetNamed: 'Feuil1'.
	cell := worksheet at: 'A3' asPoint.
	self assert: (cell data = '1').
	

]

{ #category : #tests }
TabularXLSXImporterTest2 >> testAccessSheetByName [
	self assert: (workbook worksheetNamed: 'Feuil1') name equals: 'Feuil1'.
	self assert: (workbook worksheetNamed: 'Feuil2') name equals: 'Feuil2'.
	self assert: (workbook worksheetNamed: 'Feuil3') name equals: 'Feuil3'.
	self should: [ (workbook worksheetNamed: 'Feuil4') name ] raise: NotFound
]

{ #category : #tests }
TabularXLSXImporterTest2 >> testColumnConversion [
	self assert: 'A1' asPoint equals: 1 @ 1.
	self assert: 'B3' asPoint equals: 2 @ 3.
	self assert: 'AA321' asPoint equals: 27 @ 321
]

{ #category : #tests }
TabularXLSXImporterTest2 >> testImport [
	self assert: (workbook isKindOf: TabularWorkbook)
]

{ #category : #tests }
TabularXLSXImporterTest2 >> testNumberOfSheetsIs3 [
	self assert: workbook worksheets size equals: 3
]
