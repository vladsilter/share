package com.sincrono.gestionale.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sincrono.gestionale.model.AssegnazioneCespiti;
import com.sincrono.gestionale.model.AssegnazioneCespitiMod;
import com.sincrono.gestionale.model.AssegnazioneCespitiService;
import com.sincrono.gestionale.model.AssegnazioneCespitiUtil;
import com.sincrono.gestionale.model.AssegnazioneCommesseService;
import com.sincrono.gestionale.model.AssegnazioneCommesseUtil;
import com.sincrono.gestionale.model.Cespite;
import com.sincrono.gestionale.model.CespiteService;
import com.sincrono.gestionale.model.CespiteUtil;
import com.sincrono.gestionale.model.CvService;
import com.sincrono.gestionale.model.Dipendente;
import com.sincrono.gestionale.model.DipendenteService;
import com.sincrono.gestionale.model.DipendenteUtil;
import com.sincrono.gestionale.model.NoteService;
import com.sincrono.gestionale.model.RecuperoPassword;
import com.sincrono.gestionale.model.RecuperoPasswordService;
import com.sincrono.gestionale.model.RecuperoPasswordUtil;
import com.sincrono.gestionale.model.RilService;
import com.sincrono.gestionale.model.Struttura;
import com.sincrono.gestionale.model.StrutturaService;

@Controller
@RequestMapping(path="/amm")
public class AmministrativoController {
	
	//Classi di utilità per effettuare le operazioni personalizzate
	AssegnazioneCespitiUtil acu=new AssegnazioneCespitiUtil();
	CespiteUtil cu=new CespiteUtil();
	DipendenteUtil du=new DipendenteUtil();
	RecuperoPasswordUtil rpu=new RecuperoPasswordUtil();
	AssegnazioneCommesseUtil acu2=new AssegnazioneCommesseUtil();
	
	//Classi service che forniscono i metodi CRUD + i metodi personalizzati con @Query
	@Autowired
	CespiteService cs;
	@Autowired
	AssegnazioneCespitiService acs;
	@Autowired
	DipendenteService ds;
	@Autowired
	RecuperoPasswordService rps;
	@Autowired
	CvService cvs;
	@Autowired
	AssegnazioneCommesseService acs2;
	@Autowired
	NoteService ns;
	@Autowired
	RilService rs;
	@Autowired
	StrutturaService ss;
	
	
	
	//Viste di base (già rinominate in base alle richieste del SessionController) per Dipendenti, Cespiti e Strutture
	
	@RequestMapping(path="viewDip")
	public String ciao(Model m) {
		
		List<Dipendente> dipens=ds.findAll();
		m.addAttribute("listaDipendenti",dipens);
		return "dipendenti";
		
	}
	
	@RequestMapping(path="cespiti")
	public String ciao2(Model m) {
		List<Cespite> cesps=cs.findAll();
		List<AssegnazioneCespiti> asscesps=acs.findAll();
		List<AssegnazioneCespitiMod> asscespsmod = new ArrayList<AssegnazioneCespitiMod>();
		for(AssegnazioneCespiti a:asscesps) {
			AssegnazioneCespitiMod acm=creaViewAssegnazione(a);
			if(a.getId_tipologia()==1) {
				Dipendente d=ds.getOne(a.getId_assegnatario());
				acm.setNomeAss(d.getNome()+" "+d.getCognome());				
			}
			else if (a.getId_tipologia()==2) {
				Struttura s=ss.getOne(a.getId_assegnatario());
				acm.setNomeAss(s.getDescrizione());
			}
			Cespite c=cs.getOne(a.getId_cespite());
			acm.setNomeCespite(c.getDescrizione());
			asscespsmod.add(acm);
		}
		List<Dipendente> dipens=ds.findAll();
		List<Struttura> struts=ss.findAll();
		m.addAttribute("listaCespiti",cesps);
		m.addAttribute("listaDipendenti",dipens);
		m.addAttribute("listaStrutture",struts);
		m.addAttribute("listaAssegnazioni",asscesps);
		m.addAttribute("listaAssegnazioniMod",asscespsmod);
		return "cespiti";
		
	}
	
	
	@GetMapping(path = "/struttura")
	public String getAllStrutture(Model m) {
		m.addAttribute("strutture", ss.findAll());
		return "struttura";
	}	
	
	public AssegnazioneCespitiMod creaViewAssegnazione(AssegnazioneCespiti a) {
		AssegnazioneCespitiMod acMod=new AssegnazioneCespitiMod();
		acMod.setId_assegnazione_cespiti(a.getId_assegnazione_cespiti());
		acMod.setId_cespite(a.getId_cespite());
		acMod.setId_assegnatario(a.getId_assegnatario());
		acMod.setId_tipologia(a.getId_tipologia());
		acMod.setData_inizio(a.getData_inizio());
		acMod.setData_fine(a.getData_fine());
		return acMod;
	}
	/*-- OPERAZIONI SULLE STRUTTURE --*/

	

	

	@GetMapping(path = "/deleteStruttura")
	public String deleteStruttura(Model m,@RequestParam int id) {
		ss.deleteById(id);
		return getAllStrutture(m);
	}

	

	@RequestMapping(path = "/addStruttura")
	public String addStruttura(Model m,@RequestParam String descrizione) {
		ss.aggiungiStruttura(descrizione);
		return getAllStrutture(m);
	}

	

	@RequestMapping(path = "/editStruttura")
	public String editStruttura(@RequestParam int id_struttura, @RequestParam String descrizione, Model m) {
		ss.modificaStruttura(id_struttura, descrizione);
		m.addAttribute("strutture", ss.findAll());
		return "struttura";
	}
	
	/*-- OPERAZIONI SUI CESPITI --*/  
	
	/* Da chiamare quando si vuole inserire un cespite nel database.
	 * Gestisce anche l'eventuale assegnamento ad un dipendente o ad una struttura
	 * Per ora il valore da restituire dal frontend nel caso non vada assegnato è idAssegnatario=-1.
	 * (PROVVISORIA! Poi vediamo dal frontend cosa è possibile far arrivare) 
	 * PER ORA NON SERVE, CONSERVO LA STRUTTURA PER EVENTUALI SVILUPPI FUTURI*/
	@PostMapping(path="/insAssCesp") 
	public String insertCesp (@RequestParam String descrizione,@RequestParam int idAssegnatario
			, @RequestParam String tipologiaCespite, @RequestParam int  tipologiaAssegnazione,@RequestParam String dataI,@RequestParam String dataF) {
		
		if(idAssegnatario!=-1) {
			cu.inserisci(cs,descrizione,tipologiaCespite,"Assegnato");
			acu.inserisciAssegnazioneCespiti(acs,tipologiaAssegnazione,cs.getLast(),dataI,dataF,idAssegnatario);
		}
		else {
			cu.inserisci(cs,descrizione,tipologiaCespite,"Non Assegnato");
			
		}
		return "index";
	}
	
	/* Da chiamare per modificare un Cespite, si occupa anche di modificare l'assegnazione
	 * PER ORA NON SERVE, CONSERVO LA STRUTTURA PER EVENTUALI SVILUPPI FUTURI */
	@PostMapping(path="/editCompleto") 
	public String editCespComp (@RequestParam int idCespite,@RequestParam String descrizione,@RequestParam String dataI,@RequestParam String dataF
			, @RequestParam String tipologiaCespite, @RequestParam String  stato,@RequestParam int tipologiaAssegnazione,@RequestParam int idAssegnatario) {
		
		cu.edit(cs,idCespite,descrizione,tipologiaCespite);
		Optional<Integer> idAss=acs.getFromCespite(idCespite);
		
		if(stato.equals("Non Assegnato")) {
			if(idAss.isPresent()) { 
				int idAssInt=idAss.get();
				acs.delete(acs.getOne(idAssInt));
			}
		}
		else {
			if(idAss.isPresent()==false) {
				acu.inserisciAssegnazioneCespiti(acs,tipologiaAssegnazione,idCespite,dataI,dataF,idAssegnatario);
			}
			else {
				int idAssInt=idAss.get();
				acu.modificaAssegnazioneCespiti(acs,idAssInt,tipologiaAssegnazione,idCespite,dataI,dataF,idAssegnatario);
			}
		}
		return "index";
	}
	
	/* Da chiamare per modificare descrizione e tipologia del cespite*/
	@RequestMapping(path="/editCesp") 
	public String editCesp (Model m,@RequestParam int idCespite,@RequestParam String descrizione,@RequestParam String tipologiaCespite) {
		cu.edit(cs,idCespite,descrizione,tipologiaCespite);
		return ciao2(m);
	}
	
	/* Da chiamare per inserire un nuovo cespite nel db, specificando descrizione e tipologia*/
	@RequestMapping(path="/insCesp") 
	public String insCesp (Model m,@RequestParam String descrizione, @RequestParam String tipologiaCespite) {
		cu.inserisci(cs,descrizione,tipologiaCespite,"Non Assegnato");
		return ciao2(m);
	}
	
	/* Da chiamare per elimninare un cespite dal db*/
	@RequestMapping(path="/deleteCesp") 
	public String deleteCesp(Model m,@RequestParam int id) {
		cu.delete(cs,acs,id);
		return ciao2(m);
	}
	
	@RequestMapping(path="/delAssCesp") 
	public String deleteAssCesp(Model m,@RequestParam int id) {
		acu.eliminaAssegnazioneCespiti(acs,cs,id);
		return ciao2(m);
	}
	@RequestMapping(path="/assignCespDip") 
	public String assignCespDip(Model m,@RequestParam int idCesp,@RequestParam int idDip,@RequestParam String dataI,@RequestParam String dataF) {
		acu.assegnaCespiteADipendente(acs,cs,idCesp,idDip,dataI,dataF);
		return ciao2(m);
	}
	@RequestMapping(path="/assignCespStr") 
	public String assignCespStr(Model m,@RequestParam int idCesp2,@RequestParam int idStruct,@RequestParam String dataIn,@RequestParam String dataFn) {
		acu.assegnaCespiteAStruttura(acs,cs,idCesp2,idStruct,dataIn,dataFn);
		return ciao2(m);
	}
	
	/*-- OPERAZIONI SUI DIPENDENTI --*/
	
	/* Da chiamare quando si vuole inserire un Dipendente con un contratto a tempo determinato o indeterminato. */
	@PostMapping(path="/insDip") 
	public String insertDip (Model m,@RequestParam String nome
			, @RequestParam String cognome, @RequestParam String  email, @RequestParam String  psw, @RequestParam String dataI, @RequestParam String dataF
			, @RequestParam String cf, @RequestParam int  ruolo, @RequestParam String indirizzo) {
		if(!ds.isCfPresente(cf).isPresent()){ 
			if(!dataF.equals("")) {
				du.inserisciDeterminato(ds,cvs,nome,cognome,email,psw,dataI,dataF,cf,ruolo,indirizzo);
			}
			else {
				du.inserisciIndeterminato(ds,cvs,nome,cognome,email,psw,dataI,cf,ruolo,indirizzo);
			}
			return ciao(m);
		}
		else {
			return ciao(m);
		}
	}
	
	/* Da chiamare quando si vuole eliminare un dipendente */
	@RequestMapping(path="/deleteDip") 
	public String deleteDip (Model m,@RequestParam int id) {
		du.elimina(ds,acs,acs2,ns,rs,rps,cs,id);
		return ciao(m);
	}
	
	/* Da chiamare per modificare un dipendente */
	@PostMapping(path="/editDip") 
	public String editDip (Model m,@RequestParam int id,@RequestParam String nome, @RequestParam String cognome,
			@RequestParam String cf, @RequestParam int  ruolo, @RequestParam String indirizzo,@RequestParam String dataI, 
			@RequestParam String dataF) {
		du.edit(ds,id,cf,nome,cognome,indirizzo,dataI,dataF,ruolo);
		return ciao(m);
	}
	
	/* Da chiamare per modificare il profilo personale di un dipendente loggato */
	@PostMapping(path="/editProf") 
	public String editProf(@RequestParam int id,@RequestParam String nome,@RequestParam String password,@RequestParam String cognome, 
			@RequestParam String  email, @RequestParam String cf, @RequestParam String indirizzo) {
		du.editProfilo(ds,id,cf,nome,cognome,email,indirizzo,password);
		return "dipendenti";
	}
	
	/* Da chiamare per inoltrare una richiesta di recupero password */
	@PostMapping(path="/resetPswd") 
	public String resetPsw (@RequestParam int id) {
		rpu.resetPswd(rps,id);
		return "dipendenti";
	}
	

	@GetMapping("/VisualizzaRichieste")

	public String VisualizzaRichieste(Model m) {

		List<RecuperoPassword> lrpacc= new ArrayList<RecuperoPassword>();

		List<RecuperoPassword> lrpda= new ArrayList<RecuperoPassword>();

		List<String> email= new ArrayList<String>();

		List<String> emailri= new ArrayList<String>();





		for(RecuperoPassword rp: rps.findAll()) {

			if(rp.getStato().equals("accettata")){

				lrpacc.add(rp);

				email.add(ds.findById(rp.getId_dipendente_psw()).get().getEmail());}

			if(rp.getStato().equals("da lavorare")){

				lrpda.add(rp);

				emailri.add(ds.findById(rp.getId_dipendente_psw()).get().getEmail());}

			if(rp.getStato().equals("respinta")){

				lrpacc.add(rp);

				email.add(ds.findById(rp.getId_dipendente_psw()).get().getEmail());}

		}

		m.addAttribute("richiesteaa",lrpacc);

		m.addAttribute("richiesteda",lrpda);

		m.addAttribute("email",email);

		m.addAttribute("emailri",emailri);

		return"richieste";

	}

	

	@GetMapping("/respingi")

	public String respingi(Model m, @RequestParam int id_rich) {

		rpu.RespingiRichiesta(rps, id_rich);

		return VisualizzaRichieste(m);

	}

	

	@GetMapping("/accetta")

	public String accetta(Model m,@RequestParam int id_rich, @RequestParam int id_dipps) {

		rpu.AccettaRichiesta(rps, ds, id_rich, id_dipps);

		return VisualizzaRichieste(m);

	}
}
