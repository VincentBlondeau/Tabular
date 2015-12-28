Class {
	#name : #PaeoniaSession,
	#superclass : #WASession,
	#instVars : [
		'settingsWorkbook',
		'articles',
		'customers',
		'sellerGUID',
		'catalogGUID',
		'exportPath'
	],
	#category : #'Paeonia-Components'
}

{ #category : #classifiers }
PaeoniaSession >> articles [
	^articles ifNil:[self buildArticles. articles]
]

{ #category : #classifiers }
PaeoniaSession >> buildArticles [
| worksheet |
	worksheet := self settingsWorkbook worksheetNamed: 'Номенклатура'.
	articles := Dictionary new.

	(2 to: worksheet rows size) do:[:row| |articleId articleDesc articleGUID |
		articleDesc := worksheet dataAtCol: 1 row: row.
		articleGUID := worksheet dataAtCol: 2 row: row.
		articleId := (worksheet dataAtCol: 3 row: row) asString withBlanksCondensed.

		articles at: articleId put: (PaeoniaArticle guid: articleGUID  desc: articleDesc).
	].
]

{ #category : #configuration }
PaeoniaSession >> buildConfiguration [
| worksheet |
	worksheet := self settingsWorkbook worksheetNamed: 'Разное'.

	sellerGUID := worksheet dataAtCol: 2 row: 1.
	catalogGUID := worksheet dataAtCol: 2 row: 2.
	exportPath  := (worksheet dataAtCol: 2 row: 4) 

]

{ #category : #classifiers }
PaeoniaSession >> buildCustomers [
| worksheet customersByGUID|
	customersByGUID := Dictionary new.

	worksheet := self settingsWorkbook worksheetNamed: 'Заказчики по базе'.
	(2 to: worksheet rows size) do:[:row| |customerGUID customerDesc |
		customerGUID := (worksheet dataAtCol: 1 row: row) asString withBlanksCondensed.
		customerDesc := worksheet dataAtCol: 2 row: row.

		customersByGUID at: customerGUID put: (PaeoniaCustomer guid: customerGUID desc: customerDesc).
	].

	worksheet := self settingsWorkbook worksheetNamed: 'Заказчики'.
	customers := Dictionary new.

	(2 to: worksheet rows size) do:[:row| |desc customerGUID|
		desc := (worksheet dataAtCol: 1 row: row) asString withBlanksCondensed.
		customerGUID := (worksheet dataAtCol: 2 row: row) asString withBlanksCondensed.

		customers at: desc put: (customersByGUID at: customerGUID ifAbsent: nil ).
	].
]

{ #category : #accessing }
PaeoniaSession >> buildSettingsWorkbook [
|file|
	file := 'Настройки.xlsx' asFileReference binaryReadStream.
	settingsWorkbook := XLSXImporter import: file.
	file close.

]

{ #category : #configuration }
PaeoniaSession >> catalogGUID [
	^catalogGUID ifNil: [ self buildConfiguration. catalogGUID ]
]

{ #category : #classifiers }
PaeoniaSession >> customers [
	^customers ifNil:[self buildCustomers. customers]
]

{ #category : #configuration }
PaeoniaSession >> exportPath [
	^exportPath ifNil: [ self buildConfiguration. exportPath ]
]

{ #category : #accessing }
PaeoniaSession >> readSettings [
	settingsWorkbook := articles :=  customers := sellerGUID := catalogGUID := exportPath := nil.
]

{ #category : #configuration }
PaeoniaSession >> sellerGUID [
	^sellerGUID ifNil: [ self buildConfiguration. sellerGUID ]
]

{ #category : #accessing }
PaeoniaSession >> settingsWorkbook [
	^settingsWorkbook ifNil:[self buildSettingsWorkbook. settingsWorkbook].

]
