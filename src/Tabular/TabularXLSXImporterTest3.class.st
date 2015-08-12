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
