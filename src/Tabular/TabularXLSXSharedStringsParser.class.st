Class {
	#name : #TabularXLSXSharedStringsParser,
	#superclass : #TabularSAXParser,
	#category : #'Tabular-SAXParser'
}

{ #category : #initialization }
TabularXLSXSharedStringsParser >> buildRootObject [
	^ OrderedCollection new.
]

{ #category : #elements }
TabularXLSXSharedStringsParser >> registeredElements [
	^ #(si t)
]

{ #category : #acccessing }
TabularXLSXSharedStringsParser >> sharedStringsTable [
	^parsingStack top
]

{ #category : #elements }
TabularXLSXSharedStringsParser >> si_start: properties [
	self sharedStringsTable add: nil.
]

{ #category : #elements }
TabularXLSXSharedStringsParser >> t_characters: aString [
	| table |
	table := self sharedStringsTable.
	table atLast: 1 put: (table last ifNil: [ aString ] ifNotNil: [ :str | str , aString ])	"whe we have multiple <t> inside <si>, which is possible if in-cell formatting used"
]
