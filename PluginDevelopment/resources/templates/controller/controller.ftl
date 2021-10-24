// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}
package com.example.${appName}.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import com.example.${appName}.dto.${ name }DTOImpl;
import com.example.${appName}.dto.${ name }DetailDTOImpl;
import com.example.${appName}.service.${ name }ServiceImpl;


public class ${ name }Controller {
    @Autowired
    private ${ name }ServiceImpl ${name?lower_case}Service;

    @GetMapping(path="/{pageNo}/{pageSize}")
    public ResponseEntity<List<${ name }DTOImpl>> getAll(@PathVariable int pageNo, @PathVariable int pageSize) {

        return ${ name?lower_case }Service.get${name}Page(pageNo, pageSize);
    }

    @GetMapping(path="/{id}")
    public ResponseEntity<${ name }DetailDTOImpl> get${ name }(@PathVariable Long id) {

        return ${ name?lower_case }Service.get${ name }(id);
    }

    @PostMapping()
    public ResponseEntity<${ name }DetailDTOImpl> create(@RequestBody ${ name }DetailDTOImpl ${ name?lower_case }Dto) {
        return ${ name?lower_case }Service.create(${name?lower_case}Dto);
    }

    @PutMapping(path = "/{id}")
    public ResponseEntity<${ name }DetailDTOImpl> update(@PathVariable Long id, @RequestBody ${ name }DetailDTOImpl ${ name?lower_case }Dto) {
        return ${ name?lower_case }Service.update${ name}(id, ${ name?lower_case }Dto);
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        return ${ name?lower_case }Service.delete${ name }(id);
    }
    
    @GetMapping(path="/lists")
    public ResponseEntity<String> getLists() {
        return ${ name?lower_case }Service.getLists();
    }
}