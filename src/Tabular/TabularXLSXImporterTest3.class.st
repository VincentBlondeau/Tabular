Class {
	#name : #TabularXLSXImporterTest3,
	#superclass : #TestCase,
	#instVars : [
		'workbook'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularXLSXImporterTest3 >> setUp [
	| file |
	file := TabularResources testExcelFile3WithAlignment  readStream.
	workbook := XLSXImporter import: file
]

{ #category : #'as yet unclassified' }
TabularXLSXImporterTest3 >> testAccessSheetByName [
	self assert: (workbook worksheetNamed: 'Sheet1') name equals: 'Sheet1'.
	self should: [ (workbook worksheetNamed: 'Sheet2') name ] raise: NotFound.
	

]
