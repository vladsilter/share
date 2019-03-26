package com.sincrono.gestionale.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface NoteService extends JpaRepository<Note, Integer> {
	
	@Query("SELECT id_commessa_nota FROM Note ")
	public List<Integer> getIdCommessa();
	
	/* Restituisce una lista (optional) di tutte le note pubblicate dal dipendente con l'id uguale a quello in input  */
	@Query("FROM Note where id_dip_autore=?1")
	public Optional<List<Note>> getNoteByDipendente(int id);

}