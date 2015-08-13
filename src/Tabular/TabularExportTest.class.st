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
		'fname',
		'fname2',
		'fname3',
		'fname0'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularExportTest >> setUp [
    fname0 := 'TabularEmptySheetExported.xlsx'.
		
    fname := TabularResources fileNameOfExample1.
    (FileLocator home / fname ) ensureDelete.

    fname2 := TabularResources fileNameOfExample2.
    (FileLocator home / fname2 ) ensureDelete.
   
    fname3 := TabularResources fileNameOfExample1.
    (FileLocator home / fname3 ) ensureDelete
	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport0 [
"export empty workbook"

|w  |
	w := TabularWorkbook new.
	self assert:  (w worksheets isEmpty).	
		
	TabularXSLXExport workbook: w fileName: fname2.

	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport1 [

	| wbk  wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	
	self assert: (wimported worksheetNamed: 'Sheet1') name equals: 'Sheet1'.
	self should: [ (wimported worksheetNamed: 'Sheet2') name ] raise: NotFound.

	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport1CellAccess [

	| wbk  wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	
	self assert: (((wimported worksheetNamed: 'Sheet1') at: 3@9) data = '39').
	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport2 [

|  wbk wimported |
	wbk := XLSXImporter import: TabularResources testExcelFile2withThreeSheets   readStream.
		
	TabularXSLXExport workbook: wbk fileName: fname2.
	
	


	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport3 [

	| wbk  wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname3.

	wimported := XLSXImporter import: (FileLocator home / fname3 ) .
	
	self assert: (wimported worksheetNamed: 'Feuil1') name equals: 'Feuil1'.
	self should: [ (wimported worksheetNamed: 'Feuil4') name ] raise: NotFound.
	
	
	
]

{ #category : #'as yet unclassified' }
TabularExportTest >> testExport4 [

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
	self assert: (((wimported worksheetNamed: 'Sheet1') at: 1@1) data = 11).
]
