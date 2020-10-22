<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
   <pattern>
        <let name="cast-characters" value="//cast/character/@id"/>
        <let name="body-characters" value="//body//character/@ref"/>
        <rule context="cast/character">
            <assert test="@id = $body-characters">The @id "<value-of select="@id"/>" 
                occurs in the cast list, but not in the body.</assert>
        </rule>
        <rule context="body//character">
            <assert test="@ref">The character "<value-of select="."/>" is missing its @ref
                attribute.</assert>
            <assert
                test="every $i in tokenize(normalize-space(@ref),'\s+') satisfies $i = $cast-characters"
                >The @ref "<value-of select="@ref"/>" occurs in the body, but not in the cast
                list.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="cast">
            <let name="ccount" value="count(character)"/>
            <let name="fcount" value="count(faction)"/>
            <let name="gfcount" value="count(faction[@alignment = 'good'])"/>
            <let name="efcount" value="count(faction[@alignment = 'evil'])"/>
            <report
                test="."
                >There are <value-of select="$ccount"/> characters in the cast.</report>
            <report
                test="."
                >There are <value-of select="$fcount"/> factions in the cast.</report>
            <report
                test="."
                >There are <value-of select="$gfcount"/> good factions in the cast.</report>
            <report
                test="."
                >There are <value-of select="$efcount"/> evil factions in the cast.</report>
        </rule>
    </pattern>
</schema>