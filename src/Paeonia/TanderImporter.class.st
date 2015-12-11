Class {
	#name : #TanderImporter,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'colShop',
		'colPrice',
		'colAmount',
		'colArticle',
		'firstRow',
		'orders'
	],
	#category : #'Paeonia-Components'
}

{ #category : #analyzing }
TanderImporter >> analyze [
	orders := OrderPreservingDictionary new.
	self loadRawData.
	self substitute.
]

{ #category : #accessing }
TanderImporter >> colAmount [
	^ colAmount
]

{ #category : #accessing }
TanderImporter >> colAmount: anObject [
	colAmount := anObject
]

{ #category : #accessing }
TanderImporter >> colArticle [
	^ colArticle
]

{ #category : #accessing }
TanderImporter >> colArticle: anObject [
	colArticle := anObject
]

{ #category : #accessing }
TanderImporter >> colPrice [
	^ colPrice
]

{ #category : #accessing }
TanderImporter >> colPrice: anObject [
	colPrice := anObject
]

{ #category : #accessing }
TanderImporter >> colShop [
	^ colShop
]

{ #category : #accessing }
TanderImporter >> colShop: anObject [
	colShop := anObject
]

{ #category : #accessing }
TanderImporter >> firstRow [
	^ firstRow
]

{ #category : #accessing }
TanderImporter >> firstRow: anObject [
	firstRow := anObject
]

{ #category : #analyzing }
TanderImporter >> loadRawData [
|worksheet|
	worksheet := self session worksheet.
	(firstRow to: worksheet cells keys max y)
		do: [ :row | 
			| shop article amount price |
			shop := worksheet dataAtCol: colShop row: row.
			article := worksheet dataAtCol: colArticle row: row.
			amount := worksheet dataAtCol: colAmount row: row.
			price := worksheet dataAtCol: colPrice row: row.
			article notNil & shop notNil
				ifTrue: [ 
					| order entry |
					order := orders at: shop ifAbsentPut: [ PaeoniaOrder new shop: shop ].
					entry := PaeoniaEntry new
						article: article;
						amount: amount;
						price: price.
					order entries add: entry ] ]
]

{ #category : #'as yet unclassified' }
TanderImporter >> next [
| component |
	component := TanderExporter new.
	component orders: orders.
	self call: component.
]

{ #category : #'as yet unclassified' }
TanderImporter >> redo [
	self session readConfiguration.
	self analyze.
]

{ #category : #'as yet unclassified' }
TanderImporter >> renderContentOn: aRenderer [
	| articlesNames firmsNames |
	self renderErrorsOn: aRenderer.
	aRenderer
		form: [ 
			self renderBackOn: aRenderer.
			self renderRedoOn: aRenderer.
			self renderNextOn: aRenderer.
		].
	articlesNames := self session articlesNames.
	firmsNames := self session firmsNames.
	orders values
		do: [ :order | 
			aRenderer heading
				level: 1;
				class:
						(order unrecognized = true
								ifTrue: [ 'unrecognized' ]
								ifFalse: [ nil ]);
				with: (firmsNames at: order shop ifAbsent: [ order shop ]).
			aRenderer orderedList
				with: [ 
					order entries
						do: [ :entry | 
							aRenderer listItem
								class:
										(entry unrecognized = true
												ifTrue: [ 'unrecognized' ]
												ifFalse: [ nil ]);
								with: (articlesNames at: entry article ifAbsent: [ entry article ]) ] ] ]
]

{ #category : #'as yet unclassified' }
TanderImporter >> style [
^super style, '
	.unrecognized { color: red}
'
]

{ #category : #analyzing }
TanderImporter >> substitute [
|unrecognizedShops unrecognizedArticles|
	unrecognizedShops := unrecognizedArticles := 0.
	
	orders do:[:order|
		order shop: (
			self session firms
				at: order shop
				ifAbsent:[
					order unrecognized: true.
					unrecognizedShops := unrecognizedShops + 1.
					order shop
				]
		).
		order entries do:[:entry|
			entry article: (
				self session articles
					at: entry article
					ifAbsent:[
						entry unrecognized: true.
						unrecognizedArticles := unrecognizedArticles + 1.
						entry article
					]
			).		
		]
	].

	errors := OrderedCollection new.
	(unrecognizedShops > 0) ifTrue: [ errors add: 'Нераспознанных заказчиков: ', (unrecognizedShops asString)].
	(unrecognizedArticles > 0) ifTrue: [ errors add: 'Нераспознанных товаров: ', (unrecognizedArticles asString)].
]
