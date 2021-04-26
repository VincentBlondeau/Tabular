"
A TabularODSStyle holds formatting information for one or more ODS cells (TabularODSCell).

    Instance Variables
	attributes: 	<Dictionary>  Attributes of the style
	details:		<OrderedCollection> Child elements of the style


    Implementation Points
"
Class {
	#name : #TabularODSStyle,
	#superclass : #TabularStyle,
	#instVars : [
		'details'
	],
	#category : #'Tabular-Model'
}

{ #category : #accessing }
TabularODSStyle >> details [

	^ details
]

{ #category : #initialization }
TabularODSStyle >> initialize [
	super initialize.
	details := OrderedCollection new.
]
