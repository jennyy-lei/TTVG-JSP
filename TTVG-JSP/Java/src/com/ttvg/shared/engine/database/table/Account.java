package com.ttvg.shared.engine.database.table;

import javax.persistence.*;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name = "account")
public class Account{
	public Account() {}
	
	@Id
	@GenericGenerator(name="Account" , strategy="increment")
	@GeneratedValue(generator="Account")
	@Column(name = "id")
	protected int id;
	public int getId() {
		return id;
	}
	public void setId( int id ) {
		this.id = id;
	}
	 
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "PersonId")
    protected Account person;
    public Account getPerson() {
        return person;
    }
	public void setPerson( Account person ) {
		this.person = person;
	}

	@Column(name = "GivenName")
	protected String givenName;
	public String getGivenName() {
		return givenName;
	}
	public void setGivenName( String givenName ) {
		this.givenName = givenName;
	}

	@Column(name = "Email")
	protected String email;
	public String getEmail() {
		return email;
	}
	public void setEmail( String email ) {
		this.email = email;
	}

	@Column(name = "Password")
	protected String password;
	public String getPassword() {
		return password;
	}
	public void setPassword( String password ) {
		this.password = password;
	}
}
