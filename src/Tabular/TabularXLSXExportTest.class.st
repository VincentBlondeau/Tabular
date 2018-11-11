Class {
	#name : #TabularXLSXExportTest,
	#superclass : #TestCase,
	#instVars : [
		'worksheet',
		'fname4',
		'fname5',
		'fname6',
		'fname7',
		'fname8',
		'fname9',
		'fname10',
		'wsheetNumbersInRow1'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> setUp [
    
	| dir |
	wsheetNumbersInRow1 := TabularWorksheet new.
	wsheetNumbersInRow1
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31.

     dir := FileLocator temp.  "use temporary directory to put the exported test files."

    fname4 := dir / 'TabularConstructed4Exported.xlsx'. 
    fname5 := dir / 'TabularConstructed5Exported.xlsx'.
    fname6 := dir / 'TabularConstructed6Exported.xlsx'.
    fname7 := dir / 'TabularConstructed7Exported.xlsx'.
    fname8 := dir / 'TabularConstructed8ExportedInlineStringsAnalysis.xlsx'.
    fname9 := dir / 'TabularConstructed9ExportedSharedStringsAnalysis.xlsx'.
    fname10 :=dir /  'TabularConstructed10TwoWorksheets.xlsx'.




]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport4 [

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).		
	wsheet := wsheetNumbersInRow1.
	wbk worksheets add: wsheet.
	fname4  ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname4.
	
	"manual inspection shows that the exported file is fine"

]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport5 [

|wbk wsheet    |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
	wsheet := wsheetNumbersInRow1.
	wsheet	at: 9 @ 9 putData: 99.		
	wbk worksheets add: wsheet.
	fname5  ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname5.
	
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
	fname6  ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname6.	
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
      (wsheet cellAt: 1 @ 1) colspan: 1.
			
	wbk worksheets add: wsheet.
	fname7  ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname7.
	
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
      (wsheet cellAt: 'A1' asPoint) colspan: 1.
			
	wbk worksheets add: wsheet.
	fname7 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname7.
	
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
	wsheet at: 'A1' asPoint putData: myString.
	wbk worksheets add: wsheet.
	fname8  ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname8.
	"ZipArchive new readFrom: fname8."
	
]

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> testExport9 [
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
	fname9  ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname9.
	
	"manual inspection shows that the exported file is fine"	
	
     "The generated code"

'<row r="2">
<c r="A2" t="inlineStr"><is><t>abcdefghijklmnopqrstuvwxyz 1234567890</t></is></c></row>'

]

{ #category : #tests }
TabularXLSXExportTest >> testExportSharedStrings [
	| xml dom wbk sheet strings |
	wbk := TabularWorkbook new.
	sheet := TabularWorksheet new.
	sheet name: 'Sheet1'.
	sheet at: 1@1 putData: 'shared'.
	sheet at: 2@1 putData: 'shared'.
	sheet at: 3@1 putData: ' shared'. "not really"
	sheet at: 4@1 putData: 25.
	wbk addSheet: sheet.
	xml := TabularXLSXExport new
		workbook: wbk;
		countSharedStrings;
		sharedStrings_xml.
	dom := xml parseXML.
	self assert: (dom root attributeAt: 'count') equals: '3'.
	self assert: (dom root attributeAt: 'uniqueCount') equals: '2'.
	strings := (dom root elements collect: [:el | el rawContentStringAt: 't']) asSortedCollection asArray.
	self assert: strings equals: #(' shared' 'shared')
]

{ #category : #tests }
TabularXLSXExportTest >> testExportStyles [
	| xml dom |
	xml := TabularXLSXExport new
		workbook: TabularWorkbook new;
		styles_xml.
	dom := xml parseXML.
	{(#numFmts -> 1).
	(#fonts -> 4).
	(#fills -> 2).
	(#borders -> 1).
	(#cellStyleXfs -> 20).
	(#cellXfs -> 1).
	(#cellStyles -> 6)}
		do: [ :assoc | 
			| element |
			element := dom root elementAt: assoc key asString.
			self assert: (element attributeAt: 'count') equals: assoc value printString.
			self assert: element elements size equals: assoc value ]
]
