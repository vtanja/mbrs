// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.service;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import javassist.NotFoundException;
import java.util.*;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.example.${appName}.dto.${name}DetailDTO;
import com.example.${appName}.dto.${name}DTO;
import com.example.${appName}.model.${name};
import com.example.${appName}.repository.${name}Repository;

<#list importedPackages as import>
<#if import.typePackage == "">
import com.example.${appName}.model.${import.name};
import com.example.${appName}.dto.${import.name}DTO;
import com.example.${appName}.dto.${import.name}DetailDTO;
import com.example.${appName}.service.${import.name}Service;
</#if>
</#list>

@Service
public class  ${name}Service {
    @Autowired
    private  ${name}Repository  ${repository};
    
    <#list importedPackages as import>
	<#if import.typePackage == "">
	@Autowired
    private ${import.name}Service ${import.name?uncap_first}Service;
	</#if>
	</#list>

    public ResponseEntity<List<${name}DTO>> get${name}Page(int pageNo, int pageSize){
    	ModelMapper modelMapper = new ModelMapper();
        List<${name}DTO> dtoList = new ArrayList<${name}DTO>();
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<${name}> pagedResult = ${repository}.findAll(paging);
         
        if (pagedResult.hasContent()) {
            List<${name}> list = pagedResult.getContent();

            for (${name} ${name?uncap_first} : list)
            {
                ${name}DTO ${name?uncap_first}DTO = modelMapper.map(${name?uncap_first}, ${name}DTO.class);
                dtoList.add(${name?uncap_first}DTO);
            }

        }
        return new ResponseEntity<>(dtoList, HttpStatus.OK);
    }
    
    public ${name} getById(Long id){
        if (${repository}.findById(id).isPresent())
            return ${repository}.findById(id).get();
        else
            return null;
    }

    public ResponseEntity<${name}DetailDTO> get${name}(Long id){
    	ModelMapper modelMapper = new ModelMapper();
    	if(${repository}.findById(id).isPresent()){
    		${name} ${name?uncap_first} = ${repository}.findById(id).get();
    		${name}DetailDTO dto = modelMapper.map(${name?uncap_first}, ${name}DetailDTO.class);
        	return new ResponseEntity<>(dto, HttpStatus.OK);
    	}
    	else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    public List<${name}DTO>getAll(){
    	ModelMapper modelMapper = new ModelMapper();
        List<${name}> list = ${repository}.findAll();
        List<${name}DTO> dtoList = new LinkedList<>();
        for(${name} ${name?uncap_first}: list) {
            ${name}DTO ${name?uncap_first}Dto = modelMapper.map(${name?uncap_first}, ${name}DTO.class);
            dtoList.add(${name?uncap_first}Dto);
        }
        return dtoList;
    }

    public ResponseEntity<${name}DetailDTO> update${name}(Long id, ${name}DetailDTO ${name?uncap_first}Dto){
        ModelMapper modelMapper = new ModelMapper();
        
        ${name} ${name?uncap_first} = ${repository}.find${name}ById(id);
        if(${name?uncap_first} == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST); 
        }
        else {
    		<#list persistentProps as prop>
			${name?uncap_first}.set${prop.name?cap_first}(${name?uncap_first}Dto.get${prop.name?cap_first}());
			</#list>
			<#list linkedProps as prop>
			<#if prop.upper == 1 >
			${name?uncap_first}.set${prop.name?cap_first}(${prop.type.name?uncap_first}Service.getById(${name?uncap_first}Dto.get${prop.name?cap_first}().getId()));
			<#else>
			Set<${prop.type.name}> ${prop.name}Set = new HashSet<>();
			for(${prop.type.name}DTO item : ${name?uncap_first}Dto.get${prop.name?cap_first}()){
				${prop.type.name} ${prop.type.name?uncap_first} = ${prop.type.name?uncap_first}Service.getById(item.getId());
				${prop.name}Set.add(${prop.type.name?uncap_first});
			}
			${name?uncap_first}.set${prop.name?cap_first}(${prop.name}Set);
			</#if>
			</#list>
			${repository}.save(${name?uncap_first});
            return new ResponseEntity<>(modelMapper.map(${name?uncap_first}, ${name}DetailDTO.class), HttpStatus.OK); 
        }
    }

    public ResponseEntity<${name}DetailDTO> create(${name}DetailDTO ${name?uncap_first}Dto){
    	ModelMapper modelMapper = new ModelMapper();
        ${name} ${name?uncap_first} = new ${name}();
        <#list persistentProps as prop>
		${name?uncap_first}.set${prop.name?cap_first}(${name?uncap_first}Dto.get${prop.name?cap_first}());
		</#list>
		<#list linkedProps as prop>
		<#if prop.upper == 1 >
		${name?uncap_first}.set${prop.name?cap_first}(${prop.type.name?uncap_first}Service.getById(${name?uncap_first}Dto.get${prop.name?cap_first}().getId()));
		<#else>
		Set<${prop.type.name}> ${prop.name}Set = new HashSet<>();
		for(${prop.type.name}DTO item : ${name?uncap_first}Dto.get${prop.name?cap_first}()){
			${prop.type.name} ${prop.type.name?uncap_first} = ${prop.type.name?uncap_first}Service.getById(item.getId());
			${prop.name}Set.add(${prop.type.name?uncap_first});
		}
		${name?uncap_first}.set${prop.name?cap_first}(${prop.name}Set);
		</#if>
		</#list>
		
		${repository}.save(${name?uncap_first});
    
        return new ResponseEntity<>(modelMapper.map(${name?uncap_first}, ${name}DetailDTO.class), HttpStatus.OK); 
    }

    public ResponseEntity<Void> delete${name}(Long id){
        try{
            ${repository}.deleteById(id);
            return new ResponseEntity<>(HttpStatus.OK);
        }
        catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    public void Save(${name} ${name?uncap_first}){
        ${repository}.save(${name?uncap_first});
    }
}
