package com.sincrono.gestionale.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.sincrono.gestionale.model.AssegnazioneCespitiService;
import com.sincrono.gestionale.model.AssegnazioneCespitiUtil;
import com.sincrono.gestionale.model.AssegnazioneCommesseService;
import com.sincrono.gestionale.model.AssegnazioneCommesseUtil;
import com.sincrono.gestionale.model.CespiteService;
import com.sincrono.gestionale.model.CespiteUtil;
import com.sincrono.gestionale.model.ClienteService;
import com.sincrono.gestionale.model.ClienteUtil;
import com.sincrono.gestionale.model.CommessaService;
import com.sincrono.gestionale.model.CommessaUtil;
import com.sincrono.gestionale.model.CvService;
import com.sincrono.gestionale.model.Dipendente;
import com.sincrono.gestionale.model.DipendenteService;
import com.sincrono.gestionale.model.DipendenteUtil;
import com.sincrono.gestionale.model.RecuperoPasswordService;
import com.sincrono.gestionale.model.RecuperoPasswordUtil;
import com.sincrono.gestionale.model.RuoloService;

@Controller
//@RequestMapping(path="/")
@RequestMapping(path="/comm")
public class CommercialeController {
	
	//Classi di utilità per effettuare le operazioni personalizzate
	AssegnazioneCommesseUtil acu=new AssegnazioneCommesseUtil();
	CommessaUtil cu=new CommessaUtil();
	ClienteUtil clu=new ClienteUtil();
	DipendenteUtil du=new DipendenteUtil();
	
	//Classi service che forniscono i metodi CRUD + i metodi personalizzati con @Query
	@Autowired
	DipendenteService dipendenteService;
	@Autowired
	CommessaService cs;
	@Autowired
	ClienteService cls;
	@Autowired
	AssegnazioneCommesseService acs;
	@Autowired
	RuoloService rs;
	
	@RequestMapping("/clienti")
	public String getClientiPage(Model mdl) {
		mdl.addAttribute("listaClienti", cls.findAll());
		return "clienti";
	}
	

	/*-- OPERAZIONI SUI CLIENTI --*/
	
	/* Da chiamare per inserire un nuovo cliente nel db.
	 * Se esiste nel db un cliente con lo stesso cf/partita iva, non effettua l'inserimento.
	 * (ma non visualizza messaggi di errore quindi controlla il database per vedere le non-modifiche) */
	@RequestMapping(path="/insCliente") 
//	id_cliente,ragione_sociale,cf_piva,stato,email,telefono,indirizzo,categoria
	public String insertCli (Model mdl,@RequestParam String ragSociale, @RequestParam String stato,@RequestParam String email, @RequestParam String  telefono
			, @RequestParam String cfPiva,@RequestParam String indirizzo,@RequestParam String categoria) {
		
		if(!cls.isCfPresente(cfPiva).isPresent()){
			clu.inserisci(cls,ragSociale,cfPiva,stato,email,telefono,indirizzo,categoria);
		}
		
		mdl.addAttribute("listaClienti", cls.findAll());
		return getClientiPage(mdl);
	}
	
	/* Da chiamare per modificare un cliente già presente nel db.
	 *  */
	@RequestMapping(path="/modCliente") 
	public String modCli (Model mdl,@RequestParam int idCliente,@RequestParam String ragSociale, @RequestParam String stato,@RequestParam String email, @RequestParam String  telefono
			, @RequestParam String cfPiva,@RequestParam String indirizzo,@RequestParam String categoria) {
		
		clu.modifica(cls,idCliente,ragSociale,cfPiva,stato,email,telefono,indirizzo,categoria);
		return getClientiPage(mdl);
	}
	
	/* Da chiamare quando si vuole eliminare un cliente */
	@RequestMapping(path="/deleteCliente") 
	public String deleteCli (Model mdl,@RequestParam int id) {
		clu.elimina(cls,id);
		mdl.addAttribute("listaClienti", cls.findAll());
		return getClientiPage(mdl);
	}
	
/*-- OPERAZIONI SULLE COMMESSE --*/
	

	/* Da chiamare per modificare una commessa già esistente nel db.
	 * NON GESTISCE L'ASSEGNAMENTO, immagino di modificare gli assegnamenti in modo diverso
	 * (cioè da una schermata apposita del frontend)*/
	@RequestMapping(path="/modCommessa") 
	public String modCommessa (Model m,@RequestParam int idCommessa,@RequestParam int idCliente,@RequestParam String titoloProgetto,
			@RequestParam String dataInizio,@RequestParam String dataFine) {
		cu.modifica(cs,idCommessa,idCliente,titoloProgetto,dataInizio,dataFine);
		m.addAttribute("ListaIdClienti",cu.getListaIdClienteByListaCommesse(cs.findAll()));
		m.addAttribute("Listanomiclienti",clu.getRagioneSocialebyId(cls, cu.getListaIdClienteByListaCommesse(cs.findAll())));
		m.addAttribute("ListaCommesse",cs.findAll());
		
		//menu a tendina dei clienti//
		m.addAttribute("clienti",clu.recuperaRagioneSocDaListaClienti(cls, cls.findAll()));
		return showCommesse(m);
	}
	

	
	/* Da chiamare per modificare un assegnamento già esistente nel DB
	 * Posso modificare il dipendente a cui è assegnata la commessa o modificare il costo e il prezzo
	 * previsti per l'azienda e per il cliente.
	 * Il valore idAssegnazione verrà passato dal frontend, che idealmente avrà un menù a tendina
	 * (o qualcosa del genere) con tutte le assegnazione di commesse presenti e modificabili */
	@RequestMapping(path="/modAssCommessa") 
	public String modCommessa ( Model m, @RequestParam int prezzo,@RequestParam int costo,@RequestParam int idAssegnazione,
			@RequestParam int idDipendente, @RequestParam int idC,@RequestParam String fin) {
		acu.modifica(acs,idAssegnazione,idDipendente,costo,prezzo);
		
		List<Dipendente> listadip= du.getListaDipendentebyListaIdDip(dipendenteService, acs.getIdDipFromIdCommessa(idC));
		
		List<String> ruolo= new ArrayList<String>();
		List<Integer> id = new ArrayList<Integer>();
		for(Dipendente d : listadip) {
			id.add(d.getId_ruolo());
		}
		for (Integer id_r: id) {
			ruolo.add(rs.findById(id_r).get().getTitolo());
		}
		
		m.addAttribute("asse",acu.getidAsseCommbyListCommessa(acs, acs.getListaAssegnamentoCommessebyIdCommessa(idC)));
		m.addAttribute("titolo",cs.getTitleFromId(idC).get());
		m.addAttribute("iddipe",listadip);
		m.addAttribute("ruolo",ruolo);
		m.addAttribute("costo",acs.getListaCostoFromIdCommessa(idC));
		m.addAttribute("prezzo",acs.getListaPrezzoFromIdCommessa(idC));

		//per visualizzare tabella dipendenti non assegnati
		List<Dipendente> listatuttidip = dipendenteService.findAll();
		List<Dipendente> listadipnonassegnati= new ArrayList<Dipendente>();
		for (Dipendente dipendente: listatuttidip) {
			if(listadip.contains(dipendente)==false) {
				listadipnonassegnati.add(dipendente);
			}
		}
		
		List<String> ruolo1= new ArrayList<String>();
		List<Integer> id1 = new ArrayList<Integer>();
		for(Dipendente d1 : listadipnonassegnati) {
			id1.add(d1.getId_ruolo());
		}
		for (Integer id_r: id1) {
			ruolo1.add(rs.findById(id_r).get().getTitolo());
		}
		
		m.addAttribute("nonasse",listadipnonassegnati);
		m.addAttribute("ruolo1",ruolo1);
		m.addAttribute("idcom", idC);
		m.addAttribute("idCommessa",idC);
		return AssComm(m,idC,fin);
	}
	
	//per visualizzare tabella commesse
	@RequestMapping(path="/commesse")
	public String showCommesse(Model m) {
		m.addAttribute("ListaIdClienti",cu.getListaIdClienteByListaCommesse(cs.findAll()));
		m.addAttribute("Listanomiclienti",clu.getRagioneSocialebyId(cls, cu.getListaIdClienteByListaCommesse(cs.findAll())));
		m.addAttribute("ListaCommesse",cs.findAll());
		
		//menu a tendina dei clienti//
		m.addAttribute("clienti",clu.recuperaRagioneSocDaListaClienti(cls, cls.findAll()));
		
		return "commesse";
	}
	
	//Per inserire una nuova commessa
	@GetMapping(path="/insCommessa") 
		public String insCommessa (Model m,@RequestParam String nomeCliente,@RequestParam String titoloProgetto,
				@RequestParam String dataInizio,@RequestParam String dataFine) {
		int idCliente=cls.findIdClienteFromRagioneSociale(nomeCliente);
		if(!cs.isCommessaPresente(idCliente,titoloProgetto).isPresent()){
			cu.inserisci(cs,idCliente,titoloProgetto,dataInizio,dataFine);
		}

		//visualizza commesse//
		m.addAttribute("ListaIdClienti",cu.getListaIdClienteByListaCommesse(cs.findAll()));
		m.addAttribute("Listanomiclienti",clu.getRagioneSocialebyId(cls, cu.getListaIdClienteByListaCommesse(cs.findAll())));
		m.addAttribute("ListaCommesse",cs.findAll());
		
		//menu a tendina dei clienti//
		m.addAttribute("clienti",clu.recuperaRagioneSocDaListaClienti(cls, cls.findAll()));
		return "commesse";
	}
	
	
	//per visualizzare tabella assegnazione commessa
	@RequestMapping(path="/assegnazioneCommessa")
	public String AssComm(Model m,@RequestParam int id_commessa, @RequestParam String fin) {

		

		List<Dipendente> listadip= du.getListaDipendentebyListaIdDip(dipendenteService, acs.getIdDipFromIdCommessa(id_commessa));

		

		List<String> ruolo= new ArrayList<String>();

		List<Integer> id = new ArrayList<Integer>();

		for(Dipendente d : listadip) {

			id.add(d.getId_ruolo());

		}

		for (Integer id_r: id) {

			ruolo.add(rs.findById(id_r).get().getTitolo());

		}

		

		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");

		Date fin1;
		try {
			fin1 = format.parse(fin);
			m.addAttribute("fin",fin1);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	

		

		m.addAttribute("asse",acu.getidAsseCommbyListCommessa(acs, acs.getListaAssegnamentoCommessebyIdCommessa(id_commessa)));

		m.addAttribute("titolo",cs.getTitleFromId(id_commessa).get());

		m.addAttribute("idCommessa",id_commessa);

		m.addAttribute("iddipe",listadip);

		m.addAttribute("ruolo",ruolo);

		m.addAttribute("costo",acs.getListaCostoFromIdCommessa(id_commessa));

		m.addAttribute("prezzo",acs.getListaPrezzoFromIdCommessa(id_commessa));



		//per visualizzare tabella dipendenti non assegnati

		List<Dipendente> listatuttidip = dipendenteService.findAll();

		List<Dipendente> listadipnonassegnati= new ArrayList<Dipendente>();

		for (Dipendente dipendente: listatuttidip) {

			if(listadip.contains(dipendente)==false) {

				listadipnonassegnati.add(dipendente);

			}

		}

		

		List<String> ruolo1= new ArrayList<String>();

		List<Integer> id1 = new ArrayList<Integer>();

		for(Dipendente d1 : listadipnonassegnati) {

			id1.add(d1.getId_ruolo());

		}

		for (Integer id_r: id1) {

			ruolo1.add(rs.findById(id_r).get().getTitolo());

		}

		

		m.addAttribute("nonasse",listadipnonassegnati);

		m.addAttribute("ruolo1",ruolo1);

		m.addAttribute("idcom", id_commessa);

		

		return "AssegnamentoCommesse";

	}

	

		

	
	
	@RequestMapping(path="/assignCommessa") 
	public String assCommessa (Model m,@RequestParam int idDipendente,@RequestParam int idCommessa,@RequestParam float costo,
			@RequestParam float prezzo,@RequestParam String fin) {
		
		if(!acs.getIdAssegnamentoEsistente(idDipendente,idCommessa).isPresent()){
			acu.inserisci(acs,idDipendente,idCommessa,costo,prezzo);
		}
		
				
		List<Dipendente> listadip= du.getListaDipendentebyListaIdDip(dipendenteService, acs.getIdDipFromIdCommessa(idCommessa));
		
		List<String> ruolo= new ArrayList<String>();
		List<Integer> id = new ArrayList<Integer>();
		for(Dipendente d : listadip) {
			id.add(d.getId_ruolo());
		}
		for (Integer id_r: id) {
			ruolo.add(rs.findById(id_r).get().getTitolo());
		}
		
		m.addAttribute("asse",acu.getidAsseCommbyListCommessa(acs, acs.getListaAssegnamentoCommessebyIdCommessa(idCommessa)));
		m.addAttribute("titolo",cs.getTitleFromId(idCommessa).get());
		m.addAttribute("iddipe",listadip);
		m.addAttribute("ruolo",ruolo);
		m.addAttribute("idCommessa",idCommessa);
		m.addAttribute("costo",acs.getListaCostoFromIdCommessa(idCommessa));
		m.addAttribute("prezzo",acs.getListaPrezzoFromIdCommessa(idCommessa));

		//per visualizzare tabella dipendenti non assegnati
		List<Dipendente> listatuttidip = dipendenteService.findAll();
		List<Dipendente> listadipnonassegnati= new ArrayList<Dipendente>();
		for (Dipendente dipendente: listatuttidip) {
			if(listadip.contains(dipendente)==false) {
				listadipnonassegnati.add(dipendente);
			}
		}
		
		List<String> ruolo1= new ArrayList<String>();
		List<Integer> id1 = new ArrayList<Integer>();
		for(Dipendente d1 : listadipnonassegnati) {
			id1.add(d1.getId_ruolo());
		}
		for (Integer id_r: id1) {
			ruolo1.add(rs.findById(id_r).get().getTitolo());
		}
		
		m.addAttribute("nonasse",listadipnonassegnati);
		m.addAttribute("ruolo1",ruolo1);
		m.addAttribute("idcom", idCommessa);
			
		return AssComm(m,idCommessa,fin);
	}
	@RequestMapping(path="/deleteCommessa") 
	public String deleteAssCommessa (Model m,@RequestParam int idAssegnazioneCommessa,@RequestParam int idCommessa,@RequestParam String fin) {
		acu.elimina(acs,idAssegnazioneCommessa);
		return AssComm(m,idCommessa,fin);
	}
	
}
