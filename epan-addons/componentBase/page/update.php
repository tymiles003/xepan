<?php

class page_componentBase_page_update extends page_base_owner{

	public $git_path=null;

	function update(){
		if($this->git_path==null)
			throw $this->exception('public variable git_path must be defined in page class');
		
		// Get new code from git
		// Get all models in lib/Model
		// add dynamic line on object
		// tryLoanAny

	}

}
