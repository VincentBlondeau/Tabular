Class {
	#name : #PaeoniaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'errors'
	],
	#category : #'Paeonia-Components'
}

{ #category : #rendering }
PaeoniaComponent >> back [
	self answer
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
]

{ #category : #rendering }
PaeoniaComponent >> renderErrorsOn: aRenderer [
	aRenderer unorderedList
		class: 'errors';
		list: errors.
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
	ul.errors { color: red}

'
]
