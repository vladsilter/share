package com.sincrono.gestionale.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CommessaUtil {
	
	/* Inserisce una nuova commessa nel database */
	public void inserisci(CommessaService cs, int idCliente, String titoloProgetto,String dataInizio,String dataFine) {
		Commessa c=new Commessa();
		c.setId_cliente(idCliente);
		c.setTitolo_progetto(titoloProgetto);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(dataInizio);
			c.setData_inizio(dataI);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {		
			dataF=format.parse(dataFine);
			c.setData_fine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		cs.save(c);
	}
	
	/* Modifica una commessa già presente nel database */
	public void modifica(CommessaService cs,int idCommessa, int idCliente, String titoloProgetto,String dataInizio,String dataFine) {
		Commessa c=cs.getOne(idCommessa);
		c.setId_cliente(idCliente);
		c.setTitolo_progetto(titoloProgetto);
		cs.save(c);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(dataInizio);
			c.setData_inizio(dataI);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {		
			dataF=format.parse(dataFine);
			c.setData_fine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		cs.save(c);
	}
	
	/* Daje Kevin */
	public ArrayList<String> getTitleList(CommessaService cs){
		ArrayList<String> l=new ArrayList<String>();
		for(Commessa c:cs.findAll()) {
			l.add(c.getTitolo_progetto());
		}
		return l;
	}
	
	//Recupero lista id cliente da una lista di commesse
	public List<Integer> getListaIdClienteByListaCommesse (List<Commessa> ls){
		List<Integer> i=new ArrayList<Integer>();
		for (Commessa com:ls) {
			i.add(com.getId_cliente());
		}
		return i;
	}
	
	
	
}
