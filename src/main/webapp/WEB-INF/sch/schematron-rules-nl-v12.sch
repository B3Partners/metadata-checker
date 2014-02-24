<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
	<sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
	<sch:ns uri="http://www.isotc211.org/2005/gco" prefix="gco"/>
    <sch:ns uri="http://www.isotc211.org/2005/srv" prefix="srv"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.opengis.net/gml" prefix="gml"/>
	<sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
	
	<sch:let name="lowercase" value="'abcdefghijklmnopqrstuvwxyz'"/>
	<sch:let name="uppercase" value="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<sch:pattern name="DutchMetadataCoreSetForServices">
		<sch:title>Validatie van metadata op het Nederlands metadataprofiel op ISO19119 voor services 1.2.</sch:title>
		<sch:rule context="/*">
			<!-- Namespace declaration -->
			<sch:assert test="contains(normalize-space(@xsi:schemaLocation), 'http://www.isotc211.org/2005/gmd ')">Het ISO 19139 XML document mist een verplichte schema namespace. De schema namespace http://www.isotc211.org/2005/gmd moet aanwezig zijn.
			</sch:assert>
			<sch:report test="contains(normalize-space(@xsi:schemaLocation), 'http://www.isotc211.org/2005/gmd ')">Het ISO 19139 XML document bevat de schema namespace http://www.isotc211.org/2005/gmd
			</sch:report>
		    <!-- lvdb test op srv ns toegevoegd -->
			<sch:assert test="contains(normalize-space(@xsi:schemaLocation), 'http://www.isotc211.org/2005/srv ')">Het ISO 19139 XML document mist een verplichte schema namespace. De schema namespace http://www.isotc211.org/2005/srv moet aanwezig zijn.
		    </sch:assert>
			<sch:report test="contains(normalize-space(@xsi:schemaLocation), 'http://www.isotc211.org/2005/srv ')">Het ISO 19139 XML document bevat de schema namespace http://www.isotc211.org/2005/srv
			</sch:report>
		<!--  fileIdentifier -->
			<sch:let name="fileIdentifier" value="normalize-space(gmd:fileIdentifier)"/>
			<sch:assert test="$fileIdentifier">Er is geen Metadata ID (ISO nr. 2) opgegeven.</sch:assert>
			<sch:report test="$fileIdentifier">Metadata ID: <sch:value-of select="$fileIdentifier"/>
			</sch:report>
			
       		     <!-- Metadata taal -->
 			<sch:let name="mdLanguage" value="gmd:language/gmd:LanguageCode/@codeListValue = 'dut'"/>
            			<sch:let name="mdLanguage_value" value="gmd:language/*/@codeListValue"/>
		<!-- Metadata hiërarchieniveau -->
			<sch:let name="hierarchyLevel" value="gmd:hierarchyLevel[1]/*/@codeListValue = 'service'"/>
            <sch:let name="hierarchyLevel_value" value="gmd:hierarchyLevel[1]/*/@codeListValue"/>
            <!-- Metadata verantwoordelijke organisatie (name) -->
			<sch:let name="mdResponsibleParty_Organisation" value="normalize-space(gmd:contact/*/gmd:organisationName)"/>
			<!-- Metadata verantwoordelijke organisatie (role) INSPIRE
			<sch:let name="mdResponsibleParty_Role" value="gmd:contact/*/gmd:role/*/@codeListValue = 'pointOfContact' "/>
			 -->
			<!-- Metadata verantwoordelijke organisatie (role) NL profiel -->
			<sch:let name="mdResponsibleParty_Role" value="gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'resourceProvider' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'custodian' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'owner' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'user' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'distributor' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'owner' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'originator' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'pointOfContact' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'principalInvestigator' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'processor' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'publisher' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'author'"/>
			<!-- Metadata verantwoordelijke organisatie (url) -->
			<sch:let name="mdResponsibleParty_Mail" value="normalize-space(gmd:contact/*/gmd:contactInfo/*/gmd:address/*/gmd:electronicMailAddress)"/>
            <!-- Metadata datum -->
			<sch:let name="dateStamp" value="normalize-space(gmd:dateStamp/gco:Date)"/>
			<!-- Karakterset -->
			<sch:let name="characterset_value" value="gmd:characterSet/*/@codeListValue[. ='ucs2' or . ='ucs4' or . ='utf7' or . ='utf8' or . ='utf16' or . ='8859part1' or . ='8859part2' or . ='8859part3' or . ='8859part4' or . ='8859part5' or . ='8859part6' or . ='8859part7' or . ='8859part8' or . ='8859part9' or . ='8859part10' or . ='8859part11' or  . ='8859part12' or . ='8859part13' or . ='8859part14' or . ='8859part15' or . ='8859part16' or . ='jis' or . ='shiftJIS' or . ='eucJP' or . ='usAscii' or . ='ebcdic' or . ='eucKR' or . ='big5' or . ='GB2312']"/>
			<!-- Metadatastandaard naam -->
			<sch:let name="metadataStandardName" value="translate(normalize-space(gmd:metadataStandardName), $lowercase, $uppercase)"/>
			<!-- Versie metadatastandaard naam -->
			<sch:let name="metadataStandardVersion" value="translate(normalize-space(gmd:metadataStandardVersion), $lowercase, $uppercase)"/>
			
			<!-- rules and assertions -->
			<sch:assert test="$mdLanguage">De metadata taal (ISO nr. 3) ontbreekt of heeft een verkeerde waarde. Dit hoort een waarde en verwijzing naar de codelijst te zijn.</sch:assert>
			<sch:report test="$mdLanguage">Metadata taal (ISO nr. 3) voldoet </sch:report>
			<sch:assert test="$hierarchyLevel">Resource type (ISO nr. 6) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$hierarchyLevel">Resource type (ISO nr. 6) voldoet</sch:report>
			<sch:assert test="$mdResponsibleParty_Organisation">Naam organisatie metadata (ISO nr. 376) ontbreekt</sch:assert>
			<sch:report test="$mdResponsibleParty_Organisation">Naam organisatie metadata (ISO nr. 376): <sch:value-of select="$mdResponsibleParty_Organisation"/>
			</sch:report>
			<sch:assert test="$mdResponsibleParty_Role">Rol organisatie metadata (ISO nr. 379) ontbreekt of heeft een verkeerde waarde,  deze dient voor INSPIRE contactpunt te zijn</sch:assert>
			<sch:report test="$mdResponsibleParty_Role">Rol organisatie metadata (ISO nr. 379) voldoet</sch:report>
			<sch:assert test="$mdResponsibleParty_Mail">E-mail organisatie metadata (ISO nr. 386) ontbreekt</sch:assert>
			<sch:report test="$mdResponsibleParty_Mail">E-mail organisatie metadata (ISO nr. 386): <sch:value-of select="$mdResponsibleParty_Mail"/>
			</sch:report>
			<sch:assert test="matches($dateStamp, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')">Metadata datum (ISO nr. 9) ontbreekt of heeft het verkeerde formaat (YYYY-MM-DD)</sch:assert>
			<sch:report test="$dateStamp">Metadata datum (ISO nr. 9): <sch:value-of select="$dateStamp"/>
			</sch:report>
			<!-- IdV wordt ook niet bij data op getest
			<sch:assert test="$characterset_value">Metadata karakterset (ISO nr. 40) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$characterset_value">Metadata karakterset (ISO nr. 40) voldoet</sch:report>
			 -->
			<sch:assert test="not($metadataStandardName) or $metadataStandardName = 'ISO 19119'">Metadatastandaard naam (ISO nr. 10) is niet correct ingevuld</sch:assert>
			<sch:report test="$metadataStandardName">Metadatastandaard naam (ISO nr. 10): <sch:value-of select="$metadataStandardName"/>
			</sch:report>
			<sch:assert test="contains($metadataStandardVersion, 'PROFIEL OP ISO 19119')">Versie metadatastandaard naam (ISO nr. 11) is niet correct ingevuld</sch:assert>
			<sch:report test="contains($metadataStandardVersion, 'PROFIEL OP ISO 19119')">Versie metadatastandaard naam (ISO nr. 11): <sch:value-of select="$metadataStandardVersion"/>
				</sch:report>
			
		    <!-- alle regels over elementen binnen gmd:identificationInfo -->
			<!-- service titel -->
			<sch:let name="serviceTitle" value="normalize-space(gmd:identificationInfo[1]/*/gmd:citation/*/gmd:title/gco:CharacterString)"/>
		    <!-- Service referentie datum -->
			<sch:let name="publicationDate" value="matches(gmd:identificationInfo[1]/*/gmd:citation/*/gmd:date[./*/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="creationDate" value="matches(gmd:identificationInfo[1]/*/gmd:citation/*/gmd:date[./*/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="revisionDate" value="matches(gmd:identificationInfo[1]/*/gmd:citation/*/gmd:date[./*/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
		    <!-- Samenvatting -->
			<sch:let name="abstract" value="normalize-space(gmd:identificationInfo[1]/*/gmd:abstract/gco:CharacterString)"/>
		    <!--  Verantwoordelijke organisatie bron -->
			<sch:let name="responsibleParty_Organisation" value="normalize-space(gmd:identificationInfo[1]/*/gmd:pointOfContact/*/gmd:organisationName/gco:CharacterString)"/>
		    <!-- Verantwoordelijke organisatie bron: role -->
			<sch:let name="responsibleParty_Role" value="gmd:identificationInfo[1]/*/gmd:pointOfContact/*/gmd:role/*/@codeListValue[. = 'resourceProvider' or . = 'custodian' or . = 'owner' or . = 'user' or . = 'distributor' or . = 'owner' or . = 'originator' or . = 'pointOfContact' or . = 'principalInvestigator' or . = 'processor' or . = 'publisher' or . = 'author']"/>
		    <!-- Service verantwoordelijke organisatie (url) -->
			<sch:let name="responsibleParty_Mail" value="normalize-space(gmd:identificationInfo[1]/*/gmd:pointOfContact/*/gmd:contactInfo/*/gmd:address/*/gmd:electronicMailAddress/gco:CharacterString)"/>
		    <!-- Trefwoorden  voor INSPIRE
			<sch:let name="keyword" value="normalize-space(gmd:identificationInfo[1]/*/gmd:descriptiveKeywords/*/gmd:keyword/*[text() = 'infoFeatureAccessService'
		        or text() = 'infoMapAccessService'
		        or text() = 'humanGeographicViewer'])"/>
    
		        -->
		        <!-- Trefwoorden NL profiel-->
		        <sch:let name="keyword" value="normalize-space(gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:descriptiveKeywords[1]/gmd:MD_Keywords/gmd:keyword[1]/gco:CharacterString)"/>
		    <!-- Unieke Identifier van de bron -->
			<sch:let name="identifier" value="normalize-space(gmd:identificationInfo[1]/*/gmd:citation/*/gmd:identifier/*/gmd:code/gco:CharacterString)"/>
		    <!-- Gebruiksbeperkingen -->
			<sch:let name="useLimitation" value="normalize-space(gmd:identificationInfo[1]/*/gmd:resourceConstraints/gmd:MD_Constraints/gmd:useLimitation/gco:CharacterString)"/>
		    <!-- Overige beperkingen -->
			<sch:let name="otherConstraints" value="normalize-space(gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints[1]/gco:CharacterString)"/>
		    <!-- Veiligheidsrestricties -->
		    <sch:let name="classification_value" value="gmd:identificationInfo[1]/*/gmd:resourceConstraints/*/gmd:classification/*/@codeListValue[. = 'unclassified' or . = 'restricted' or . = 'confidential' or . = 'secret' or . = 'topSecret']"/>
		    <!-- (Juridische) toegangsrestricties  -->
		    <sch:let name="accessConstraints_value" value="string(gmd:identificationInfo[1]/*/gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue[. = 'copyright' or . = 'patent' or . = 'patentPending' or . = 'trademark' or . = 'license' or . = 'intellectualPropertyRights' or . = 'restricted' or . = 'otherRestrictions'])"/>
		    <!-- Locatie algemeen -->
			<sch:let name="geographicLocation" value="normalize-space(gmd:identificationInfo[1]/*/srv:extent/*/gmd:geographicElement)"/>
			<!-- Omgrenzende rechthoek -->
		    <sch:let name="west" value="number(gmd:identificationInfo[1]/*/srv:extent/*/gmd:geographicElement/*/gmd:westBoundLongitude/gco:Decimal)"/>
		    <sch:let name="east" value="number(gmd:identificationInfo[1]/*/srv:extent/*/gmd:geographicElement/*/gmd:eastBoundLongitude/gco:Decimal)"/>
		    <sch:let name="north" value="number(gmd:identificationInfo[1]/*/srv:extent/*/gmd:geographicElement/*/gmd:northBoundLatitude/gco:Decimal)"/>
		    <sch:let name="south" value="number(gmd:identificationInfo[1]/*/srv:extent/*/gmd:geographicElement/*/gmd:southBoundLatitude/gco:Decimal)"/>
		    <!-- Temporele dekking begin -->
		    <!-- idv hier net als bij data de verschillende mogelijkheden inbouwen -->
			<!-- LVDB gedaan -->
			<sch:let name="begin_beginPosition" value="matches(gmd:identificationInfo/*/srv:extent/*/gmd:temporalElement/*/gmd:extent/*/gml:beginPosition, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="begin_begintimePosition" value="matches(gmd:identificationInfo/*/srv:extent/*/gmd:temporalElement/*/gmd:extent/*/gml:begin/*/gml:timePosition, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="begin_timePosition" value="matches(gmd:identificationInfo/*/srv:extent/*/gmd:temporalElement/*/gmd:extent/*/gml:timePosition, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="begin" value="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition"/>
			<!-- Temporele dekking end 
				LVDB verwijderd net als bij data
			<sch:let name="end" value="gmd:identificationInfo[1]/*/srv:extent/*/gmd:temporalElement/*/gmd:extent/*/gml:endPosition or gmd:extent/*/gmd:temporalElement/*/gmd:extent/*/gml:end/*/gml:timePosition"/>-->
			<sch:let name="dcp_value" value="normalize-space(string(gmd:identificationInfo/srv:SV_ServiceIdentification/srv:containsOperations[1]/srv:SV_OperationMetadata[1]/srv:DCP[1]/srv:DCPList/@codeListValue))"/>
			<sch:let name="operationName" value="normalize-space(gmd:identificationInfo[1]/*/srv:containsOperations[1]/*/srv:operationName/gco:CharacterString)"/>
			<sch:let name="connectPoint" value="normalize-space(gmd:identificationInfo[1]/*/srv:containsOperations[1]/*/srv:connectPoint/*/gmd:linkage/gmd:URL)"/>
			<sch:let name="resourceLocator" value="normalize-space(gmd:identificationInfo[1]/*/gmd:transferOptions[1]/*/gmd:onLine/*/gmd:linkage/gco:CharacterString)"/>
		    <sch:let name="serviceType_value" value="gmd:identificationInfo[1]/*/srv:serviceType/*/text()"/>
		    <sch:let name="serviceType" value="gmd:identificationInfo[1]/*/srv:serviceType/*[text() = 'view'
		        or text() = 'download'
		        or text() = 'discovery'
		        or text() = 'transformation'
		        or text() = 'invoke'
		        or text() = 'other'
]"/>
			<sch:let name="serviceTypeVersion" value="normalize-space(gmd:identificationInfo[1]/*/srv:serviceTypeVersion/gco:CharacterString)"/>
			<sch:let name="coupledResource_scopedName" value="normalize-space(gmd:identificationInfo[1]/*/srv:coupledResource/*/gco:ScopedName)"/>
		    <sch:let name="couplingType_value" value="string(gmd:identificationInfo[1]/*/srv:couplingType/*/@codeListValue)"/>            
		    <sch:let name="couplingType" value="gmd:identificationInfo[1]/*/srv:couplingType/*/@codeListValue[. ='tight' or . ='mixed' or . ='loose']"/>                   
			<sch:let name="operatesOn" value="normalize-space(string(gmd:identificationInfo[1]/*/srv:operatesOn[1]/@xlink:href))"/>
			<sch:let name="coupledResource_identifier" value="normalize-space(gmd:identificationInfo[1]/*/srv:coupledResource/*/srv:identifier/gco:CharacterString)"/>
			<sch:let name="coupledResource_operationName" value="normalize-space(gmd:identificationInfo[1]/*/srv:coupledResource/*/srv:operationName/gco:CharacterString)"/>
		    <!-- assertions and reports -->
		    <!-- service type -->
		    <sch:assert test="$serviceType">Service type ontbreekt of heeft de verkeerde waarde</sch:assert>
		    <sch:report test="$serviceType">Service type: <sch:value-of select="$serviceType_value"/></sch:report>
		    <!-- service type version
		    <sch:assert test="$serviceTypeVersion">Service type version ontbreekt of heeft de verkeerde waarde</sch:assert>
		    <sch:report test="$serviceTypeVersion">Service type version: <sch:value-of select="$serviceTypeVersion"/></sch:report>
		    -->
		    <!-- connectPoint -->
		    <sch:assert test="$connectPoint"> Connect point linkage ontbreekt of heeft de verkeerde waarde </sch:assert>
		    <sch:report test="$connectPoint">Connect point linkage: <sch:value-of select="$connectPoint"/></sch:report>
		    <!-- operationName -->
		    <sch:assert test="$operationName">Op zijn minst een operation name ontbreekt.</sch:assert>
		    <sch:report test="$operationName">Operation name: <sch:value-of select="$operationName"/></sch:report>
		    <!-- dcp -->
		    <sch:assert test="$dcp_value = 'WebServices'"> DCP ontbreekt  of heeft de verkeerde waarde </sch:assert>
		    <sch:report test="$dcp_value">DCP: <sch:value-of select="$dcp_value"/></sch:report>
		    <!-- couplingType -->
		    <sch:assert test="$couplingType">Coupling type ontbreekt of heeft de verkeerde waarde</sch:assert>
		    <sch:report test="$couplingType">Coupling type: <sch:value-of select="$couplingType_value"/></sch:report>
		    <!-- extent -->
			<sch:assert test="($couplingType_value='loose') or (($couplingType_value='tight' or $couplingType_value='mixed') and $geographicLocation)">Geographic location is verplicht indien data aan de service is gekoppeld (coupled resource 'tight' of 'mixed').</sch:assert>
			<sch:report test="($couplingType_value='tight' or $couplingType_value='mixed') and $geographicLocation">Geographic location: <sch:value-of select="$geographicLocation"/></sch:report>
		    <sch:assert test="(-180.00 &lt; $west) and ( $west &lt; 180.00) or ( $west = 0.00 ) or ( $west = -180.00 ) or ( $west = 180.00 )">Minimum x-coördinaat (ISO nr. 344) ontbreekt of heeft een verkeerde waarde</sch:assert>
		    <sch:report test="(-180.00 &lt; $west) and ( $west &lt; 180.00) or ( $west = 0.00 ) or ( $west = -180.00 ) or ( $west = 180.00 )">Minimum x-coördinaat (ISO nr. 344): <sch:value-of select="$west"/></sch:report>
		    <sch:assert test="(-180.00 &lt; $east) and ($east &lt; 180.00) or ( $east = 0.00 ) or ( $east = -180.00 ) or ( $east = 180.00 )">Maximum x-coördinaat (ISO nr. 345) ontbreekt of heeft een verkeerde waarde</sch:assert>
		    <sch:report test="(-180.00 &lt; $east) and ($east &lt; 180.00) or ( $east = 0.00 ) or ( $east = -180.00 ) or ( $east = 180.00 )">Maximum x-coördinaat (ISO nr. 345): <sch:value-of select="$east"/></sch:report>
		    <sch:assert test="(-90.00 &lt; $south) and ($south &lt; $north) or (-90.00 = $south) or ($south = $north)">Minimum y-coördinaat (ISO nr. 346) ontbreekt of heeft een verkeerde waarde</sch:assert>
		    <sch:report test="(-90.00 &lt; $south) and ($south &lt; $north) or (-90.00 = $south) or ($south = $north)">Minimum y-coördinaat (ISO nr. 346): <sch:value-of select="$south"/></sch:report>
		    <sch:assert test="($south &lt; $north) and ($north &lt; 90.00) or ($south = $north) or ($north = 90.00)">Maximum y-coördinaat (ISO nr. 347) ontbreekt of heeft een verkeerde waarde</sch:assert>
		    <sch:report test="($south &lt; $north) and ($north &lt; 90.00) or ($south = $north) or ($north = 90.00)">Maximum y-coördinaat (ISO nr. 347): <sch:value-of select="$north"/></sch:report>
		    <!-- conditional elements -->
		    <!-- resourceLocator -->
			<!-- removed on request by Ine, GeoCat issue 3152 
		    <sch:report test="$resourceLocator = $connectPoint">Resource locator: <sch:value-of select="$resourceLocator"/></sch:report>
			-->
		    <!-- operatesOn -->
		    <!-- changed with version 1.2 
		        <sch:assert test="($couplingType_value='tight' or $couplingType_value='mixed') and $operatesOn">'operatesOn' is mandatory, if coupling type is not 'loose'. If it is instead, a value for operatesOn shall not be given.</sch:assert>
		        <sch:report test="($couplingType_value='tight' or $couplingType_value='mixed') and $operatesOn">operatesOn is present for a valid coupling type: <sch:value-of select="$operatesOn"/></sch:report>
		    -->
		    <!-- coupledResource -->
		 	<!-- identifier optioneel in versie 1.2
			<sch:assert test="($couplingType_value='loose') or (($couplingType_value='tight' or $couplingType_value='mixed') and $coupledResource_identifier)">Coupled resource identifier is verplicht als data aan de service is gekoppeld (coupled resource 'tight' of 'mixed').</sch:assert>
			<sch:report test="($couplingType_value='tight' or $couplingType_value='mixed') and $coupledResource_identifier">Coupled resource identifier: <sch:value-of select="$coupledResource_identifier"/></sch:report>
			 -->
			<!-- operation name optioneel in versie 1.2
			<sch:assert test="($couplingType_value='loose') or (($couplingType_value='tight' or $couplingType_value='mixed') and $coupledResource_operationName)">Coupled resource operation name is verplicht als data aan de service is gekoppeld (coupled resource 'tight' of 'mixed').</sch:assert>
			<sch:report test="($couplingType_value='tight' or $couplingType_value='mixed') and $coupledResource_operationName">Coupled resource operation name : <sch:value-of select="$coupledResource_operationName"/></sch:report>
			-->
			<sch:assert test="$serviceTitle">Resource titel (ISO nr. 360) ontbreekt</sch:assert>
		    <sch:report test="$serviceTitle">Resource titel (ISO nr. 360): <sch:value-of select="$serviceTitle"/>
		    </sch:report>
		    <sch:assert test="($publicationDate or $creationDate or $revisionDate) ">Temporal reference date (ISO nr. 394) ontbreekt of heeft het verkeerde formaat (YYYY-MM-DD)</sch:assert>
		    <sch:report test="($publicationDate or $creationDate or $revisionDate) ">Tenminste 1>Temporal reference (ISO nr. 394) is gevonden</sch:report>
		    <sch:assert test="$abstract">Resource abstract (ISO nr. 25) ontbreekt</sch:assert>
		    <sch:report test="$abstract">Resource abstract (ISO nr. 25): <sch:value-of select="$abstract"/>
		    </sch:report>
		    <sch:assert test="$responsibleParty_Organisation">Responsible party (ISO nr. 376) ontbreekt</sch:assert>
		    <sch:report test="$responsibleParty_Organisation">Responsible party (ISO nr. 376): <sch:value-of select="$responsibleParty_Organisation"/>
		    </sch:report>
		    <sch:assert test="$responsibleParty_Role">Responsible party role (ISO nr. 379) ontbreekt of heeft een verkeerde waarde</sch:assert>
		    <sch:report test="$responsibleParty_Role">Responsible party role (ISO nr. 379) voldoet</sch:report>
		    <sch:assert test="$responsibleParty_Mail">Responsible party e-mail (ISO nr. 386) ontbreekt of heeft een verkeerde waarde</sch:assert>
		    <sch:report test="$responsibleParty_Mail">Responsible party e-mail (ISO nr. 386): <sch:value-of select="$responsibleParty_Mail"/>
		    </sch:report>
		    <sch:assert test="$keyword">Keyword (ISO nr. 53)  ontbreekt of heeft de verkeerde waarde</sch:assert>
		    <sch:report test="$keyword">Tenminste 1 keyword (ISO nr. 53) is gevonden</sch:report>
			<!-- idv klopt dit wel?is unieke identifier hier verplicht? -->
			<!-- LVDB verwijderd -->
<!--		    <sch:assert test="$identifier">Unique identifier code (ISO nr. 207) of the resource is mandatory</sch:assert>-->
		    <sch:report test="$identifier">Unique identifier code (ISO nr. 207) of the resource is present: <sch:value-of select="$identifier"/>
		    </sch:report>
			<!-- idv zie temporeel bij data -->
			<!-- LVDB gedaan -->
			<!-- idv  opgenomen bij temporele reference
			<sch:assert test="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition">Temporele dekking - BeginDatum (ISO nr. 351) ontbreekt</sch:assert>
			<sch:report test="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition">Temporele dekking - BeginDatum (ISO nr. 351): <sch:value-of select="$begin_beginPosition"/><sch:value-of select="$begin_begintimePosition"/><sch:value-of select="$begin_timePosition"/>
			
			</sch:report>
			 -->
		    <!--<sch:assert test="$end">Temporele dekking - EindDatum (ISO nr. 351) ontbreekt</sch:assert>-->
		    <!-- changed with version 1.3 
		    <sch:report test="$end">Temporele dekking - EindDatum (ISO nr. 351): <sch:value-of select="$end"/>
		    </sch:report>-->
		    <sch:assert test="$useLimitation">Use limitations (ISO nr. 68) ontbreken</sch:assert>
		    <sch:report test="$useLimitation">Use limitations (ISO nr. 68): <sch:value-of select="$useLimitation"/>
		    </sch:report>
			<!-- toegangsrestricties -->
			<!-- idv net zo als bij dat een van de drie en als acces heeft de waarde other dan moet ook otherconstrains een waarde hebben -->
			<!-- LVDB gedaan -->
			<sch:assert test="$accessConstraints_value or $otherConstraints or $classification_value">Minimaal een van (Juridische) toegangsrestricties (ISO nr. 70), Overige beperkingen (ISO nr 72) of Veiligheidsrestricties (ISO nr 74) dient ingevuld te zijn</sch:assert>
			<sch:assert test="not($accessConstraints_value = 'otherRestrictions') or ($accessConstraints_value = 'otherRestrictions' and $otherConstraints)">Het element overige beperkingen (ISO nr. 72) dient een waarde te hebben als (juridische) toegangsrestricties (ISO nr. 70) de waarde 'anders' heeft</sch:assert>
			<sch:report test="$otherConstraints">Overige beperkingen (ISO nr 72): <sch:value-of select="$otherConstraints"/></sch:report>
			<sch:report test="$classification_value">Veiligheidsrestricties (ISO nr 74): <sch:value-of select="gmd:resourceConstraints/*/gmd:classification/*/@codeListValue"/></sch:report>
			<sch:report test="$accessConstraints_value">(Juridische) toegangsrestricties (ISO nr. 70) voldoet: <sch:value-of select="$accessConstraints_value"/></sch:report>
			<!-- coupling type -->
		    <sch:assert test="not($couplingType_value='loose')">'coupling type' heeft de verkeerde waarde; loose is alleen mogelijk als er geen data aan de service gekoppeld is</sch:assert>
		    <sch:report test="$couplingType_value and not($couplingType_value='loose')">'coupling type' : <sch:value-of select="concat('', $couplingType_value)"/></sch:report>			
		    <!-- href to identifier -->            
		    <sch:assert test="$operatesOn">'operatesOn' heeft geen xlink:href attribuut.</sch:assert>
		    <sch:report test="$operatesOn">'operatesOn' heeft xlink:href attribuut: <sch:value-of select="$operatesOn"/></sch:report>
		    <!-- scoped name, only reported -->
		    <!-- idv Verplicht voor de OGC:WMS, OGC:WFS en OGC:WCS, conditie testen op basis van servicetype-->
			<!-- LVDB gedaan -->
			<!-- scopedName -->
			<!--<sch:assert test="not($serviceType_value='OGC:WMS' or $serviceType_value='OGC:WFS' or $serviceType_value='OGC:WCS') or ($serviceType_value='OGC:WMS' or $serviceType_value='OGC:WFS' or $serviceType_value='OGC:WCS' ) and $coupledResource_scopedName">Coupled resource scoped name is verplicht als het service type  'OGC:WMS', 'OGC:WFS' of  'OGC:WCS' is</sch:assert>
			<sch:report test="($serviceType_value='OGC:WMS' or $serviceType_value='OGC:WFS' or $serviceType_value='OGC:WCS' ) and $coupledResource_scopedName">Coupled resource scoped name: <sch:value-of select="$coupledResource_scopedName"/></sch:report>
			
-->
			<!-- alle regels over elementen binnen gmd:referenceSystemInfo -->
			<!-- LVDB verwijderd 
		    <sch:let name="referenceSystemInfo" value="gmd:referenceSystemInfo"/>
			<sch:assert test="$referenceSystemInfo">Er is geen referenceSystemInfo opgegeven (ISO nr. 13). Dit element bevat vereiste elementen uit de kernset.</sch:assert>
			-->
			<!-- alle regels over elementen binnen gmd:distributorContact -->
			<!-- LVDB verwijderd
			<sch:let name="distributorContact" value="gmd:distributionInfo/*/gmd:distributor/*/gmd:distributorContact/gco:CharacterString"/>
			<sch:assert test="$distributorContact">Er is geen distributorContact opgegeven (ISO nr. 250). Dit element bevat vereiste elementen uit de kernset.</sch:assert>
			-->
			
			<!-- alle regels over elementen binnen gmd:dataQualityInfo -->
			<sch:let name="dataQualityInfo" value="gmd:dataQualityInfo/gmd:DQ_DataQuality"/>
			<sch:let name="level" value="string($dataQualityInfo/gmd:scope/gmd:DQ_Scope/gmd:level/*/@codeListValue[. = 'service'])"/>
			<!-- rules and assertions -->
			
			<!-- new -->
			<sch:assert test="$level">Niveau kwaliteitsbeschrijving (ISO nr.139) ontbreekt</sch:assert>
			<!-- new -->
			<sch:report test="$level">Niveau kwaliteitsbeschrijving (ISO nr.139): <sch:value-of select="$level"/>
			</sch:report>
			
			<!--  Conformiteitindicatie met de specificatie -->
			<!-- Specificatie title -->
			<sch:let name="conformity_SpecTitle" value="normalize-space(gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
			<sch:let name="conformity_Explanation" value="normalize-space(gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString)"/>
			<!-- Specificatie date -->
			<sch:let name="conformity_Date" value="matches(gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="conformity_Datetype" value="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/*[@codeListValue='creation' or @codeListValue='publication' or @codeListValue='revision']"/>
			<sch:let name="conformity_SpecCreationDate" value="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/*"/>
			<sch:let name="conformity_SpecPublicationDate" value="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/*"/>
			<sch:let name="conformity_SpecRevisionDate" value="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/*"/>
			<sch:let name="conformity_Pass" value="normalize-space(gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean)"/>
			
			<!-- als title is ingevuld, moeten date, datetype, explanation en pass ingevuld zijn -->
			<!-- Specificatie title  INSPIRE
			<sch:assert test="not($conformity_SpecTitle and not(contains($conformity_SpecTitle, 'INSPIRE Data Specification on')))">Specificatie (ISO nr. 360) verwijst niet naar een INSPIRE dataspecificatie die start met 'INSPIRE Data Specification on'.</sch:assert>
			-->
			<!-- Specificatie title NL profiel -->
			
			<sch:assert test="not($conformity_SpecTitle) or ($conformity_SpecTitle and $conformity_Explanation)">Verklaring (ISO nr. 131) is verplicht als een specificatie is opgegeven.</sch:assert>
			<sch:assert test="not($conformity_SpecTitle and not($conformity_Date))">Datum (ISO nr. 394) is verplicht als een specificatie is opgegeven. </sch:assert>
			<sch:assert test="not($conformity_SpecTitle and not($conformity_Datetype))">Datumtype (ISO nr. 395) is verplicht als een specificatie is opgegeven. </sch:assert>
			<sch:assert test="not($conformity_SpecTitle) or (string-length($conformity_SpecTitle) &gt; 0 and $conformity_Pass)">Conformiteit (ISO nr. 132) is verplicht als een specificatie is opgegeven.</sch:assert>
		
		<!-- als er geen titel is ingevuld, moeten date, dattype explanation en pass leeg zijn -->
			<sch:assert test="not($conformity_Explanation) or ($conformity_Explanation and $conformity_SpecTitle)">Verklaring (ISO nr. 131) hoort leeg als geen specificatie is opgegeven</sch:assert>
			<sch:assert test="not($conformity_Date and not($conformity_SpecTitle))">Datum (ISO nr. 394)  hoort leeg als geen specificatie is opgegeven.. </sch:assert>
			<sch:assert test="not($conformity_Datetype and not($conformity_SpecTitle))">Datumtype (ISO nr. 395) hoort leeg als geen specificatie is opgegeven.. </sch:assert>
			<!-- removed on request by Ine, GeoCat issue 3193
			<sch:assert test="not($conformity_Pass) or ($conformity_Pass and $conformity_SpecTitle)">Conformiteit (ISO nr. 132) hoort leeg als geen specificatie is opgegeven..</sch:assert>
			-->
            <!-- removed on request by Ine, GeoCat issue 172 			
			<sch:report test="not($conformity_Explanation)">Waarschuwing: Verklaring (ISO nr. 131) is verplicht als de dataset een INSPIRE bron is of als de informatie is gemodelleerd volgens een specifiek informatiemodel.</sch:report>
			-->
			<sch:report test="$conformity_Explanation">Verklaring (ISO nr. 131): <sch:value-of select="$conformity_Explanation"/></sch:report>
		</sch:rule>		

        <!-- Spatial resolution equivalentScale -->
        <sch:rule context="//gmd:spatialResolution/*/gmd:equivalentScale/*">
            <!-- Toepassingsschaal -->
            <sch:let name="denominator" value="gmd:denominator/*/text()"/>
            <!-- assertions and reports -->
            <!--idv  is conditioneel en de conditie is niet te testen, dus geen assert -->
        	<!-- LVDB verwijderd -->
            <!--<sch:assert test="$denominator">Toepassingsschaal (ISO nr. 57) ontbreekt</sch:assert>-->
            <sch:report test="$denominator">Toepassingsschaal (ISO nr. 57): <sch:value-of select="$denominator"/>
            </sch:report>
        </sch:rule>
        <!-- Spatial resolution distance 
        <sch:rule context="//gmd:spatialResolution/*/gmd:distance/gco:Distance">
            <sch:let name="distance" value="text()"/>
            <sch:let name="distance_UOM" value="@uom"/>
            <sch:assert test="not(string(number($distance))='NaN')">Distance (ISO nr. 61) is een  nummer</sch:assert>
            <sch:report test="$distance">Distance (ISO nr. 61) is: <sch:value-of select="$distance"/>
            </sch:report>
            <sch:assert test="$distance and $distance_UOM">Unit of measure voor de distance ontbreekt.</sch:assert>
            <sch:report test="$distance_UOM">Unit of measure voor de  distance: <sch:value-of select="$distance_UOM"/>
            </sch:report>
        </sch:rule>
        -->
        <!-- Controlled originating vocabulary -->
        <sch:rule context="//gmd:descriptiveKeywords/*/gmd:thesaurusName/*">
            <!--Thesaurus title -->
        	<sch:let name="thesaurus_Title" value="normalize-space(gmd:title/gco:CharacterString)"/>
            <!--Thesaurus date -->
        	<sch:let name="thesaurus_PublicationDate" value="matches(gmd:date[./*/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
        	<sch:let name="thesaurus_CreationDate" value="matches(gmd:date[./*/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
        	<sch:let name="thesaurus_RevisionDate" value="matches(gmd:date[./*/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
            <sch:report test="$thesaurus_Title">Thesaurus title (ISO nr. 360) is: <sch:value-of select="$thesaurus_Title"/></sch:report>
        	<sch:assert test="not($thesaurus_Title) or ($thesaurus_Title and ($thesaurus_CreationDate or $thesaurus_PublicationDate or $thesaurus_RevisionDate))">Als er gebruik wordt gemaakt van een thesaurus dient de datum (ISO nr.394) en datumtype (ISO nr. 395) opgegeven te worden. Datum formaat moet YYYY-MM-DD zijn.</sch:assert>
            <sch:report test="$thesaurus_CreationDate or $thesaurus_PublicationDate or $thesaurus_RevisionDate">Thesaurus Date (ISO nr. 394) en thesaurus date type (ISO nr. 395) zijn aanwezig</sch:report>
        </sch:rule>
        <sch:rule context="//gmd:distributionInfo/*/gmd:transferOptions/*/gmd:onLine">
            <!-- URL -->
        	<sch:let name="transferOptions_URL" value="normalize-space(gmd:CI_OnlineResource/gmd:linkage/gmd:URL)"/>
            <!-- Protocol -->
            <sch:let name="transferOptions_Protocol" value="gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:CSW' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WMS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WFS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WCS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WCTS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WPS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'UKST' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WMC' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:KML' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:GML' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WFS-G' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:SOS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:SPS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:SAS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WNS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:ODS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:OGS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:OUS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:OPS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:ORS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'website' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'OGC:WMTS' or gmd:CI_OnlineResource/gmd:protocol/*/text() = 'download'"/>
            <!-- Naam -->
        	<sch:let name="transferOptions_Name" value="normalize-space(gmd:name/gco:CharacterString)"/>
            <!-- asssertions and report -->
              <sch:assert test="string-length($transferOptions_URL) &gt; 0">resource locator (ISO nr. 397) ontbreekt</sch:assert>
            <sch:report test="$transferOptions_URL">resource locator (ISO nr. 397): <sch:value-of select="$transferOptions_URL"/>
            </sch:report>

          <sch:assert test="$transferOptions_Protocol">Transfer options protocol (ISO nr. 398) mist of heeft de verkeerde waarde</sch:assert>
            <sch:report test="$transferOptions_Protocol">Transfer options protocol (ISO nr. 398) is aanwezig: <sch:value-of select="gmd:protocol/*/text()"/>
            </sch:report>
            <!--<sch:assert test="$transferOptions_Name">Transfer options name (ISO nr. 400) is mandatory if a URL is provided</sch:assert>-->
            <sch:report test="$transferOptions_Name">Transfer options name (ISO nr. 400) is present: <sch:value-of select="$transferOptions_Name"/>
            </sch:report>
        </sch:rule>
        <!-- INSPIRE Conformity -->
       
        <!-- use a general format check for dates in ISO tags -->
        <!-- idv eruit als mogelijk, liefst specifieke meldingen -->
		<!-- LVDB gedaan -->
		<!-- <sch:rule context="gco:Date">
			<sch:let name="date" value="."/>
			<sch:assert test="matches($date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>Een datum staat in het verkeerde formaat: <sch:value-of select="$date">. Het formaat moet zijn JJJJ-MM-DD.</sch:assert>			
		</sch:rule> -->
		<!-- check also the GML tags on date format
		<sch:rule context="gml:timePosition">
			<sch:let name="date" value="."/>
			<sch:assert test="matches($date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')">Een datum staat in het verkeerde formaat: <sch:value-of select="$date"/>. Het formaat moet zijn JJJJ-MM-DD.</sch:assert>			
		</sch:rule> -->
		<!-- check if a dataset reference date has a codetype from the list
		<sch:rule context="gmd:dateType">
			<sch:let name="dateType" value="./*/@codeListValue"/>
			<sch:assert test="$dateType='creation' or $dateType='publication' or $dateType='revision' ">Datum type is onjuist: <sch:value-of select="$dateType"/>. Het attribuut bij datum type (ISO nr. 395) moet een waarde uit de volgende codelijst zijn: creation, publication, revision.</sch:assert>
		</sch:rule> -->
	</sch:pattern>
</sch:schema>
