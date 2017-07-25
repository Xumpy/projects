using Toybox.WatchUi as Ui;

class DomoticzDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new DomoticzMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

}