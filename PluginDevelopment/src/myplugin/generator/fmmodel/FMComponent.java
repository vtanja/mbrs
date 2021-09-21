package myplugin.generator.fmmodel;

public class FMComponent extends FMElement {
	private boolean delete;
	private boolean update;
	private boolean create;
	private boolean detail;

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
