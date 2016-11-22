package com.example.probe.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import java.io.Serializable;
import java.sql.Timestamp;

@Entity
@Table(name="USER")
public class User implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6431550983890009559L;

	@Id
	@Column(name="id")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
	
	@Column(name="name")
    private String name;
	
	@Column(name="age")
    private Integer age;
	
	@Column(name="isAdmin")
    private Boolean admin;
	
	@Column(name="createdDate", nullable = false, updatable=false)
    private Timestamp createdDate;
	
		
	public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate() {
        this.createdDate =  new Timestamp(System.currentTimeMillis());
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}

	@Override
	public String toString(){
		return "id="+id+", name="+name+", age="+age+", admin="+admin+", date="+createdDate;
	}
}
