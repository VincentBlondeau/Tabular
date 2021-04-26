"
A TabularTableWriterWordMLTest is a test class for testing the behavior of TabularTableWriterWordML
"
Class {
	#name : #TabularTableWriterWordMLTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularTableWriterWordMLTest >> testRenderWorksheet [


      | aWorksheet |
aWorksheet := TabularWorksheet new.
aWorksheet col: 1 row: 1 putData: 'abc'.
      aWorksheet col: 2 row: 1 putData: 'efg'.
      aWorksheet col: 3 row: 1 putData: 'hij'.
      aWorksheet col: 1 row: 2 putData: 'klm'.
      aWorksheet col: 2 row: 2 putData: 'nop'.
      aWorksheet col: 3 row: 2 putData: 'qrs'.

 
    self assert: (TabularWorksheetWriterWordML  for: aWorksheet) equals: 
'<?xml version="1.0" standalone="yes"?>
<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="240" w:after="120"/><w:rPr><w:sz w:val="36"/><w:b/><w:sz w:val="36"/><w:b/><w:szCs w:val="36"/><w:bCs/><w:rFonts w:ascii="Liberation Sans" w:hAnsi="Liberation Sans" w:eastAsia="Droid Sans Fallback" w:cs="FreeSans"/>
</w:rPr>
</w:pPr>
<w:r>
        <w:t>New sheet</w:t>
    </w:r></w:p>
<w:tbl>
<w:tblPr>
<w:tblW w:w="9638" w:type="dxa"/><w:jc w:val="left"/><w:tblInd w:w="55" w:type="dxa"/><w:tblBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tblBorders><w:tblCellMar><w:top w:w="55" w:type="dxa"/><w:left w:w="54" w:type="dxa"/><w:bottom w:w="55" w:type="dxa"/><w:right w:w="55" w:type="dxa"/></w:tblCellMar>
</w:tblPr>
<w:tblGrid><w:gridCol w:w="3212"/><w:gridCol w:w="3212"/><w:gridCol w:w="3212"/></w:tblGrid><w:tr>
        <w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar>
</w:tcPr>
<w:p>
                <w:r>
                    <w:t>abc</w:t>
                </w:r>
            </w:p></w:tc>
        <w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar>
</w:tcPr>
<w:p>
                <w:r>
                    <w:t>efg</w:t>
                </w:r>
            </w:p></w:tc>
        <w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar>
</w:tcPr>
<w:p>
                <w:r>
                    <w:t>hij</w:t>
                </w:r>
            </w:p></w:tc>
    </w:tr><w:tr>
        <w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar>
</w:tcPr>
<w:p>
                <w:r>
                    <w:t>klm</w:t>
                </w:r>
            </w:p></w:tc>
        <w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar>
</w:tcPr>
<w:p>
                <w:r>
                    <w:t>nop</w:t>
                </w:r>
            </w:p></w:tc>
        <w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar>
</w:tcPr>
<w:p>
                <w:r>
                    <w:t>qrs</w:t>
                </w:r>
            </w:p></w:tc>
    </w:tr></w:tbl>'
]
