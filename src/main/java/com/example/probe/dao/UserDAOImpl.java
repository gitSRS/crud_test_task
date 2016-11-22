package com.example.probe.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.example.probe.model.User;

@Repository
public class UserDAOImpl implements UserDAO {

	private static final Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);
	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}
	
	@Override
	public Integer addUser(User u) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(u);
		logger.info("User saved successfully, User Details="+u);
		return u.getId();
	}

	@Override
	public void updateUser(User u) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(u);
		logger.info("User updated successfully, User Details="+u);
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<User> listUsers() {
		Session session = this.sessionFactory.getCurrentSession();
		List<User> usersList = session.createQuery("from User").list();
		
		return usersList;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> listUsers(String name) {
		Session session = this.sessionFactory.getCurrentSession();
		String sql = "from User where name like '"+name+"%'";
		List<User> usersList = session.createQuery(sql).list();
		
		return usersList;
	}

	@Override
	public User getUserById(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		User user = (User) session.load(User.class, new Integer(id));
		logger.info("User loaded successfully, User details="+user);
		return user;
	}

	@Override
	public void removeUser(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		User u = (User) session.load(User.class, new Integer(id));
		if(null != u){
			session.delete(u);
		}
		logger.info("User deleted successfully, User details="+u);
		
	}

}
