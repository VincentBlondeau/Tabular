Class {
	#name : #TabularXLSXExportTest,
	#superclass : #TestCase,
	#instVars : [
		'worksheet',
		'fname4',
		'fname5',
		'fname6',
		'fname7'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularXLSXExportTest >> setUp [
    

    fname4 := 'TabularConstructed4Exported.xlsx'.
    fname5 := 'TabularConstructed5Exported.xlsx'.
    fname6 := 'TabularConstructed6Exported.xlsx'.
    fname7 := 'TabularConstructed7Exported.xlsx'.



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
