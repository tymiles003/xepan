<?php

class page_{namespace}_page_owner_update extends page_componentBase_page_update {
		
	public $git_path=null; // Put your components git path here

	function init(){
		parent::init();

		// 
		// Code To run before update
		
		$this->update(); // All modls will be dynamic executed in here
		
		// Code to run after update
	}
}