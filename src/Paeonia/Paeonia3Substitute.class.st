"
Answer structure:
	1) #next or #back
	2) Collection of the ""fully-filled"" PaeoniaOrders
	
""Fully-filled"" means that orders and it's etries do not only have IDs and names from the file, but also links to correspondent articles.

"
Class {
	#name : #Paeonia3Substitute,
	#superclass : #PaeoniaComponent,
	#instVars : [
		'orders',
		'unrecognizedOrders',
		'unrecognizedEntries'
	],
	#category : #'Paeonia-Components'
}

{ #category : #'instance creation' }
Paeonia3Substitute class >> orders: aCollection [
	^(self new)
		orders: aCollection;
		yourself.
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> next [
	self answer:{#next . orders}
]

{ #category : #accessing }
Paeonia3Substitute >> orders [
	^ orders
]

{ #category : #accessing }
Paeonia3Substitute >> orders: anObject [
	orders := anObject.
	self substitute.
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> redo [
	self session readSettings.
	self substitute.
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> renderEntry:entry on: aRenderer [
	aRenderer tableRow
		class: (entry unrecognized ifTrue: ['unrecognized'] ifFalse: [nil]);
		with:[
			aRenderer	tableData
				title: (entry unrecognized ifTrue: [nil] ifFalse: [entry article guid]);
				with: entry articleId.

			aRenderer	tableData
				title: (entry unrecognized ifTrue: [nil] ifFalse: [entry article desc]);
				with: entry articleDesc.

			aRenderer
				tableData: entry price;
				tableData: entry amount.
		]
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> renderFormContentOn: aRenderer [
	self renderBackOn: aRenderer.
	self renderRedoOn: aRenderer.
	self renderNextOn: aRenderer.
	(unrecognizedEntries notEmpty | unrecognizedOrders notEmpty)
		ifTrue: [
			aRenderer heading: 'Нераспознанные'.
			self renderUnrecognizedListOn: aRenderer.
			aRenderer heading: 'Накладные'.
		].
	orders do: [ :order | self renderOrder: order on: aRenderer]
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> renderHeadingsOn: aRenderer [
	^ aRenderer
		tableRow: [ 
			aRenderer
				tableData: 'Код товара';
				tableData: 'Наименование';
				tableData: 'Цена';
				tableData: 'Количество' ]
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> renderOrder: order on: aRenderer [
	aRenderer table
		class: 'order';
		with: [ 
			aRenderer
				tableHead: [ 
					self renderOrderTitle: order on: aRenderer.
					self renderHeadingsOn: aRenderer
				].
			aRenderer tableBody: [
				order entries do: [ :entry | self renderEntry: entry on: aRenderer ]
			]
		]
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> renderOrderTitle: order on: aRenderer [
	aRenderer
		tableRow: [ 
			aRenderer tableData
				colSpan: 4;
				class: (order unrecognized ifTrue: ['unrecognized'] ifFalse: [nil]);
				title: (order unrecognized ifTrue: [nil] ifFalse: [order customer desc]);
				with: [
					aRenderer heading
						level2;
						with: order customerDesc
				]
		]
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> renderUnrecognizedListOn: aRenderer [
	aRenderer table
		class: 'order';
		with: [ 
			aRenderer
				tableHead: [ 
					unrecognizedOrders do:[:order| self renderOrderTitle: order on: aRenderer ].
					unrecognizedEntries ifNotEmpty: [self renderHeadingsOn: aRenderer].
				].
			aRenderer tableBody: [
				unrecognizedEntries do: [ :entry | self renderEntry: entry on: aRenderer ]
			]
		]
]

{ #category : #'as yet unclassified' }
Paeonia3Substitute >> style [
^super style, '
	.order {
		margin-top: 1em;
		margin-bottom: 1em;
	}

	.unrecognized { 
		color: red;
	}
'
]

{ #category : #accessing }
Paeonia3Substitute >> substitute [
|customers articles |
	customers := self session customers.
	articles := self session articles.
	
	unrecognizedOrders := OrderedCollection new.
	unrecognizedEntries := OrderedCollection new.
	
	orders do:[:order|
		order customer: (customers at: order customerDesc ifAbsent: [unrecognizedOrders addIfNotPresent: order. nil]).
		order entries do:[:entry|
			entry article: (articles at: entry articleId ifAbsent: [unrecognizedEntries addIfNotPresent: entry. nil]).
		]
	].

]
