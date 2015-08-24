"
I am TabularExport the root of a class of objects which export Tabular models.


More comment see TabularXSLXExport



Responsibility part: I define the general export API every export class supports.

Note: The API is not  fully defined yet.  Subclass TabularXSLXExport1 has hard coded parameters.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #TabularExport,
	#superclass : #Object,
	#instVars : [
		'zip',
		'workbook',
		'stream'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #examples }
TabularExport class >> example1 [

    self export: (TabularWorkbook example1)
]

{ #category : #exporting }
TabularExport class >> export: aWorkbook [

      self new workbook: aWorkbook; generate.
]

{ #category : #exporting }
TabularExport class >> export: aWorkbook fileName: aFileNameString [

      aWorkbook filename: aFileNameString.
      self new workbook: aWorkbook; generate.
]

{ #category : #exporting }
TabularExport class >> workbook: aWorkbook fileName: aFileNameString [

      self export: aWorkbook fileName: aFileNameString
      
]

{ #category : #generating }
TabularExport >> generate [

	self subclassResponsibility 
]

{ #category : #initialization }
TabularExport >> initialize [

     super initialize
]

{ #category : #accessing }
TabularExport >> workbook [
	^ workbook
]

{ #category : #accessing }
TabularExport >> workbook: anObject [
	workbook := anObject.

]

{ #category : #'as yet unclassified' }
TabularExport >> writeZip [

	zip writeToFileNamed: workbook filename
]
