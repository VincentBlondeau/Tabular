Class {
	#name : #PaeoniaWorkflow,
	#superclass : #WATask,
	#category : #'Paeonia-Components'
}

{ #category : #'as yet unclassified' }
PaeoniaWorkflow class >> canBeRoot [
	^ true
]

{ #category : #'as yet unclassified' }
PaeoniaWorkflow >> go [
	| ws |
	ws:=self call: PaeoniaFilePicker new.
]
