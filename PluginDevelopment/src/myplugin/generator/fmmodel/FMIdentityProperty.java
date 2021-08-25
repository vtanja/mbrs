package myplugin.generator.fmmodel;

public class FMIdentityProperty extends FMPersistentProperty {
	private Strategy strategy;

	public FMIdentityProperty(FMPersistentProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(), fmProp.getLower(), fmProp.getUpper(),
				fmProp.getColumnName(), fmProp.getPrecision(), fmProp.getLength());
	}
	
	public Strategy getStrategy() {
		return strategy;
	}

	public void setStrategy(Strategy strategy) {
		this.strategy = strategy;
	}
}
