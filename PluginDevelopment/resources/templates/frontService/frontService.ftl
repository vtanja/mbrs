import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';


import { I${class.name} } from '../model/${name}.model';

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
	
    update${class.name}(model: I${class.name}){
        return this.http.put(this.BaseURI + '/${name}/update', model);
    }
	
    addNew${class.name}(model: I${class.name}) {
        return this.http.post(this.BaseURI + '/${name}/create', model);
    }
	
    delete${class.name}(id: Number){
		return this.http.delete(this.BaseURI + '/${name}/'+id);
    }

}
	