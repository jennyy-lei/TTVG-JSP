package com.ttvg.shared.engine.database.table;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name = "forum")
public class Forum{
	public Forum() {}
	
	@Id
	@GenericGenerator(name="Forum" , strategy="increment")
	@GeneratedValue(generator="Forum")
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
    protected Person person;
    public Person getPerson() {
        return person;
    }
	public void setPerson( Person person ) {
		this.person = person;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "forum")
	protected Set<Forum> followingForums = new HashSet<Forum>(0);
	public Set<Forum> getFollowingForums() {
		return this.followingForums;
	}

	public void setFollowingForums(Set<Forum> followingForums) {
		this.followingForums = followingForums;
	}
	
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ForumId")
    protected Forum forum;
    public Forum getForum() {
        return forum;
    }
	public void setForum( Forum forum ) {
		this.forum = forum;
	}

	@Column(name = "Title")
	protected String title;
	public String getTitle() {
		return title;
	}
	public void setTitle( String title ) {
		this.title = title;
	}

	@Column(name = "Content")
	protected String content;
	public String getContent() {
		return content;
	}
	public void setContent( String content ) {
		this.content = content;
	}
	
    @Temporal(TemporalType.TIMESTAMP)
    protected Date dateTime;
    public Date getDateTime() {
        return dateTime;
    }
    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

}
