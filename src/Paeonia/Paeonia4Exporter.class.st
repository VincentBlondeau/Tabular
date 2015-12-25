Class {
	#name : #Paeonia4Exporter,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'orders',
		'date',
		'savedFiles'
	],
	#category : #'Paeonia-Components'
}

{ #category : #'instance creation' }
Paeonia4Exporter class >> orders: aCollection [
	^(self new)
		orders: aCollection;
		yourself.
]

{ #category : #saving }
Paeonia4Exporter >> fileNameFor: anOrder [
	^(
	date yyyymmdd,
	' ',
	(anOrder customer desc),
	'.xml'
	)
]

{ #category : #accessing }
Paeonia4Exporter >> orders [
	^ orders
]

{ #category : #accessing }
Paeonia4Exporter >> orders: anObject [
	orders := anObject
]

{ #category : #rendering }
Paeonia4Exporter >> renderFormContentOn: aRenderer [
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
			with: 'Сохранить'.
	
	savedFiles ifNotNil:[ self renderSavedFilesOn: aRenderer ]
]

{ #category : #rendering }
Paeonia4Exporter >> renderRestartButtonOn: aRenderer [
|tmp|
	tmp := self session.
	aRenderer break.
	aRenderer anchor
		url: self session parent url;
		id: 'restart';
		with: 'В начало'.
]

{ #category : #rendering }
Paeonia4Exporter >> renderSavedArticlesFor: anOrder on: aRenderer [
| unrecognized |
	unrecognized := anOrder entries select: [:entry| entry unrecognized = true].
	
	unrecognized		

		ifEmpty: [
			aRenderer heading
				level: 2;
				with: [
					aRenderer text: (anOrder customer desc), ' - '.
					aRenderer span
						class: 'ok';
						with: (anOrder entries size asString), ' позиций ОК'
				].
		]

		ifNotEmpty: [
			aRenderer heading
				level: 2;
				with: [
					aRenderer text: (anOrder customer desc), ' - '.
					aRenderer span: (anOrder entries size asString), ' позиций, '.
					aRenderer span
						class: 'unsaved';
						with: (unrecognized size asString), ' не сохранено, '.
				].

			aRenderer orderedList
				class: 'unsaved';
				with:[unrecognized do:[:entry|
					aRenderer listItem
						attributeAt: 'value' put: (anOrder entries findFirst: [:entry1| entry1 articleId = entry articleId]);
						with: entry articleDesc
				]]
		]
]

{ #category : #rendering }
Paeonia4Exporter >> renderSavedFilesOn: aRenderer [
	aRenderer heading: 'Сохранено:'.
	aRenderer paragraph: self session exportPath.
	orders do:[:order|

		savedFiles at: order customer
			ifPresent: [:tmp|
				self renderSavedArticlesFor: order on: aRenderer
			]
			ifAbsent: [
				aRenderer heading level: 2; class: 'unsaved'; with: (order customerDesc).
			]
		.
	].
]

{ #category : #saving }
Paeonia4Exporter >> save: anOrder [
| writer fileRef|
	writer:=XMLWriter new.
	writer tag name: 'BizTalk'; with:[
		writer tag name: 'Body'; with:[
			writer tag name: 'CommerceML'; with:[
				self
					saveDocument: anOrder on: writer;
					saveBuyerFin: anOrder customer on: writer;
					saveSellerFinOn: writer.
			]
		]
	].
	writer write.

	fileRef := self session exportPath asFileReference / (self fileNameFor: anOrder).

	fileRef delete.
	fileRef writeStream text; << writer contents.
	savedFiles at: anOrder customer put: fileRef.
]

{ #category : #saving }
Paeonia4Exporter >> saveAll [
	savedFiles := Dictionary new.
	orders do:[:order| order unrecognized ifFalse:[|cleanorder| "Only save orders from RECOGNIZED shops"
		cleanorder := order copy.
		cleanorder entries: (order entries reject: [:entry| entry unrecognized]). "Only save a RECOGNIZED articles"
		self save: cleanorder.
	]]

]

{ #category : #saving }
Paeonia4Exporter >> saveBuyer: aPaeoniaCustomer on: writer [
	writer tag
		name: 'ПредприятиеВДокументе';
		attributeAt: 'Роль' put: 'Buyer';
		attributeAt: 'Контрагент' put: aPaeoniaCustomer guid.
]

{ #category : #saving }
Paeonia4Exporter >> saveBuyerFin: aPaeoniaCustomer on: writer [
	writer tag
		name: 'Контрагент';
		attributeAt: 'Идентификатор' put: aPaeoniaCustomer guid.
]

{ #category : #saving }
Paeonia4Exporter >> saveDocument: anOrder on: writer [
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
				saveBuyer: anOrder customer on: writer;
				saveSellerOn: writer.
			anOrder entries do:[:entry| self saveEntry: entry on: writer ].

		].
]

{ #category : #saving }
Paeonia4Exporter >> saveEntry: anEntry on: writer [
| tag |
	tag:=writer tag
		name: 'ТоварнаяПозиция';
		attributeAt: 'Каталог' put: self session catalogGUID;
		attributeAt: 'Товар' put: anEntry article guid;
		attributeAt: 'Количество' put: anEntry amount asString;
		yourself.

	anEntry price ifNotNilDo:[:price|
		tag 
			attributeAt: 'Цена' put: anEntry price asString.
	]
]

{ #category : #saving }
Paeonia4Exporter >> saveSellerFinOn: writer [ 
	writer tag
		name: 'Контрагент';
		attributeAt: 'Идентификатор' put: self session sellerGUID.
]

{ #category : #saving }
Paeonia4Exporter >> saveSellerOn: writer [
	writer tag
		name: 'ПредприятиеВДокументе';
		attributeAt: 'Роль' put: 'Saler';
		attributeAt: 'Контрагент' put: self session sellerGUID
]

{ #category : #hooks }
Paeonia4Exporter >> style [
^super style, '
	.unsaved { color: red}
	h2.unsaved { text-decoration: line-through}
	.ok { color: green}
	#restart { font-size: 150%; border: 3px green solid; padding: 5px; border-radius: 7px; background: yellow;}
'
]
