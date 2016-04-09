
namespace PantheonTweaks {

    public interface Options.Option : GLib.Object {
        // method getters
        public abstract string get_icon_name ();
        public abstract string get_title ();
        public abstract string get_description ();
        public abstract string get_category ();

        // get content
        public abstract Gtk.Box get_content ();

        /* Sample Option

        // interface methods
        public string get_icon_name () {
            return "preferences-desktop-wallpaper";
        }

        public string get_title () {
            return _("Appearance");
        }

        public string get_description () {
            return _("Test Description");
        }

        public string get_category () {
            return _("System");
        }

        public Gtk.Box get_content () {
            var grid = new Gtk.Grid ();

            grid.halign = Gtk.Align.CENTER;
            grid.column_spacing = 12;
            grid.row_spacing = 6;

            var row = 0;


            grid.show_all ();
            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            box.add (grid);
            return box;
        }

        */
    }
}
