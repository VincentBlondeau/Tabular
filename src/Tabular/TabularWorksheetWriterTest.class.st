Class {
	#name : #TabularWorksheetWriterTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

{ #category : #'tests-rendering' }
TabularWorksheetWriterTest >> testRenderWorksheet [

	| ws |
	ws := TabularWorksheet new.
	ws col: 1 row: 1 putData: 'abc'.
	ws col: 2 row: 1 putData: '123'.
 
	self assert: (TabularWorksheetWriterXL for: ws) equals: 

'<?xml version="1.0" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
    <sheetData>
        <row r="1">
            <c r="A1" t="inlineStr">
                <is>
                    <t>abc</t>
                </is>
            </c>
            <c r="B1" t="inlineStr">
                <is>
                    <t>123</t>
                </is>
            </c>
        </row>
    </sheetData>
</worksheet>'
]
