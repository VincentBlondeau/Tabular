Class {
	#name : #TabularXLSXWorkbookParser,
	#superclass : #TabularSAXParser,
	#category : #'Tabular-SAXParser'
}

{ #category : #'as yet unclassified' }
TabularXLSXWorkbookParser >> buildRootObject [
	^ StandardOrderedDictionary new.
]

{ #category : #'as yet unclassified' }
TabularXLSXWorkbookParser >> registeredElements [
	^ #(sheet)
]

{ #category : #'as yet unclassified' }
TabularXLSXWorkbookParser >> sheet_start: properties [
	parsingStack top at: (properties at: #r:id) put: (properties at: #name)
]
