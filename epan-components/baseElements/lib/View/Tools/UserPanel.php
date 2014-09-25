<?php

namespace baseElements;

class View_Tools_UserPanel extends \componentBase\View_Component{
	public $html_attributes=array(); // ONLY Available in server side components
	
	function init(){
		parent::init();
		$user_panel_name="Login ID";
		$user_panel_pass="Password";
		$user_panel_btn_login_name="Login";
		$user_panel_btn_registration_name="registration";
		$user_panel_remember_pass="Remember password";
		$user_panel_forgot_pass="forgot password";

		

		if($this->html_attributes['user_panel_name'])
			$user_panel_name=$this->html_attributes['user_panel_name'];

		if($this->html_attributes['user_panel_pass'])
			$user_panel_pass=$this->html_attributes['user_panel_pass'];

		if($this->html_attributes['user_panel_remember_caption'])
			$user_panel_remember_pass=$this->html_attributes['user_panel_remember_caption'];

		if($this->html_attributes['user_panel_btn_login_name'])
			$user_panel_btn_login_name=$this->html_attributes['user_panel_btn_login_name'];
		
		if($this->html_attributes['user_panel_forgot_pass'])
			$user_panel_forgot_pass=$this->html_attributes['user_panel_forgot_pass'];

		if($this->html_attributes['user_panel_btn_registration_name'])
			$user_panel_btn_registration_name=$this->html_attributes['user_panel_btn_registration_name'];

		if(!$this->api->auth->isLoggedIn()){
			$this->api->stickyGET('new_registration');

			if($_GET['new_registration']){
				$r_form = $this->add('Form');
				$r_form->addField('line','first_name')->validateNotNull(true);
				$r_form->addField('line','last_name')->validateNotNull(true);
				$r_form->addField('line','email_id')->validateNotNull()->validateField('filter_var($this->get(), FILTER_VALIDATE_EMAIL)');
				$r_form->addField('password','password')->validateNotNull(true);
				$r_form->addField('password','re_password')->validateNotNull(true);				
				$r_form->addSubmit('submit')->set('Register');

				if($r_form->isSubmitted()){

					if( $r_form['password'] != $r_form['re_password']){
						$r_form->displayError('password','Password not match');
					}

					$user_model=$this->add('Model_Users');
					$user_model['name'] = $r_form['first_name']." ".$r_form['last_name'];
					$user_model['email'] = $r_form['email_id'];
					$user_model['username'] = $r_form['email_id'];
					$user_model['password'] = $r_form['password'];
					$user_model['created_at'] = date('Y-m-d');
					$user_model['type'] = 50;
					$user_model['activation_code'] = rand(999,10000);
					$user_model['epan_id'] = $this->api->current_website->id;
					$user_model->save();
					// $r_form->js()->reload()->execute();
					$this->js(null,$this->js()->univ()->successMessage('Created Successfully'))->reload()->execute();
				}

			}else{
				// create login form
				$form=$this->add('Form');
				
				if($this->html_attributes['form_stacked_on'])
					$form->addClass('stacked');

				$username_field = $form->addField('line','username',$user_panel_name)->validateNotNull();
				$password_field = $form->addField('password','password',$user_panel_pass)->validateNotNull();

				if($this->html_attributes['user_panel_username_placeholder'])
					$username_field->setAttr('placeHolder',$this->html_attributes['user_panel_username_placeholder']);
				if($this->html_attributes['user_panel_password_placeholder'])
					$password_field->setAttr('placeHolder',$this->html_attributes['user_panel_password_placeholder']);
				
				$cols = $form->add('Columns');
				$col = $cols->addColumn(12);
				$submit_field = $form->addSubmit($user_panel_btn_login_name)->addClass('btn btn-block btn-default');
				$submit_field->js(true)->appendTo($col);//->add($submit_field);
				$form->js(true)->find('.atk-buttons')->removeClass('atk-buttons');
				// $submit_field->js('click',$form->js()->submit());
					
				if($this->html_attributes['show_remember_me']){
					$col = $cols->addColumn(6);
					$remeber_field = $form->addField('Checkbox','remember',$user_panel_remember_pass);
					$col->add($remeber_field);
					}
				if($this->html_attributes['show_forgot_password']){
					$col = $cols->addColumn(6);
					$forgot_field = $form->add('View')->set($user_panel_forgot_pass)->setElement('a')->setAttr('href','index.php');
					$col->add($forgot_field);	
					}	

				if($this->html_attributes['show_register_new_user']){
					$col = $cols->addColumn(12);
					$sign_up_field = $form->add('Button')->set($user_panel_btn_registration_name);
					$col->add($sign_up_field);
					$sign_up_field->js('click',$this->js()->reload(array('new_registration'=>1)));
				}	
				
				
				

				if($form->isSubmitted()){
					$user_model = $this->add('Model_Users');
					$user_model->addCondition('username',$form['username']);
					$user_model->addCondition('password',$form['password']);
					$user_model->tryLoadAny();

					if(!$user_model->loaded())
						$form->displayError('username','Wrong Credentials');

					if(!$user_model['is_active'])
						$form->displayError('username','Please Activate Your Account First');

					$this->api->auth->login($user_model);
					// if reload page
						$this->js()->univ()->redirect($this->api->url(null,array('subpage'=>$_GET['subpage'])))->execute();
					// else
						$this->js()->reload()->execute();
				}
			}

		}else{
			// create hello user panel
			$cols=$this->add('Columns');
			$leftcol=$cols->addColumn(10);
			$rightcol=$cols->addColumn(2);
			$leftcol->add('View')->set('Hello'." ".$this->api->auth->model['username']);
			$rightcol->add('View')->set('Logout')->setElement('a')->setAttr('href','index.php?page=logout');
		}

	}

	// defined in parent class
	// Template of this tool is view/namespace-ToolName.html
}