/// [ ${.now?date} ${.now?time} ]
/// This file is generated based on ${.current_template_name}

import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { ${entity_name}Service } from '../${entity_name?uncap_first}.service';
import { I${entity_name} } from 'src/app/shared/model/${entity_name?uncap_first}.model';

@Component({
	selector: 'app-${entity_name?uncap_first}',
	templateUrl: './${entity_name?uncap_first}.component.html',
})

export class ${entity_name}Component {
    obj: I${entity_name}|undefined;

    closeResult: string = '';

    constructor(private ${entity_name?uncap_first}Service: ${entity_name}Service,
                private activatedRoute: ActivatedRoute, private router: Router,
                private modalService: NgbModal){}

    ngOnInit(): void {
        this.activatedRoute.paramMap.subscribe(params => {
            let param = params.get('id');
            if (param == null) {
                this.router.navigate(['/${entity_name?uncap_first}']);
            }
            this.${entity_name?uncap_first}Service.get${entity_name}(parseInt(param!)).subscribe(
                data => { 
                    this.obj = data;
                },
                error => {
                    if (error.status == 403)
                        alert("Forbidden");
                    else 
                        alert(error.error);
                }
            );
        });
    }

    delete(){
        if(this.obj != undefined){
            this.${entity_name?uncap_first}Service.delete${entity_name}(this.obj.id).subscribe(
			data =>{
				alert("${entity_name} has been successfully deleted!");
			},
			error => {
                if (error.status == 403)
					alert("Forbidden");
				else 
					alert("Something went wrong while deleting ${entity_name?uncap_first}!");
			});

            let path = '/${entity_name?uncap_first}';

            this.router.navigateByUrl('', { skipLocationChange: true }).then(() => {
                this.router.navigate([path]);
            });
        }
        else{
            alert("Something went wrong while deleting ${entity_name?uncap_first}!");
        }
		
	}

    open(content:any) {
		this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
		this.closeResult = `Closed with: ` + result;
		}, (reason) => {
		this.closeResult = `Dismissed ` + this.getDismissReason(reason);
		});
	}

	private getDismissReason(reason: any): string {
		if (reason === ModalDismissReasons.ESC) {
		return 'by pressing ESC';
		} else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
		return 'by clicking on a backdrop';
		} else {
		return `with: ` + reason;
		}
	}

}