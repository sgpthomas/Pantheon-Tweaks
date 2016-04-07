

namespace PantheonTweaks {

    public class Views.AlertView : Granite.Widgets.AlertView {

        public AlertView () {
            Object (title: _("The following settings were not intended to be changed!"),
                    description: _("The elementary team is not responsible for any problems that you may encounter."),
                    icon_name: "dialog-warning");

            this.show_action(_("Continue Anyway?"));

            this.show_all ();
        }
    }
}
