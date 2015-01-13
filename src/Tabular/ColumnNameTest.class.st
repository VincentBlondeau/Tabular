Class {
	#name : #ColumnNameTest,
	#superclass : #TestCase,
	#instVars : [
		't'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
ColumnNameTest >> setUp [
	t:=TabularExperimenting new.
]

{ #category : #tests }
ColumnNameTest >> testA [
	self assert: (t columnName: 1) equals: 'A'
]

{ #category : #tests }
ColumnNameTest >> testAA [
	self assert: (t columnName: 27) equals:'AA'
]

{ #category : #tests }
ColumnNameTest >> testAAA [
	self assert: (t columnName: 703) equals: 'AAA'
]

{ #category : #tests }
ColumnNameTest >> testAZ [
	self assert: (t columnName: 52) equals: 'AZ'
]

{ #category : #tests }
ColumnNameTest >> testBA [
	self assert: (t columnName: 53)equals: 'BA'
]

{ #category : #tests }
ColumnNameTest >> testZ [
	self assert: (t columnName: 26) equals: 'Z'
]

{ #category : #tests }
ColumnNameTest >> testZZ [
	self assert: (t columnName: 702) equals: 'ZZ'
]
