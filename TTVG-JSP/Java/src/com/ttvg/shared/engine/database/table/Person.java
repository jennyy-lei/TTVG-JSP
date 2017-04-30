package com.ttvg.shared.engine.database.table;

import javax.persistence.*;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name = "person")
public class Person{
	public Person() {}
	
	@Id
	@GenericGenerator(name="Person" , strategy="increment")
	@GeneratedValue(generator="Person")
	@Column(name = "id")
	protected int id;
	public int getId() {
		return id;
	}
	public void setId( int id ) {
		this.id = id;
	}
	 
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ParentId")
    protected Person parent;
    public Person Parent() {
        return parent;
    }
 
    public void setAuthor(Person parent) {
        this.parent = parent;
    }

	@Column(name = "GivenName")
	protected String givenName;
	public String getGivenName() {
		return givenName;
	}
	public void setGivenName( String givenName ) {
		this.givenName = givenName;
	}

	@Column(name = "LastName")
	protected String lastName;
	public String getLastName() {
		return lastName;
	}
	public void setLastName( String lastName ) {
		this.lastName = lastName;
	}

	@Column(name = "MiddleName")
	protected String middleName;
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName( String middleName ) {
		this.middleName = middleName;
	}

	@Column(name = "Phone")
	protected String phone;
	public String getPhone() {
		return phone;
	}
	public void setPhone( String phone ) {
		this.phone = phone;
	}

	@Column(name = "Mobile")
	protected String mobile;
	public String getMobile() {
		return mobile;
	}
	public void setMobile( String mobile ) {
		this.mobile = mobile;
	}

	@Column(name = "Address")
	protected String address;
	public String getAddress() {
		return address;
	}
	public void setAddress( String address ) {
		this.address = address;
	}
}
