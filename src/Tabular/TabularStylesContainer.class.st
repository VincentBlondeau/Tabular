Class {
	#name : #TabularStylesContainer,
	#superclass : #TabularObject,
	#instVars : [
		'styles'
	],
	#category : #'Tabular-Model'
}

{ #category : #conversion }
TabularStylesContainer >> extractFromXml: aXMLDocument [
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
TabularStylesContainer >> initialize [
	super initialize.
	styles := OrderedCollection new
]
