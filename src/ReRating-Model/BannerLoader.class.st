Class {
	#name : #BannerLoader,
	#superclass : #WAFileLibrary,
	#category : #'ReRating-Seaside-Banner'
}

{ #category : #'as yet unclassified' }
BannerLoader >> loaderJs [
^'
document.write(''<iframe height="90" src="http://rerating.pharocloud.com/seaside/banner?url=''+document.documentURI+''" width="100%" border="0" scrolling="no" style="border:0"></iframe><div class="line-way"><img src="/img/1.gif" alt="" width="1" height="2"></div>'');
'
]

{ #category : #'as yet unclassified' }
BannerLoader >> loaderTest [
^'
new Insertion.Before($$(''table.info'')[0].up(), ''<iframe height="70" src="http://rerating.pharocloud.com/seaside/banner" width="100%" border="0" scrolling="no" style="border:0"></iframe><div class="line-way"><img src="/img/1.gif" alt="" width="1" height="2"></div>'');
'
]
