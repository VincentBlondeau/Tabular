"
Answer is always a collection.
	first element - symbol #next or #back
	other elements - optional data, only if first one is #next
"
Class {
	#name : #PaeoniaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'errors'
	],
	#category : #'Paeonia-Components'
}

{ #category : #workflow }
PaeoniaComponent >> back [
	self answer: #(back)
]

{ #category : #'as yet unclassified' }
PaeoniaComponent >> flushErrors [
	errors := OrderedCollection new
]

{ #category : #'as yet unclassified' }
PaeoniaComponent >> initialize [
	super initialize.
	self flushErrors
]

{ #category : #workflow }
PaeoniaComponent >> next [
	self answer: #(next)
]

{ #category : #rendering }
PaeoniaComponent >> renderBackOn: aRenderer [
	aRenderer submitButton
		callback: [ self back ];
		with: 'Назад'
]

{ #category : #rendering }
PaeoniaComponent >> renderContentOn: aRenderer [
	aRenderer unorderedList
		class: 'errors';
		list: errors.
	aRenderer form
		multipart;
		with:[ self renderFormContentOn: aRenderer ]
]

{ #category : #rendering }
PaeoniaComponent >> renderErrorsOn: aRenderer [
	aRenderer unorderedList
		class: 'errors';
		list: errors.
]

{ #category : #rendering }
PaeoniaComponent >> renderFormContentOn: aRenderer [
	self subclassResponsibility 
]

{ #category : #rendering }
PaeoniaComponent >> renderNextOn: aRenderer [
	aRenderer submitButton
		callback: [ self next ];
		with: 'Далее'
]

{ #category : #rendering }
PaeoniaComponent >> renderRedoOn: aRenderer [
	aRenderer button
		callback: [ self redo ];
		with: 'Ещё раз'.
		
]

{ #category : #hooks }
PaeoniaComponent >> style [
^'
	ul.errors {
		color: red;
		margin: 0.3em 1em;
	}
	table {
		border-collapse: collapse;
		border: 2px black solid;
		margin: 0.3em 0;
	}

	td, th {
		border: 1px black solid;
	}
	
	thead td {
		font-weight: bold;
		text-align: center;
	}
	
	label { 
		display: block;
		margin-top: 1em;
		margin-bottom: 1em;	
	}
	
	input.submit { 
		margin: 0.3em 1em;
	}
'
]
