<?php

class page_owner_updater extends page_base_owner {
	public $git_path = 'https://github.com/xepan/xepan';

	function page_index(){
		$this->add('View_Error')->set('1 : You are strongly recommended to backup your database and files and folders first.');
		$this->add('View_Error')->set('2 : Provide proper permissions to get files replaced');
		$update_btn = $this->add('Button')->set('Update');

		if($update_btn->isClicked()){
			$this->update();
			$this->js()->univ()->successMessage('xEpan CMS Updated')->execute();
		}
	}

	function update($dynamic_model_update=true){
		if($this->git_path==null)
			throw $this->exception('public variable git_path must be defined in page class');
		
		
		$installation_path = getcwd();

		if(file_exists($installation_path.DS.'.git'))
			$repo = Git::open($installation_path);
		else
			$repo=Git::create($installation_path);

		$remote_branches = $repo->list_remote_branches();

		if(count($remote_branches) == 0)
			$repo->add_remote_address($this->git_path);

		$repo->run('fetch --all');
		$repo->run('reset --hard origin/master');

		if($dynamic_model_update){
			$dir = $installation_path.DS.'lib'.DS.'Model';
			if(is_dir($dir)){
				$lst = scandir($dir);
	                array_shift($lst);
	                array_shift($lst);
	            foreach ($lst as $item){
	            	$model = $this->add('Model_'.str_replace(".php", '', $item));
	            	$model->add('dynamic_model/Controller_AutoCreator');
	            	$model->tryLoadAny();
	            }
        	}
		}
	}

	function query($q){
		$this->api->db->dsql($this->api->db->dsql()->expr($q))->execute();
	}
}