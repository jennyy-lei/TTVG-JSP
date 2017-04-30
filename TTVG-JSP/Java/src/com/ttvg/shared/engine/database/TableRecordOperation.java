package com.ttvg.shared.engine.database;

import java.util.Iterator;
import java.util.Vector;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.proxy.HibernateProxy;

public class TableRecordOperation {
	
	/**
	 * Fetch the first met record from DB by the Hibernate SQL
	 * 
	 * @param h_sql A Hibernate SQL statement
	 * @return A record, null if not found
	 */
	public static synchronized Object findRecord(String h_sql) throws Exception {
		
		Object ret = null;
		
		Session session = null;
		
		try{ 
			session = MyDatabaseFeactory.getSession();

			Query query = session.createQuery(h_sql);
			Iterator it = query.iterate();
	        if (it.hasNext()){
	        	ret = it.next();
	    		if ( ret instanceof HibernateProxy )
	    			((HibernateProxy)ret).getHibernateLazyInitializer().initialize();
	        }

	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    	ret = null;
	    }finally{
	      // Actual contact insertion will happen at this step
	    	if (session != null) {
	    		session.close();
	    	}
	    }
	    
	    return ret;
		
	}
	
	/**
	 * Fetch all records from DB by the Hibernate SQL
	 * 
	 * @param h_sql A Hibernate SQL statement
	 * @return Collection of records
	 */
	public static synchronized Vector<Object> findAllRecord(String h_sql) throws Exception {
		Vector<Object> ret = new Vector<Object>();
		
		Session session = null;
		
		try{ 
			session = MyDatabaseFeactory.getSession();
			
			Query query = session.createQuery(h_sql);
			for ( Iterator it = query.iterate(); it.hasNext();) {
	    		Object obj = it.next();
	    		if ( obj instanceof HibernateProxy )
	    			((HibernateProxy)obj).getHibernateLazyInitializer().initialize();
				ret.add(obj);
			}
	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    }finally{
	      // Actual contact insertion will happen at this step
	    	if (session != null) {
	    		session.close();
	    	}
	    }
	    
	    return ret;
		
	}
	
	/**
	 * Insert the changed record to DB by the Hibernate SQL
	 * 
	 * @param obj A Hibernate object
	 * @return Success or not
	 */
	public static synchronized boolean insertRecord(Object obj) throws Exception {
		
		boolean ret = false;
		
		if (obj == null) return ret;
			
		Session session = null;
		
		try{ 
			session = MyDatabaseFeactory.getSession();
			
			session.save(obj);
	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    	ret = false;
	    }finally{
	      // Actual contact insertion will happen at this step
	    	if (session != null) {
	    		session.flush();
	    		session.close();
	    	}
	    }
	    
	    return ret;
		
	}
	
	/**
	 * Update the changed record to DB by the Hibernate SQL
	 * 
	 * @param obj A Hibernate object
	 * @return Success or not
	 */
	public static synchronized boolean updateRecord(Object obj) throws Exception {
		
		boolean ret = false;
		
		if (obj == null) return ret;
			
		Session session = null;
		
		try{ 
			session = MyDatabaseFeactory.getSession();
			
			session.update(obj);
	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    	ret = false;
	    }finally{
	      // Actual contact insertion will happen at this step
	    	if (session != null) {
	    		session.flush();
	    		session.close();
	    	}
	    }
	    
	    return ret;
		
	}

}
