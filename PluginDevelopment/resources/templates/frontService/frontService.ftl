import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

<#if importedPackages??>
<#list importedPackages as import>
<#if import.typePackage == "">
import { ${import.name} } from 'src/app/shared/model/${import.name?uncap_first}.model';
</#if>
</#list>
</#if>
import { ${class.name} } from 'src/app/shared/model/${class.name?uncap_first}.model';

@Injectable({
    providedIn: 'root',
   })
   
export class ${class.name}Service {
    readonly BaseURI = 'http://localhost:PORT';

    constructor(private http: HttpClient) {
        
    }
	
    getAll${class.name}s() {
        return this.http.get(this.BaseURI + '/${class.name?uncap_first}/getAll');
    }
	
    get${class.name}(id: number) {
        return this.http.get(this.BaseURI + '/${class.name?uncap_first}/get${class.name}/'+id);
    }
	
    update${class.name}(id: number, model: ${class.name}){
        return this.http.put(this.BaseURI + '/${class.name?uncap_first}/' + id, model);
    }
	
    addNew${class.name}(model: ${class.name}) {
        return this.http.post(this.BaseURI + '/${class.name?uncap_first}/', model);
    }
	
    delete${class.name}(id: number){
		return this.http.delete(this.BaseURI + '/${class.name?uncap_first}/'+id);
    }
    
    getLists(){
    	return this.http.get(this.BaseURI + '/${class.name?uncap_first}/getLists');
    }

}
	