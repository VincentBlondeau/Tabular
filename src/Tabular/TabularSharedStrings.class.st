Class {
	#name : #TabularSharedStrings,
	#superclass : #TabularObject,
	#instVars : [
		'strings'
	],
	#category : #'Tabular-Model'
}

{ #category : #'as yet unclassified' }
TabularSharedStrings >> at: anIndex [
	^ strings at: anIndex + 1 "Because the array begin at 0."
]

{ #category : #'as yet unclassified' }
TabularSharedStrings >> extractFromXml: aXMLDocument [
	aXMLDocument
		allElementsNamed: 'si'
		do: [ :aXmlTextElement | aXmlTextElement allElementsNamed: 't' do: [ :xmlElement | strings add: xmlElement firstNode ] ]
]

{ #category : #'as yet unclassified' }
TabularSharedStrings >> initialize [
	super initialize.
	strings := OrderedCollection new.
]
