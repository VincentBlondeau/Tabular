Class {
	#name : #PaeoniaFilePicker,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'workbook',
		'file',
		'worksheet'
	],
	#category : #'Paeonia-Components'
}

{ #category : #accessing }
PaeoniaFilePicker >> eraseFile [
	^ file := workbook := nil
]

{ #category : #'as yet unclassified' }
PaeoniaFilePicker >> next [
	self answer: {#next . worksheet}
]

{ #category : #accessing }
PaeoniaFilePicker >> pickFile: aWAFile [ 
	file:=aWAFile.
	workbook := (XLSXImporter import: aWAFile rawContents readStream).

]

{ #category : #rendering }
PaeoniaFilePicker >> renderFilePickerOn: aRenderer [
	workbook
		ifNil: [ 

							aRenderer fileUpload
								onChange: 'submit()';
								on: #pickFile of: self	"callback: [ : file1 | self pickFile: file1 ]" ]
		ifNotNil: [ 
			aRenderer text: file fileName.
			aRenderer anchor
				callback: [ self eraseFile ];
				with: 'Загрузить другой' ]
]

{ #category : #rendering }
PaeoniaFilePicker >> renderFormContentOn: aRenderer [
	self renderNextOn: aRenderer.

	aRenderer heading: 'Выберите файл для импорта'.

	self renderFilePickerOn: aRenderer.
	self renderTypeSelectorOn: aRenderer.
	self renderWorksheetSelectorOn: aRenderer.
]

{ #category : #rendering }
PaeoniaFilePicker >> renderTypeSelectorOn: aRenderer [
| typeSelector |
	typeSelector := aRenderer radioGroup.
	typeSelector radioButton value: #Tander; with:'Тандер'.
	typeSelector radioButton value: #SK; with: 'Солнечный круг'.
]

{ #category : #rendering }
PaeoniaFilePicker >> renderWorksheetSelectorOn: aRenderer [
|selectTag|
	selectTag := aRenderer select
		labels: [:worksheet| worksheet name ];
		on: #worksheet of: self;
		yourself.
			
	workbook
		ifNil: [ selectTag disabled: true]
		ifNotNil: [
			selectTag list: workbook worksheets.
			"selectTag onChange: 'alert(''test'')'"
		].

]

{ #category : #accessing }
PaeoniaFilePicker >> worksheet [
	^ worksheet
]

{ #category : #accessing }
PaeoniaFilePicker >> worksheet: anObject [
	worksheet := anObject
]
