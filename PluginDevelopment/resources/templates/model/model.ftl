package com.example.demo.dto;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

<#list importedPackages as import>
<#if import.typePackage != "">
import ${import.typePackage}.${import.name};
</#if>
</#list>

@Getter;
@Setter;
@AllArgsConstructor;
@NoArgsConstructor;
public class ${name}{
}