package org;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

//CLASSE SINGLETON PER LA CONNESSIONE AL DB
public class Dao {
	private static SessionFactory sessionFactory=null;
	
	private Dao() throws Throwable {
		// A SessionFactory is set up once for an application!
		final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
				.configure() // configures settings from hibernate.cfg.xml
					.build();
			try {
				sessionFactory= new Configuration().configure().buildSessionFactory();
//new MetadataSources( registry ).buildMetadata().buildSessionFactory();
			}
			catch (Throwable e) {
				// The registry would be destroyed by the SessionFactory, but we had trouble building the SessionFactory
				// so destroy it manually.
				StandardServiceRegistryBuilder.destroy( registry );
			}
			
	}
	
	public static SessionFactory getConnection() {
		if(sessionFactory==null) {//controllo sul datasource
			try {
				new Dao();
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return sessionFactory;
	}
	
	public static void closeConnection() {
		sessionFactory.close();
	}
	
	

}
