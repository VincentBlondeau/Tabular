Class {
	#name : #TabularXLSXImporterTest1,
	#superclass : #TestCase,
	#instVars : [
		'workbook'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
TabularXLSXImporterTest1 >> setUp [
	| file |
	file := TabularResources testExcelFile1OneSheetOnly  readStream.
	workbook := XLSXImporter import: file
]

{ #category : #tests }
TabularXLSXImporterTest1 >> testAccessElementFromASheet [
	self assert: (((workbook worksheetNamed: 'Sheet1') at: 3@9) data = '39').
]

{ #category : #tests }
TabularXLSXImporterTest1 >> testAccessSheetByName [
	self assert: (workbook worksheetNamed: 'Sheet1') name equals: 'Sheet1'.
	self should: [ (workbook worksheetNamed: 'Sheet2') name ] raise: NotFound
]
