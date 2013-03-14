<?php 
class ControllerPaymentsveapartpayment extends Controller {
	private $error = array(); 
	 
	public function index() { 
		$this->load->language('payment/svea_partpayment');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('svea_partpayment', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect(HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token']);
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
				
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');		
		$this->data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
        
		$this->data['tab_general'] = $this->language->get('tab_general');
        
        //Definitions lang //Anneli
        $this->data['entry_username'] = $this->language->get('entry_username');
        $this->data['entry_testmode'] = $this->language->get('entry_testmode');
        $this->data['entry_password'] = $this->language->get('entry_password');
        $this->data['entry_clientno'] = $this->language->get('entry_clientno');
        $this->data['entry_invoicefee'] = $this->language->get('entry_invoicefee');
        
        //Definitions settings
        $this->data['svea_partpayment_sort_order'] = $this->config->get('svea_partpayment_sort_order');
        $this->data['svea_username'] = $this->config->get('svea_username');
        $this->data['svea_password'] = $this->config->get('svea_password');
        $this->data['svea_partpayment_clientno'] = $this->config->get('svea_partpayment_clientno');
        $this->data['svea_partpayment_testmode'] = $this->config->get('svea_partpayment_testmode');
        
        
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('text_payment'),
      		'separator' => ' :: '
   		);
		
   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=payment/svea_partpayment&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = HTTPS_SERVER . 'index.php?route=payment/svea_partpayment&token=' . $this->session->data['token'];

		$this->data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'];	
		
		if (isset($this->request->post['svea_partpayment_order_status_id'])) {
			$this->data['svea_partpayment_order_status_id'] = $this->request->post['svea_partpayment_order_status_id'];
		} else {
			$this->data['svea_partpayment_order_status_id'] = $this->config->get('svea_partpayment_order_status_id'); 
		} 
		
		$this->load->model('localisation/order_status');
		
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['svea_partpayment_geo_zone_id'])) {
			$this->data['svea_partpayment_geo_zone_id'] = $this->request->post['svea_partpayment_geo_zone_id'];
		} else {
			$this->data['svea_partpayment_geo_zone_id'] = $this->config->get('svea_partpayment_geo_zone_id'); 
		} 
		
		$this->load->model('localisation/geo_zone');						
		
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['svea_partpayment_status'])) {
			$this->data['svea_partpayment_status'] = $this->request->post['svea_partpayment_status'];
		} else {
			$this->data['svea_partpayment_status'] = $this->config->get('svea_partpayment_status');
		}
		
		if (isset($this->request->post['svea_partpayment_sort_order'])) {
			$this->data['svea_partpayment_sort_order'] = $this->request->post['svea_partpayment_sort_order'];
		} else {
			$this->data['svea_partpayment_sort_order'] = $this->config->get('svea_partpayment_sort_order');
		}
        
        if (isset($this->request->post['svea_testmode'])) {
			$this->data['svea_partpayment_testmode'] = $this->request->post['svea_partpayment_testmode'];
		} else {
			$this->data['svea_partpayment_testmode'] = $this->config->get('svea_partpayment_testmode');
		}
		
		$this->template = 'payment/svea_partpayment.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/svea_partpayment')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
				
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>