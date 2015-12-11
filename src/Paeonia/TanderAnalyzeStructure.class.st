Class {
	#name : #TanderAnalyzeStructure,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'colmeaning',
		'firstRow'
	],
	#category : #'Paeonia-Components'
}

{ #category : #actions }
TanderAnalyzeStructure >> back [
	self session worksheetErase
]

{ #category : #initialization }
TanderAnalyzeStructure >> initialize [
	super initialize.
	colmeaning := Dictionary new.

]

{ #category : #private }
TanderAnalyzeStructure >> meanings [
	^ #('Магазин' 'Код товара' 'Количество' 'Цена')
]

{ #category : #actions }
TanderAnalyzeStructure >> next [
	errors := OrderedCollection new.

	firstRow ifNil:[errors add: 'Не выбрана первая строка данных'].
	self meanings do:[:meaning|
		colmeaning at: meaning ifAbsent: [ errors add: 'Не выбрана колонка "', meaning, '"' ]
	].
	
	errors ifEmpty: [|importer|
		importer := TanderImporter new.
		importer
			colShop: (colmeaning at: self meanings first);
			colArticle: (colmeaning at: self meanings second);
			colAmount: (colmeaning at: self meanings third);
			colPrice: (colmeaning at: self meanings fourth);
			firstRow: firstRow;
			analyze.
						
		self call: importer onAnswer:[:answer| self initialize]
	].
]

{ #category : #actions }
TanderAnalyzeStructure >> redo [

]

{ #category : #rendering }
TanderAnalyzeStructure >> renderAnalyzerOn: aRenderer [
	| cols rows headSelector worksheet|
	super renderErrorsOn: aRenderer.
	worksheet := self session worksheet.
	cols := worksheet cols size.
	rows := worksheet rows size.
	aRenderer
		form: [ 
			self renderBackOn: aRenderer.
			self renderRedoOn: aRenderer.
			self renderNextOn: aRenderer.
			
			headSelector := aRenderer radioGroup.
			headSelector callback: [ :val | firstRow := val ].
			aRenderer
				table: [ 
					aRenderer
						tableHead
							
							with:[
								aRenderer tableRow "style: 'position: fixed';" with: [ 
									aRenderer tableData: 'Первая строка данных'.
									(1 to: cols) do: [ :col | 
										aRenderer tableData: [ 
											aRenderer select
												beOptional;
												list: self meanings;
												callback: [ :value | colmeaning at: value put: col ]
										]
									]
								]
							].
					
					aRenderer tableBody: [(1 to: rows)
						do: [ :row | 
							aRenderer
								tableRow: [ 
									aRenderer tableData: [ headSelector radioButton value: row ].
									(1 to: cols) do: [ :col | aRenderer tableData: (worksheet dataAt: col@row) ] ] ] ] ]]
]

{ #category : #rendering }
TanderAnalyzeStructure >> renderContentOn: aRenderer [
	self session worksheet
		ifNil: [ self renderFilePickerOn: aRenderer ]
		ifNotNil: [ self renderAnalyzerOn: aRenderer ]
]

{ #category : #rendering }
TanderAnalyzeStructure >> renderFilePickerOn: aRenderer [ 
	aRenderer	form
		multipart;
		with: [ 
			aRenderer heading: 'Выберите файл для импорта'.
			aRenderer fileUpload
				"accept: 'xlsx';"
				onChange: 'submit()';
				callback: [:file| self session worksheetFrom: file]
		]

]

{ #category : #hooks }
TanderAnalyzeStructure >> style [
^super style, '
	td { border: 1px black solid }
'
]
