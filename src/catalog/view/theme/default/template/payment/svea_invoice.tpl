<div class="content">
<?php
if(isset($getAddressIframeUrlError)){
    echo $getAddressIframeUrlError;
}
?>


<noscript>Please <a href="http://enable-javascript.com">enable JavaScript</a>.</noscript>
<iframe src="<?php echo $getAddressIframeUrl; ?>" id="get-address-frame" frameborder="0" scrolling="no" style="width: 100%; min-height: 600px; -webkit-transition: min-height 0.15s; transition: min-height 0.15s;"></iframe>
       <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<!--<script src="~/Scripts/Svea/Svea.js"></script>-->


</div>
<script type="text/javascript">

//window.onload = function () {
$( document ).ready(function() {
    var isCompany = null;
    var returnUrl = "http://localhost:8080/opencart_1.5-testing/upload/index.php?route=checkout/checkout";     //url where returned address should post to
    var iFrameUrl = $('#iFrameUrl').text();
    console.log(iFrameUrl);
    $('select').on('change', function() {
        isCompany = $(this).val();
        console.log("(FakeSite) isCompany: " + isCompany);
        //getAddressFrameUrl(returnUrl, isCompany);
    });

   // getAddressFrameUrl(returnUrl, isCompany);
});

function getAddressFrameUrl(iFrameUrl,currentUrl, isCompany) {
    var localUrl = "http://localhost:51246";
    var testUrl = "http://testwpyweb01.sveaweb.se/HostedGetAddress.MVC";
    var actionUrl = "/GetAddresses/GetUrl";
    $.ajax({
        type: "POST",
        dataType: "text",
        url: testUrl + actionUrl,                              // <--- *****  local / test *******
        data: {
            returnUrl: currentUrl,
            isCompany: isCompany
        },
        success: function (response) {
            console.log("(FakeSite) getAddressFrameUrl success");
            //console.log(response);
            $('#get-address-frame').attr('src', response);
            return response;
        },
        done: function () {
            console.log("(FakeSite) getAddressFrameUrl done");
        },
        fail: function() {
            console.log("(FakeSite) getAddressFrameUrl fail");
        }
    });

    function receiveMessage(event) {

        if (event.origin !== testUrl || event.data.GetAddressesResult == null) {   // <--- *****  local / test *******
            return;
        }
        $('#address-ul').empty();
        for (var i = 0; i < event.data.GetAddressesResult.Addresses.length; i++) {
            var address = event.data.GetAddressesResult.Addresses[i].Address;
            var addressstring = "<li>" +
                address.FullName + "</br>" +
                address.Street + " " + address.HouseNumber + "</br>" +
                address.ZipCode + " " + address.Locality +
                "</li>";
            $('#address-ul').append(addressstring);
        }
    }

    if (window.addEventListener) {
        addEventListener("message", receiveMessage, false);
    } else {
        //Older IE fix
        attachEvent("onmessage", receiveMessage);
    }

}
</script>