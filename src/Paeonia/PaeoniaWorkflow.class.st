Class {
	#name : #PaeoniaWorkflow,
	#superclass : #WATask,
	#instVars : [
		'worksheet'
	],
	#category : #'Paeonia-Components'
}

{ #category : #'as yet unclassified' }
PaeoniaWorkflow class >> canBeRoot [
	^ true
]

{ #category : #pages }
PaeoniaWorkflow >> analyzeStructure [
| res |
	res := self call: (PaeoniaAnalyzeStructure worksheet: worksheet).
	^res first.
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
PaeoniaWorkflow >> pickFile [
| res |
	res:=self call: PaeoniaFilePicker new.

	worksheet := res at: 2 ifAbsent: nil.
	^res first.
	
]

{ #category : #running }
PaeoniaWorkflow >> steps [
	^#(pickFile analyzeStructure importData exportData)
]
