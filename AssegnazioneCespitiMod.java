package com.sincrono.gestionale.model;

import java.io.Serializable;

public class AssegnazioneCespitiMod extends AssegnazioneCespiti implements Serializable{

	private static final long serialVersionUID = 1L; 
	private String nomeAss;
	private String nomeCespite;
	
	
	
	public AssegnazioneCespitiMod() {
		
	}
	public String getNomeAss() {
		return nomeAss;
	}

	public void setNomeAss(String nomeAss) {
		this.nomeAss = nomeAss;
	}

	public String getNomeCespite() {
		return nomeCespite;
	}

	public void setNomeCespite(String nomeCespite) {
		this.nomeCespite = nomeCespite;
	}
	
	
}
