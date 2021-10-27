import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';


import { ${class.name} } from '../model/${name}.model';

@Injectable({
    providedIn: 'root',
   })
   
export class ${class.name}Service {
    readonly BaseURI = 'http://localhost:8080';

    constructor(private http: HttpClient) {
        
    }
	
    getAll${class.name}s() {
        return this.http.get(this.BaseURI + '/${name}');
    }
	
    get${class.name}(id: Number) {
        return this.http.get(this.BaseURI + '/${name}/'+id);
    }
	
    update${class.name}(id: number, model: ${class.name}){
        return this.http.put(this.BaseURI + '/${class.name?uncap_first}/' + id, model);
    }
	
    addNew${class.name}(model: ${class.name}) {
        return this.http.post(this.BaseURI + '/${class.name?uncap_first}/', model);
    }
	
    delete${class.name}(id: Number){
		return this.http.delete(this.BaseURI + '/${name}/'+id);
    }
    
    getLists(){
    	return this.http.get(this.BaseURI + '/${class.name?uncap_first}/lists');
    }

}
	