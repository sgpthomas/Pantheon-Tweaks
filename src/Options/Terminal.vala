
namespace PantheonTweaks {

    public class Options.Terminal : Gtk.Box, Option {

        // interface methods
        public string get_icon_name () {
            return "utilities-terminal";
        }

        public string get_title () {
            return _("Terminal");
        }

        public string get_description () {
            return _("Test Description");
        }

        public string get_category () {
            return _("Applications");
        }

        public Terminal () {
            this.add (new Gtk.Label ("terminal test"));
        }
    }
}
