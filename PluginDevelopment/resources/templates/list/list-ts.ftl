/// [ ${.now?date} ${.now?time} ]
/// This file is generated based on ${.current_template_name}

import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { ${class.name} } from 'src/app/shared/model/${class.name}';
import { ${entity_name}Service } from 'src/app/shared/services/${entity_name?uncap_first}.service';

@Component({
	selector: 'app-${entity_name?uncap_first}-list',
	templateUrl: './${entity_name?uncap_first}-list.component.html',
})

export class ${entity_name}ListComponent implements OnInit {

	${entity_name?uncap_first}_list: ${entity_name}[] = [];
	
	page:number = 1;
	elementsPerPage = 5;
	options:number[] = [5, 10, 15];
	idToDelete: any;
	isLoading: boolean = true;

	isDisabled: boolean = false;
	
	closeResult: string = '';
	
	constructor(
		private  ${entity_name?uncap_first}Service: ${entity_name}Service,
		private router: Router,
		private modalService: NgbModal
	){}

	ngOnInit(){
		this.${entity_name?uncap_first}Service.getAll${class.name}s.subscribe(
			(data: ${class.name}[])  => {
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
			(data: ${class.name}[]) =>{
				alert("${entity_name} has been successfully deleted!");
			},
			(error) => {
				if (error.status == 403)
					alert("Forbidden");
				else 
					alert("Something went wrong while deleting ${entity_name}!");
			}
		);
	}
	
	onChange(newValue:number) {
	   this.elementsPerPage = newValue;
	}
	
	open(content:any) {
		this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
		this.closeResult = 'Closed with: ' + result;
		}, (reason) => {
		this.closeResult = 'Dismissed ' + this.getDismissReason(reason);
		});
	}

	private getDismissReason(reason: any): string {
		if (reason === ModalDismissReasons.ESC) {
		return 'by pressing ESC';
		} else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
		return 'by clicking on a backdrop';
		} else {
		return 'with: ' + reason;
		}
	}

}