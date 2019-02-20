package org;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

public class ActorImpl {
	
	List<Actor> lista=new ArrayList<Actor>();
	Session session;
	
	public void addAttori() {
		try {
			session=Dao.getConnection().openSession();
			session.beginTransaction();
			session.save( new Actor("EL TANQUE", "SOSA") );
			session.save( new Actor("ASR","1927" ) );
			session.getTransaction().commit();
			session.close();
			
			session=Dao.getConnection().openSession();
			session.beginTransaction();
			List result = session.createQuery( "from Actor" ).list();
			for ( Actor actor : (List<Actor>) result ) {
				System.out.println( "Actor (" + actor.getFirst_name() + ") : " + actor.getLast_name() );
			}
			session.getTransaction().commit();
			session.close();
			
		}
		catch (Throwable e) {
            System.out.println(e.getMessage());
        } 

	}
	
	public List<Actor> getAll(){
		Session session=Dao.getConnection().openSession();
		session.beginTransaction();
		List result = session.createQuery( "from Actor" ).list();
		for ( Actor actor : (List<Actor>) result ) {
			System.out.println( "Actor (" + actor.getFirst_name() + ") : " + actor.getLast_name() );
		}
		session.getTransaction().commit();
		session.close();
		return lista;
	}
}
