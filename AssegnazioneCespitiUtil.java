package com.sincrono.gestionale.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

public class AssegnazioneCespitiUtil {
	
	/* Prende l'entry della tabella assegnazione_cespiti che ha come chiave il valore idAss.
	 * Se il valore di newTipoId è diverso da 0 lo mette dentro il campo id_tipologia,
	 * altrimenti elimina l'entry.   */
	public void editIdTipologiaAssegnazione(AssegnazioneCespitiService acs,int idAss,int newTipoId) {
		AssegnazioneCespiti ac=acs.getOne(idAss);
		if(newTipoId!=0) {
			ac.setId_tipologia(newTipoId);
			acs.save(ac);
		}
		else {
			acs.delete(ac);
		}
		
		
	}
	
	/* Inserisce nella tabella assegnazione_cespiti una nuova entry */
	public void inserisciAssegnazioneCespiti(AssegnazioneCespitiService acs,int tipologia,int idC,String di,String df,int idAssegnatario ) {
		AssegnazioneCespiti ac=new AssegnazioneCespiti();
		ac.setId_tipologia(tipologia);
		ac.setId_cespite(idC);
		ac.setId_assegnatario(idAssegnatario);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(di);		
			ac.setData_inizio(dataI);			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {	
			dataF=format.parse(df);
			ac.setData_fine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		acs.save(ac);
	}
	
	/* Modifica l'entry della tabella assegnazione_cespiti che ha per chiave il valore idAss */
	public void modificaAssegnazioneCespiti(AssegnazioneCespitiService acs,int idAss,int tipologia,int idC,String di,String df,int idAssegnatario) {
		AssegnazioneCespiti ac=acs.getOne(idAss);
		ac.setId_tipologia(tipologia);
		ac.setId_cespite(idC);
		ac.setId_assegnatario(idAssegnatario);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(di);		
			ac.setData_inizio(dataI);			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {	
			dataF=format.parse(df);
			ac.setData_fine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		acs.save(ac);
	}
	
	/* Elimina dalla tabella assegnazione_cespiti l'entry in cui nel campo id_cespite compare il valore in input idC */
	public void eliminaAssegnazioneCespiti(AssegnazioneCespitiService acs,CespiteService cs,int idC) {
		int idAss=acs.getFromCespite(idC).get();
		AssegnazioneCespiti ac=acs.getOne(idAss);
		acs.delete(ac);
		Cespite c=cs.getOne(idC);
		c.setStato("Non Assegnato");
		cs.save(c);
		
	}
	
	/* Assegna il cespite con l'id uguale a idC al dipendente con l'id uguale a idD, per il periodo di tempo specificato dalle date in input */
	public void assegnaCespiteADipendente(AssegnazioneCespitiService acs,CespiteService cs,int idC,int idD,String di,String df) {
		
		AssegnazioneCespiti ac=new AssegnazioneCespiti();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(di);		
			ac.setData_inizio(dataI);			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {	
			dataF=format.parse(df);
			ac.setData_fine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ac.setId_assegnatario(idD);
		ac.setId_cespite(idC);
		ac.setId_tipologia(1);
		acs.save(ac);
		Cespite c=cs.getOne(idC);
		c.setStato("Assegnato");
		cs.save(c);
		
	}
	/* Assegna il cespite con l'id uguale a idC alla struttura con l'id uguale a idD, per il periodo di tempo specificato dalle date in input */
	public void assegnaCespiteAStruttura(AssegnazioneCespitiService acs,CespiteService cs,int idC,int idD,String di,String df) {
		
		AssegnazioneCespiti ac=new AssegnazioneCespiti();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(di);		
			ac.setData_inizio(dataI);			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {	
			dataF=format.parse(df);
			ac.setData_fine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ac.setId_assegnatario(idD);
		ac.setId_cespite(idC);
		ac.setId_tipologia(2);
		acs.save(ac);
		Cespite c=cs.getOne(idC);
		c.setStato("Assegnato");
		cs.save(c);
		
	}
}
