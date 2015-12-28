"
Answer structure:
	1) #next or #back
	2) worksheet object
	3) type symbol
"
Class {
	#name : #Paeonia1FilePicker,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'workbook',
		'file',
		'worksheet',
		'type'
	],
	#category : #'Paeonia-Components'
}

{ #category : #accessing }
Paeonia1FilePicker >> eraseFile [
	^ file := workbook := type := nil
]

{ #category : #guessing }
Paeonia1FilePicker >> guessTypeAndSheet [
	workbook worksheets
		detect: [:ws| ws name = 'Лист1' ]
		ifFound: [:ws| worksheet := ws. type := #Tander. ^self].

	workbook worksheets
		detect: [:ws| ws name = 'TDSheet' ]
		ifFound: [:ws| worksheet := ws. type := #SK. ^self].
]

{ #category : #workflow }
Paeonia1FilePicker >> next [

	self flushErrors.

	workbook
		ifNil:[errors add: 'Не выбран файл для загрузки']
		ifNotNil: [ worksheet ifNil:[errors add: 'Не выбрана загружаемая вкладка в файле'] ].
	type ifNil:[errors add: 'Не выбран тип загружаемой накладной'].
	
	errors ifNotEmpty: [ ^self ].
	
	

	worksheet cleanup compactify.
	self answer: {#next . worksheet . type}
]

{ #category : #accessing }
Paeonia1FilePicker >> pickFile: aWAFile [ 
	file:=aWAFile.
	[
		workbook := (XLSXImporter import: aWAFile rawContents readStream).
		self flushErrors.
		self guessTypeAndSheet.
	] on: Error do: [:e|  errors add: 'Файл неподходящего формата. Возможно, вы указали XLS-файл вместо XLSX-файла?']

]

{ #category : #rendering }
Paeonia1FilePicker >> renderFilePickerOn: aRenderer [
	aRenderer label:[
		aRenderer text: 'Файл для загрузки: '.
		workbook
			ifNil: [ 
				aRenderer fileUpload
					onChange: 'submit()';
					on: #pickFile of: self.
			]
			ifNotNil: [ 
				aRenderer text: file fileName.
				aRenderer space.
				aRenderer anchor
					callback: [ self eraseFile ];
					with: '[Загрузить другой]'.
			]
	]
]

{ #category : #rendering }
Paeonia1FilePicker >> renderFormContentOn: aRenderer [
	self renderNextOn: aRenderer.

	aRenderer heading: 'Выберите файл для импорта'.

	self renderFilePickerOn: aRenderer.
	self renderTypeSelectorOn: aRenderer.
	self renderWorksheetSelectorOn: aRenderer.
]

{ #category : #rendering }
Paeonia1FilePicker >> renderTypeSelectorOn: aRenderer [
| typeSelector |

	typeSelector := aRenderer radioGroup.

	typeSelector
		selected: self type;
		callback:[:type1| self type: type1].

	aRenderer div:[
		aRenderer label class: 'type'; with:[ typeSelector radioButton value: #Tander. aRenderer text:'Тандер'. ].
		aRenderer label class: 'type'; with:[ typeSelector radioButton value: #SK. aRenderer text:'Солнечный круг'. ].
	]
]

{ #category : #rendering }
Paeonia1FilePicker >> renderWorksheetSelectorOn: aRenderer [
|selectTag|
	aRenderer label:[
		aRenderer text: 'Лист в файле: '.

		selectTag := aRenderer select
			labels: [:worksheet1| worksheet1 name ];
			on: #worksheet of: self;
			yourself.
			
		workbook
			ifNil: [ selectTag disabled: true]
			ifNotNil: [ selectTag list: workbook worksheets ].
	]

]

{ #category : #'as yet unclassified' }
Paeonia1FilePicker >> style [
^super style, '
	label.type {
		display: block;
		font-weight: bold;
		font-size: 150%;
	}
'
]

{ #category : #accessing }
Paeonia1FilePicker >> type [
	^ type
]

{ #category : #accessing }
Paeonia1FilePicker >> type: anObject [
	type := anObject
]

{ #category : #accessing }
Paeonia1FilePicker >> worksheet [
	^ worksheet
]

{ #category : #accessing }
Paeonia1FilePicker >> worksheet: anObject [
	worksheet := anObject
]
