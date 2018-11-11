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

    | dir |
     dir := FileLocator temp.  "use temporary directory to put the exported test files."
                                          "FileLocator home  is an alternative"

    fname0 := dir / 'TabularEmptySheetExported.xlsx'.      

    fname := dir / TabularResources fileNameOfExample1.
    fname2 := dir /  TabularResources fileNameOfExample2.   
    fname3 := dir / TabularResources fileNameOfExample1.

    fname4 := dir / 'TabularConstructed4Exported.xlsx'.  
    fname5 := dir / 'TabularConstructed5Exported.xlsx'.   
    fname6 := dir / 'TabularConstructed6ExportedTwoWorksheets.xlsx'.   
    fname7 := dir / 'TabularConstructed7ExportedThreeWorksheets.xlsx'. 
		
		
	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport0EmptyWorkbook [
"export empty workbook"

|w  |
	w := TabularWorkbook new.
	self assert:  (w worksheets isEmpty).	
		
	TabularXLSXExport workbook: w fileName: fname2.

	
]

{ #category : #'tests-numbers' }
TabularExportImportTest >> testExport1CellAccess [

	| wbk  wimported cell ws |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	fname ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: fname.
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
	TabularXLSXExport workbook: wbk fileName: fname.

	wimported := XLSXImporter import: fname .
	
	self assert: (wimported worksheetNamed: 'Sheet1') name equals: 'Sheet1'.
	self should: [ (wimported worksheetNamed: 'Sheet2') name ] raise: NotFound.

	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport1SheetName [
	| wbk   sheetImported theSheetName wbkimported |
	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
	self assert: wbk worksheets size equals: 1.
	theSheetName := wbk worksheets first name.
	
	fname ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname.

	wbkimported := XLSXImporter import: fname.
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
     fname ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname.


	wbkimported := XLSXImporter import: fname.
	sheetImported := wbkimported worksheetNamed: theSheetName. 
	self assert: sheetImported name equals: theSheetName.
	self assert: wbkimported worksheets size equals: 1.

]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport2 [

|  wbk wimported |
	wbk := XLSXImporter import: TabularResources testExcelFile2withThreeSheets   readStream.
		
	TabularXLSXExport workbook: wbk fileName: fname2.
	
	


	
]

{ #category : #'as yet unclassified' }
TabularExportImportTest >> testExport3 [
	| wbk  wimported |

	wbk := XLSXImporter import: TabularResources testExcelFile1OneSheetOnly  readStream.
     fname3 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname3.

	wimported := XLSXImporter import: fname3.
	
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
      fname4 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: fname4.
	cell := ((wimported worksheetNamed: nameOfSheet) at: 1@1).
	self assert: (cell isKindOf:  TabularXLSXCell).
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
	fname4 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: fname4.
	cell := wimported worksheets first at: 1@1.
	self assert: (cell isKindOf:  TabularXLSXCell).
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
	fname4 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname4.

	wimported := XLSXImporter import: fname4.
	cell := wimported worksheets first cellAt:  1@1.
	self assert: (cell isKindOf:  TabularXLSXCell).
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
	fname5 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname5.
	wbkimported := XLSXImporter import: fname5 .
	wsheetimported := wbkimported worksheets first.
	cell := wsheetimported at: 1 @ 1.
	self assert: (cell isKindOf:  TabularXLSXCell).
	self assert: (cell data asString= 'abc 11').
	cell := wsheetimported at: 2 @ 1.
		self assert: (cell isKindOf:  TabularXLSXCell).
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
fname6 ensureDelete.
TabularXLSXExport workbook: wbk fileName: fname6.

wbkimported := XLSXImporter import: fname6.
 
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

fname7 ensureDelete.
TabularXLSXExport workbook: wbk fileName: fname7.

wbkimported := XLSXImporter import: fname7 .
 
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

{ #category : #'tests-strings' }
TabularExportImportTest >> testExport8ExportManyWorksheets [

	| wbk wsheet wbkimported wsheetimported rnd sheetNames cellPositions values |
	wbk := TabularWorkbook new.
	rnd := Random new.
	sheetNames := (1 to: 10) collect: [ :i | 'Sheet ', i printString].
	values := (1 to: 10) collect: [ :i | i even ifTrue: [rnd nextInt: 1000] ifFalse: [ (rnd nextInt: 100) printStringRadix: 16 ] ].
	cellPositions := (1 to: 10) collect: [ :i | (rnd nextInt: 5) @ (rnd nextInt: 10) ].
	1 to: 10 do: [ :i |
		wsheet := TabularWorksheet new.
		wsheet name: (sheetNames at: i).
		wsheet at: (cellPositions at: i) putData: (values at: i).
		wbk addSheet: wsheet].

	fname7 ensureDelete.
	TabularXLSXExport workbook: wbk fileName: fname7.

	wbkimported := XLSXImporter import: fname7 .
 
	1 to: 10 do: [ :i |
		wsheetimported := wbkimported worksheets at: i.
		self assert: wsheetimported name equals: (sheetNames at: i).
		self assert: (wsheetimported at: (cellPositions at: i)) data equals: (values at: i)]
]
