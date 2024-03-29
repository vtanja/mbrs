/// [ ${.now?date} ${.now?time} ]
/// This file is generated based on ${.current_template_name}

import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { ${entity_name} } from 'src/app/shared/model/${component_name}.model';
import { ${entity_name}Service } from 'src/app/shared/services/${component_name}.service';

@Component({
	selector: 'app-${component_name}-list',
	templateUrl: './${component_name}-list.component.html',
})

export class ${entity_name}ListComponent implements OnInit {

	${entity_name?uncap_first}_list: ${entity_name}[] = [];
	
	page:number = 1;
	totalLength: any;
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
		this.${entity_name?uncap_first}Service.getAll${entity_name}s().subscribe(
			(data: any)  => {
				this.${entity_name?uncap_first}_list = data
				this.isLoading = false;
				this.totalLength = data.length;
			},
			(error: any) => {
				if (error.status == 403)
					alert("Forbidden");
				else 
					alert(error);
			}
		);
	}
	
	<#if component.delete>
	delete${entity_name}(id: number){
		this.${entity_name?uncap_first}Service.delete${entity_name}(id).subscribe(
			data =>{
				alert("${entity_name} has been successfully deleted!");
				let path = '/${paths[entity_name]}';

					this.router.navigateByUrl('', { skipLocationChange: true }).then(() => {
						this.router.navigate([path]);
					});
			},
			error => {
				if (error.status == 403)
					alert("Forbidden");
				else 
					alert("Something went wrong while deleting ${entity_name}!");
			}
		);
	}
	</#if>
	
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