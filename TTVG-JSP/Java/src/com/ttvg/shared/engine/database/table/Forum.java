package com.ttvg.shared.engine.database.table;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

import org.hibernate.annotations.GenericGenerator;

import com.ttvg.shared.engine.base.EntityResolvable;


@Entity
@Table(name = "forum")
public class Forum extends EntityResolvable {
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
	 
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
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
	
    @OneToOne(fetch = FetchType.LAZY)
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
	
	@Column(name = "DateTime")
    @Temporal(TemporalType.TIMESTAMP)
    protected Date dateTime;
    public Date getDateTime() {
        return dateTime;
    }
    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }
	
	@Column(name = "Priority")
	protected int priority;
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
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
	
	@Override
	public void resolve() throws Exception {
		// TODO Auto-generated method stub
		followingForums.size();
	}

	@Override
	public void resolve(int limit) throws Exception {
		// TODO Auto-generated method stub
		this.resolve();
		if ( limit != 0 ){
			int nextLimit = limit > 0 ? limit - 1 : limit;
			for (Forum item : followingForums){
				item.resolve(nextLimit);
			}
		}
	}

}
