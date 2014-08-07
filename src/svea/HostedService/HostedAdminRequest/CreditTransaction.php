<?php
namespace Svea\HostedService;

require_once SVEA_REQUEST_DIR . '/Includes.php';

/**
 * creditTransaction can be used to credit transactions. Only transactions that
 * have reached the status SUCCESS can be credited.
 * 
 * @author Kristian Grossman-Madsen
 */
class CreditTransaction extends HostedRequest {

    protected $transactionId;
    protected $creditAmount;
    
    function __construct($config) {
        $this->method = "credit";
        parent::__construct($config);
    }

    /**
     * Set the transaction id, which must have status SUCCESS at Svea.
     * 
     * Required.
     * 
     * @param string $transactionId
     * @return $this
     */
    function setTransactionId( $transactionId ) {
        $this->transactionId = $transactionId;
        return $this;
    }
    
    /**
     * Set the amount to credit.
     * 
     * Required.
     * 
     * @param int $creditAmount  amount to credit, in minor currency (i.e. 1 SEK => 100 in minor currency)
     * @return $this
     */
    function setCreditAmount( $creditAmount ) {
        $this->creditAmount = $creditAmount;
        return $this;
    }
    
    /**
     * prepares the elements used in the request to svea
     */
    public function prepareRequest() {
        $this->validateRequest();
        
        $xmlBuilder = new HostedXmlBuilder();
        
        // get our merchantid & secret
        $merchantId = $this->config->getMerchantId( \ConfigurationProvider::HOSTED_TYPE,  $this->countryCode);
        $secret = $this->config->getSecret( \ConfigurationProvider::HOSTED_TYPE, $this->countryCode);
        
        // message contains the credit request
        $messageContents = array(
            "transactionid" => $this->transactionId,
            "amounttocredit" => $this->creditAmount
        ); 
        $message = $xmlBuilder->getCreditTransactionXML( $messageContents );        

        // calculate mac
        $mac = hash("sha512", base64_encode($message) . $secret);
        
        // encode the request elements
        $request_fields = array( 
            'merchantid' => urlencode($merchantId),
            'message' => urlencode(base64_encode($message)),
            'mac' => urlencode($mac)
        );
        return $request_fields;
    }
    
    public function validate($self) {
        $errors = array();
        $errors = $this->validateTransactionId($self, $errors);
        $errors = $this->validateCreditAmount($self, $errors);
        return $errors;
    }
    
    private function validateTransactionId($self, $errors) {
        if (isset($self->transactionId) == FALSE) {                                                        
            $errors['missing value'] = "transactionId is required. Use function setTransactionId() with the SveaOrderId from the createOrder response.";  
        }
        return $errors;
    }   
    
    private function validateCreditAmount($self, $errors) {
        if (isset($self->creditAmount) == FALSE) {                                                        
            $errors['missing value'] = "creditAmount is required. Use function setCreditAmount().";
        }
        return $errors;    
    }
}