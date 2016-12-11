Class {
	#name : #RRAgent,
	#superclass : #SPClassifier,
	#instVars : [
		'phone',
		'email',
		'qualification',
		'region',
		'firm',
		'docs',
		'rating',
		'avatar',
		'photo',
		'accountFB',
		'accountVK',
		'accountOK',
		'website',
		'inn',
		'gender',
		'dateOfBirth'
	],
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionAccountFB [
	^(SPStringDescription new)
		accessorAndName: #accountFB;
		priority: 50;
		label: 'Аккаунт в FB';
		fieldWidth: 250;
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionAccountOK [
	^(SPStringDescription new)
		accessorAndName: #accountOK;
		priority: 70;
		label: 'Аккаунт в OK';
		fieldWidth: 250;
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionAccountVK [
	^(SPStringDescription new)
		accessorAndName: #accountVK;
		priority: 60;
		label: 'Аккаунт в VK';
		fieldWidth: 250;
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionAvatar [
	^SPImageDescription new
		accessorAndName: #avatar;
		label: 'Аватар';
		priority: 300;
		onDelete: #deleteAvatar;
		onSave: #saveAvatar;
		maxFileSize: 100000;
		fileExtensions: #(jpg jpeg png gif);
		yourself.
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Агенты';
		addListFields: #(firm region rating);
		table: 'agents';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionDateOfBirth [
	^(SPDateDescription new)
		accessorAndName: #dateOfBirth;
		priority: 17;
		label: 'Дата рождения';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionDocs [
	^(SPTablePartDescription new)
		entryClass: RRDoc;
		accessorAndName: #docs;
		priority: 200;
		label: 'Сертификаты';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionEmail [
	^(SPStringDescription new)
		accessorAndName: #email;
		priority: 40;
		label: 'Email';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionFirm [
	^(SPClassifierDescription new)
		classifier: RRFirm;
		accessorAndName: #firm;
		priority: 20;
		label: 'Фирма';
		fieldWidth: 300;
		fastSearchDBAccessBlock: [:agent| agent firm title];
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionGender [
	^(SPBooleanDescription new)
		accessorAndName: #gender;
		priority: 15;
		label: 'Пол';
		componentClass: SPSelectListComponent;
		trueString: 'Женский';
		falseString: 'Мужской';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionInn [
	^(SPStringDescription new)
		accessorAndName: #inn;
		priority: 90;
		label: 'ИНН агента';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionPhone [
	^(SPStringDescription new)
		accessorAndName: #phone;
		priority: 30;
		label: 'Телефон';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionPhoto [
	^SPImageDescription new
		accessorAndName: #photo;
		label: 'Фото';
		priority: 310;
		onDelete: #deletePhoto;
		onSave: #savePhoto;
		maxFileSize: 100000;
		fileExtensions: #(jpg jpeg png gif);
		yourself.
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionQualification [
	^(SPClassifierDescription new)
		classifier: RRQualification;
		accessorAndName: #qualification;
		priority: 110;
		label: 'Квалификация';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionRating [
	^(SPNumberDescription new)
		accessorAndName: #rating;
		label: 'Рейтинг (0-50)';
		priority: 10;
		min: 0 max: 50;
		yourself.
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionRegion [
	^(SPClassifierDescription new)
		classifier: RRRegion;
		accessorAndName: #region;
		priority: 100;
		label: 'Регион';
		fastSearchDBAccessBlock: [:agent| agent region title];
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionTitle [
	^(super descriptionTitle)
		fieldWidth: 300;
		yourself.  
]

{ #category : #'as yet unclassified' }
RRAgent class >> descriptionWebsite [
	^(SPStringDescription new)
		accessorAndName: #website;
		priority: 80;
		label: 'Сайт агента';
		fieldWidth: 250;
		yourself.  
]

{ #category : #accessing }
RRAgent >> accountFB [
	^ accountFB
]

{ #category : #accessing }
RRAgent >> accountFB: anObject [
	accountFB := anObject
]

{ #category : #accessing }
RRAgent >> accountOK [
	^ accountOK
]

{ #category : #accessing }
RRAgent >> accountOK: anObject [
	accountOK := anObject
]

{ #category : #accessing }
RRAgent >> accountVK [
	^ accountVK
]

{ #category : #accessing }
RRAgent >> accountVK: anObject [
	accountVK := anObject
]

{ #category : #accessing }
RRAgent >> avatar [
	^ avatar
]

{ #category : #accessing }
RRAgent >> avatar: anObject [
	avatar := anObject
]

{ #category : #accessing }
RRAgent >> dateOfBirth [
	^ dateOfBirth
]

{ #category : #accessing }
RRAgent >> dateOfBirth: anObject [
	dateOfBirth := anObject
]

{ #category : #'as yet unclassified' }
RRAgent >> deleteAvatar [
	self deleteFileUsing: self class descriptionAvatar.
]

{ #category : #'as yet unclassified' }
RRAgent >> deletePhoto [
	self deleteFileUsing: self class descriptionPhoto.
]

{ #category : #accessing }
RRAgent >> docs [
	^ docs
]

{ #category : #accessing }
RRAgent >> docs: anObject [
	docs := anObject
]

{ #category : #accessing }
RRAgent >> email [
	^ email
]

{ #category : #accessing }
RRAgent >> email: anObject [
	email := anObject
]

{ #category : #accessing }
RRAgent >> firm [
	^ firm
]

{ #category : #accessing }
RRAgent >> firm: anObject [
	firm := anObject
]

{ #category : #accessing }
RRAgent >> gender [
	^ gender
]

{ #category : #accessing }
RRAgent >> gender: anObject [
	gender := anObject
]

{ #category : #'as yet unclassified' }
RRAgent >> initialize [
	docs := OrderedCollection new.
]

{ #category : #accessing }
RRAgent >> inn [
	^ inn
]

{ #category : #accessing }
RRAgent >> inn: anObject [
	inn := anObject
]

{ #category : #accessing }
RRAgent >> phone [
	^ phone
]

{ #category : #accessing }
RRAgent >> phone: anObject [
	phone := anObject
]

{ #category : #accessing }
RRAgent >> photo [
	^ photo
]

{ #category : #accessing }
RRAgent >> photo: anObject [
	photo := anObject
]

{ #category : #accessing }
RRAgent >> qualification [
	^ qualification
]

{ #category : #accessing }
RRAgent >> qualification: anObject [
	qualification := anObject
]

{ #category : #accessing }
RRAgent >> rating [
	^ rating
]

{ #category : #accessing }
RRAgent >> rating: anObject [
	rating := anObject
]

{ #category : #accessing }
RRAgent >> region [
	^ region
]

{ #category : #accessing }
RRAgent >> region: anObject [
	region := anObject
]

{ #category : #'as yet unclassified' }
RRAgent >> saveAvatar [
	self preSaveFileUsing: self class descriptionAvatar.
]

{ #category : #'as yet unclassified' }
RRAgent >> savePhoto [
	self preSaveFileUsing: self class descriptionPhoto.
]

{ #category : #accessing }
RRAgent >> website [
	^ website
]

{ #category : #accessing }
RRAgent >> website: anObject [
	website := anObject
]
