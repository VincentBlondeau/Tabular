Class {
	#name : #TanderSession,
	#superclass : #WASession,
	#instVars : [
		'articles',
		'articlesNames',
		'workbook',
		'firms',
		'firmsNames',
		'sellerGUID',
		'catalogGUID',
		'exportPath',
		'worksheet'
	],
	#category : #'Paeonia-Components'
}

{ #category : #accessing }
TanderSession >> articles [
	^articles ifNil:[self buildArticles. articles]
]

{ #category : #accessing }
TanderSession >> articlesNames [
	^articlesNames ifNil:[ self buildArticles. articlesNames]
]

{ #category : #accessing }
TanderSession >> buildArticles [
| worksheet |
	worksheet := self settingsWorkbook worksheetNamed: 'Номенклатура'.
	articles := Dictionary new.
	articlesNames := Dictionary new.

	(2 to: worksheet rows) do:[:row| |article articleName articleCode|
		articleName := worksheet dataAtCol: 1 row: row.
		article := worksheet dataAtCol: 2 row: row.
		articleCode := worksheet dataAtCol: 3 row: row.

		articles at: articleCode put: article.
		articlesNames at: article put: articleName.
	].
]

{ #category : #accessing }
TanderSession >> buildFirms [
| worksheet |
	worksheet := self settingsWorkbook worksheetNamed: 'Заказчики'.
	firms := Dictionary new.

	(2 to: worksheet rows) do:[:row| |shop guid|
		shop := worksheet dataAtCol: 1 row: row.
		guid := worksheet dataAtCol: 2 row: row.

		firms at: shop put: guid.
	].
]

{ #category : #accessing }
TanderSession >> buildFirmsNames [
| worksheet |
	worksheet := self settingsWorkbook worksheetNamed: 'Заказчики по базе'.
	firmsNames := Dictionary new.

	(2 to: worksheet rows) do:[:row| |guid firmName|
		guid := worksheet dataAtCol: 1 row: row.
		firmName := worksheet dataAtCol: 2 row: row.

		firmsNames at: guid put: firmName.
	].
]

{ #category : #accessing }
TanderSession >> buildParams [
| worksheet |
	worksheet := self settingsWorkbook worksheetNamed: 'Разное'.

	sellerGUID := worksheet dataAtCol: 2 row: 1.
	catalogGUID := worksheet dataAtCol: 2 row: 2.
	exportPath  := worksheet dataAtCol: 2 row: 4.

]

{ #category : #'as yet unclassified' }
TanderSession >> catalogGUID [
	^catalogGUID ifNil: [ self buildParams. catalogGUID ]
]

{ #category : #'as yet unclassified' }
TanderSession >> exportPath [
	^exportPath ifNil: [ self buildParams. exportPath ]
]

{ #category : #accessing }
TanderSession >> firms [
	^firms ifNil:[self buildFirms. firms]
]

{ #category : #accessing }
TanderSession >> firmsNames [
	^firmsNames ifNil:[self buildFirmsNames. firmsNames]
]

{ #category : #'as yet unclassified' }
TanderSession >> readConfiguration [
	articles := articlesNames := workbook := firms := firmsNames := sellerGUID := catalogGUID := exportPath := nil.
]

{ #category : #'as yet unclassified' }
TanderSession >> sellerGUID [
	^sellerGUID ifNil: [ self buildParams. sellerGUID ]
]

{ #category : #accessing }
TanderSession >> settingsWorkbook [
|file|
	file := 'Настройки.xlsx' asFileReference binaryReadStream.
	workbook ifNil:[ workbook := XLSXImporter import: file].
	file close.
	^workbook
]

{ #category : #accessing }
TanderSession >> worksheet [
	^worksheet
]

{ #category : #accessing }
TanderSession >> worksheetErase [
	worksheet := nil
]

{ #category : #accessing }
TanderSession >> worksheetFrom: aWAFile [
	worksheet := (XLSXImporter import: aWAFile rawContents readStream) worksheetNamed: 'Лист1'.
]
