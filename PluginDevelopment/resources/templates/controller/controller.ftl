package com.example.${ name }.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import com.example.${ name?lower_case }.dto.${ name }DTO;
import com.example.${ name?lower_case }.service.${ name }Service;


@CrossOrigin
@RestController
@RequestMapping( path = "/${ name?lower_case }")
public class ${ name }Controller {
    @Autowired
    private ${ name }Service ${name?lower_case}Service;

    @GetMapping(path="/{pageNo}/{pageSize}")
    public ResponseEntity<List<${ name }DTO>> getAll(@PathVariable int pageNo, @PathVariable int pageSize) {

        return ${ name?lower_case }Service.getAll(pageNo, pageSize);
    }

    @GetMapping(path="/{id}")
    public ResponseEntity<${ name }DTO> get${ name }(@PathVariable Long id) {

        return ${ name?lower_case }Service.get${ name }(id);
    }

    @PostMapping()
    public ResponseEntity<${ name }DTO> create(@RequestBody ${ name }DTO ${ name?lower_case }Dto) {
        return ${ name?lower_case }Service.create(${name?lower_case}Dto);
    }

    @PutMapping(path = "/{id}")
    public ResponseEntity<${ name }DTO> update(@PathVariable Long id, @RequestBody ${ name }DTO ${ name?lower_case }Dto) {
        return ${ name?lower_case }Service.update${ name}(id, ${ name?lower_case }Dto);
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        return ${ name?lower_case }Service.delete${ name }(id);
    }
}