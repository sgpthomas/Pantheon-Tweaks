
namespace PantheonTweaks {

    public class Options.Terminal : GLib.Object, Option {

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

        public Gtk.Box get_content () {
            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            box.add (new Gtk.Label ("terminal test"));
            return box;
        }
    }
}
