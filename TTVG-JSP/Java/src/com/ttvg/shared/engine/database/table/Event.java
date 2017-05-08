package com.ttvg.shared.engine.database.table;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name = "event")
public class Event{
	public Event() {}
	
	@Id
	@GenericGenerator(name="Event" , strategy="increment")
	@GeneratedValue(generator="Event")
	@Column(name = "id")
	protected int id;
	public int getId() {
		return id;
	}
	public void setId( int id ) {
		this.id = id;
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

	@Column(name = "EventType")
	protected String type;
	public String getType() {
		return type;
	}
	public void setType( String type ) {
		this.type = type;
	}

	@Column(name = "EventCategory")
	protected String category;
	public String getCategory() {
		return category;
	}
	public void setCategory( String category ) {
		this.category = category;
	}
	
	@Column(name = "FromDate")
    @Temporal(TemporalType.DATE)
    protected Date fromDate;
    public Date getFromDate() {
        return fromDate;
    }
    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }
	
	@Column(name = "ToDate")
    @Temporal(TemporalType.DATE)
    protected Date toDate;
    public Date getToDate() {
        return toDate;
    }
    public void setToDate(Date toDate) {
        this.toDate = toDate;
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

}
