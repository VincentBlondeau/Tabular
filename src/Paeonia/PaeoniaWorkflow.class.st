Class {
	#name : #PaeoniaWorkflow,
	#superclass : #WATask,
	#instVars : [
		'worksheet',
		'type',
		'orders'
	],
	#category : #'Paeonia-Components'
}

{ #category : #'as yet unclassified' }
PaeoniaWorkflow class >> canBeRoot [
	^ true
]

{ #category : #'as yet unclassified' }
PaeoniaWorkflow class >> register [
	(WAAdmin register: self asApplicationAt: 'PaeoniaImporter')
      preferenceAt: #sessionClass put: PaeoniaSession.
]

{ #category : #running }
PaeoniaWorkflow >> go [
|i|
	i:=1.
	[ i <= self steps size ] whileTrue:[|res|
		res := self perform: (self steps at:i).

		(res = #back) ifTrue: [ i := i-1 ].	
		(res = #next) ifTrue: [ i := i+1 ].
	]

]

{ #category : #pages }
PaeoniaWorkflow >> step1pickFile [
| res |
	res:=self call: Paeonia1FilePicker new.

	worksheet := res at: 2 ifAbsent: nil.
	type := res at: 3 ifAbsent: nil.
	
	^res first.
	
]

{ #category : #pages }
PaeoniaWorkflow >> step2analyzeStructure [
| res |
	res := self call: (
		(Paeonia2AnalyzeStructure type: type)
			worksheet: worksheet;
			yourself
	).
	orders := res at:2 ifAbsent: nil.
	^res first.
]

{ #category : #pages }
PaeoniaWorkflow >> step3substitute [
| res |
	res := self call: (Paeonia3Substitute orders: orders).
	orders := res at:2 ifAbsent: nil.
	^res first.
]

{ #category : #pages }
PaeoniaWorkflow >> step4export [
| res |
	res := self call: (Paeonia4Exporter orders: orders).
	^res first.
]

{ #category : #running }
PaeoniaWorkflow >> steps [
	^#(#step1pickFile #step2analyzeStructure #step3substitute step4export)
]
