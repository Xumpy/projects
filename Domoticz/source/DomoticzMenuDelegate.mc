using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Communications as Comm;

class DomoticzMenuDelegate extends Ui.MenuInputDelegate {

	var switchScene3 = true;
	var switchScene2 = true;
	
	function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item==:rolluik_huis_zonder_deur_sluiten){  switchDomoticzScene(3, true); }
        if (item==:lamp_garage){  switchDomoticz(11); }
        if (item==:boiler){  switchDomoticz(13); }
        if (item==:rolluik_living_links){  switchDomoticz(1); }
        if (item==:rolluik_living_rechts){  switchDomoticz(2); }
        if (item==:rolluik_living_voorkant){  switchDomoticz(31); }
        if (item==:rolluik_deur){  switchDomoticz(4); }
        if (item==:rolluik_slaapkamer1){  switchDomoticz(6); }
        if (item==:rolluik_slaapkamer2){  switchDomoticz(5); }
        if (item==:rolluik_badkamer){  switchDomoticz(7); }
        if (item==:rolluik_bureau){  switchDomoticz(8); }
        if (item==:rolluik_keuken){  switchDomoticz(9); }
        if (item==:rolluik_berging){  switchDomoticz(10); }
        if (item==:rolluik_huis_sluiten){  switchDomoticzScene(2, true); }
        if (item==:rolluik_huis_open){  switchDomoticzScene(2, false); }
        
    }

    function switchDomoticz(idx){
        var url = "http://192.168.1.31:8080/json.htm";
        
        var params = {"type" => "command", "param" => "switchlight", "idx" => idx, "switchcmd" => "Toggle"};
        
        Comm.makeWebRequest(url, params, { "Content-Type" => Comm.REQUEST_CONTENT_TYPE_URL_ENCODED }, method(:onReceive));
    }

    function switchDomoticzScene(idx, bool){
        var url = "http://192.168.1.31:8080/json.htm";
        
        var params;
        if (bool){
        	params = {"type" => "command", "param" => "switchscene", "idx" => idx, "switchcmd" => "On"};
        } else {
        	params = {"type" => "command", "param" => "switchscene", "idx" => idx, "switchcmd" => "Off"};
        }
        Comm.makeWebRequest(url, params, { "Content-Type" => Comm.REQUEST_CONTENT_TYPE_URL_ENCODED }, method(:onReceive));
    }

    function onReceive(responseCode, data){
        Sys.println("data received");
        if( responseCode == 200 ){
           Sys.println("data ok 200");
           Sys.println(data);
        } else {
           Sys.println("response code:" + responseCode);
           Sys.println("data:" + data);
        }
    }
}