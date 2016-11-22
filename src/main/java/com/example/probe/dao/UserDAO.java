package com.example.probe.dao;

import java.util.List;
import com.example.probe.model.User;

public interface UserDAO {

	public Integer addUser(User u);
	public void updateUser(User u);
	public List<User> listUsers();
	public List<User> listUsers(String name);
	public User getUserById(int id);
	public void removeUser(int id);
}
