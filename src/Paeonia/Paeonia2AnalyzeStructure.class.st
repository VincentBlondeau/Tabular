"
Answer structure:
	1) #next or #back
	2) collection of ""semi-filled"" PaeoniaOrders

""Semi-filled"" means that it has IDs and names from the file, but not yet substituted from the 1C.

"
Class {
	#name : #Paeonia2AnalyzeStructure,
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
Paeonia2AnalyzeStructure class >> type: aSymbol [
	(aSymbol=#SK) ifTrue: [ ^PaeoniaAnalyzerSK new].
	(aSymbol=#Tander) ifTrue: [ ^PaeoniaAnalyzerTander new].
	self error: 'Wrong type of file selected'.
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> guessFirstRow [
|tmp candidates|
	tmp := worksheet allCoord select:[:point| self stringArray: self headerNames includes: (worksheet dataAt: point) ] thenCollect:[:point| point y].
	tmp ifEmpty:[^self].
	
	candidates := Dictionary new.
	tmp do:[:row| candidates at: row put: (candidates at: row ifAbsent: 0)+1].
	tmp := candidates values max.
	firstRow := (candidates keyAtValue: tmp) + 1.
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> guessLastRow [
|tmp|
	tmp := worksheet allCoord collect:[:point| point y].
	tmp ifEmpty: [ ^self ].
	lastRow := tmp max.
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> guessMeaning: name with: namesArray [ 
|tmp candidates|
	tmp := worksheet allCoord
		select:[:point| ((point y) = (firstRow - 1)) and: [  self stringArray: namesArray includes: (worksheet dataAt: point) ]]
		thenCollect:[:point| point x].

	tmp ifEmpty:[^nil].
	
	candidates := Dictionary new.
	tmp do:[:col| candidates at: col put: (candidates at: col ifAbsent: 0)+1].
	tmp := candidates keyAtValue: candidates values max.

	colmeaning at: name put:tmp.
	
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> guessMeanings [
	firstRow ifNil:[^self].
	(self guessMeaning: 'Код товара' with: self headerNamesArticleId).
	(self guessMeaning: 'Наименование' with: self headerNamesArticleDesc).
	(self guessMeaning: 'Количество' with: self headerNamesAmount).

]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> headerNames [
	^#('№' 'СУММА'),
	(self headerNamesAmount),
	(self headerNamesArticleDesc),
	(self headerNamesArticleId),
	(self headerNamesCustomerDesc),
	(self headerNamesPrice).
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> headerNamesAmount [
	^#('КОЛ-ВО' 'КОЛИЧЕСТВО')
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> headerNamesArticleDesc [
	^#('НАЗВАНИЕ ТОВАРА' 'ТОВАР')
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> headerNamesArticleId [
	^#('КОД ТОВАРА' 'КОД')
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> headerNamesCustomerDesc [
	^#('ГМ' 'Наименование ГМ')
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> headerNamesPrice [
	^#('ЦЕНА')
]

{ #category : #initialization }
Paeonia2AnalyzeStructure >> initialize [
	super initialize.
	colmeaning := Dictionary new.

]

{ #category : #analyzing }
Paeonia2AnalyzeStructure >> loadRawData [
	self shouldBeImplemented.
]

{ #category : #analyzing }
Paeonia2AnalyzeStructure >> meanings [
	self error: 'Wrong type of input document selected'.
	self shouldBeImplemented.
]

{ #category : #workflow }
Paeonia2AnalyzeStructure >> next [
	errors := OrderedCollection new.

	firstRow ifNil:[errors add: 'Не выбрана первая строка данных о товаре'].
	lastRow ifNil:[errors add: 'Не выбрана последняя строка данных о товаре'].
	
	self meanings do:[:meaning|
		colmeaning at: meaning ifAbsent: [ errors add: 'Не выбрана колонка "', meaning, '"' ]
	].
	errors ifNotEmpty: [ ^self ].
	self answer:{#next . self loadRawData}
]

{ #category : #rendering }
Paeonia2AnalyzeStructure >> renderFormContentOn: aRenderer [
	self renderBackOn: aRenderer.
	self renderNextOn: aRenderer.
	self renderTableOn: aRenderer

]

{ #category : #rendering }
Paeonia2AnalyzeStructure >> renderMainData: cell on:aRenderer [
	cell
		ifNil:[aRenderer tableData.]
		ifNotNil:[
			aRenderer tableData: (
				(cell data isFloat)
					ifTrue: [ cell data printShowingDecimalPlaces: 2]
					ifFalse: [ cell data]
			)
		]
]

{ #category : #rendering }
Paeonia2AnalyzeStructure >> renderRangeSelectorHeadingOn: aRenderer [
	aRenderer
		tableData: [ 
			aRenderer
				text: 'Товары';
				break;
				text: 'с';
				space: 5;
				text: 'по' ]
]

{ #category : #rendering }
Paeonia2AnalyzeStructure >> renderRowHeading: row firstSelector: firstRowSelector lastSelector: lastRowSelector on: aRenderer [
	aRenderer
		tableHeading: [ 
			firstRowSelector radioButton
				onChange: 'setFirst(this.value)';
				value: row.
			aRenderer space: 2.
			lastRowSelector radioButton
				onChange: 'setLast(this.value)';
				value: row ]
]

{ #category : #rendering }
Paeonia2AnalyzeStructure >> renderTableOn: aRenderer [
	| cols rows firstRowSelector lastRowSelector |
	cols := worksheet cols size.
	rows := worksheet rows size.

	firstRowSelector := aRenderer radioGroup.
	firstRowSelector
		selected: firstRow;
		callback: [ :val | firstRow := val ].
	lastRowSelector := aRenderer radioGroup.
	lastRowSelector
		selected: lastRow;
		callback: [ :val | lastRow := val ].


	^ aRenderer table
		script: (JSStream on: 'initialize()');
		id: #analyzer;
		with: [ 
					aRenderer tableHead
						with: [ 
							aRenderer tableRow
								with: [ 
									self renderRangeSelectorHeadingOn: aRenderer.
									(1 to: cols)
										do: [ :col | 
											aRenderer
												tableData: [ 
													aRenderer select
														beOptional;
														list: self meanings;
														selected: (colmeaning keyAtValue: col ifAbsent: nil);
														callback: [ :value "selected: " | colmeaning at: value put: col ] ] ] ] ].
					aRenderer
						tableBody: [ 
							(1 to: rows)
								do: [ :row | 
									aRenderer
										tableRow: [ 
											self
												renderRowHeading: row
												firstSelector: firstRowSelector
												lastSelector: lastRowSelector
												on: aRenderer.
											(1 to: cols) do: [ :col | self renderMainData: (worksheet at: col @ row) on: aRenderer ] ] ] ] ]
]

{ #category : #hooks }
Paeonia2AnalyzeStructure >> script [
^(super script ifNil:''), '

function initialize(){
	rows = document.getElementById("analyzer").getElementsByTagName("tr");
	firstRow = ',(firstRow asString),';
	lastRow = ',(lastRow asString),';
	reDraw();

	row = document.getElementById("analyzer").getElementsByTagName("thead")[0].children[0].children;
	
	widtharr=[];
	for(var i=0; i<row.length; i++)
		widtharr[i]=row.offsetWidth;

//	row.setAttribute("style", "position: fixed");

};

function reDraw(){
	for(var i=0; i<rows.length; i++)
		if(i<firstRow | i>lastRow)
			rows[i].setAttribute("class", "");
   	else
 			rows[i].setAttribute("class", "selected");
	
};

function setFirst (row){
	firstRow = row;
	reDraw();
};

function setLast(row){
	lastRow = row;
	reDraw();
};
'
]

{ #category : #guessing }
Paeonia2AnalyzeStructure >> stringArray: array includes: string [
	string isString ifFalse: [ ^false ].
	^array includes: string asUppercase withBlanksCondensed
]

{ #category : #hooks }
Paeonia2AnalyzeStructure >> style [
^super style, '
	table {
		z-index: 1;
		overflow: hidden;
	}

	td, th {
		position: relative;
	}
	
	tbody { color: lightgrey; }
	.selected { color: black; }

	td:hover::after{
		content: " ";
		position: absolute;
		background-color: #ffa;
		left: 0;
		top: -5000px;
		height: 10000px;
		width: 100%;
		z-index: -1;
}
'
]

{ #category : #accessing }
Paeonia2AnalyzeStructure >> worksheet [
	^ worksheet
]

{ #category : #accessing }
Paeonia2AnalyzeStructure >> worksheet: anObject [
	worksheet := anObject.
	self guessFirstRow.
	self guessMeanings.
	self guessLastRow. "We need both meanings and first row to be detected before detecting last row"

]
