<?php

namespace baseElements;

class View_Tools_UserPanel extends \componentBase\View_Component{
	public $html_attributes=array(); // ONLY Available in server side components
	
	function init(){
		parent::init();

		// if(!$this->api->isLoggedIn()){
		// 	// create login form
		// }else{
		// 	// create hello user panel
		// }

	}

	// defined in parent class
	// Template of this tool is view/namespace-ToolName.html
}