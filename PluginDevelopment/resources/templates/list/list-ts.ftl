/// [ ${.now?date} ${.now?time} ]
/// This file is generated based on ${.current_template_name}

import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { I${entity_name} } from 'src/app/shared/model/${entity_name?uncap_first}.model';
import { ${entity_name}Service } from 'src/app/shared/services/${entity_name?uncap_first}.service';

@Component({
	selector: 'app-${entity_name?uncap_first}-list',
	templateUrl: './${entity_name?uncap_first}-list.component.html',
})

export class ${entity_name}ListComponent implements OnInit {

	${entity_name?uncap_first}_list: I${entity_name}[] = [];
	
	page:number = 1;
	elementsPerPage = 5;
	options:number[] = [5, 10, 15];
	idToDelete: any;
	isLoading: boolean = true;

	isDisabled: boolean = false;
	
	constructor(
		private  ${entity_name?uncap_first}Service: ${entity_name}Service,
		private router: Router
	){}

	ngOnInit(){
		this.${entity_name?uncap_first}Service.getAll${class.name}s.subscribe(
			(data) => {
				this.${entity_name?uncap_first}_list = data
				this.isLoading = false;
			},
			(error) => {
				if (error.status == 403)
					alert("Forbidden");
				else 
					alert(error.error);
			}
		);
	}
	
	delete${entity_name}(id: number){
		this.${entity_name?uncap_first}Service.delete${class.name}(id).subscribe(
			data =>{
				alert("${entity_name} has been successfully deleted!");
			},
			error => {
				if (error.status == 403)
					alert("Forbidden");
				else 
					alert("Something went wrong while deleting ${entity_name}!");
			}
		);
	}

}