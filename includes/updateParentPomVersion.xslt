<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pom="http://maven.apache.org/POM/4.0.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <!-- This is an identity template - it copies everything
    that doesn't match another template -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Replace the pom's project version -->
    <xsl:template match="/pom:project/pom:parent[PARENT_ARTIFACT_CONDITION]/pom:version">
        <xsl:element name="version" namespace="{namespace-uri()}">
            <xsl:text>PROJECT_VERSION</xsl:text>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>

