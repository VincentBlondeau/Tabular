Class {
	#name : #TabularStylesContainer,
	#superclass : #TabularObject,
	#instVars : [
		'styles',
		'formats'
	],
	#category : #'Tabular-Model'
}

{ #category : #initialization }
TabularStylesContainer >> at: anIndex [
	^ styles at: anIndex + 1 "Because the array begin at 0."
]

{ #category : #conversion }
TabularStylesContainer >> extractFromXml: aXMLDocument [
	aXMLDocument
		allElementsNamed: 'numFmt'
		do: [ :aXmlTextElement | formats at: (aXmlTextElement attributeAt: 'numFmtId') asNumber put: (aXmlTextElement attributeAt: 'formatCode')  ].
	aXMLDocument
		allElementsNamed: 'cellXfs'
		do: [ :aXmlTextElement | 
			aXmlTextElement
				allElementsNamed: 'xf'
				do: [ :xmlElement | 
					styles
						add:
							(TabularStyle new
								numFmtId: (xmlElement attributeAt: 'numFmtId') asNumber;
								fontId: (xmlElement attributeAt: 'fontId') asNumber;
								fillId: (xmlElement attributeAt: 'fillId') asNumber;
								borderId: (xmlElement attributeAt: 'borderId') asNumber;
								xfId: (xmlElement attributeAt: 'xfId') asNumber;
								workbook: self workbook;
								yourself) ] ]
]

{ #category : #initialization }
TabularStylesContainer >> formats [
	^ formats
]

{ #category : #initialization }
TabularStylesContainer >> initialize [
	super initialize.
	styles := OrderedCollection new.
	formats := Dictionary new
]
