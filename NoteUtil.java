package com.sincrono.gestionale.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;

public class NoteUtil {

	/* 
	 * Metodo che ritorna tutte le note di una specifica commessa
	 */
	public List<Note> getNotabyIdcommessa(NoteService noteservice, int id_commessa) {
		List<Note> note=noteservice.findAll();
		note=note.stream().filter(x -> x.getId_commessa_nota()==id_commessa).collect(Collectors.toList());
		return note;
	}
	
	/*
	 * Metodo che ritorna le id_commesse da una tabella AssegnamentoCommessa
	 */
	public List<Integer> getListIdCommessebyListaAssegnamento(NoteService noteservice, List<AssegnazioneCommesse> listaassegnamentocommessa) {
		List<Integer> listaidcommesse = new ArrayList<Integer>();
		for (AssegnazioneCommesse  x: listaassegnamentocommessa) {
			listaidcommesse.add(x.getId_commessa());
		}
		return listaidcommesse;
	}
	
	/*
	 * Metodo che ritorna le id_commesse da una tabella AssegnamentoCommessa
	 */
	public List<Integer> getNotabyListaAssegnamento(NoteService noteservice, List<AssegnazioneCommesse> listaassegnamentocommessa) {
		List<Integer> listaidcommesse = new ArrayList<Integer>();
		for (AssegnazioneCommesse  x: listaassegnamentocommessa) {
			listaidcommesse.add(x.getId_commessa());
		}
		return listaidcommesse;
	}
	
	
	/*
	 * Metodo che ritorna una lista finale note
	 */
	public List<List<Note>> getListanote(NoteService noteservice,List<Integer> listaidcommesse){
		List<List<Note>> listafin=new ArrayList<List<Note>>();
		for (Integer idcommesse: listaidcommesse) {
			List<Note> listanote=this.getNotabyIdcommessa(noteservice, idcommesse);
			listafin.add(listanote);
		}
		return listafin;
	}
	
	public List<String> trasformation(CommessaService commessaService, DipendenteService dipendenteService, List<List<Note>> listafin){
		String s="";
		List<String> listas= new ArrayList<>();
		for (List<Note> listanote: listafin) {
			for (Note nota:listanote) {
				s=nota.getId_note() + ": " +commessaService.getTitleFromId(nota.getId_commessa_nota()).get()+": "+ dipendenteService.FindCognomeIDdip(nota.getId_dip_autore())+ " "+dipendenteService.FindNomeIDdip(nota.getId_dip_autore())+": "+nota.getNota();
				listas.add(s);
			}
		}
		return listas;
	}
	
	
	
	public Boolean addNewNote(NoteService noteservice,int id_dip_autore, int id_commessa_nota, String nota) {
		Note nt=new Note();
		nt.setId_dip_autore(id_dip_autore);
		nt.setId_commessa_nota(id_commessa_nota);
		nt.setNota(nota);
		Note tmp=noteservice.save(nt);
		return tmp != null ? true : false;
	}
}