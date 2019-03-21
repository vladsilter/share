package com.sincrono.gestionale.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RecuperoPasswordService extends JpaRepository<RecuperoPassword, Integer> {
	
	
	@Query("FROM RecuperoPassword where  id_dipendente_psw=?1")
	public Optional<List<RecuperoPassword>> getRecuperiByIdDipendente(int idCliente);
}
