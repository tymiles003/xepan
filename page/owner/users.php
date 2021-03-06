<?php
class page_owner_users extends page_base_owner {
	function page_index(){
		$this->add( 'H1' )->setHTML( "User Management <small>Manage your website / applications registered users</small>" );

		$crud=$this->add('CRUD');
		$usr=$this->add('Model_Users');
		$usr->addCondition('epan_id',$this->api->current_website->id);
		
		$crud->setModel($usr);

		if($crud->grid){
			$crud->grid->addButton('Options')->js('click',$this->js()->univ()->frameURL('User Options',$this->api->url('./options')));
			$crud->grid->addButton('Email Config')->js('click',$this->js()->univ()->frameURL('User Email Configuration',$this->api->url('./emailconfig')));
		}
	}

	function page_options(){
		$form = $this->add('Form');
		$form->addClass('stacked');
		$form->setModel($this->api->current_website,array('is_frontent_regiatrstion_allowed','user_activation'));
		$form->addSubmit('Update');
		if($form->isSubmitted()){
			$form->update();
			$form->js(null,$form->js()->univ()->successMessage('Options Updated'))->univ()->closeDialog()->execute();
		}
	}

	function page_emailconfig(){
		$form = $this->add('Form');
		$form->addClass('stacked');
		$form->setModel($this->api->current_website,array('user_registration_email_subject','user_registration_email_message_body'));
		$form->addSubmit('save');
		if($form->isSubmitted()){
			$form->update();
			$form->js(null,$form->js()->univ()->successMessage('Email Config Updated'))->univ()->closeDialog()->execute();
		}
	}
}
