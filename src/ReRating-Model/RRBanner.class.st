Class {
	#name : #RRBanner,
	#superclass : #WAComponent,
	#traits : 'TDirectSQLReport',
	#classTraits : 'TDirectSQLReport classTrait',
	#instVars : [
		'agents',
		'active',
		'logger',
		'mode'
	],
	#category : #'ReRating-Seaside-Banner'
}

{ #category : #accessing }
RRBanner >> agents [
| ids |
	agents ifNotNil:[^agents].
	ids := self queryData collect:[:row| row first].
	^agents := self session readClass: RRAgent where: [:agent| agent id in: ids] limit: 2 offset: 0
]

{ #category : #rendering }
RRBanner >> clickTo: agent [
	active add: agent.
	[logger clickTo:  agent] fork.
]

{ #category : #'as yet unclassified' }
RRBanner >> initialRequest: aRequest [
| url |
	url := aRequest at:  #url.
	((url findString: 'yp_5702') > 0) ifTrue: [mode := #ops. ^self].
	((url findString: 'yp_6877') > 0) ifTrue: [mode := #docs. ^self].
	mode := nil.
]

{ #category : #'as yet unclassified' }
RRBanner >> initialize [
	super initialize.
	active := Set new.
	logger := RRBannerLogger session: self session.
]

{ #category : #rendering }
RRBanner >> renderAgent: agent on: html [
	html tableRow:[
		html tableData: [self renderAvatar: agent on: html].
		html tableData: [html div: agent title].
		html tableData: [self renderPhone: agent on: html].
		self renderRating: (agent rating ifNil:[0]) on: html.
	]
]

{ #category : #rendering }
RRBanner >> renderAvatar: agent on: html [
| dir |
	dir := FileDirectory default / SPImageComponent fileDir / RRAgent name.
	(dir matchingEntries: (agent id asString, '_avatar*'))
		ifEmpty: [
			html image
				class: 'avatar';
				src: (BannerMedia / 'noavatar.png').	
		]
		ifNotEmptyDo: [:photos|
			html image
				class: 'avatar';
				src: ( '/', SPImageComponent fileDir, '/', RRAgent name, '/', photos first name).	
		].

]

{ #category : #rendering }
RRBanner >> renderContentOn: html [
	html table attributeAt: 'type' put: mode; with:[
"		5 timesRepeat: [html tableColumn]."

		html tableHead: [html tableRow: [html tableHeading colSpan: 5;  with: 'ВЫБЕРИТЕ СВОЕГО АГЕНТА ПО НЕДВИЖИМОСТИ']].

		html tableFoot: [html tableRow: [html tableData colSpan: 5; with: [
			html anchor
				class:'rerating';
				url: 'http://rerating.ru/?reg=87&act=1&obj=1';
				target: 'top';
				with:'Лучшие агенты'.
			html text: ' к вашим услугам'.
		]]] .

		html tableBody: [self agents do:[:agent| self renderAgent: agent on: html]].
	

	].
]

{ #category : #rendering }
RRBanner >> renderPhone: agent on: html [
	(active includes: agent)
		ifTrue: [ html text: agent phone ]
		ifFalse: [ 
			(html anchor)
				callback: [ self clickTo: agent ];
				with: '+7 xxx xxx-xx-xx' ]
]

{ #category : #rendering }
RRBanner >> renderRating: rating on: html [
|fullStars emptyStars|
	fullStars := rating // 10.
	emptyStars := 5-fullStars.
	
	html tableData:[
		html space.
		fullStars  timesRepeat: [html image src:(BannerMedia / 'star_full.png'); altText: '@'].
		emptyStars  timesRepeat: [html image src:(BannerMedia / 'star_empty.png'); altText: 'O'].
		html space.
	].
	html tableData:[
		html text: fullStars asString; text:','; text: (rating - (10*fullStars)) asString
	].
]

{ #category : #sql }
RRBanner >> sql [
	(mode = #docs) ifTrue:  [^'select id from agents where region_id=30 and gender=true order by random() limit 2;'].
	(mode = #ops) ifTrue:  [^'select id from agents where region_id=30 and gender=false  order by random() limit 2;'].
	^'select id from agents where region_id=30 order by random() limit 2;'
]

{ #category : #'as yet unclassified' }
RRBanner >> style [
^'
	body{
		font-family: monospace;
	}
	
	html, body, table, h1, a, td, th{
		padding: 0;
		margin: 0;
		border: 0;
	}

	
	tfoot td{
		text-align: right;
		font-size: medium;
	}
	
	th{
		color: darkorange;
		text-align: right;
		font-size: small;
	}


	tbody td{
		white-space: nowrap;
		font-size: 85%;
	}
	
	tbody td div{
		overflow: hidden;
		text-overflow: ellipsis;
		margin-right: 5px;
	}
	
	.avatar{
		height: 23px;
		width: 23px;
		border-radius: 11.5px;
		margin-left: 5px;
		margin-right: 5px;
	}

'
]
