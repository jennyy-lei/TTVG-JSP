package com.ttvg.test;


import java.util.Date;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.ttvg.shared.engine.database.MyDatabaseFeactory;
import com.ttvg.shared.engine.database.TableRecordOperation;
import com.ttvg.shared.engine.database.table.Forum;
import com.ttvg.shared.engine.database.table.Person;

public class TestForumInsert{
  public static void main(String[] args) {
    Session session = null;

    try{
      // This step will read hibernate.cfg.xml and prepare hibernate for use
    	session = MyDatabaseFeactory.getSession();
        Transaction transaction = session.beginTransaction();
        
        Person person = TableRecordOperation.getRecord(1, Person.class);
        
        //Create new instance of Person and set values in it by reading them from form object
    	System.out.println("Inserting Record");
    	Forum item = new Forum();
        item.setPerson(person);
        item.setDateTime(new Date());
        item.setTitle("My forum");
        item.setContent("Some thing");
    	
        Forum item1 = new Forum();
        item1.setPerson(person);
        item1.setForum(item);
        item1.setDateTime(new Date());
        item1.setTitle("My following forum");
        item1.setContent("Some thing More");
        
        item.getFollowingForums().add(item1);
        session.save(item1);
        transaction.commit();
        System.out.println("Done");
    }catch(Exception e){
      System.out.println(e.getMessage());
    }finally{
      // Actual contact insertion will happen at this step
    	if (session != null) {
    		session.flush();
    		session.close();
    	}
      }
    
  }
} 
