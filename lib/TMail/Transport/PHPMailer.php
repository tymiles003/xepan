<?php
class TMail_Transport_PHPMailer extends AbstractObject {
    public $PHPMailer;

    function init(){
        parent::init();
        require_once("PHPMailer/class.phpmailer.php");
        $this->PHPMailer = new PHPMailer(true);

        $mail = $this->PHPMailer;

        $mail->IsSMTP();
        $mail->SMTPDebug  = 0;                     // enables SMTP debug information (for testing)
        $mail->SMTPAuth   = $this->api->current_website['email_username']?true:false;                  // enable SMTP authentication
        $mail->Host       = $this->api->current_website['email_host'];
        $mail->Port       = $this->api->current_website['email_port'];
        $mail->Username   = $this->api->current_website['email_username'];
        $mail->Password   = $this->api->current_website['email_password'];
        
        if($this->add('Controller_EpanCMSApp')->emailSettings($mail) !== true){
            $mail->AddReplyTo($this->api->current_website['email_reply_to'], $this->api->current_website['email_reply_to_name']);
            $mail->SetFrom($this->api->current_website['email_from'], $this->api->current_website['email_from_name']);
        }

        $mail->SMTPSecure = 'ssl';
        // $mail->AltBody = null;
        $mail->IsHTML(true);
        // $mail->SMTPKeepAlive = true;
    }

    function getPHPMailer(){
        return $this->PHPMailer;
    }

    function send($to,$from = null,$subject,$body,$ccs=null,$bcc=null,$headers=''){
        $mail = $this->PHPMailer;
        $mail->ClearAllRecipients();
        
        if(is_array($to)){
            foreach ($to as $to_1) {
                $mail->AddAddress($to_1);
            }
        }else{
            $mail->AddAddress($to);
        }

        if($ccs){
            if(is_array($ccs)){
                foreach ($ccs as $ccs_1) {
                    $mail->AddCC($ccs_1);
                }
            }else{
                $mail->AddCC($ccs);
            }
        }

        if($bcc){
            if(is_array($bcc)){
                foreach ($bcc as $bcc_1) {
                    $mail->AddBCC($bcc_1);
                }
            }else{
                $mail->AddBCC($bcc);
            }
        }

        $mail->Subject = $subject;
        $mail->MsgHTML("\n\n",$body);
        
        foreach (explode("\n", $headers) as $h){
            $mail->AddCustomHeader($h);
        }
        $mail->Send();
    }

    function __destruct(){
        // $this->PHPMailer->SmtpClose();
    }
}
 
