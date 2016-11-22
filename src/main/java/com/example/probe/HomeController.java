package com.example.probe;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.probe.model.User;
import com.example.probe.service.UserService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private UserService userService;
	
	
	@Autowired(required=true)
	@Qualifier(value="userService")
	
	public void setUserService(UserService us){
		this.userService = us;
	}
	
	//For redirection to home page
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		//logger.info("redirection to /user");
		return "home";
	}
	
		
		@RequestMapping("/remove/{id}")
	    public String removeUser(@PathVariable("id") int id, Model model){
			this.userService.removeUser(id);
			model.addAttribute("message", "User with id = "+id+" removed");
	        //return "redirect:/user/page";
			return "home";
	    }
		
		//For edit or find user
		@RequestMapping("/user/action")
	    public String userAction(@RequestParam(required = false) Integer page, @ModelAttribute("user") User u, Model model){
			logger.info("edit= "+u);
			
			if(u.getId() != null){
				//existing user, call update
				logger.info("user from service="+this.userService.getUserById(u.getId()));
				this.userService.updateUser(u);
				return "redirect:/user/page";
			} else if(u.getId() == null && u.getName() != null) {
				
				model.addAttribute("user", new User());
				model.addAttribute("listUsers", this.userService.listUsers(u.getName()));
		        			
				return "page";
			}
			
			return "redirect:/user/page";
	    }
		
		
		@RequestMapping("/user/edit")
	    public String editUser(@ModelAttribute("user") User u, Model model){
			logger.info("edit= "+u);
			
			if(u.getId() != null){
				//existing user, call update
				this.userService.updateUser(u);
			}
			
	        return "redirect:/user/page";
	    }
	    
		
		@RequestMapping("/edit/{id}")
	    public String editUser(@PathVariable("id") int id, Model model){
	        model.addAttribute("user", this.userService.getUserById(id));
	        return "page";
	    }
		
		
		//For displaying add page 
		@RequestMapping("/user/adduserpage")
	    public String showUser(Model model){
	        model.addAttribute("user", new User());
	        
	        return "adduser";
	    }
		
		@RequestMapping(value= "/user/adduser", method = {RequestMethod.POST, RequestMethod.GET})
		public String addUser(@ModelAttribute("user") User u, Model model){
			logger.info("start add");
			
		    String message = "";
			if(u.getId() == null && u.getName() != ""){
				//new user, add it
				u.setCreatedDate();
				Integer i = this.userService.addUser(u);
				message = "User with Id ="+i+" added ";
				
			}else {
				message = "Name must not be null";
			}
			
			model.addAttribute("message", message);
			
			return "home";
		}
		
		
		//For displaying all users page, edit and find 
		@RequestMapping("/user/page")
		public String usersList(@RequestParam(required = false) Integer page, Model model){
		     
			logger.info("start /user/page");
			
			model.addAttribute("user", new User());
			PagedListHolder<User> pagedListHolder = new PagedListHolder<>(this.userService.listUsers());
			pagedListHolder.setPageSize(5);
			model.addAttribute("maxPages", pagedListHolder.getPageCount());
			if(page==null || page < 1 || page > pagedListHolder.getPageCount())page=1;
			model.addAttribute("page", page);
			
			if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
	            pagedListHolder.setPage(0);
	            model.addAttribute("listUsers", pagedListHolder.getPageList());
	        }else if(page <= pagedListHolder.getPageCount()) {
	            pagedListHolder.setPage(page-1);
	            model.addAttribute("listUsers", pagedListHolder.getPageList());
	        }
	        			
			return "page";
		}
		
}
