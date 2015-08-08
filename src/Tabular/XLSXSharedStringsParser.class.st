Class {
	#name : #XLSXSharedStringsParser,
	#superclass : #TabularSAXParser,
	#category : #'Tabular-SAXParser'
}

{ #category : #initialization }
XLSXSharedStringsParser >> buildRootObject [
	^ OrderedCollection new.
]

{ #category : #elements }
XLSXSharedStringsParser >> registeredElements [
	^ #(si t)
]

{ #category : #acccessing }
XLSXSharedStringsParser >> sharedStringsTable [
	^parsingStack top
]

{ #category : #elements }
XLSXSharedStringsParser >> si_start: properties [
	self sharedStringsTable add: nil.
]

{ #category : #elements }
XLSXSharedStringsParser >> t_characters: aString [
	| table |
	table := self sharedStringsTable.
	table atLast: 1 put: (table last ifNil: [ aString ] ifNotNil: [ :str | str , aString ])	"whe we have multiple <t> inside <si>, which is possible if in-cell formatting used"
]
