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
		do: [ :aXmlTextElement | formats at: (aXmlTextElement attributeAt: 'numFmtId') put: (aXmlTextElement attributeAt: 'formatCode') ].
	aXMLDocument
		allElementsNamed: 'cellXfs'
		do: [ :aXmlTextElement | 
			aXmlTextElement
				allElementsNamed: 'xf'
				do: [ :xmlElement | 
					styles
						add:
							(TabularStyle new
								numFmtId: (xmlElement attributeAt: 'numFmtId');
								fontId: (xmlElement attributeAt: 'fontId');
								fillId: (xmlElement attributeAt: 'fillId');
								borderId: (xmlElement attributeAt: 'borderId');
								xfId: (xmlElement attributeAt: 'xfId');
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
