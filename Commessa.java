package com.sincrono.gestionale.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="commesse")
public class Commessa implements Serializable{

	private static final long serialVersionUID = 1L;
	private int id_commessa;
	private int id_cliente;
	private String titolo_progetto;
	private Date data_inizio;
	private Date data_fine;

	
	public Commessa() {
		
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id_commesse")
	public int getId_commessa() {
		return id_commessa;
	}

	public void setId_commessa(int id_commessa) {
		this.id_commessa = id_commessa;
	}
	
	@Column(name="id_cliente")
	public int getId_cliente() {
		return id_cliente;
	}

	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	
	@Column(name="titolo_progetto")
	public String getTitolo_progetto() {
		return titolo_progetto;
	}

	public void setTitolo_progetto(String titolo_progetto) {
		this.titolo_progetto = titolo_progetto;
	}
	
	@Column(name="data_inizio")
	public Date getData_inizio() {
		return data_inizio;
	}

	public void setData_inizio(Date data_inizio) {
		this.data_inizio = data_inizio;
	}
	
	@Column(name="data_fine")
	public Date getData_fine() {
		return data_fine;
	}

	public void setData_fine(Date data_fine) {
		this.data_fine = data_fine;
	}
	

	
	
}
	