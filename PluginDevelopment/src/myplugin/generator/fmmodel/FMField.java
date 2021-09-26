package myplugin.generator.fmmodel;

public class FMField extends FMElement{
	private String label;
	private FieldType type;
	private Boolean editable;
	private Boolean calculated;
	private Boolean filter;
	private Boolean sort;
	private Boolean visible;
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public FieldType getType() {
		return type;
	}
	public void setType(FieldType type) {
		this.type = type;
	}
	public Boolean getEditable() {
		return editable;
	}
	public void setEditable(Boolean editable) {
		this.editable = editable;
	}
	public Boolean getCalculated() {
		return calculated;
	}
	public void setCalculated(Boolean calculated) {
		this.calculated = calculated;
	}
	public Boolean getFilter() {
		return filter;
	}
	public void setFilter(Boolean filter) {
		this.filter = filter;
	}
	public Boolean getSort() {
		return sort;
	}
	public void setSort(Boolean sort) {
		this.sort = sort;
	}
	public Boolean getVisible() {
		return visible;
	}
	public void setVisible(Boolean visible) {
		this.visible = visible;
	}
	
	public FMField(String name) {
		super(name);
	}
	
}
