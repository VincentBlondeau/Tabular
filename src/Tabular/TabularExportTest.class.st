"
| workbook sheet |
	workbook := TabularWorkbook withSheets: 1.
	workbook filename: 'Test.xlsx'.
	sheet := workbook worksheets first.
	sheet
		at: 1 @ 1 putData: '-';
		at: 2 @ 1 putData: 'colspan test ...........';
		at: 1 @ 2 putData: 'rowspan test';
		at: 2 @ 2 putData: 777.77.
	(sheet cells at: 2 @ 1) colspan: 3.
	(sheet cells at: 1 @ 2) rowspan: 3.
	sheet  at: 4 @ 3 putData: 'Jurij -- Юрий'.
	
	^ workbook
"
Class {
	#name : #TabularExportTest,
	#superclass : #TestCase,
	#instVars : [
		'worksheet',
		'fname'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularExportTest >> setUp [
		
    fname := TabularResources fileNameOfExample1.
    (FileLocator home / fname ) ensureDelete
	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport1 [

	| wbk wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	wimported inspect
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport2 [

|w wimported |
	w := TabularWorkbook new.
	self assert:  (w worksheets isEmpty).	
	w worksheets add: worksheet.
	TabularXSLXExport workbook: w fileName: fname.

	"wimported := XLSXImporter import: (FileLocator home / fname ) .
	wimported inspect"
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport3 [

|wbk wsheet  wimported |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31.	
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	wimported inspect
]
