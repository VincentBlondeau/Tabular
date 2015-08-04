Class {
	#name : #XLSXWorkbookParser,
	#superclass : #XLSXSaxParser,
	#category : #'Tabular-Importers'
}

{ #category : #'as yet unclassified' }
XLSXWorkbookParser >> buildRootObject [
	^ StandardOrderedDictionary new.
]

{ #category : #'as yet unclassified' }
XLSXWorkbookParser >> registeredElements [
	^ #(sheet)
]

{ #category : #'as yet unclassified' }
XLSXWorkbookParser >> sheet_start: properties [
	parsingStack top at: (properties at: #r:id) put: (properties at: #name)
]
