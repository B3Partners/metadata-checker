<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
	<sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
	<sch:ns uri="http://www.isotc211.org/2005/gco" prefix="gco"/>
	<sch:ns uri="http://www.opengis.net/gml" prefix="gml"/>
	<sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
	<sch:ns uri="http://www.w3.org/2004/02/skos/core#" prefix="skos"/>
	<sch:let name="lowercase" value="'abcdefghijklmnopqrstuvwxyz'"/>
	<sch:let name="uppercase" value="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<!-- werkt nog niet
	<sch:let name="gemet-nl" value="document('GEMET-InspireThemes-nl.rdf')"/>
	-->
	<sch:pattern name="DutchMetadataCoreSet">
		<sch:title>Validatie van metadata op de verplichte kernset volgens de Nederlandse metadatastandaard voor geografie.</sch:title>
		<sch:rule context="/gmd:MD_Metadata">
			<!-- Namespace declaration -->
			<sch:assert test="contains(normalize-space(@xsi:schemaLocation), 'http://www.isotc211.org/2005/gmd ')">Het ISO 19139 XML document mist een verplichte schema namespace. De schema namespace http://www.isotc211.org/2005/gmd moet aanwezig zijn.
			</sch:assert>
			<sch:report test="contains(normalize-space(@xsi:schemaLocation), 'http://www.isotc211.org/2005/gmd ')">Het ISO 19139 XML document bevat de schema namespace http://www.isotc211.org/2005/gmd
			</sch:report>
			<!-- Thijs: added fileIdentifier for report -->
			<sch:let name="fileIdentifier" value="normalize-space(gmd:fileIdentifier/gco:CharacterString)"/>
            <!-- Metadata taal
			<sch:let name="mdLanguage" value="normalize-space(gmd:language/gco:CharacterString)"/>
-->
			<sch:let name="mdLanguage" value="(gmd:language/*/@codeListValue = 'dut')"/>
            		<sch:let name="mdLanguage_value" value="string(gmd:language/*/@codeListValue)"/>

			<!-- Metadata hiërarchielevel variable  -->
			<sch:let name="hierarchyLevel" value="(gmd:hierarchyLevel[1]/*/@codeListValue = 'dataset' or gmd:hierarchyLevel[1]/*/@codeListValue = 'series')"/>
            <sch:let name="hierarchyLevel_value" value="gmd:hierarchyLevel[1]/*/@codeListValue"/>
            <!-- Beschrijving hiërarchisch niveau -->
			<sch:let name="hierarchyLevelName" value="normalize-space(gmd:hierarchyLevelName/gco:CharacterString)"/>
			<!-- Metadata verantwoordelijke organisatie (name) -->
			<sch:let name="mdResponsibleParty_Organisation" value="normalize-space(gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString)"/>
			<!-- Metadata verantwoordelijke organisatie (role) NL profiel -->
			<sch:let name="mdResponsibleParty_Role" value="gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'resourceProvider' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'custodian' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'owner' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'user' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'distributor' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'owner' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'originator' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'pointOfContact' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'principalInvestigator' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'processor' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'publisher' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'author'"/>
			<!-- alleen met de voor INSPIRE toegestane waarde
			<sch:let name="mdResponsibleParty_Role" value="gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'pointOfContact' "/>
			-->
			<!-- Metadata verantwoordelijke organisatie (url) -->
			<sch:let name="mdResponsibleParty_Mail" value="normalize-space(gmd:contact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString)"/>
            <!-- Metadata datum -->
			<sch:let name="dateStamp" value="normalize-space(gmd:dateStamp/gco:Date)"/>
			<!-- Metadatastandaard naam -->
			<sch:let name="metadataStandardName" value="translate(normalize-space(gmd:metadataStandardName/gco:CharacterString), $lowercase, $uppercase)"/>
			<!-- Versie metadatastandaard naam -->
			<sch:let name="metadataStandardVersion" value="translate(normalize-space(gmd:metadataStandardVersion/gco:CharacterString), $lowercase, $uppercase)"/>
			<!-- Metadata karakterset -->
			<sch:let name="metadataCharacterset" value="normalize-space(gmd:characterSet/*/@codeListValue)"/>
			<sch:let name="metadataCharacterset_value" value="gmd:characterSet/*[@codeListValue ='ucs2' or @codeListValue ='ucs4' or @codeListValue ='utf7' or @codeListValue ='utf8' or @codeListValue ='utf16' or @codeListValue ='8859part1' or @codeListValue ='8859part2' or @codeListValue ='8859part3' or @codeListValue ='8859part4' or @codeListValue ='8859part5' or @codeListValue ='8859part6' or @codeListValue ='8859part7' or @codeListValue ='8859part8' or @codeListValue ='8859part9' or @codeListValue ='8859part10' or @codeListValue ='8859part11' or  @codeListValue ='8859part12' or @codeListValue ='8859part13' or @codeListValue ='8859part14' or @codeListValue ='8859part15' or @codeListValue ='8859part16' or @codeListValue ='jis' or @codeListValue ='shiftJIS' or @codeListValue ='eucJP' or @codeListValue ='usAscii' or @codeListValue ='ebcdic' or @codeListValue ='eucKR' or @codeListValue ='big5' or @codeListValue ='GB2312']"/>


			<!-- rules and assertions -->
			<!-- Thijs: check for elements that are in schematron rules. If these are not available, the schematron rules aren't applied, so we have to give an error then. -->

			<!-- change in version 1.5 - Ine - removed - in v 1.6 lvdb re-added, message changed - 1.7 lvdb message changed-->
			<sch:let name="referenceSystemInfo" value="gmd:referenceSystemInfo"/>
			<sch:assert test="$referenceSystemInfo">Code referentiesysteem (ISO nr. 207) ontbreekt en verantwoordelijke organisatie voor namespace referentiesysteem (ISO nr. 208.1) ontbreekt</sch:assert>

			<!-- alle regels over elementen binnen gmd:dataQualityInfo -->
			<sch:let name="dataQualityInfo" value="gmd:dataQualityInfo/gmd:DQ_DataQuality"/>
			<!-- Algemene beschrijving herkomst  -->
			<sch:let name="statement" value="normalize-space($dataQualityInfo/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString)"/>
			<!--  Niveau kwaliteitsbeschrijving  -->
			<!-- new -->
			<sch:let name="level" value="string($dataQualityInfo/gmd:scope/gmd:DQ_Scope/gmd:level/*/@codeListValue[. = 'dataset' or . = 'series' or . = 'featureType'])"/>
			<!-- rules and assertions -->
			<sch:assert test="$statement">Algemene beschrijving herkomst (ISO nr. 83) ontbreekt</sch:assert>
			<sch:report test="$statement">Algemene beschrijving herkomst (ISO nr. 83): <sch:value-of select="$statement"/>
			</sch:report>
			<!-- new -->
			<sch:assert test="$level">Niveau kwaliteitsbeschrijving (ISO nr.139) ontbreekt</sch:assert>
			<!-- new -->
			<sch:report test="$level">Niveau kwaliteitsbeschrijving (ISO nr.139): <sch:value-of select="$level"/>
			</sch:report>

			<!-- Thijs: begin change for fileIdentifier -->
			<sch:assert test="$fileIdentifier">Er is geen Metadata ID (ISO nr. 2) opgegeven.</sch:assert>
			<sch:report test="$fileIdentifier">Metadata ID: <sch:value-of select="$fileIdentifier"/>
			</sch:report>
            <!-- Thijs: end change -->
			<sch:assert test="$mdLanguage">De metadata taal (ISO nr. 3) ontbreekt of heeft een verkeerde waarde. Dit hoort een waarde en verwijzing naar de codelijst te zijn.</sch:assert>
			<sch:report test="$mdLanguage">Metadata taal (ISO nr. 3) voldoet </sch:report>
			<!-- 1.6 lvdb re-added hierarchylevel tests -->
			<sch:assert test="$hierarchyLevel">Metadata hierarchieniveau (ISO nr. 6) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$hierarchyLevel">Metadata hierarchieniveau (ISO nr. 6) voldoet</sch:report>
			<!-- als value series is moet name ingevuld zijn -->
            <sch:assert test="not($hierarchyLevel_value = 'series' and not($hierarchyLevelName))">Beschrijving hierarchisch niveau (ISO nr. 7) ontbreekt. Dit is verplicht als hierarchieniveau = 'series'.</sch:assert>
			<sch:report test="$hierarchyLevelName">Tenminste 1 beschrijving hierarchisch niveau (ISO nr. 7) is gevonden</sch:report>
			<sch:assert test="$mdResponsibleParty_Organisation">Naam organisatie metadata (ISO nr. 376) ontbreekt</sch:assert>
			<sch:report test="$mdResponsibleParty_Organisation">Naam organisatie metadata (ISO nr. 376): <sch:value-of select="$mdResponsibleParty_Organisation"/>
			</sch:report>
			<sch:assert test="$mdResponsibleParty_Role">Rol organisatie metadata (ISO nr. 379) ontbreekt of heeft een verkeerde waarde, deze dient voor INSPIRE contactpunt te zijn</sch:assert>
			<sch:report test="$mdResponsibleParty_Role">Rol organisatie metadata (ISO nr. 379) voldoet</sch:report>
			<!-- new -->
			<sch:assert test="$mdResponsibleParty_Mail">E-mail organisatie metadata (ISO nr. 386) ontbreekt</sch:assert>
			<!-- new -->
			<sch:report test="$mdResponsibleParty_Mail">E-mail organisatie metadata (ISO nr. 386): <sch:value-of select="$mdResponsibleParty_Mail"/>
			</sch:report>
			<sch:assert test="matches($dateStamp, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')">Metadata datum (ISO nr. 9) ontbreekt of heeft het verkeerde formaat (YYYY-MM-DD)</sch:assert>
			<sch:report test="$dateStamp">Metadata datum (ISO nr. 9): <sch:value-of select="$dateStamp"/>
		    </sch:report>

			<sch:assert test="$metadataStandardName = 'ISO 19115'">Metadatastandaard naam (ISO nr. 10) ontbreekt of is niet correct ingevuld</sch:assert>
			<sch:report test="$metadataStandardName">Metadatastandaard naam (ISO nr. 10): <sch:value-of select="$metadataStandardName"/>
			</sch:report>
			<sch:assert test="contains($metadataStandardVersion, 'PROFIEL OP ISO 19115')">Versie metadatastandaard naam (ISO nr. 11) ontbreekt of is niet correct ingevuld</sch:assert>
			<sch:report test="$metadataStandardVersion">Versie metadatastandaard naam (ISO nr. 11): <sch:value-of select="$metadataStandardVersion"/>
			</sch:report>
			<sch:assert test="not($metadataCharacterset) or $metadataCharacterset_value">Metadata karakterset (ISO nr. 4) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="not($metadataCharacterset) or $metadataCharacterset_value">Metadata karakterset (ISO nr. 4) voldoet</sch:report>

			<!-- alle regels over elementen binnen gmd:identificationInfo -->
			<!-- Dataset titel -->
			<sch:let name="datasetTitle" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
			<!-- Dataset referentie datum -->
			<sch:let name="publicationDate" value="matches(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/gmd:CI_Date/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="creationDate" value="matches(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/gmd:CI_Date/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="revisionDate" value="matches(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/gmd:CI_Date/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<!-- Samenvatting -->
			<sch:let name="abstract" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString)"/>
			<!-- Status -->
			<sch:let name="status" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/*[@codeListValue = 'completed' or @codeListValue = 'historicalArchive' or @codeListValue = 'obsolete' or @codeListValue = 'onGoing' or @codeListValue = 'planned' or @codeListValue = 'required' or @codeListValue = 'underDevelopment']"/>
			<!--  Verantwoordelijke organisatie bron -->
			<sch:let name="responsibleParty_Organisation" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString)"/>
			<!-- Verantwoordelijke organisatie bron: role -->
			<sch:let name="responsibleParty_Role" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:role/*[@codeListValue = 'resourceProvider' or @codeListValue = 'custodian' or @codeListValue = 'owner' or @codeListValue = 'user' or @codeListValue = 'distributor' or @codeListValue = 'owner' or @codeListValue = 'originator' or @codeListValue = 'pointOfContact' or @codeListValue = 'principalInvestigator' or @codeListValue = 'processor' or @codeListValue = 'publisher' or @codeListValue = 'author']"/>
			<!-- Dataset  verantwoordelijke organisatie (url) -->
			<!-- new -->
			<sch:let name="responsibleParty_Mail" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString)"/>
			<!-- Trefwoorden -->
			<sch:let name="keyword" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords[1]/gmd:MD_Keywords/gmd:keyword[1]/gco:CharacterString)"/>
			<!-- Unieke Identifier van de bron -->
			<!-- new -->
			<sch:let name="identifier" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString)"/>
			<!-- Ruimtelijk schema -->
			<sch:let name="spatialRepresentationType" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialRepresentationType/*[@codeListValue='vector' or @codeListValue='grid' or @codeListValue='textTable' or @codeListValue='tin' or @codeListValue='stereoModel' or @codeListValue='video']"/>
			<!-- Dataset taal -->
			<sch:let name="language" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:language/gco:CharacterString)"/>
			<!-- Dataset karakterset -->
			<sch:let name="characterset" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet/*/@codeListValue)"/>
			<sch:let name="characterset_value" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet/*[@codeListValue ='ucs2' or @codeListValue ='ucs4' or @codeListValue ='utf7' or @codeListValue ='utf8' or @codeListValue ='utf16' or @codeListValue ='8859part1' or @codeListValue ='8859part2' or @codeListValue ='8859part3' or @codeListValue ='8859part4' or @codeListValue ='8859part5' or @codeListValue ='8859part6' or @codeListValue ='8859part7' or @codeListValue ='8859part8' or @codeListValue ='8859part9' or @codeListValue ='8859part10' or @codeListValue ='8859part11' or  @codeListValue ='8859part12' or @codeListValue ='8859part13' or @codeListValue ='8859part14' or @codeListValue ='8859part15' or @codeListValue ='8859part16' or @codeListValue ='jis' or @codeListValue ='shiftJIS' or @codeListValue ='eucJP' or @codeListValue ='usAscii' or @codeListValue ='ebcdic' or @codeListValue ='eucKR' or @codeListValue ='big5' or @codeListValue ='GB2312']"/>
			<!-- Thema's  -->
			<sch:let name="topicCategory" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:topicCategory/*[text() = 'farming' or text() = 'biota' or text() = 'boundaries' or text() = 'climatologyMeteorologyAtmosphere' or text() = 'economy' or text() = 'elevation' or text() = 'environment' or text() = 'geoscientificInformation' or text() = 'health' or text() = 'imageryBaseMapsEarthCover' or text() = 'intelligenceMilitary' or text() = 'inlandWaters' or text() = 'location' or text() = 'oceans' or text() = 'planningCadastre' or text() = 'society' or text() = 'structure' or text() = 'transportation' or text() = 'utilitiesCommunication']"/>
			<!-- Gebruiksbeperkingen -->
			<sch:let name="useLimitation" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_Constraints/gmd:useLimitation/gco:CharacterString)"/>
			<!-- Overige beperkingen -->
			<!-- new -->
			<sch:let name="otherConstraints" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[1]/gmd:MD_LegalConstraints/gmd:otherConstraints[1]/gco:CharacterString)"/>
			<sch:let name="otherConstraints_value" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints"/>
			<!-- Veiligheidsrestricties -->
			<!-- new -->
			<sch:let name="classification_value" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_SecurityConstraints/gmd:classification/*[@codeListValue = 'unclassified' or @codeListValue = 'restricted' or @codeListValue = 'confidential' or @codeListValue = 'secret' or @codeListValue = 'topSecret']"/>
			<!-- (Juridische) toegangsrestricties  -->
			<sch:let name="accessConstraints_value" value="string(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints/*[@codeListValue = 'copyright' or @codeListValue = 'patent' or @codeListValue = 'patentPending' or @codeListValue = 'trademark' or @codeListValue = 'license' or @codeListValue = 'intellectualPropertyRights' or @codeListValue = 'restricted' or @codeListValue = 'otherRestrictions']/@codeListValue)"/>
			<!-- Omgrenzende rechthoek -->
			<sch:let name="west" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal)"/>
			<sch:let name="east" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:eastBoundLongitude/gco:Decimal)"/>
			<sch:let name="north" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:northBoundLatitude/gco:Decimal)"/>
			<sch:let name="south" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:southBoundLatitude/gco:Decimal)"/>
			<!-- Temporele dekking begin -->
			<sch:let name="begin_beginPosition" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/*/gml:beginPosition)"/>
			<sch:let name="begin_begintimePosition" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/*/gml:begin/*/gml:timePosition)"/>
			<sch:let name="begin_timePosition" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/*/gml:timePosition)"/>
			<!-- spatial resolution -->
			<sch:let name="spatialResolution" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialResolution"/>
			<!-- rules and assertions -->
			<sch:assert test="$datasetTitle">Dataset titel (ISO nr. 360) ontbreekt</sch:assert>
			<sch:report test="$datasetTitle">Dataset titel (ISO nr. 360): <sch:value-of select="$datasetTitle"/>
			</sch:report>
			<sch:assert test="$publicationDate or $creationDate or $revisionDate">Datum van de bron(ISO nr. 394) of Datatype (ISO nr.395) ontbreken of heeft het verkeerde formaat (YYYY-MM-DD)</sch:assert>
			<sch:report test="$publicationDate or $creationDate or $revisionDate">Tenminste 1 datum van de bron  (ISO nr. 394) is gevonden</sch:report>
			<sch:assert test="$abstract">Samenvatting (ISO nr. 25) ontbreekt</sch:assert>
			<sch:report test="$abstract">Samenvatting (ISO nr. 25): <sch:value-of select="$abstract"/>
			</sch:report>
			<sch:assert test="$status">Status (ISO nr. 28) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$status">Status (ISO nr. 28) voldoet</sch:report>
			<sch:assert test="$responsibleParty_Organisation">Verantwoordelijke organisatie bron (ISO nr. 376) ontbreekt</sch:assert>
			<sch:report test="$responsibleParty_Organisation">Verantwoordelijke organisatie bron (ISO nr. 376): <sch:value-of select="$responsibleParty_Organisation"/>
			</sch:report>
			<sch:assert test="$responsibleParty_Role">Rol verantwoordelijke organisatie bron (ISO nr. 379) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$responsibleParty_Role">Rol verantwoordelijke organisatie bron (ISO nr. 379) voldoet</sch:report>
			<!-- new -->
			<sch:assert test="$responsibleParty_Mail">E-mail verantwoordelijke organisatie bron (ISO nr. 386) ontbreekt</sch:assert>
			<sch:report test="$responsibleParty_Mail">E-mail verantwoordelijke organisatie bron (ISO nr. 386): <sch:value-of select="$responsibleParty_Mail"/>
			</sch:report>
			<sch:assert test="$keyword">Trefwoorden (ISO nr. 53) ontbreken</sch:assert>
			<sch:report test="$keyword">Tenminste 1 trefwoord (ISO nr. 53) is gevonden</sch:report>
			<!-- new -->
			<sch:assert test="$identifier">Unieke Identifier van de bron (ISO nr. 207) ontbreekt</sch:assert>
			<!-- new -->
			<sch:report test="$identifier">Unieke Identifier van de bron (ISO nr. 207): <sch:value-of select="$identifier"/>
			</sch:report>
			<!-- removed on request by Ine, GeoCat issue 3150
			<sch:report test="not($language)">Waarschuwing: Dataset taal (ISO nr. 39) is verplicht als de dataset tekstuele informatie bevat.</sch:report>
			-->
			<sch:report test="$language">Dataset taal (ISO nr. 39): <sch:value-of select="$language"/>
			</sch:report>
			<!-- change in version 1.3 -->
			<sch:assert test="not($characterset) or $characterset_value">Dataset karakterset (ISO nr. 40) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$characterset_value">Dataset karakterset (ISO nr. 40) voldoet</sch:report>
			<sch:assert test="$topicCategory">Onderwerp(ISO nr. 41) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="$topicCategory">Onderwerp (ISO nr. 41) voldoet</sch:report>
			<sch:assert test="(-180.00 &lt; $west) and ( $west &lt; 180.00) or ( $west = 0.00 ) or ( $west = -180.00 ) or ( $west = 180.00 )">Minimum x-coördinaat (ISO nr. 344) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="(-180.00 &lt; $west) and ( $west &lt; 180.00) or ( $west = 0.00 ) or ( $west = -180.00 ) or ( $west = 180.00 )">Minimum x-coördinaat (ISO nr. 344): <sch:value-of select="$west"/>
			</sch:report>
			<sch:assert test="(-180.00 &lt; $east) and ($east &lt; 180.00) or ( $east = 0.00 ) or ( $east = -180.00 ) or ( $east = 180.00 )">Maximum x-coördinaat (ISO nr. 345) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="(-180.00 &lt; $east) and ($east &lt; 180.00) or ( $east = 0.00 ) or ( $east = -180.00 ) or ( $east = 180.00 )">Maximum x-coördinaat (ISO nr. 345): <sch:value-of select="$east"/>
			</sch:report>
			<sch:assert test="(-90.00 &lt; $south) and ($south &lt; $north) or (-90.00 = $south) or ($south = $north)">Minimum y-coördinaat (ISO nr. 346) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="(-90.00 &lt; $south) and ($south &lt; $north) or (-90.00 = $south) or ($south = $north)">Minimum y-coördinaat (ISO nr. 346): <sch:value-of select="$south"/>
			</sch:report>
			<sch:assert test="($south &lt; $north) and ($north &lt; 90.00) or ($south = $north) or ($north = 90.00)">Maximum y-coördinaat (ISO nr. 347) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report test="($south &lt; $north) and ($north &lt; 90.00) or ($south = $north) or ($north = 90.00)">Maximum y-coördinaat (ISO nr. 347): <sch:value-of select="$north"/>
			</sch:report>
			<!-- optineel geworden in v1.3
			<sch:assert test="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition">Temporele dekking - BeginDatum (ISO nr. 351) ontbreekt</sch:assert>
			<sch:report test="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition">Temporele dekking - BeginDatum (ISO nr. 351): <sch:value-of select="$begin_beginPosition"/><sch:value-of select="$begin_begintimePosition"/><sch:value-of select="$begin_timePosition"/>
			</sch:report>
			 -->
			<sch:assert test="$useLimitation">Gebruiksbeperkingen (ISO nr. 68) ontbreken</sch:assert>
			<sch:report test="$useLimitation">Gebruiksbeperkingen (ISO nr. 68): <sch:value-of select="$useLimitation"/>
			</sch:report>

			<!-- new -->
			<sch:assert test="$accessConstraints_value or $otherConstraints or $classification_value">Minimaal een van (Juridische) toegangsrestricties (ISO nr. 70), Overige beperkingen (ISO nr 72) of Veiligheidsrestricties (ISO nr 74) dient ingevuld te zijn</sch:assert>
			<!-- new -->
			<!-- change in version 1.3 -->
			<sch:assert test="not($accessConstraints_value = 'otherRestrictions') or ($accessConstraints_value = 'otherRestrictions' and $otherConstraints)">Het element overige beperkingen (ISO nr. 72) dient een waarde te hebben als (juridische) toegangsrestricties (ISO nr. 70) de waarde 'anders' heeft</sch:assert>
			<!-- new -->
			<sch:report test="$otherConstraints">Overige beperkingen (ISO nr 72): <sch:value-of select="$otherConstraints_value"/></sch:report>
			<!-- new -->
			<sch:report test="$classification_value">Veiligheidsrestricties (ISO nr 74): <sch:value-of select="gmd:resourceConstraints/gmd:MD_SecurityConstraints/gmd:classification/*/@codeListValue"/></sch:report>
			<!--toegevoegd Ine-->
			<sch:report test="$accessConstraints_value">(Juridische) toegangsrestricties (ISO nr. 70) voldoet: <sch:value-of select="$accessConstraints_value"/></sch:report>
			<!-- new-->
			<!-- removed on request by Ine, GeoCat issue 3150
			<sch:report test="not($spatialResolution)">Waarschuwing: Toepassingsschaal (ISO nr. 57) is verplicht als hij gespecificeerd kan worden. </sch:report>
			-->

			<!-- alle regels over elementen binnen distributionInfo -->
			<!-- URL -->
			<!-- new -->
			<sch:let name="transferOptions_URL" value="normalize-space(gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[1]/gmd:CI_OnlineResource/gmd:linkage/gmd:URL)"/>
			<!-- Protocol -->
			<!-- new -->
			<sch:let name="transferOptions_Protocol" value="gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[1]/gmd:CI_OnlineResource/gmd:protocol/*[text() = 'OGC:CSW' or text() = 'OGC:WMS' or text() = 'OGC:WFS' or text() = 'OGC:WCS' or text() = 'OGC:WCTS' or text() = 'OGC:WPS' or text() = 'UKST' or text() = 'OGC:WMC' or text() = 'OGC:KML' or text() = 'OGC:GML' or text() = 'OGC:WFS-G' or text() = 'OGC:SOS' or text() = 'OGC:SPS' or text() = 'OGC:SAS' or text() = 'OGC:WNS' or text() = 'OGC:ODS' or text() = 'OGC:OGS' or text() = 'OGC:OUS' or text() = 'OGC:OPS' or text() = 'OGC:ORS' or text() = 'website' or text() = 'OGC:WMTS' or text() = 'dataset' or text() = 'download']"/>
			<sch:let name="transferOptions_Protocol_isOGCService" value="gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[1]/gmd:CI_OnlineResource/gmd:protocol/*[text() = 'OGC:WMS' or text() = 'OGC:WFS' or text() = 'OGC:WCS']"/>
			<!-- Naam -->
			<!-- new -->
			<sch:let name="transferOptions_Name" value="normalize-space(gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[1]/gmd:CI_OnlineResource/gmd:name)"/>
			<!-- asssertions and report -->
			<!-- new -->
			<sch:assert test="not($transferOptions_URL and not($transferOptions_Protocol))">Protocol (ISO nr. 398) is verplicht als URL (ISO nr. 397) is ingevuld.</sch:assert>
			<!-- removed on request by Ine, GeoCat issue 3150
			<sch:report test="not($transferOptions_URL)">Waarschuwing: URL (ISO nr. 397) is verplicht als er een link is naar (meer informatie over) de bron.</sch:report>
			-->
			<sch:report test="$transferOptions_URL"> URL (ISO nr. 397): <sch:value-of select="$transferOptions_URL"/>
			</sch:report>
			<!-- new -->
			<sch:report test="$transferOptions_Protocol">Protocol (ISO nr. 398): <sch:value-of select="$transferOptions_Protocol"/>
			</sch:report>
			<sch:assert test="($transferOptions_Protocol_isOGCService and $transferOptions_Name) or not($transferOptions_Protocol_isOGCService)">Naam (ISO nr. 400) is verplicht als  Protocol (ISO nr. 398) de waarde OGC:WMS, OGC:WFS of OGC:WCS heeft.</sch:assert>
			<!-- new -->
			<sch:report test="$transferOptions_Name">Naam (ISO nr. 400) is : <sch:value-of select="$transferOptions_Name"/>
			</sch:report>


        </sch:rule>


        <!-- alle regels over dataQualityInfo INSPIRE conformity -->
        <!--  Conformiteitindicatie met de specificatie -->
        <!-- new -->
        <!-- Verklaring 1.6 lvdb-->
        <sch:rule context="//gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report">
			<!-- Specificatie title -->
			<sch:let name="conformity_SpecTitle" value="normalize-space(gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
			<sch:let name="conformity_Explanation" value="normalize-space(gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString)"/>
			<!-- Specificatie date -->
			<sch:let name="conformity_Date" value="matches(gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="conformity_Datetype" value="gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/*[@codeListValue='creation' or @codeListValue='publication' or @codeListValue='revision']"/>
			<sch:let name="conformity_SpecCreationDate" value="gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/*"/>
			<sch:let name="conformity_SpecPublicationDate" value="gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/*"/>
			<sch:let name="conformity_SpecRevisionDate" value="gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/*"/>
			<sch:let name="conformity_Pass" value="normalize-space(gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean)"/>

			<!-- als title is ingevuld, moeten date, datetype, explanation en pass ingevuld zijn -->
			<!-- Specificatie titel alleen voor INSPIRE
			<sch:assert test="not($conformity_SpecTitle and not(contains($conformity_SpecTitle, 'INSPIRE Data Specification on')))">Specificatie (ISO nr. 360) verwijst niet naar een INSPIRE dataspecificatie die start met 'INSPIRE Data Specification on'.</sch:assert>
			-->
			<sch:assert test="not($conformity_SpecTitle) or ($conformity_SpecTitle and $conformity_Explanation)">Verklaring (ISO nr. 131) is verplicht als een specificatie is opgegeven.</sch:assert>
			<sch:assert test="not($conformity_SpecTitle and not($conformity_Date))">Datum (ISO nr. 394) is verplicht als een specificatie is opgegeven. </sch:assert>
			<sch:assert test="not($conformity_SpecTitle and not($conformity_Datetype))">Datumtype (ISO nr. 395) is verplicht als een specificatie is opgegeven. </sch:assert>
			<sch:assert test="not($conformity_SpecTitle) or (string-length($conformity_SpecTitle) &gt; 0 and $conformity_Pass)">Conformiteit (ISO nr. 132) is verplicht als een specificatie is opgegeven.</sch:assert>

		<!-- als er geen titel is ingevuld, moeten date, dattype explanation en pass leeg zijn -->
			<sch:assert test="not($conformity_Explanation) or ($conformity_Explanation and $conformity_SpecTitle)">Verklaring (ISO nr. 131) hoort leeg als geen specificatie is opgegeven</sch:assert>
			<sch:assert test="not($conformity_Date and not($conformity_SpecTitle))">Datum (ISO nr. 394)  hoort leeg als geen specificatie is opgegeven.. </sch:assert>
			<sch:assert test="not($conformity_Datetype and not($conformity_SpecTitle))">Datumtype (ISO nr. 395) hoort leeg als geen specificatie is opgegeven.. </sch:assert>
<!-- removed on request by Ine (geocat redmine issue 3151)
			<sch:assert test="not($conformity_Pass) or ($conformity_Pass and $conformity_SpecTitle)">Conformiteit (ISO nr. 132) hoort leeg als geen specificatie is opgegeven..</sch:assert>
-->

			<!-- removed on request by Ine, GeoCat issue 3150
			<sch:report test="not($conformity_Explanation)">Waarschuwing: Verklaring (ISO nr. 131) is verplicht als de dataset een INSPIRE bron is of als de informatie is gemodelleerd volgens een specifiek informatiemodel.</sch:report>
			-->
			
			<sch:report test="$conformity_Explanation">Verklaring (ISO nr. 131): <sch:value-of select="$conformity_Explanation"/></sch:report>
			<!-- change in version 1.3 -->
			<!--<sch:assert test="$conformity_Pass">Conformity (ISO nr. 132) is mandatory</sch:assert>-->
			<!-- new -->
			<sch:report test="$conformity_Pass">Conformiteitindicatie met de specificatie (ISO nr. 132): <sch:value-of select="$conformity_Pass"/></sch:report>
			<!-- new -->
			<!-- change in version 1.3 -->
			<!--<sch:assert test="$conformity_SpecTitle">Specificatie (ISO nr. 360) ontbreekt</sch:assert>-->
			<!-- new -->
			<sch:report test="$conformity_SpecTitle">Specificatie (ISO nr. 360): <sch:value-of select="$conformity_SpecTitle"/>
			</sch:report>
			<!-- new -->
			<!-- change in version 1.3 -->
			<!--<sch:assert test="$conformity_SpecCreationDate or $conformity_SpecPublicationDate or $conformity_SpecRevisionDate">A date (ISO nr. 394) and a date type (ISO nr. 395) has to be defined.</sch:assert>-->
			<!-- new -->
			<sch:report test="$conformity_SpecCreationDate or $conformity_SpecPublicationDate or $conformity_SpecRevisionDate">Datum (ISO nr. 394) en datum type (ISO nr. 395) is aanwezig voor specificatie.</sch:report>
		</sch:rule>

        <!-- Spatial resolution equivalentScale -->
		<sch:rule context="//gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction">
            <!-- Toepassingsschaal -->
            <sch:let name="denominator" value="normalize-space(gmd:denominator)"/>
            <!-- assertions and reports -->
			<!-- removed on request by Ine, GeoCat issue 3150
            <sch:report test="not($denominator)">Waarschuwing: Toepassingsschaal (ISO nr. 57) is verplicht als hij gespecificeerd kan worden. </sch:report>
			-->
            <sch:report test="$denominator">Toepassingsschaal (ISO nr. 57): <sch:value-of select="$denominator"/>
            </sch:report>
        </sch:rule>
        <!-- Spatial resolution distance -->
		<sch:rule context="//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance">
        	<!-- new -->
            <sch:let name="distance" value="text()"/>
            <!-- new -->
            <sch:let name="distance_UOM" value="string(@uom)"/>
            <!-- new -->
            <sch:assert test="not(string(number($distance))='NaN')">Resolutie (ISO nr. 61) is numeriek</sch:assert>
            <!-- new -->
            <sch:report test="$distance">Resolutie (ISO nr. 61) is: <sch:value-of select="$distance"/>
            </sch:report>
            <!-- new -->
            <sch:assert test="$distance and $distance_UOM">Unit of measure voor resolutie ontbreekt</sch:assert>
            <!-- new DISABLED -->
            <sch:report test="$distance_UOM">Unit of measure voor resolutie: <sch:value-of select="concat('',$distance_UOM)"/>
            </sch:report>

        </sch:rule>
        <!-- Controlled originating vocabulary -->
		<sch:rule context="//gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation">
            <!--Thesaurus title -->
            <!-- changed okt 2011 -->
			<sch:let name="all_thesaurus_Titles" value="ancestor::gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title"/>
			<sch:let name="thesaurus_Title" value="normalize-space(gmd:title/gco:CharacterString)"/>

        	<!--Thesaurus date -->
            <!-- new -->
			<sch:let name="thesaurus_PublicationDate" value="matches(gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="thesaurus_CreationDate" value="matches(gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
			<sch:let name="thesaurus_RevisionDate" value="matches(gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/gco:Date, '^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')"/>
            <!-- Thesaurus titel alleen voor INSPIRE
        	<sch:assert test="$all_thesaurus_Titles[normalize-space(*/text()) = 'GEMET - INSPIRE themes, version 1.0']">Voor INSPIRE is het verplicht om minstens 1 keyword uit de GEMET INSPIRE themes thesaurus op te nemen.</sch:assert>
            <sch:report test="$thesaurus_Title">Thesaurus title (ISO nr. 360) is: <sch:value-of select="$thesaurus_Title"/></sch:report>
         -->
        	<sch:assert test="not($thesaurus_Title) or ($thesaurus_Title and ($thesaurus_CreationDate or $thesaurus_PublicationDate or $thesaurus_RevisionDate))">Als er gebruik wordt gemaakt van een thesaurus dient de datum (ISO nr.394) en datumtype (ISO nr. 395) opgegeven te worden. Datum formaat moet YYYY-MM-DD zijn.</sch:assert>
            <!-- new
            <sch:assert test="$thesaurus_PublicationDate">Datum  type (ISO nr. 395) voor de thesaurus is niet correct.</sch:assert>
            -->
		</sch:rule>

		<!-- Controlled originating vocabulary - INSPIRE Specific -->
		<sch:rule context="//gmd:descriptiveKeywords
			[normalize-space(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title) = 'GEMET - INSPIRE themes, version 1.0']
			/gmd:MD_Keywords/gmd:keyword">

	            <sch:assert test="((normalize-space(current())='Administratieve eenheden'
)
		        or (normalize-space(current())='Adressen'
)
		        or (normalize-space(current())='Atmosferische omstandigheden'
)
		        or (normalize-space(current())='Beschermde gebieden'
)
		        or (normalize-space(current())='Biogeografische gebieden'
)
		        or (normalize-space(current())='Bodem')
		         or (normalize-space(current())='Bodemgebruik')
		         or (normalize-space(current())='Energiebronnen')
		         or (normalize-space(current())='Faciliteiten voor landbouw en aquacultuur')
		         or (normalize-space(current())='Faciliteiten voor productie en industrie')
		         or (normalize-space(current())='Gebieden met natuurrisico es')
		         or (normalize-space(current())='Gebiedsbeheer, gebieden waar beperkingen gelden, gereguleerde gebieden en rapportage-eenheden')
		         or (normalize-space(current())='Gebouwen')
		         or (normalize-space(current())='Geografisch rastersysteem')
		         or (normalize-space(current())='Geografische namen')
		         or (normalize-space(current())='Geologie')
		         or (normalize-space(current())='Habitats en biotopen')
		         or (normalize-space(current())='Hoogte')
		         or (normalize-space(current())='Hydrografie')
		         or (normalize-space(current())='Kadastrale percelen')
		         or (normalize-space(current())='Landgebruik')
		         or (normalize-space(current())='Menselijke gezondheid en veiligheid')
		         or (normalize-space(current())='Meteorologische geografische kenmerken')
		         or (normalize-space(current())='Milieubewakingsvoorzieningen')
		         or (normalize-space(current())='Minerale bronnen')
		         or (normalize-space(current())='Nutsdiensten en overheidsdiensten')
		         or (normalize-space(current())='Oceanografische geografische kenmerken')
		         or (normalize-space(current())='Orthobeeldvorming')
		         or (normalize-space(current())='Spreiding van de bevolking — demografie')
		         or (normalize-space(current())='Spreiding van soorten')
		         or (normalize-space(current())='Statistische eenheden')
		         or (normalize-space(current())='Systemen voor verwijzing door middel van coördinaten')
		         or (normalize-space(current())='Vervoersnetwerken')
		         or (normalize-space(current())='Zeegebieden'))">
Deze keywords  moeten uit GEMET- INSPIRE themes thesaurus komen. gevonden keywords: <sch:value-of select="."/></sch:assert>

		       <!--  voor externe thesaurus
			<sch:assert test="$gemet-nl//skos:prefLabel[normalize-space(text()) = normalize-space(current())]">Keywords [<sch:value-of select="$gemet-nl//skos:prefLabel "/>]   moeten uit GEMET- INSPIRE themes thesaurus komen. gevonden keywords: <sch:value-of select="."/></sch:assert>
		          -->
		</sch:rule>

		<sch:rule context="//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem">
			<!-- Referentiesysteem (Code) -->
			<sch:let name="referenceSystemInfo_Code" value="normalize-space(gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString)"/>
			<!-- Referentiesysteem (Verantwoordelijke organisatie) -->
			<sch:let name="referenceSystemInfo_Organisation" value="normalize-space(gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString)"/>
			<sch:assert test="$referenceSystemInfo_Code">Code referentiesysteem (ISO nr. 207) ontbreekt</sch:assert>
			<sch:report test="$referenceSystemInfo_Code">Code referentiesysteem (ISO nr. 207): <sch:value-of select="$referenceSystemInfo_Code"/>
			</sch:report>
			<sch:assert test="$referenceSystemInfo_Organisation">Verantwoordelijke organisatie voor namespace referentiesysteem (ISO nr. 208.1) ontbreekt</sch:assert>
			<sch:report test="$referenceSystemInfo_Organisation">Verantwoordelijke organisatie voor namespace referentiesysteem (ISO nr. 208.1): <sch:value-of select="$referenceSystemInfo_Organisation"/>
			</sch:report>
        </sch:rule>

	</sch:pattern>
</sch:schema>
