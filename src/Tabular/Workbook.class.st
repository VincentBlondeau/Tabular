Class {
	#name : #Workbook,
	#superclass : #Object,
	#instVars : [
		'worksheets',
		'styles',
		'attributes'
	],
	#category : #Tabular
}

{ #category : #'instance creation' }
Workbook class >> withSheets: n [
]

{ #category : #initialization }
Workbook >> initialize [
	worksheets := OrderedCollection new.
	super initialize.
]

{ #category : #accessing }
Workbook >> worksheets [
	^worksheets
]
