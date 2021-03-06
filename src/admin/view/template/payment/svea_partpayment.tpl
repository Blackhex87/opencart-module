<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
    <h1 style=""><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
          <tbody>
            <tr>
                <td>Version</td>
                <td>2.6.4</td>
            </tr>
            <tr>
              <td><?php echo $entry_geo_zone; ?></td>
              <td><select name="svea_partpayment_geo_zone_id">
                  <option value="0"><?php echo $text_all_zones; ?></option>
                  <?php foreach ($geo_zones as $geo_zone) { ?>
                  <?php if ($geo_zone['geo_zone_id'] == $svea_partpayment_geo_zone_id) { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="svea_partpayment_status">
                  <?php if ($svea_partpayment_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="svea_partpayment_sort_order" value="<?php echo $svea_partpayment_sort_order; ?>" size="1" /></td>
            </tr>
            <tr>
                <td><?php echo $entry_payment_description; ?></td>
                <td><textarea rows="2" cols="30" name="svea_partpayment_payment_description"><?php echo $svea_partpayment_payment_description; ?></textarea></td>
            </tr>
            <!-- order statuses -->
            <tr>
              <td><?php echo $entry_order_status; ?><!--<span class="help"><?php echo $entry_order_status_text ?></span>--></td>
               <td>
                    <div><?php echo $entry_status_order; ?></div>
                    <select name="svea_partpayment_order_status_id">
                        <?php foreach ($order_statuses as $order_status) { ?>
                        <?php if ($order_status['order_status_id'] == $svea_partpayment_order_status_id) { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                    <div>
                        <span><?php echo $entry_status_delivered; ?></span>
                        <span class="help"><?php echo $entry_status_delivered_text; ?></span>
                    </div>
                    <select name="svea_partpayment_deliver_status_id">
                        <?php foreach ($order_statuses as $deliver_status) { ?>
                        <?php if ($deliver_status['order_status_id'] == $svea_partpayment_deliver_status_id) { ?>
                        <option value="<?php echo $deliver_status['order_status_id']; ?>" selected="selected"><?php echo $deliver_status['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $deliver_status['order_status_id']; ?>"><?php echo $deliver_status['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                    <div>
                        <span><?php echo $entry_status_canceled; ?></span>
                        <span class="help"><?php echo $entry_status_canceled_text; ?></span>
                    </div>
                    <select name="svea_partpayment_canceled_status_id">
                   <?php foreach ($order_statuses as $order_status) {
                       if ($order_status['order_status_id'] == $svea_partpayment_canceled_status_id) { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                        <?php } else { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                         <?php } ?>
                    <?php } ?>
                    </select>
                </td>
            </tr>
            <!--shipping billing-->
            <tr>
                <td><?php echo $entry_shipping_billing; ?>
                    <span class="help"><?php echo $entry_shipping_billing_text ?></span>
                </td>
                <td>
                    <?php if ($svea_partpayment_shipping_billing === "0") { ?>
                    <input type="radio" name="svea_partpayment_shipping_billing" value="1" />
                    <?php echo $entry_yes; ?>
                    <input type="radio" name="svea_partpayment_shipping_billing" value="0" checked="checked" />
                    <?php echo $entry_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="svea_partpayment_shipping_billing" value="1" checked="checked" />
                    <?php echo $entry_yes; ?>
                    <input type="radio" name="svea_partpayment_shipping_billing" value="0" />
                    <?php echo $entry_no; ?>
                    <?php } ?>
                </td>
            </tr>
            <!-- autodeliver -->
            <tr>
                <td><?php echo $entry_auto_deliver; ?><span class="help"><?php echo $entry_auto_deliver_text ?></span></td>
                <td>
                    <select name="svea_partpayment_auto_deliver">
                        <option value="0" <?php if($svea_partpayment_auto_deliver == '0'){ echo 'selected="selected"';}?> ><?php echo $text_disabled; ?></option>
                        <option value="1" <?php if($svea_partpayment_auto_deliver == '1'){ echo 'selected="selected"';}?> ><?php echo $text_enabled; ?></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><?php echo $entry_product; ?><span class="help"><?php echo $entry_product_text ?></span></td>
                <td>
                    <?php if ($svea_partpayment_product_price) { ?>
                    <input type="radio" name="svea_partpayment_product_price" value="1" checked="checked" />
                    <?php echo $entry_yes; ?>
                    <input type="radio" name="svea_partpayment_product_price" value="0" />
                    <?php echo $entry_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="svea_partpayment_product_price" value="1" />
                    <?php echo $entry_yes; ?>
                    <input type="radio" name="svea_partpayment_product_price" value="0" checked="checked" />
                    <?php echo $entry_no; ?>
                    <?php } ?>
                </td>
            </tr>
          </tbody>
      </table>
         <!-- Countrycode specific -->
        <div id="tab-partpayment" style="display: inline;">
             <?php if($version >= 1.5){ ?>
            <div id="vtabs" class="vtabs">
                <?php foreach ($credentials as $code){ ?>
                    <a href="#tab-partpayment_<?php echo $code['lang'] ?>"><?php echo $code['lang'] ?></a>
                <?php } ?>
            </div>
             <?php } ?>
        <?php foreach($credentials as $code){ ?>
            <div id="tab-partpayment_<?php echo $code['lang'] ?>" class="vtabs-content">
                 <?php if($version < 1.5){ ?>
                 <h3><?php echo $code['lang']; ?></h3>
                 <?php } ?>
                <table class="form">
                    <tbody>
                         <tr>
                            <td><?php echo $entry_testmode; ?></td>
                            <td>
                                <select name="<?php echo $code['name_testmode']; ?>">
                                    <option value="1" <?php if($code['value_testmode'] == '1'){ echo 'selected="selected"';}?> ><?php echo $text_enabled; ?></option>
                                    <option value="0" <?php if($code['value_testmode'] == '0'){ echo 'selected="selected"';}?> ><?php echo $text_disabled; ?></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_username; ?></td>
                            <td>
                                <input name="<?php echo $code['name_username']; ?>" type="text"
                                       value="<?php echo $code['value_username']; ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_password; ?></td>
                            <td>
                                <input name="<?php echo $code['name_password']; ?>" type="password"
                                       value="<?php echo $code['value_password']; ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_clientno; ?></td>
                            <td>
                                <input name="<?php echo $code['name_clientno']; ?>" type="text"
                                       value="<?php echo $code['value_clientno']; ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_min_amount; ?></td>
                            <td>
                                <input name="<?php echo $code['min_amount_name']; ?>" type="text"
                                       value="<?php echo $code['min_amount_value']; ?>" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        <?php } ?>
        </div>
    </div>
  </form>
    </div>
    <div style="height:100px"></div>
</div>
<script type="text/javascript"><!--
$('#tab-partpayment a').tabs();

//--></script>
<?php echo $footer; ?>