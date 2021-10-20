// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.repository;

import org.springframework.stereotype.Repository;
import com.example.${appName}.model.${class.name};

@Repository
public interface ${class.name}RepositoryImpl extends ${class.name}Repository{

}