package com.sincrono.gestionale.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="note")
public class Note implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer id_note;
	private int id_dip_autore;
	private int id_commessa_nota;
	private String nota;
	
	public Note() {
		super();
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getId_note() {
		return id_note;
	}

	public void setId_note(Integer id_note) {
		this.id_note = id_note;
	}
	
	@Column(name="id_dip_autore")
	public int getId_dip_autore() {
		return id_dip_autore;
	}

	public void setId_dip_autore(int id_dip_autore) {
		this.id_dip_autore = id_dip_autore;
	}
	
	@Column(name="id_commessa_nota")
	public int getId_commessa_nota() {
		return id_commessa_nota;
	}

	public void setId_commessa_nota(int id_commessa_nota) {
		this.id_commessa_nota = id_commessa_nota;
	}
	
	@Column(name="nota")
	public String getNota() {
		return nota;
	}

	public void setNota(String nota) {
		this.nota = nota;
	}
	
	
	
	
	
}