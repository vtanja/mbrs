package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.List;

public class FMComponent extends FMElement {
	private boolean delete;
	private boolean update;
	private boolean create;
	private boolean detail;

	private List<FMField> fields = new ArrayList<FMField>();
	
	public boolean isDelete() {
		return delete;
	}
	public void setDelete(boolean delete) {
		this.delete = delete;
	}
	public boolean isUpdate() {
		return update;
	}
	public void setUpdate(boolean update) {
		this.update = update;
	}
	public boolean isCreate() {
		return create;
	}
	public void setCreate(boolean create) {
		this.create = create;
	}
	public boolean isDetail() {
		return detail;
	}
	public void setDetail(boolean detail) {
		this.detail = detail;
	}
	
	public List<FMField> getFields() {
		return fields;
	}
	
	public void addField(FMField field) {
		this.fields.add(field);
	}
	
	public FMComponent(String name) {
		super(name);
	}
	
	public FMComponent(String name, boolean delete, boolean update, boolean create, boolean detail) {
		super(name);
		this.delete = delete;
		this.update = update;
		this.create = create;
		this.detail = detail;				
	}
	
}
