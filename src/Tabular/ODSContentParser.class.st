Class {
	#name : #ODSContentParser,
	#superclass : #TabularSAXParser,
	#instVars : [
		'workbook',
		'currentWorksheet',
		'rowNum',
		'colNum'
	],
	#category : #'Tabular-SAXParser'
}

{ #category : #private }
ODSContentParser >> addStyleFrom: attributes [

	| newStyle |

	newStyle := TabularODSStyle new.
	self addAttributes: attributes to: newStyle.
	workbook styles at: (attributes at: #'style:name') put: newStyle.
	parsingStack push: newStyle.
]

{ #category : #initialization }
ODSContentParser >> buildRootObject [

	workbook := TabularWorkbook new.
	workbook styles: Dictionary new.
	^ workbook.
]

{ #category : #'handling - content' }
ODSContentParser >> number_currency_style_end [
	parsingStack pop	"the style"
]

{ #category : #'handling - content' }
ODSContentParser >> number_currency_style_start: attributes [

	self addStyleFrom: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> number_date_style_end [
	parsingStack pop	"the style"
]

{ #category : #'handling - content' }
ODSContentParser >> number_date_style_start: attributes [

	self addStyleFrom: attributes.

]

{ #category : #'handling - content' }
ODSContentParser >> number_day_start: attributes [

	parsingStack top details add: (Association key: #'number:day' value: attributes)
]

{ #category : #'handling - content' }
ODSContentParser >> number_hours_start: attributes [

	parsingStack top details add: (Association key: #'number:hours' value: attributes)
]

{ #category : #'handling - content' }
ODSContentParser >> number_minutes_start: attributes [

	parsingStack top details add: (Association key: #'number:minutes' value: attributes)
]

{ #category : #'handling - content' }
ODSContentParser >> number_month_start: attributes [

	parsingStack top details add: (Association key: #'number:month' value: attributes)
]

{ #category : #'handling - content' }
ODSContentParser >> number_percentage_style_end [
	parsingStack pop	"the style"
]

{ #category : #'handling - content' }
ODSContentParser >> number_percentage_style_start: attributes [

	self addStyleFrom: attributes.

]

{ #category : #'handling - content' }
ODSContentParser >> number_seconds_start: attributes [

	parsingStack top details add: (Association key: #'number:seconds' value: attributes)
]

{ #category : #'handling - content' }
ODSContentParser >> number_text_characters: aString [

	parsingStack top details add: (Association key: #'number:text' value: aString)
]

{ #category : #'handling - content' }
ODSContentParser >> number_time_style_end [
	parsingStack pop	"the style"
]

{ #category : #'handling - content' }
ODSContentParser >> number_time_style_start: attributes [

	self addStyleFrom: attributes.

]

{ #category : #'handling - content' }
ODSContentParser >> number_year_start: attributes [

	parsingStack top details add: (Association key: #'number:year' value: attributes)
]

{ #category : #'handling - content' }
ODSContentParser >> office_automatic_styles_start: attributes [

	^self.
]

{ #category : #'handling - content' }
ODSContentParser >> office_document_content_start: attributes [

	workbook attributeAt: #office:version put: (attributes at: 'office:version')
]

{ #category : #'handling - content' }
ODSContentParser >> office_font_face_decls_start: attributes [

	workbook attributeAt: #'font-face-decls' put: Dictionary new.
]

{ #category : #elements }
ODSContentParser >> registeredElements [
	^ #('office:document-content'
		'office:font-face-decls' 'style:font-face'
		'office:automatic-styles' 'style:style' 'style:table-column-properties'
		'style:table-row-properties' 'style:table-properties'
		'number:date-style' 
		'number:day' 'number:text' 'number:month' 'number:year'
		'number:time-style'
		'number:hours' 'number:minutes' 'number:seconds'
		'number:percentage-style' 'number:currency-style'
		'number:number'
		'style:text-properties' 'style:table-cell-properties'
		'table:table' 'table:table-column'
		'table:table-row' 'table:table-cell'
		'text:p' )
]

{ #category : #'handling - content' }
ODSContentParser >> style_font_face_start: attributes [

	| fonts |
	
	fonts := workbook attributeAt: #'font-face-decls'.
	fonts at: (attributes at: 'style:name') put: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> style_style_end [

	| name style |
	
	style := parsingStack pop.
	name := style attributeAt: 'style:name'.
	workbook styles at: name put: style.
]

{ #category : #'handling - content' }
ODSContentParser >> style_style_start: attributes [

	| style |
	style := TabularODSStyle new.
	attributes associationsDo: [ :assoc |
		style attributeAt: assoc key put: assoc value ].
	parsingStack push: style.
]

{ #category : #'handling - content' }
ODSContentParser >> style_table_cell_properties_start: attributes [

	parsingStack top details add: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> style_table_column_properties_start: attributes [

	parsingStack top details add: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> style_table_properties_start: attributes [

	parsingStack top details add: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> style_table_row_properties_start: attributes [

	parsingStack top details add: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> style_text_properties_start: attributes [

	parsingStack top details add: attributes.
]

{ #category : #'handling - content' }
ODSContentParser >> table_table_cell_end [
	| cell repeated |
	"Empty cells can be represented in two ways:
		1. a cell with table:number-columns-repeated
		2. a cell with no text:p element (empty)"
	cell := parsingStack pop.
	"First check for empty repeated cells"
	repeated := cell attributeAt: 'table:number-columns-repeated'.
	repeated isNil
		ifTrue: [ cell data isNotNil
				ifTrue: [ currentWorksheet at: colNum @ rowNum putCell: cell ].
			colNum := colNum + 1 ]
		ifFalse: [ colNum := colNum + repeated asInteger ]
	"Second check for empty single cell"
]

{ #category : #'handling - content' }
ODSContentParser >> table_table_cell_start: attributes [

	| cell |
	
	cell := TabularODSCell new.
	cell workbook: workbook.
	self addAttributes: attributes to: cell.
	parsingStack push: cell.
]

{ #category : #'handling - content' }
ODSContentParser >> table_table_column_start: attributes [

	currentWorksheet colStyleAt: (attributes at: 'table:style-name') put: attributes
]

{ #category : #'handling - content' }
ODSContentParser >> table_table_row_end [

	| attributes count |
	attributes := parsingStack pop.
	count := attributes at: 'table:number-rows-repeated' ifAbsent: [ 1].
	rowNum := rowNum + count asInteger.
]

{ #category : #'handling - content' }
ODSContentParser >> table_table_row_start: attributes [

	parsingStack push: attributes.
	currentWorksheet rowStyleAt: (attributes at: 'table:style-name') put: attributes.
	colNum := 1.
]

{ #category : #'handling - content' }
ODSContentParser >> table_table_start: attributes [

	workbook addNewWorksheet.
	currentWorksheet := workbook worksheets last.
	self addAttributes: attributes to: currentWorksheet.
	currentWorksheet name: (attributes at: 'table:name').
	rowNum := 1.
]

{ #category : #'handling - content' }
ODSContentParser >> text_p_characters: aString [

	parsingStack top data: aString
]
