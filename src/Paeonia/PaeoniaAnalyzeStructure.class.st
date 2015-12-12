Class {
	#name : #PaeoniaAnalyzeStructure,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'colmeaning',
		'firstRow',
		'lastRow',
		'worksheet'
	],
	#category : #'Paeonia-Components'
}

{ #category : #'instance creation' }
PaeoniaAnalyzeStructure class >> worksheet: aTabularWorksheet [
	^(self new)
		worksheet: aTabularWorksheet;
		yourself.
]

{ #category : #initialization }
PaeoniaAnalyzeStructure >> initialize [
	super initialize.
	colmeaning := Dictionary new.

]

{ #category : #private }
PaeoniaAnalyzeStructure >> meanings [
	^ #('Магазин' 'Код товара' 'Количество' 'Цена')
]

{ #category : #actions }
PaeoniaAnalyzeStructure >> next [
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
PaeoniaAnalyzeStructure >> redo [

]

{ #category : #rendering }
PaeoniaAnalyzeStructure >> renderAnalyzerOn: aRenderer [
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
PaeoniaAnalyzeStructure >> renderFormContentOn: aRenderer [
	| cols rows headSelector |
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

{ #category : #hooks }
PaeoniaAnalyzeStructure >> style [
^super style, '
	td { border: 1px black solid }
'
]

{ #category : #accessing }
PaeoniaAnalyzeStructure >> worksheet [
	^ worksheet
]

{ #category : #accessing }
PaeoniaAnalyzeStructure >> worksheet: anObject [
	worksheet := anObject
]
