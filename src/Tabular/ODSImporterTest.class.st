Class {
	#name : #ODSImporterTest,
	#superclass : #TestCase,
	#instVars : [
		'workbook'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'test data' }
ODSImporterTest class >> addFile: fileName as: selectorName [
	"Read the supplied file, compile it and add to the receiver
	
	E.g. ODSImporterTest addFile: '/home/alistair/pharo/TestData1.ods' as: #workbook01"
	
	| bs ba source space |
	
	bs := fileName asFileReference binaryReadStream.
	[ 
		ba := bs upToEnd ] ensure: [ bs close ].
	source := String new writeStream .
	source
		nextPutAll: selectorName;
		cr; cr;
		nextPutAll: '^#['.
	space := Character space.
	ba do: [ :byte |
		source
			nextPutAll: byte printString;
			nextPut: space].
	source nextPut: $].
	self compile: source contents.
]

{ #category : #accessing }
ODSImporterTest class >> resources [

	^{ TabularResources }
]

{ #category : #running }
ODSImporterTest >> setUp [

	workbook := self workbook01.
]

{ #category : #tests }
ODSImporterTest >> testIsWorkbook [

	self assert: workbook class = TabularWorkbook.
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01Date [
	"Check that integer cells are parsed correctly"
	
	self assert: (self wb01sheet1 at: 3@7) data = (Date year: 2016 month: 04 day: 18).
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01Float [
	"Check that floating point cells are parsed correctly"
	
	self assert: (self wb01sheet1 at: 3@5) data = 42.42.
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01Formula [
	"Check that formulas cells are parsed correctly"
	
	self assert: (self wb01sheet1 at: 3@6) formula = 'of:=INT([.C5])'.
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01Integer [
	"Check that integer cells are parsed correctly"
	
	self assert: (self wb01sheet1 at: 3@4) data = 42.
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01IsolatedCell [
	"Check that cell 16@42 is located correctly"
	
	self assert: (self wb01sheet1 at: 16@42) data = 'This cell is by itself (16 @ 42)'
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01Time [
	"Check that integer cells are parsed correctly"
	
	self assert: (self wb01sheet1 at: 3@8) data = (Time hour: 7 minute: 4 second: 37).
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01Title [

	self assert: (self wb01sheet1 at: 1@1) data = 'Tabular ODS Test Data'
]

{ #category : #tests }
ODSImporterTest >> testWorksheet01TitleStyle [

	| style |
	
	style := (self wb01sheet1 at: 1@1) style.
	self assert: (style details first at: #'fo:font-size') equals: '14pt'
]

{ #category : #tests }
ODSImporterTest >> testWorksheet1 [
	"Confirm that the default worksheet is available"
	
	self assert: (workbook containsWorksheetNamed: 'Sheet1').
]

{ #category : #accessing }
ODSImporterTest >> wb01sheet1 [

	^workbook worksheetNamed: 'Sheet1'
]

{ #category : #'test data' }
ODSImporterTest >> workbook01 [

	^TabularResources current odswb01
]
