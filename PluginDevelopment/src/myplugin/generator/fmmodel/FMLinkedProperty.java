package myplugin.generator.fmmodel;

public class FMLinkedProperty extends FMProperty{
	private FetchType fetchType;
	
	public FMLinkedProperty(FMProperty fmProperty) {
		super(fmProperty.getName(), fmProperty.getType(), fmProperty.getVisibility(),
				fmProperty.getLower(), fmProperty.getUpper());
	}
	
	public FMLinkedProperty(String name, String type, String visibility, Integer lower,
			Integer upper, FetchType fetchType){
		super(name, type, visibility, lower, upper);
		this.fetchType = fetchType;
	}
	
	
	public FetchType getFetchType() {
		return fetchType;
	}

	public void setFetchType(FetchType fetchType) {
		this.fetchType = fetchType;
	}
	
}
