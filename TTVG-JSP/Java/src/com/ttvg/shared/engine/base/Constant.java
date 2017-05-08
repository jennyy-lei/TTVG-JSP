package com.ttvg.shared.engine.base;

import java.util.Hashtable;
import java.util.Map;
import java.util.Properties;

public class Constant {

	public static final String DELIMETER_DDL_ITEM			= "/";
	public static final String DELIMETER_DDL_LIST			= "|";
	
	public static final String LOCALE_CN					= "cn";
	public static final String LOCALE_EN					= "en";
	
	public static final String DDL_INDEX_LIST				= "ddl.list";
	
	public static Map<String, Map<String, String>> ddlListSet = new Hashtable<String, Map<String, String>>();
	
	public static void SetConfig(Properties p, String locale){
		if ( isLocaleEn(locale) ){
			
		}
	}
		
	public static void SetConfig(Properties p, Map<String, Map<String, String>> listSet){
		if ( listSet.size() == 0 ){
			
		}
	}
	
	public static boolean isLocaleEn(String locale){
		return  locale == null || locale.length() == 0 || LOCALE_EN.equalsIgnoreCase(locale);
	}
	
	public static Map<String, String> GetDDL(String name){
		return ddlListSet.get(name);
	}
}
