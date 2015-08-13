Class {
	#name : #TabularXLSXExportTest,
	#superclass : #TestCase,
	#instVars : [
		'worksheet',
		'fname4',
		'fname5',
		'fname6',
		'fname7',
		'fname8'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> setUp [
    

    fname4 := 'TabularConstructed4Exported.xlsx'.
    fname5 := 'TabularConstructed5Exported.xlsx'.
    fname6 := 'TabularConstructed6Exported.xlsx'.
    fname7 := 'TabularConstructed7Exported.xlsx'.
    fname8 := 'TabularConstructed8ExportedSharedStringsAnalysis.xlsx'.



]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport4 [

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31.	
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname4.
	
	"manual inspection shows that the exported file is fine"

]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport5 [

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31;
			
		at: 9 @ 9 putData: 99.		
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname5.
	
	"manual inspection shows that the exported file is fine"

]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport6 [

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 'aaa';
		at: 2 @ 1 putData: 'bbb';
		at: 3 @ 1 putData: 'ccc'.	
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname6.
	
	"manual inspection shows that the exported file is fine"

]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport7 [

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 'aaa';
		at: 3 @ 1 putData: 'ccc'.	
      (wsheet cells at: 1 @ 1) colspan: 1.
			
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname7.
	
	"manual inspection shows that the exported file is fine"
	"But is the colspan command fine? Add a colspan test to TabularCell"

]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport7b [
"the same test as testExport7 but uses regular way of adressing spreadsheet cells"

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 'A1' asPoint putData: 'aaa';
		at: 'C1' asPoint putData: 'ccc'.	
      (wsheet cells at: 'A1' asPoint) colspan: 1.
			
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname7.
	
	"manual inspection shows that the exported file is fine"
	"But is the colspan command fine? Add a colspan test to TabularCell"

]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport8 [
	| wbk wsheet myString |
	wbk := TabularWorkbook new.
	myString := 'abcdefghijklmnopqrstuvwxyz 1234567890'.
	self assert: wbk worksheets isEmpty.
	wsheet := TabularWorksheet new.
	wsheet
		at: 'A1' asPoint putData: myString;
		at: 'A2' asPoint putData: myString;
		at: 'A3' asPoint putData: myString;
		at: 'A4' asPoint putData: myString;
		at: 'A5' asPoint putData: myString;
		at: 'A6' asPoint putData: myString;
		at: 'A7' asPoint putData: myString;
		at: 'A8' asPoint putData: myString;
		at: 'A9' asPoint putData: myString.
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname8.
	
	"manual inspection shows that the exported file is fine"	
	
     "The generated code"

'<row r="2">
<c r="A2" t="inlineStr"><is><t>abcdefghijklmnopqrstuvwxyz 1234567890</t></is></c></row>'

]
