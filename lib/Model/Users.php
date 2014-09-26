<?php
class Model_Users extends Model_Table {
	var $table= "users";
	function init(){
		parent::init();
		
		$this->hasOne('Epan','epan_id')->mandatory(true);
		//$this->addCondition('epan_id',$this->api->current_website->id);
		
		$this->addField('name');
		$this->addField('email');
		$this->addField('username');
		$this->addField('password')->type('password');
		$this->addField('created_at')->type('date')->defaultValue(date('Y-m-d'));
		// $this->addField('is_systemuser')->type('boolean')->defaultValue(false);
		// $this->addField('is_frontenduser')->type('boolean')->defaultValue(false);
		// $this->addField('is_backenduser')->type('boolean')->defaultValue(false);
		$this->addField('type')->setValueList(array(100=>'SuperUser',80=>'BackEndUser',50=>'FrontEndUser'))->defaultValue(0);
		$this->addField('is_active')->type('boolean')->defaultValue(false);
		$this->addField('activation_code');
		$this->addField('last_login_date')->type('date');

		$this->addHook('beforeDelete',$this);
		$this->addHook('beforeSave',$this);
		// $this->add('dynamic_model/Controller_AutoCreator');
	}

	function beforeSave(){
		// Check username for THIS EPAN
		$old_user = $this->add('Model_Users');
		$old_user->addCondition('username',$this['username']);
		
		if(isset($this->api->current_website))
			$old_user->addCondition('epan_id',$this->api->current_website->id);
		if($this->loaded()){
			$old_user->addCondition('id','<>',$this->id);
		}
		$old_user->tryLoadAny();
		if($old_user->loaded()){
			// throw $this->exception("This username is allready taken, Chose Another");
			$this->api->js()->univ()->errorMessage('This username is allready taken, Chose Another')->execute();
		}
	}

	function beforeDelete(){
		if($this['username'] == $this->ref('epan_id')->get('name'))
			throw $this->exception("You Can't delete it, it is default username");
			
	}

	function sendVerificationMail($email=null,$type=null,$activation_code=null){
		if(!$this->loaded()) throw $this->exception('Model Must Be Loaded Before Email Send');


		$this['activation_code'] = rand(1000,99999);
		$this->save();
		$epan=$this->add('Model_Epan');
		$epan->tryLoadAny();

		$this['email'] = $email;
		$this['activation_code'] = $activation_code;
		$type = null;

			$tm=$this->add( 'TMail_Transport_PHPMailer' );
			$msg=$this->add( 'SMLite' );
			$msg->loadTemplate( 'mail/registrationVerifyMail' );
			
			//$msg->trySet('epan',$this->api->current_website['name']);		
			$enquiry_entries="some text related to register verification";
			$msg->trySetHTML('form_entries',$enquiry_entries);

			$msg->SetHTML('activation_code',$this['activation_code']);

			$email_body=$msg->render();	

			$subject ="Thank you for Registration.";

			try{
				$tm->send( $email, $epan['email_username'], $subject, $email_body ,false,null);
				// throw new \Exception($this['emailID'].$epan['email_username'], 1);
				return true;
			}catch( phpmailerException $e ) {
				// throw $e;
				$this->api->js(null,'$("#form-'.$_REQUEST['form_id'].'")[0].reset()')->univ()->errorMessage( $e->errorMessage() . " " . "rksinha.btech@gmail.com"  )->execute();
			}catch( Exception $e ) {
				throw $e;
			}
	}

}
