Class {
	#name : #ColumnNameTest,
	#superclass : #TestCase,
	#instVars : [
		't'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
ColumnNameTest >> setUp [
	t:=TabularExperimenting new.
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testA [
	self assert: ((t columnName: 1) = 'A')
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testAA [
	self assert: ((t columnName: 27) = 'AA')
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testAAA [
	self assert: ((t columnName: 703) = 'AAA')
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testAZ [
	self assert: ((t columnName: 52) = 'AZ')
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testBA [
	self assert: ((t columnName: 53) = 'BA')
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testZ [
	self assert: ((t columnName: 26) = 'Z')
]

{ #category : #'as yet unclassified' }
ColumnNameTest >> testZZ [
	self assert: ((t columnName: 702) = 'ZZ')
]
