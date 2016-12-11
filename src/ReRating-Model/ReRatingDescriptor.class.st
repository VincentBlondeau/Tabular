Class {
	#name : #ReRatingDescriptor,
	#superclass : #SPGlorpDescriptor,
	#category : #'ReRating-Persistence'
}

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRAgent: aClassModel [
	self buildClassModelFrom: RRAgent description on: aClassModel.
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRBannerClick: aClassModel [
	self buildClassModelFrom: RRBannerClick description on: aClassModel.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRDoc: aClassModel [
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #num.
	
	aClassModel newAttributeNamed: #validFrom.
	aClassModel newAttributeNamed: #validTo.
	
	aClassModel newAttributeNamed: #parent type: RRAgent.
	aClassModel newAttributeNamed: #issuer type: RRIssuer.
	

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRREstateType: aClassModel [
	self classTemplateSimpleClassifier: aClassModel.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRFirm: aClassModel [
	self buildClassModelFrom: RRFirm description on: aClassModel.
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRIssuer: aClassModel [
	self classTemplateSimpleClassifier: aClassModel.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRROperationType: aClassModel [
	self classTemplateSimpleClassifier: aClassModel.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRQualification: aClassModel [
	self classTemplateSimpleClassifier: aClassModel.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> classModelForRRRegion: aClassModel [
	self classTemplateSimpleClassifier: aClassModel.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRAgent: aDescriptor [
	self buildDescriptorFrom: RRAgent description on: aDescriptor
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRBannerClick: aDescriptor [
	self buildDescriptorFrom: RRBannerClick description on: aDescriptor
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRDoc: aDescriptor [
| table |
	table := self tableNamed: 'docs'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping) field: #id inTable: table.
	
	(aDescriptor newMapping: DirectMapping) field: #num inTable: table.
	(aDescriptor newMapping: DirectMapping) from: #validFrom to: (table fieldNamed: 'valid_from').
	(aDescriptor newMapping: DirectMapping) from: #validTo to: (table fieldNamed: 'valid_to').

	(aDescriptor newMapping: OneToOneMapping) attributeName: #parent.
	(aDescriptor newMapping: OneToOneMapping) attributeName: #issuer.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRREstateType: aDescriptor [
| table |
	table := self tableNamed: 'estypes'.
	self descriptorTemplateSimpleClassifier: aDescriptor table: table.
	
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRFirm: aDescriptor [
	self buildDescriptorFrom: RRFirm description on: aDescriptor
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRIssuer: aDescriptor [
| table |
	table := self tableNamed: 'issuer'.
	self descriptorTemplateSimpleClassifier: aDescriptor table: table.
	
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRROperationType: aDescriptor [
| table |
	table := self tableNamed: 'optypes'.
	self descriptorTemplateSimpleClassifier: aDescriptor table: table.
	
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRQualification: aDescriptor [
| table |
	table := self tableNamed: 'qualifications'.
	self descriptorTemplateSimpleClassifier: aDescriptor table: table.
	
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> descriptorForRRRegion: aDescriptor [
| table |
	table := self tableNamed: 'regions'.
	self descriptorTemplateSimpleClassifier: aDescriptor table: table.
	
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForAGENTS: aTable [

	self buildTableFrom: RRAgent description on: aTable
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForCLICKS: aTable [
	self buildTableFrom: RRBannerClick description on: aTable.
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForDOCS: aTable [
|  issuerid agentid |

	(aTable createFieldNamed: 'id' type: platform sequence) bePrimaryKey.

	aTable createFieldNamed: 'num' type: platform text.
	aTable createFieldNamed: 'valid_from' type: platform date.
	aTable createFieldNamed: 'valid_to' type: platform date.

	issuerid := aTable createFieldNamed: 'issuerid' type: platform text.
	aTable addForeignKeyFrom: issuerid to: ((self tableNamed: 'issuer') fieldNamed: 'id').

	agentid := aTable createFieldNamed: 'agentid' type: platform text.
	aTable addForeignKeyFrom: agentid to: ((self tableNamed: 'agents') fieldNamed: 'id').


]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForESTYPES: aTable [
	self tableTemplateSimpleClassifier: aTable.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForFIRMS: aTable [
	self buildTableFrom: RRFirm description on: aTable
]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForISSUER: aTable [
	self tableTemplateSimpleClassifier: aTable.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForOPTYPES: aTable [
	self tableTemplateSimpleClassifier: aTable.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForQUALIFICATIONS: aTable [
	self tableTemplateSimpleClassifier: aTable.

]

{ #category : #'as yet unclassified' }
ReRatingDescriptor >> tableForREGIONS: aTable [
	self tableTemplateSimpleClassifier: aTable.

]
