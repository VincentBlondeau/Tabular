"
I am TabularWorksheetWriter and generate the XML for a worksheet.


For the Class part:  State the name of the class with one line description: For example, I'm xxx the root of the hierarchy of visitor objects.

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #TabularWorksheetWriterXL,
	#superclass : #TabularXMLWriter,
	#category : #'Tabular-Exporters'
}

{ #category : #rendering }
TabularWorksheetWriterXL >> mergeCells [
|res|
	res := Dictionary new.
	worksheet cellsKeysAndValuesDo: [:coord :cell|
		(cell colspan notNil | cell rowspan notNil) ifTrue:[ |offset|
			offset := (cell colspan ifNil:[0]) @ (cell rowspan ifNil:[0]). "Should upgrade it with Protected Arithmetic"
			res at: coord put: (coord + offset).
		].
	].
	^res.
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderCellWithDate: coord [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((worksheet cells at: coord) data ddmmyyyy)]]
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderCellWithNumber:  coord [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'n';
		with:[ writer tag: 'v' with: ((worksheet cellAt: coord) data asString)]
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderCellWithString: coord [
"do NOT use the construction of a file sharedStrings.xml at the moment; all strings are inlineStr"

	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((worksheet cellAt: coord) data asString)]]
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderMergeCells [
	self mergeCells
		ifNotEmpty: [ :mergeCells | 
			writer
				tag: 'mergeCells'
				with: [ mergeCells
						keysAndValuesDo: [ :topleft :bottomright | 
							writer tag
								name: 'mergeCell';
								attributeAt: 'ref'
									put: (self cellName: topleft) , ':' , (self cellName: bottomright) ] ] ]
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderRows [
	worksheet rows do:[:rowN|
		writer tag
			name: 'row';
			attributeAt: 'r' put: rowN asString;
			with:[ self renderRow: rowN]
	] 
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderSheetData [

    writer tag: 'sheetData' with: [ self renderRows ]
]

{ #category : #rendering }
TabularWorksheetWriterXL >> renderWorksheet [
	writer tag
		name: 'worksheet';
		attributeAt: 'xmlns' put: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		attributeAt: 'xmlns:r' put: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
		with: [ 
					self renderSheetData.
					self renderMergeCells ]
]
