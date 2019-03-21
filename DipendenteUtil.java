package com.sincrono.gestionale.model;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public class DipendenteUtil {
	
	/* Crea un dipendente a partire dai campi dati in input e 
	 * gli assegna uno "slot" per inserire il Cv (nella tabella cv). */
	public void inserisciDeterminato(DipendenteService ds,CvService cvs,String nome,String cognome,String email,String psw,String di,String df,String cf,int ruolo,String indirizzo) {
		Dipendente d=new Dipendente();
		
		//Setto i campi di base
		d.setNome(nome);
		d.setCognome(cognome);
		d.setEmail(email);
		d.setPassword(psw);
		d.setCod_fiscale(cf);
		d.setId_ruolo(ruolo);
		d.setIndirizzo(indirizzo);
		
		//Costruisco le date e le setto
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			dataI = format.parse(di);
			dataF=format.parse(df);
			d.setDataInizio(dataI);
			d.setDataFine(dataF);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Salvo l'entry corrispondente anche nella tabella CV (id generato automaticamente)
		Cv cv=new Cv();
		cv.setCv_file(null);
		cvs.save(cv);
		
		//Assegno al dipendente che sto creando il valore dell'id del cv appena inserito
		d.setIdCv(cvs.getLast());
		
		//Update del database
		ds.save(d);
	}
	
	/* Crea un dipendente a partire dai campi dati in input e 
	 * gli assegna uno "slot" per inserire il Cv (nella tabella cv). */
	public void inserisciIndeterminato(DipendenteService ds,CvService cvs,String nome,String cognome,String email,String psw,String di,String cf,int ruolo,String indirizzo) {
		Dipendente d=new Dipendente();
		
		//Setto i campi di base
		d.setNome(nome);
		d.setCognome(cognome);
		d.setEmail(email);
		d.setPassword(psw);
		d.setCod_fiscale(cf);
		d.setId_ruolo(ruolo);
		d.setIndirizzo(indirizzo);
		
		//Costruisco le date e le setto
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		try {
			dataI = format.parse(di);
			d.setDataInizio(dataI);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Salvo l'entry corrispondente anche nella tabella Cv (id generato automaticamente)
		Cv cv=new Cv();
		cv.setCv_file(null);
		cvs.save(cv);
		
		//Assegno al dipendente che sto creando il valore dell'id del cv appena inserito
		d.setIdCv(cvs.getLast());
		
		//Update del database
		ds.save(d);
	}
	
	/* - Elimina dal databese il dipendente che ha nel campo id_dipendente il valore dell'intero passato in input.
	 * - Elimina (dalla tabella assegnazione_commessa) tutte le associazioni tra il dipendente
	 *   eliminato e qualsiasi commessa.
	 * - Elimina dalla tabella assegnazione_cespiti tutte le associazioni tra il dipendente eliminato e qualunque cespite.
	 * - Elimina dalla tabella note tutte le note del dipendente eliminato */
	public void elimina(DipendenteService ds,AssegnazioneCespitiService acs,AssegnazioneCommesseService acs2,NoteService ns,RilService rs,RecuperoPasswordService rps,int id) {
		Optional<List<AssegnazioneCommesse>> acoList=acs2.getAssCommesseByIdDipendente(id);
		Optional<List<AssegnazioneCespiti>> aceList=acs.getAssCespitiByIdDipendente(id);
		Optional<List<Note>> nList=ns.getNoteByDipendente(id);
		Optional<List<Ril>> rList=rs.getRilByIDOptional(id);
		Optional<List<RecuperoPassword>> rpList=rps.getRecuperiByIdDipendente(id);
		if(acoList.isPresent()) {
			List<AssegnazioneCommesse> list=acoList.get();
			for(AssegnazioneCommesse ac : list) {
				acs2.delete(ac);
				
			}
			
		}
		if(aceList.isPresent()) {
			List<AssegnazioneCespiti> list=aceList.get();
			for(AssegnazioneCespiti ac : list) {
				acs.delete(ac);
				
			}
		}
		if(nList.isPresent()) {
			List<Note> list=nList.get();
			for(Note n : list) {
				ns.delete(n);
				
			}
		}
		if(rList.isPresent()) {
			List<Ril> list=rList.get();
			for(Ril r : list) {
				rs.delete(r);
				
			}
		}
		if(rpList.isPresent()) {
			List<RecuperoPassword> list=rpList.get();
			for(RecuperoPassword r : list) {
				rps.delete(r);
				
			}
		}
		ds.deleteById(id);
	}
	
	/* Modifica le informazioni personali di un dipendente */
	public void edit(DipendenteService ds,int idDip,String cf,String nome,String cognome,String indirizzo,String dataInizio,String dataFine,int id_ruolo) {
		Dipendente d=ds.getOne(idDip);
		d.setCod_fiscale(cf);
		d.setNome(nome);
		d.setCognome(cognome);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date dataI;
		Date dataF;
		try {
			if(!dataInizio.equals("")){ 
				dataI=format.parse(dataInizio);
				d.setDataInizio(dataI);
			}
			
			if(!dataFine.equals("")){
				dataF = format.parse(dataFine);
				d.setDataFine(dataF);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		d.setIndirizzo(indirizzo);
		d.setId_ruolo(id_ruolo);
		ds.save(d);
	}
	/* Modifica le informazioni personali di se stesso (immagino di chiamare questa funzione quando
	 * un dipendente vuole modificare le sue informazioni personali nel profilo. Per questo non passo
	 * le date di inizio e fine contratto (non ha senso permettere ad un dipendente di cambiarle) e 
	 * passo la password che servirà per effettuare l'accesso */
	public void editProfilo(DipendenteService ds,int idDip,String cf,String nome,String cognome,String email,String indirizzo,String password) {
		Dipendente d=ds.getOne(idDip);
		d.setCod_fiscale(cf);
		d.setNome(nome);
		d.setCognome(cognome);
		d.setEmail(email);
		d.setPassword(password);
		d.setIndirizzo(indirizzo);
		ds.save(d);
	}
	
	//Recupero lista dipendenti da una lista id_dip
	public List<Dipendente> getListaDipendentebyListaIdDip (DipendenteService ds, List<Integer> listaID){
		List<Dipendente> listadip= new ArrayList<Dipendente>();
		for(Integer id_dip:listaID) {
			Dipendente dip=ds.findById(id_dip).get();
			listadip.add(dip);
			}
		return listadip;
	}
}
