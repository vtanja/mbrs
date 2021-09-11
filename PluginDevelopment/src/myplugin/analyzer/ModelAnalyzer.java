package myplugin.analyzer;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.swing.JOptionPane;

import myplugin.generator.fmmodel.CascadeType;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMIdentityProperty;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.fmmodel.FMManytoMany;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMOneToMany;
import myplugin.generator.fmmodel.FMManytoOne;
import myplugin.generator.fmmodel.FMManytoMany;
import myplugin.generator.fmmodel.FMOnetoOne;
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FMType;
import myplugin.generator.fmmodel.FetchType;
import myplugin.generator.fmmodel.Strategy;
import myplugin.generator.options.ProjectOptions;
import myplugin.generator.options.TypeMapping;

import com.nomagic.magicdraw.uml.symbols.reflect.PersistentProperty;
import com.nomagic.uml2.ext.jmi.helpers.ModelHelper;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.EnumerationLiteral;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.NamedElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Enumeration;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Stereotype;


/** Model Analyzer takes necessary metadata from the MagicDraw model and puts it in 
 * the intermediate data structure (@see myplugin.generator.fmmodel.FMModel) optimized
 * for code generation using freemarker. Model Analyzer now takes metadata only for ejb code 
 * generation

 * @ToDo: Enhance (or completely rewrite) myplugin.generator.fmmodel classes and  
 * Model Analyzer methods in order to support GUI generation. */ 


public class ModelAnalyzer {	
	//root model package
	private Package root;
	
	//java root package for generated code
	private String filePackage;
	
	public ModelAnalyzer(Package root, String filePackage) {
		super();
		this.root = root;
		this.filePackage = filePackage;
	}

	public Package getRoot() {
		return root;
	}
	
	public void prepareModel() throws AnalyzeException {
		FMModel.getInstance().getClasses().clear();
		FMModel.getInstance().getEnumerations().clear();
		processPackage(root, filePackage);
	}
	
	private void processPackage(Package pack, String packageOwner) throws AnalyzeException {
		//Recursive procedure that extracts data from package elements and stores it in the 
		// intermediate data structure
		
		if (pack.getName() == null) throw  
			new AnalyzeException("Packages must have names!");
		
		String packageName = packageOwner;
		if (pack != root) {
			packageName += "." + pack.getName();
		}
		
		if (pack.hasOwnedElement()) {
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Class) {
					Class cl = (Class)ownedElement;
					FMClass fmClass = getClassData(cl, packageName);
					FMModel.getInstance().getClasses().add(fmClass);
				}
				
				if (ownedElement instanceof Enumeration) {
					Enumeration en = (Enumeration)ownedElement;
					FMEnumeration fmEnumeration = getEnumerationData(en, packageName);
					FMModel.getInstance().getEnumerations().add(fmEnumeration);
				}								
			}
//			
//			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
//				Element ownedElement = it.next();
//				if (ownedElement instanceof Package) {					
//					Package ownedPackage = (Package)ownedElement;
//					if (StereotypesHelper.getAppliedStereotypeByString(ownedPackage, "BusinessApp") != null)
//						//only packages with stereotype BusinessApp are candidates for metadata extraction and code generation:
//						processPackage(ownedPackage, packageName);
//				}
//			}
			
			/** @ToDo:
			  * Process other package elements, as needed */ 
		}
	}
	
	private FMClass getClassData(Class cl, String packageName) throws AnalyzeException {
		if (cl.getName() == null) 
			throw new AnalyzeException("Classes must have names!");
		
		FMClass fmClass = new FMClass(cl.getName(), packageName, cl.getVisibility().toString());
		Iterator<Property> it = ModelHelper.attributes(cl);
		while (it.hasNext()) {
			Property p = it.next();
			FMProperty prop = getPropertyData(p, cl);
			fmClass.addProperty(prop);	
		}	
		
		/** @ToDo:
		 * Add import declarations etc. */	
		
		Map<String, FMType> imports = new HashMap<String, FMType>();
		for (FMProperty fmProp : fmClass.getProperties()) {
			FMType fmType = fmProp.getType();
			if (!imports.containsKey(fmType.getName())){
				imports.put(fmType.getName(), fmType);
				fmClass.addImportedPackage(fmType);
			}
		}
		
		return fmClass;
	}
	
	private FMProperty getPropertyData(Property p, Class cl) throws AnalyzeException {
		String attName = p.getName();
		if (attName == null) 
			throw new AnalyzeException("Properties of the class: " + cl.getName() +
					" must have names!");
		
		String attTypeName = p.getType().getName();
		String typePackage = "";
		
		TypeMapping typeMapping = getType(attTypeName); 
				
		if(typeMapping != null) {
			attTypeName = typeMapping.getDestType();
			typePackage = typeMapping.getLibraryName();
		}
		
		FMType fmType = new FMType(attTypeName, typePackage);
			
		int lower = p.getLower();
		int upper = p.getUpper();
		
		FMProperty prop = new FMProperty(attName, fmType, p.getVisibility().toString(), 
				lower, upper);
		
		prop = checkTypeOfProperty(p, prop);
		
		return prop;		
	}	
	
	private TypeMapping getType(String attType) {
		List<TypeMapping> typeMappings = ProjectOptions.getProjectOptions().getTypeMappings();
		for(TypeMapping typeMapping:typeMappings) {
			if(typeMapping.getuMLType().equals(attType)) {
				return typeMapping;
			}
		}
		return null;
	}

	private FMProperty checkTypeOfProperty(Property prop, FMProperty fmProp) {
		Stereotype persistentPropStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "PersistentProperty");
		if(persistentPropStereotype != null) {
			fmProp = addPersistentPropData(persistentPropStereotype, prop, fmProp);
		}
		
		Stereotype identityPropStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "IdentityProperty");
		if(identityPropStereotype != null) {
			fmProp = addIdentityPropData(identityPropStereotype, prop, fmProp);
		}
		
		Stereotype linkedPropStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "LinkedProperty");
		if (linkedPropStereotype != null) {
			fmProp = addLinkedPropData(linkedPropStereotype, prop, fmProp);
		}
		
		
		Stereotype oneToManyStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "OneToMany");
		if (oneToManyStereotype != null) {
			fmProp = addOneToManyPropData(oneToManyStereotype, prop, fmProp);
		}
		
		Stereotype manyToOneStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "ManyToOne");
		if (manyToOneStereotype != null) {
			fmProp = addManyToOnePropData(manyToOneStereotype, prop, fmProp);
		}
		
		Stereotype manyToManyStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "ManyToMany");
		if (manyToManyStereotype != null) {
			fmProp = addManyToManyPropData(manyToManyStereotype, prop, fmProp);
		}
		
		Stereotype oneToOneStereotype = StereotypesHelper.getAppliedStereotypeByString(prop, "OneToOne");
		if (oneToOneStereotype != null) {
			fmProp = addOneToOnePropData(oneToOneStereotype, prop, fmProp);
		}
						
		return fmProp;
	}

	private FMProperty addLinkedPropData(Stereotype linkedPropStereotype, Property prop, FMProperty fmProp) {
		FMLinkedProperty linkedProperty = new FMLinkedProperty(fmProp);
		manageTags(linkedPropStereotype, prop, linkedProperty, "LinkedProperty");
		return linkedProperty;
	}

	private FMProperty addIdentityPropData(Stereotype identityPropStereotype, Property prop, FMProperty fmProp) {
		FMIdentityProperty identityProperty = new FMIdentityProperty(new FMPersistentProperty(fmProp));
		
		manageTags(identityPropStereotype, prop, identityProperty, "IdentityProperty");
		return identityProperty;
	}
	
	private FMProperty addOneToManyPropData(Stereotype oneToManyPropStereotype, Property prop, FMProperty fmProp) {
		FMOneToMany fmOneToManyProperty = new FMOneToMany(new FMLinkedProperty(fmProp));
		manageTags(oneToManyPropStereotype, prop, fmOneToManyProperty, "OneToMany");
		return fmOneToManyProperty;
	}
	
	private FMProperty addManyToOnePropData(Stereotype manyToOneStereotype, Property prop, FMProperty fmProp) {
		FMManytoOne fmManyToOneProperty = new FMManytoOne(new FMLinkedProperty(fmProp));
		manageTags(manyToOneStereotype, prop, fmManyToOneProperty, "ManyToOne");
		return fmManyToOneProperty;
	}
	
	private FMProperty addManyToManyPropData(Stereotype manyToManyStereotype, Property prop, FMProperty fmProp) {
		FMManytoMany fmManyToManyProperty = new FMManytoMany(new FMLinkedProperty(fmProp));
		manageTags(manyToManyStereotype, prop, fmManyToManyProperty, "ManyToMany");
		return fmManyToManyProperty;
	}
	
	private FMProperty addOneToOnePropData(Stereotype oneToOneStereotype, Property prop, FMProperty fmProp) {
		FMOnetoOne fmOneToOneProperty = new FMOnetoOne(new FMLinkedProperty(fmProp));
		manageTags(oneToOneStereotype, prop, fmOneToOneProperty, "OneToOne");
		return fmOneToOneProperty;
	}
	

	private void manageTags(Stereotype stereotype, Property prop, FMProperty fmProp, String propType) {
		List<Property> tags = stereotype.getOwnedAttribute();
		
		for(Property tag: tags) {
			String name = tag.getName();
			
			List value = StereotypesHelper.getStereotypePropertyValue(prop, stereotype, name);

			if(value.size() > 0) {
				setTag(name, value, fmProp, propType);
			}
		}
		
		Collection<NamedElement> inheritedTags = stereotype.getInheritedMember();
		for (NamedElement inheritedTag : inheritedTags) {
			String name = inheritedTag.getName();
			List value = StereotypesHelper.getStereotypePropertyValue(prop, stereotype, name);
			setTag(name, value, fmProp, propType);
		}
	}

	private FMProperty addPersistentPropData(Stereotype persistentPropStereotype, Property prop, FMProperty fmProp) {
		FMPersistentProperty persistentProperty = new FMPersistentProperty(fmProp);
		
		manageTags(persistentPropStereotype, prop, persistentProperty, "PersistentProperty");
		
		return persistentProperty;
	}

	private void setTag(String name, List value, FMProperty property, String propType) {
		if(propType == "PersistentProperty" || propType == "IdentityProperty") {
			switch(name) {
				case "columnName":{
					String columnName = (String) value.get(0);
					((FMPersistentProperty)property).setColumnName(columnName);
				}
				break;
				case "precision":{
					Integer precision = (Integer) value.get(0);
					((FMPersistentProperty)property).setPrecision(precision);
				}
				break;
				case "length":{
					Integer length = (Integer) value.get(0);
					((FMPersistentProperty)property).setLength(length);
				}
				break;
				default: break;
			}
		}
		 if(propType == "IdentityProperty") {
			switch(name) {
				case "strategy":{
					EnumerationLiteral enumLit = (EnumerationLiteral)value.get(0);
					Strategy strategy = Strategy.valueOf(enumLit.getName().toLowerCase());
					((FMIdentityProperty)property).setStrategy(strategy);
				}
				break;
				default: break;
			}
		}
		 
		 List<String> relations = Arrays.asList("OneToMany", "ManyToMany", "OneToOne", "ManyToOne");
		 
		 if(propType == "LinkedProperty" || relations.contains(propType)) {
			 switch(name) {
				 case "fetchType":{
					 EnumerationLiteral enumLit = (EnumerationLiteral)value.get(0);
					 FetchType fetchType = FetchType.valueOf(enumLit.getName().toUpperCase());
					 ((FMLinkedProperty)property).setFetchType(fetchType);
				 }
			 }
		 }
		 if(propType == "OneToMany") {
			 switch(name) {
				 case "cascade":{
					 EnumerationLiteral enumLit = (EnumerationLiteral)value.get(0);
					 CascadeType cascadeType = CascadeType.valueOf(enumLit.getName().toUpperCase());
					 ((FMOneToMany)property).setCascade(cascadeType);
				 }
				 break;
				 case "mappedBy":{
						String mappedBy = (String) value.get(0);
						((FMOneToMany)property).setMappedBy(mappedBy);
				 }
				 break;
				 default: break;
			 }
		 }
		 if(propType == "ManyToOne") {
			 switch(name) {
			 	case "columnName":{
			 			String columnName = (String) value.get(0);
			 			((FMManytoOne)property).setColumnName(columnName);
				}
			 	break;
			 	default: break;
			 }
		 }
		 if(propType == "ManyToMany") {
			 switch(name) {
			 	case "mappedBy":{
			 		String mappedBy = (String) value.get(0);
			 		((FMManytoMany)property).setMappedBy(mappedBy);
				}
			 	case "joinTable":{
		 			String joinTable = (String) value.get(0);
		 			((FMManytoMany)property).setJoinTable(joinTable);
			 	}
			 	break;
			 	default: break;
			 }
		 }
	}

	private FMEnumeration getEnumerationData(Enumeration enumeration, String packageName) throws AnalyzeException {
		FMEnumeration fmEnum = new FMEnumeration(enumeration.getName(), packageName);
		List<EnumerationLiteral> list = enumeration.getOwnedLiteral();
		for (int i = 0; i < list.size() - 1; i++) {
			EnumerationLiteral literal = list.get(i);
			if (literal.getName() == null)  
				throw new AnalyzeException("Items of the enumeration " + enumeration.getName() +
				" must have names!");
			fmEnum.addValue(literal.getName());
		}
		return fmEnum;
	}
	
}
