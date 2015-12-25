Class {
	#name : #PaeoniaAnalyzerTander,
	#superclass : #Paeonia2AnalyzeStructure,
	#category : #'Paeonia-Components'
}

{ #category : #'as yet unclassified' }
PaeoniaAnalyzerTander >> guessMeanings [
	super guessMeanings.
	
	firstRow ifNil:[^self].
	(self guessMeaning: 'Магазин' with: self headerNamesCustomerDesc).
	(self guessMeaning: 'Цена' with: self headerNamesPrice).

]

{ #category : #analyzing }
PaeoniaAnalyzerTander >> loadRawData [
	| colCustomer colArticleId colArticleDesc colAmount colPrice orders |

	
	colCustomer := (colmeaning at: 'Магазин' ).
	colArticleId:= (colmeaning at: 'Код товара').
	colArticleDesc:= (colmeaning at: 'Наименование').
	colAmount:= (colmeaning at: 'Количество').
	colPrice:= (colmeaning at: 'Цена').
	
	orders := OrderedDictionary new.

	(firstRow to: lastRow)	do: [ :row | | customerDesc articleId articleDesc amount price |

			customerDesc := worksheet dataAtCol: colCustomer row: row.
			articleId := worksheet dataAtCol: colArticleId row: row.
			articleDesc := worksheet dataAtCol: colArticleDesc row: row.
			amount := worksheet dataAtCol: colAmount row: row.
			price := worksheet dataAtCol: colPrice row: row.

			(articleId notNil & customerDesc notNil)
				ifTrue: [ | order entry |
					order := orders at: customerDesc ifAbsentPut: [ PaeoniaOrder new customerDesc: customerDesc; yourself ].
					entry := PaeoniaEntry new
						articleId: articleId;
						articleDesc: articleDesc;
						amount: amount;
						price: price.
					order entries add: entry.
				] 
	].

	^orders values.
	

	

	

]

{ #category : #analyzing }
PaeoniaAnalyzerTander >> meanings [
	^ #('Магазин' 'Код товара' 'Наименование' 'Количество' 'Цена')

]

{ #category : #'as yet unclassified' }
PaeoniaAnalyzerTander >> renderRangeSelectorHeadingOn: aRenderer [
	aRenderer
		tableData: [ 
			aRenderer
				text: 'Товары';
				break;
				text: 'с'.
		]
]

{ #category : #'as yet unclassified' }
PaeoniaAnalyzerTander >> renderRowHeading: row firstSelector: firstRowSelector lastSelector: lastRowSelector on: aRenderer [
	aRenderer
		tableHeading: [ 
			firstRowSelector radioButton
				onChange: 'setFirst(this.value)';
				value: row.
		]
]
