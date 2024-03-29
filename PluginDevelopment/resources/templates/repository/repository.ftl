// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.${appName}.model.${class.name};
import java.util.List;

@Repository
public interface ${class.name}Repository extends JpaRepository<${class.name}, Long>{
	${class.name} find${class.name}By${id}(Long id);
    List<${class.name}> findAll();
}