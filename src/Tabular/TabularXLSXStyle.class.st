"
A TabularStyle is xxxxxxxxx.

http://standards.iso.org/ittf/PubliclyAvailableStandards/index.html

http://standards.iso.org/ittf/PubliclyAvailableStandards/c061750_ISO_IEC_29500-1_2012.zip

numFmtId :
0 General
1 0
2 0.00
3 #,##0
ISO/IEC 29500-1:2012(E)
1770 ©ISO/IEC 2012 – All rights reserved
ID formatCode
4 #,##0.00
9 0%
10 0.00%
11 0.00E+00
12 # ?/?
13 # ??/??
14 mm-dd-yy
15 d-mmm-yy
16 d-mmm
17 mmm-yy
18 h:mm AM/PM
19 h:mm:ss AM/PM
20 h:mm
21 h:mm:ss
22 m/d/yy h:mm
37 #,##0 ;(#,##0)
38 #,##0 ;[Red](#,##0)
39 #,##0.00;(#,##0.00)
40 #,##0.00;[Red](#,##0.00)
45 mm:ss
46 [h]:mm:ss
47 mmss.0
48 ##0.0E+0
49 @

Instance Variables
	borderId:		<Object>
	fillId:		<Object>
	fontId:		<Object>
	numFmtId:		<Object>
	xfId:		<Object>

borderId
	- xxxxx

fillId
	- xxxxx

fontId
	- xxxxx

numFmtId
	- xxxxx

xfId
	- xxxxx

"
Class {
	#name : #TabularXLSXStyle,
	#superclass : #TabularStyle,
	#instVars : [
		'numFmtId',
		'fontId',
		'fillId',
		'borderId',
		'xfId'
	],
	#category : #'Tabular-Model'
}

{ #category : #accessing }
TabularXLSXStyle >> borderId [
	^ borderId
]

{ #category : #accessing }
TabularXLSXStyle >> borderId: anObject [
	borderId := anObject
]

{ #category : #accessing }
TabularXLSXStyle >> fillId [
	^ fillId
]

{ #category : #accessing }
TabularXLSXStyle >> fillId: anObject [
	fillId := anObject
]

{ #category : #accessing }
TabularXLSXStyle >> fontId [
	^ fontId
]

{ #category : #accessing }
TabularXLSXStyle >> fontId: anObject [
	fontId := anObject
]

{ #category : #testing }
TabularXLSXStyle >> isDate [
	^ ((self workbook styles formats at: self numFmtId ifAbsent: [ '' ]) includes: $y)
		or: [ #(14 15 16 17 22) includes: self numFmtId ]
]

{ #category : #accessing }
TabularXLSXStyle >> numFmtId [
	^ numFmtId
]

{ #category : #accessing }
TabularXLSXStyle >> numFmtId: anObject [
	numFmtId := anObject
]

{ #category : #accessing }
TabularXLSXStyle >> xfId [
	^ xfId
]

{ #category : #accessing }
TabularXLSXStyle >> xfId: anObject [
	xfId := anObject
]
