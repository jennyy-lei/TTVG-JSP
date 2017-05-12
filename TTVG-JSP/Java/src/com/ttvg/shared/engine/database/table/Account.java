package com.ttvg.shared.engine.database.table;

import java.util.Date;

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
	 
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "PersonId")
    protected Person person;
    public Person getPerson() {
        return person;
    }
	public void setPerson( Person person ) {
		this.person = person;
	}

	@Column(name = "Role")
	protected String role;
	public String getRole() {
		return role;
	}
	public void setRole( String role ) {
		this.role = role;
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
	
	@Column(name = "Created")
    @Temporal(TemporalType.TIMESTAMP)
    protected Date created;
    public Date getCreatedDateTime() {
        return created;
    }
    public void setCreatedDateTime(Date dateTime) {
        this.created = dateTime;
    }
}
