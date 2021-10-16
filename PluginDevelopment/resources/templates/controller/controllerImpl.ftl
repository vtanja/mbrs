// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.controller;

import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping( path = "/${ name?lower_case }")
public class ${ name }ControllerImpl extends ${ name }Controller{

}