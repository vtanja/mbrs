package com.example.demo.model;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class ${name}{
<#if identityProp??>
    @Id
  <#if identityProp.strategy == "identity" >
	@GeneratedValue(strategy = GenerationType.IDENTITY)
  <#elseif identityProp.strategy == "table" >
	@GeneratedValue(strategy = GenerationType.TABLE)
  <#elseif identityProp.strategy == "auto" >
    @GeneratedValue
   <#else>
	@GeneratedValue(generator = "sequence-generator")
	@GenericGenerator(
		name = "sequence-generator",
		strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator"
	)	 
  </#if>
    ${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	@Column
	${prop.visibility} ${prop.type.name} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
<#list oneToManyProps as prop>
   @OneToMany(mappedBy = "${prop.mappedBy}", cascade = CascadeType.${prop.cascade})
   ${prop.visibility} Set<${prop.type.name}> ${prop.name};
</#list>
<#list manyToOneProps as prop>
   @ManyToOne
   @JoinColumn(name = "${prop.columnName}")
   ${prop.visibility} ${prop.type.name} ${prop.name};
</#list>
<#list oneToOneProps as prop>
   @OneToOne
   ${prop.visibility} ${prop.type.name} ${prop.name};
</#list>
<#list manyToManyProps as prop>
   <#if prop.mappedBy?? && prop.mappedBy == "">
   @ManyToMany
   @JoinTable
   ${prop.visibility} Set<${prop.type.name}> ${prop.name};
   <#else>
   @ManyToMany(mappedBy = "${prop.mappedBy}")
   ${prop.visibility} Set<${prop.type.name}> ${prop.name};
   </#if>
</#list>

}