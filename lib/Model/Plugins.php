<?php

class Model_Plugins extends Model_Table {
	var $table= "epan_components_plugins";
	public $isInstalling=false;

	function init(){
		parent::init();

		$this->hasOne('MarketPlace','component_id');
		
		$this->addField('name');
		$this->addField('event')->enum($this->api->getConfig('xepan/events'));
		$this->addField('params')->defaultValue('$page');
		$this->addField('is_system')->type('boolean')->defaultValue(false);

		
		$this->addHook('beforeSave',$this);

		// $this->add('dynamic_model/Controller_AutoCreator');
	}

	function beforeSave(){

		if($this->loaded())
			throw $this->exception('Sorry Editing Facility is not implemented yet in Plugins','ValidityCheck')->setField('name');

		$namespace = $this->ref('component_id')->get('namespace');

		$check_existing = $this->add('Model_Plugins');
		$check_existing->join('epan_components_marketplace','component_id')
						->addField('namespace');
		$check_existing->addCondition('namespace',$namespace);
		$check_existing->addCondition('name',$this['name']);

		$check_existing->tryLoadAny();
		if($check_existing->loaded())
			throw $this->exception('The Plugin Name for this component is already used', 'ValidityCheck')->setField('name');


		if(!$this->isInstalling)
			$this->createNewFiles();


	}

	function createNewFiles(){
		// Copy tool template files from epan-addons/componentStructure/tool to appropriate locations
		
		$namespace = $this->ref('component_id')->get('namespace');

		// Responsible/Rendering class in tool 'View_Tools_'.$this->api->normalizeName($tool['name'])
		$new_tool_file_name = str_replace("_", "", $this->api->normalizeName($this['name']));
		$new_tool_class_name = 'Plugins_'.$new_tool_file_name;

		$source_folder = getcwd().DS.'epan-addons'.DS.'componentStructure'.DS.'plugins';
		$component_folder = getcwd().DS.'epan-components'.DS.$namespace;

		$new_file = $component_folder.DS.'lib'.DS.'Plugins'.DS.$new_tool_file_name.'.php';
		

		// copy($source_folder.DS.'plugins.php',$new_file);
		$fw = fopen($new_file, "w");
			
		$content = file_get_contents($source_folder.DS.'plugins.php');
		$content = str_replace("{namespace}", $namespace, $content);
		$content = str_replace("{PluginName}", $new_tool_class_name, $content);
		$content = str_replace("{event-hook}", $this['event'], $content);
		$content = str_replace("{,params}", ', '.$this['params'], $content);

		file_put_contents($new_file, $content);
		fwrite($fw, $content);
		fclose($fw);


	}
}