Class {
	#name : #TabularCell,
	#superclass : #TabularObject,
	#instVars : [
		'data',
		'style'
	],
	#category : #'Tabular-Model'
}

{ #category : #'accessing - attributes' }
TabularCell >> colspan [
	^self attributeAt: #colspan
]

{ #category : #'accessing - attributes' }
TabularCell >> colspan: anObject [
	^self attributeAt: #colspan put: anObject 
]

{ #category : #accessing }
TabularCell >> data [
	^ data
]

{ #category : #accessing }
TabularCell >> data: anObject [
	data := anObject
]

{ #category : #'accessing - attributes' }
TabularCell >> rowspan [
	^self attributeAt: #rowspan
]

{ #category : #'accessing - attributes' }
TabularCell >> rowspan: anObject [
	^self attributeAt: #rowspan put: anObject 
]
