Class {
	#name : #TanderExporter,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'orders',
		'date',
		'savedFiles'
	],
	#category : #'Paeonia-Components'
}

{ #category : #saving }
TanderExporter >> fileNameFor: anOrder [
	^(
	date yyyymmdd,
	' ',
	(self session firmsNames at: anOrder shop ifAbsent: anOrder shop),
	'.xml'
	)
]

{ #category : #accessing }
TanderExporter >> orders [
	^ orders
]

{ #category : #accessing }
TanderExporter >> orders: anObject [
	orders := anObject
]

{ #category : #rendering }
TanderExporter >> renderContentOn: aRenderer [
	aRenderer form:[
		savedFiles
			ifNil:[self renderBackOn: aRenderer]
		ifNotNil:[self renderRestartButtonOn: aRenderer].

		

	aRenderer heading
		level: 1;
		with: 'Заявок: ', (orders size asString).
			
		aRenderer dateInput
			value: date;
			callback: [:date1| date := date1].
		aRenderer	space: 5.
		aRenderer	submitButton
			callback: [ self saveAll];
			with: 'Сохранить'
	].
	
	savedFiles ifNotNil:[ self renderSavedFilesOn: aRenderer ]
]

{ #category : #rendering }
TanderExporter >> renderRestartButtonOn: aRenderer [
	aRenderer break.
	aRenderer anchor
		url:'/TanderImporter';
		id: 'restart';
		with: 'В начало'.
]

{ #category : #rendering }
TanderExporter >> renderSavedArticlesFor: anOrder on: aRenderer [
| unrecognized |
	unrecognized := anOrder entries select: [:entry| entry unrecognized = true].
	
	unrecognized		

		ifEmpty: [
			aRenderer heading
				level: 2;
				with: [
					aRenderer text: (self session firmsNames at: anOrder shop ifAbsent: [anOrder shop]), ' - '.
					aRenderer span
						class: 'ok';
						with: (anOrder entries size asString), ' позиций ОК'
				].
		]

		ifNotEmpty: [
			aRenderer heading
				level: 2;
				with: [
					aRenderer text: (self session firmsNames at: anOrder shop ifAbsent: [anOrder shop]), ' - '.
					aRenderer span: (anOrder entries size asString), ' позиций, '.
					aRenderer span
						class: 'unsaved';
						with: (unrecognized size asString), ' не сохранено, '.
				].

			aRenderer orderedList
				class: 'unsaved';
				with:[unrecognized do:[:entry|
					aRenderer listItem
						attributeAt: 'value' put: (anOrder entries findFirst: [:entry1| entry1 article = entry article]);
						with: entry article
				]]
		]
]

{ #category : #rendering }
TanderExporter >> renderSavedFilesOn: aRenderer [
	aRenderer heading: 'Сохранено:'.
	aRenderer paragraph: self session exportPath.
	orders do:[:order|

		savedFiles at: order shop
			ifPresent: [:tmp|
				self renderSavedArticlesFor: order on: aRenderer
			]
			ifAbsent: [
				aRenderer heading level: 2; class: 'unsaved'; with: (self session firmsNames at: order shop ifAbsent: [ order shop ] ).
			]
		.
	].
]

{ #category : #saving }
TanderExporter >> save: anOrder [
| writer fileRef|
	writer:=XMLWriter new.
	writer tag name: 'BizTalk'; with:[
		writer tag name: 'Body'; with:[
			writer tag name: 'CommerceML'; with:[
				self
					saveDocument: anOrder on: writer;
					saveBuyerFin: anOrder shop on: writer;
					saveSellerFinOn: writer.
			]
		]
	].
	writer write.

	fileRef := self session exportPath asFileReference / (self fileNameFor: anOrder).
	fileRef writeStream text; << writer contents.
	savedFiles at: anOrder shop put: fileRef.
]

{ #category : #saving }
TanderExporter >> saveAll [
	savedFiles := Dictionary new.
	orders do:[:order| (order unrecognized = true) ifFalse:[|cleanorder| "Only save orders from RECOGNIZED shops"
		cleanorder := order copy.
		cleanorder entries: (order entries reject: [:entry| entry unrecognized = true]). "Only save a RECOGNIZED articles"
		self save: cleanorder.
	]]

]

{ #category : #saving }
TanderExporter >> saveBuyer: GUID on: writer [
	writer tag
		name: 'ПредприятиеВДокументе';
		attributeAt: 'Роль' put: 'Buyer';
		attributeAt: 'Контрагент' put: GUID.
]

{ #category : #saving }
TanderExporter >> saveBuyerFin: GUID on: writer [
	writer tag
		name: 'Контрагент';
		attributeAt: 'Идентификатор' put: GUID.
]

{ #category : #saving }
TanderExporter >> saveDocument: anOrder on: writer [
	writer tag
		name:'Документ';
		attributeAt: 'ХозОперация' put: 'Order';
		attributeAt: 'Номер' put: '1';
		attributeAt: 'Дата' put: date yyyymmdd;
		attributeAt: 'Валюта' put: 'руб.';
		attributeAt: 'Курс' put: '1';
		with:[
			writer tag
				name: 'СуммаНалога';
				attributeAt: 'Налог' put: 'AVT';
				attributeAt: 'Сумма' put: '1';
				attributeAt: 'ВключенВСумму' put: '1'.
			self
				saveBuyer: anOrder shop on: writer;
				saveSellerOn: writer.
			anOrder entries do:[:entry| self saveEntry: entry on: writer ]
		].
]

{ #category : #saving }
TanderExporter >> saveEntry: anEntry on: writer [
	writer tag
		name: 'ТоварнаяПозиция';
		attributeAt: 'Каталог' put: self session catalogGUID;
		attributeAt: 'Товар' put: anEntry article;
		attributeAt: 'Количество' put: anEntry amount;
		attributeAt: 'Цена' put: anEntry price
]

{ #category : #saving }
TanderExporter >> saveSellerFinOn: writer [ 
	writer tag
		name: 'Контрагент';
		attributeAt: 'Идентификатор' put: self session sellerGUID.
]

{ #category : #saving }
TanderExporter >> saveSellerOn: writer [
	writer tag
		name: 'ПредприятиеВДокументе';
		attributeAt: 'Роль' put: 'Saler';
		attributeAt: 'Контрагент' put: self session sellerGUID
]

{ #category : #hooks }
TanderExporter >> style [
^super style, '
	.unsaved { color: red}
	h2.unsaved { text-decoration: line-through}
	.ok { color: green}
	#restart { font-size: 150%; border: 3px green solid; padding: 5px; border-radius: 7px; background: yellow;}
'
]
