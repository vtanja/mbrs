import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

<#if importedPackages??>
<#list importedPackages as import>
<#if import.typePackage == "">
import { ${import.name} } from 'src/app/shared/model/${import.name}';
</#if>
</#list>
</#if>
import { ${class.name} } from 'src/app/shared/model/${class.name}';

@Injectable({
    providedIn: 'root',
   })
   
export class ${class.name}Service {
    readonly BaseURI = 'http://localhost:PORT';

    constructor(private http: HttpClient) {
        
    }
	
    getAll${class.name}s() {
        return this.http.get(this.BaseURI + '/${class.name}/getAll');
    }
	
    get${class.name}(id: Number) {
        return this.http.get(this.BaseURI + '/${class.name}/get${class.name}/'+id);
    }
	
    update${class.name}(model: ${class.name}){
        return this.http.put(this.BaseURI + '/${class.name}/update', model);
    }
	
    addNew${class.name}(model: ${class.name}) {
        return this.http.post(this.BaseURI + '/${class.name}/create', model);
    }
	
    delete${class.name}(id: Number){
		return this.http.delete(this.BaseURI + '/${class.name}/delete/'+id);
    }

}
	