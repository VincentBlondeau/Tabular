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
		'fname4',
		'fname5',
		'fname6',
		'fname7'
	],
	#category : #'Tabular-Tests'
}

{ #category : #setUp }
TabularExportImportTest >> setUp [
    fname0 := 'TabularEmptySheetExported.xlsx'.
    fname4 := 'TabularConstructed4Exported.xlsx'.
    fname5 := 'TabularConstructed5Exported.xlsx'.
    fname6 := 'TabularConstructed6ExportedTwoWorksheets.xlsx'.
    fname7 := 'TabularConstructed7ExportedThreeWorksheets.xlsx'.
		
		
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

{ #category : #'tests-numbers' }
TabularExportImportTest >> testExport1CellAccess [

	| wbk  wimported cell ws |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	TabularXSLXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: (FileLocator home / fname ) .
	
	ws := (wimported worksheetNamed: 'Sheet1').
	self assert: (ws allCoord includes: 3@9).
	cell := ws at: 3@9.
	self assert: (cell notNil).
	self assert: (cell data = 39).
	
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
	self assert: wbk worksheets size equals: 1.
	theSheetName := wbk worksheets first name.
	TabularXSLXExport workbook: wbk fileName: fname.

	wbkimported := XLSXImporter import: (FileLocator home / fname ) .
	sheetImported := wbkimported worksheetNamed: theSheetName. 
	self assert: sheetImported name equals: theSheetName.
	self assert: wbkimported worksheets size equals: 1.

]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport1SheetName2 [
	| wbk   sheetImported theSheetName wbkimported |
	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	theSheetName := 'theTestWorkSheet'.
	wbk worksheets first name: theSheetName.
	self assert: wbk worksheets size equals: 1.
	self assert: wbk worksheets first name equals: theSheetName. 
	TabularXSLXExport workbook: wbk fileName: fname.

	wbkimported := XLSXImporter import: (FileLocator home / fname ) .
	sheetImported := wbkimported worksheetNamed: theSheetName. 
	self assert: sheetImported name equals: theSheetName.
	self assert: wbkimported worksheets size equals: 1.

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
	
	self assert: (wimported worksheetNamed: 'Sheet1') name equals: 'Sheet1'.
	self should: [ (wimported worksheetNamed: 'Sheet4') name ] raise: NotFound.
	
	
	
]

{ #category : #'tests-numbers' }
TabularExportImportTest >> testExport4Numbers [

|wbk wsheet  wimported cell nameOfSheet |
	wbk := TabularWorkbook new.
	self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31.	
	nameOfSheet := wsheet name.		
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: (FileLocator home / fname4 ) .
	cell := ((wimported worksheetNamed: nameOfSheet) at: 1@1).
	self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data asString= '11').
	self assert: (cell data = 11).  "cell data is aString but should be a number"
]

{ #category : #'tests-numbers' }
TabularExportImportTest >> testExport4NumbersStringContent [

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
	cell := wimported worksheets first at: 1@1.
	self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data asString= '11').  "content OK"
     "cell data is aString but should be a number"
]

{ #category : #'tests-strings' }
TabularExportImportTest >> testExport4Strings [

|wbk wsheet  wimported cell |
	wbk := TabularWorkbook new. self assert:  (wbk worksheets isEmpty).	
		
	wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 'abc 11';
		at: 2 @ 1 putData: 'def 21';
		at: 3 @ 1 putData: 'ghi 31'.	
	wbk worksheets add: wsheet.
	TabularXSLXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: (FileLocator home / fname4 ) .
	cell := wimported worksheets first cellAt:  1@1.
	self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data asString= 'abc 11').
]

{ #category : #'tests-strings' }
TabularExportImportTest >> testExport5 [
|wbk wsheet  wbkimported wsheetimported cell |
	wbk := TabularWorkbook new. wsheet := TabularWorksheet new.
	wsheet
		at: 1 @ 1 putData: 'abc 11';
		at: 2 @ 1 putData: 21.
	wbk worksheets add: wsheet.
		TabularXSLXExport workbook: wbk fileName: fname5.
	wbkimported := XLSXImporter import: (FileLocator home / fname5 ) .
	wsheetimported := wbkimported worksheets first.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data asString= 'abc 11').
	cell := wsheetimported at: 2 @ 1.
		self assert: (cell isKindOf:  TabularCell).
	self assert: (cell data = 21).


]

{ #category : #'tests-strings' }
TabularExportImportTest >> testExport6ExportTwoWorksheets [

"The import part is tested by testExport6aImportTwoWorksheets"

| wbk wsheet wbkimported wsheetimported cell |
wbk := TabularWorkbook new.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet'.
wsheet at: 1 @ 1 putData: 123.
wbk addSheet: wsheet.

wsheet := TabularWorksheet new.
wsheet name: 'mySecondSheet'.
wsheet at: 1 @ 1 putData: 456.
wsheet at: 1 @ 2 putData: 'abc'.
wbk addSheet: wsheet.

TabularXSLXExport workbook: wbk fileName: fname6.

wbkimported := XLSXImporter import: (FileLocator home / fname6 ) .
 
     wsheetimported := wbkimported worksheets first.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 123).

	wsheetimported := wbkimported worksheets second.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 456).
	cell := wsheetimported at: 1 @ 2.
	self assert: (cell data = 'abc').
]

{ #category : #'tests-strings' }
TabularExportImportTest >> testExport6aImportTwoWorksheets [

	| file wbkimported wsheetimported cell |
	file := TabularResources testExcelFile6aTwoWorksheets  readStream.
	wbkimported := XLSXImporter import: file.
 
     wsheetimported := wbkimported worksheets first.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 123).

	wsheetimported := wbkimported worksheets second.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 456).
	cell := wsheetimported at: 1 @ 2.
	self assert: (cell data = 'abc').
]

{ #category : #'tests-strings' }
TabularExportImportTest >> testExport7ExportThreeWorksheets [

"The import part is tested by testExport6aImportTwoWorksheets"

| wbk wsheet wbkimported wsheetimported cell |
wbk := TabularWorkbook new.
wsheet := TabularWorksheet new.
wsheet name: 'mySheet'.
wsheet at: 1 @ 1 putData: 123.
wbk addSheet: wsheet.

wsheet := TabularWorksheet new.
wsheet name: 'mySecondSheet'.
wsheet at: 1 @ 1 putData: 456.
wsheet at: 1 @ 2 putData: 'abc'.
wbk addSheet: wsheet.

wsheet := TabularWorksheet new.
wsheet name: 'myThirdSheet'.
wsheet at: 1 @ 1 putData: 789.
wbk addSheet: wsheet.


TabularXSLXExport workbook: wbk fileName: fname7.

wbkimported := XLSXImporter import: (FileLocator home / fname7 ) .
 
     wsheetimported := wbkimported worksheets first.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 123).

	wsheetimported := wbkimported worksheets second.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 456).
	cell := wsheetimported at: 1 @ 2.
	self assert: (cell data = 'abc').
	
	wsheetimported := wbkimported worksheets third.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell data = 789).
]
