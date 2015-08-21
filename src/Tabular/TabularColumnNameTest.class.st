Class {
	#name : #TabularColumnNameTest,
	#superclass : #TestCase,
	#instVars : [
		't'
	],
	#category : #'Tabular-Tests'
}

{ #category : #running }
TabularColumnNameTest >> setUp [
	t:=TabularWorksheetWriterXL new.
]

{ #category : #tests }
TabularColumnNameTest >> testA [
	self assert: (t columnName: 1) equals: 'A'
]

{ #category : #tests }
TabularColumnNameTest >> testAA [
	self assert: (t columnName: 27) equals:'AA'
]

{ #category : #tests }
TabularColumnNameTest >> testAAA [
	self assert: (t columnName: 703) equals: 'AAA'
]

{ #category : #tests }
TabularColumnNameTest >> testAZ [
	self assert: (t columnName: 52) equals: 'AZ'
]

{ #category : #tests }
TabularColumnNameTest >> testBA [
	self assert: (t columnName: 53)equals: 'BA'
]

{ #category : #tests }
TabularColumnNameTest >> testZ [
	self assert: (t columnName: 26) equals: 'Z'
]

{ #category : #tests }
TabularColumnNameTest >> testZZ [
	self assert: (t columnName: 702) equals: 'ZZ'
]
