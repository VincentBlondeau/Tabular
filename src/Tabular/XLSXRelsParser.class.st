Class {
	#name : #XLSXRelsParser,
	#superclass : #TabularSAXParser,
	#category : #'Tabular-SAXParser'
}

{ #category : #'as yet unclassified' }
XLSXRelsParser >> Relationship_start: properties [
	parsingStack top at: (properties at: #Id) put: (properties at: #Target)
]

{ #category : #'as yet unclassified' }
XLSXRelsParser >> buildRootObject [
	^ Dictionary new.
]

{ #category : #'as yet unclassified' }
XLSXRelsParser >> registeredElements [
	^ #(Relationship)
]
