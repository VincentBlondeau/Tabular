Class {
	#name : #PaeoniaAnalyzerSK,
	#superclass : #Paeonia2AnalyzeStructure,
	#instVars : [
		'customerDesc'
	],
	#category : #'Paeonia-Components'
}

{ #category : #accessing }
PaeoniaAnalyzerSK >> customerDesc [
	^ customerDesc
]

{ #category : #accessing }
PaeoniaAnalyzerSK >> customerDesc: anObject [
	customerDesc := anObject
]

{ #category : #guessing }
PaeoniaAnalyzerSK >> guessCustomerDesk [
|tmp step1|
	tmp := worksheet allCoord.
	step1 := tmp detect:[:point|  'АДРЕС ДОСТАВКИ*'  match: (worksheet dataAt: point) asString asUppercase withBlanksCondensed ] ifNone:[^nil].
	tmp := tmp select:[:point| (point y = step1 y) & (point x > step1 x)].
	tmp ifEmpty: [^nil].
	tmp := (tmp collect:[:point| point x]) min.
	tmp:=(worksheet dataAtCol: tmp row: step1 y) findBetweenSubStrs: ', '.
	tmp ifEmpty:[^nil].
	customerDesc := tmp first.
]

{ #category : #guessing }
PaeoniaAnalyzerSK >> guessLastRow [
|col row|
	row := firstRow ifNil: [ ^self ].
	col := colmeaning at: 'Код товара' ifAbsent: [ ^self ].
	
	[
		row := row+1.
		(worksheet dataAtCol: col row: row) notNil
	] whileTrue.
	lastRow := row-1.
]

{ #category : #analyzing }
PaeoniaAnalyzerSK >> loadRawData [
	| colArticleId colArticleDesc colAmount  order|
	
	colArticleId:= (colmeaning at: 'Код товара').
	colArticleDesc:= (colmeaning at: 'Наименование').
	colAmount:= (colmeaning at: 'Количество').

	
	order := PaeoniaOrder new.
	
	(firstRow to: lastRow) do: [ :row | | articleId articleDesc amount |
			articleId := worksheet dataAtCol: colArticleId row: row.
			articleDesc := worksheet dataAtCol: colArticleDesc row: row.
			amount := worksheet dataAtCol: colAmount row: row.

			articleId ifNotNil: [ | entry |
				entry := (PaeoniaEntry new)
					articleId: articleId;
					articleDesc: articleDesc;
					amount: amount;
					yourself.
				order entries add: entry
			]
	].
	order customerDesc: customerDesc.
	^OrderedCollection with: order.
	
]

{ #category : #analyzing }
PaeoniaAnalyzerSK >> meanings [
	^ #('Код товара' 'Наименование' 'Количество' )

]

{ #category : #rendering }
PaeoniaAnalyzerSK >> renderCustomerFieldOn: aRenderer [
	aRenderer div:[
	aRenderer label:[
		aRenderer text: 'Заказчик'; space:3.
		aRenderer textInput
			placeholder: 'Скопируйте название магазина';
			on: #customerDesc of: self.
	]]
]

{ #category : #rendering }
PaeoniaAnalyzerSK >> renderFormContentOn: aRenderer [
	self renderBackOn: aRenderer.
	self renderNextOn: aRenderer.
	self renderCustomerFieldOn: aRenderer.
	self renderTableOn: aRenderer.

]

{ #category : #accessing }
PaeoniaAnalyzerSK >> worksheet: anObject [
	super worksheet: anObject.
	self guessCustomerDesk.

]
