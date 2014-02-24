<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	 xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	 xmlns:fn="http://www.w3.org/2005/xpath-functions"
	 xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
	 
	<xsl:param name="document-link"/>
	
	<xsl:template match="checked">
		<html>
			<head>
				<title>Metadata checker rapport</title>
				<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	border: 0px none white; 
	font-size: 9pt;
	font-family: Verdana, Tahoma, Arial, Helvetica, sans-serif;
}

th, td {
	font-size: 9pt;
}

hr {
	background-color: #1962a0;
	height: 3px;
	border: 0px none;
}
				
				</style>
			</head>
			<body>
				<h1>Metadata checker rapport</h1>

				<xsl:variable name="root" select="."/>
				<xsl:variable name="total" select="count(output)"/>
				Aantal documenten gecontroleerd: <xsl:value-of select="$total"/><br/>

				<xsl:variable name="schematrons" select="distinct-values(output/svrl:schematron-output/@schematron)"/>
				<p/>
				<table border="1" style="border-collapse: collapse">
					<tbody>
						<tr>
							<th>Schematron</th><th>Successvol</th><th>Gefaald</th>
						</tr>
						<xsl:for-each select="$schematrons">
							<xsl:variable name="schematron" select="."/>
							<tr>
								<td><xsl:value-of select="$schematron"/></td>
								<xsl:variable name="failed" select="count($root/output/svrl:schematron-output[@schematron=$schematron and svrl:failed-assert])"/>
								<td align="right"><xsl:value-of select="$total - $failed"/></td>
								<td align="right"><xsl:value-of select="$failed"/></td>
							</tr>
						</xsl:for-each>
						<p/>
						
					</tbody>
				</table>
				<p>Gefaalde tests:</p>
				<table border="1" style="border-collapse: collapse">
					<thead>
						<tr>
							<th>Record</th>
							<th>ID</th>
							<th>Titel</th>
							<th>Schematron</th>
							<th>location</th>
							<th>test</th>
							<th>text</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$root/output">
							<xsl:variable name="output" select="."/>
							<xsl:for-each select="$schematrons">
								<xsl:variable name="schematron" select="."/>
								<xsl:variable name="e" select="tokenize(.,'/')"/>
								<xsl:variable name="schematron-short" select="$e[position()= count($e)]"/>
								<xsl:for-each select="$output/svrl:schematron-output[@schematron=$schematron]/svrl:failed-assert">
									<tr>
										<td><xsl:value-of select="$output/@record"/></td>
										<td style="white-space: nowrap">
											<xsl:choose>
												<xsl:when test="$document-link">
													<a href="{concat($document-link,$output/@id)}" target="_blank">
														<xsl:value-of select="$output/@id"/>
													</a>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$output/@id"/>
												</xsl:otherwise>												
											</xsl:choose>
										</td>
										<td style="white-space: nowrap"><xsl:value-of select="$output/@title"/></td>
										<td style="white-space: nowrap"><xsl:value-of select="$schematron-short"/></td>
										<td style="white-space: nowrap"><xsl:value-of select="svrl:text"/></td>
										<td style="white-space: nowrap"><xsl:value-of select="@test"/></td>
										<td style="white-space: nowrap"><xsl:value-of select="@location"/></td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
