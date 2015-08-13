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
	#name : #TabularExportImportTest,
	#superclass : #TestCase,
	#instVars : [
		'worksheet',
		'fname',
		'fname2',
		'fname3',
		'fname0',
		'fname4'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularExportImportTest >> setUp [
    fname0 := 'TabularEmptySheetExported.xlsx'.
    fname4 := 'TabularConstructed4Exported.xlsx'.
		
    fname := TabularResources fileNameOfExample1.
    (FileLocator home / fname ) ensureDelete.

    fname2 := TabularResources fileNameOfExample2.
    (FileLocator home / fname2 ) ensureDelete.
   
    fname3 := TabularResources fileNameOfExample1.
    (FileLocator home / fname3 ) ensureDelete
	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport0EmptyWorkbook [
"export empty workbook"

|w  |
	w := TabularWorkbook new.
	self assert:  (w worksheets isEmpty).	
		
	TabularXSLXExport workbook: w fileName: fname2.

	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport1CellAccess [

	| wbk  wimported cell ws |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	
	ws := (wimported worksheetNamed: 'Sheet1').
	self assert: (ws cells includesKey: 3@9).
	cell := ws at: 3@9.
	self assert: (cell notNil).
	self assert: (cell data = '39').
	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport1DefaultSheetName [

	| wbk  wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	
	self assert: (wimported worksheetNamed: 'Sheet1') name equals: 'Sheet1'.
	self should: [ (wimported worksheetNamed: 'Sheet2') name ] raise: NotFound.

	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport1SheetName [

	| wbk   sheetImported theSheetName wbkimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	theSheetName := 'theTestWorkSheet'.
	wbk worksheets first name: theSheetName.
	TabularXSLXExport workbook: wbk fileName: fname.


	wbkimported := XLSXImporter import: (FileLocator home / fname ) .
	sheetImported := wbkimported worksheetNamed: theSheetName. 
	self assert: sheetImported name equals: theSheetName.
	self should: [ (wbkimported worksheetNamed: 'Sheet2') name ] raise: NotFound.

	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport2 [

|  wbk wimported |
	wbk := XLSXImporter import: TabularResources testExcelFile2withThreeSheets   readStream.
		
	TabularXSLXExport workbook: wbk fileName: fname2.
	
	


	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport3 [

	| wbk  wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname3.

	wimported := XLSXImporter import: (FileLocator home / fname3 ) .
	
	self assert: (wimported worksheetNamed: 'Feuil1') name equals: 'Feuil1'.
	self should: [ (wimported worksheetNamed: 'Feuil4') name ] raise: NotFound.
	
	
	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport4 [

|wbk wsheet  wimported cell |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31.	
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: (FileLocator home / fname4 ) .
	cell := ((wimported worksheetNamed: 'Sheet1') at: 1@1).
	self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data asString= '11').
	self assert: (cell data = 11).  "cell data is aString but should be a number"
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport4Strings [

|wbk wsheet  wimported cell |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 'abc 11';
		at: 2 @ 1 putData: 'def 21';
		at: 3 @ 1 putData: 'ghi 31'.	
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: (FileLocator home / fname4 ) .
	cell := ((wimported worksheetNamed: 'Sheet1') at: 1@1).
	self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data asString= 'abc 11').
	self assert: (cell data = 'abc 11').  
	
"The import function cannot deal with the content constructed by the export function. 

How does the import function treat the inlineStr (inline strings). The t property is recognized, but later that assingment to the cell does not take place.
".


'<row r="1">
<c r="A1" t="inlineStr"><is><t>abc 11</t></is></c>
<c r="B1" t="inlineStr"><is><t>def 21</t></is></c>
<c r="C1" t="inlineStr"><is><t>ghi 31</t></is></c>
</row>'


]
