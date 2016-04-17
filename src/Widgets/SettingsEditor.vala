
namespace PantheonTweaks {

    public class Widgets.SettingsEditor : Gtk.Box {
        // private Gtk.Box content;
        private Gtk.Stack content;
        private SettingsHeader header;

        //private Gtk.ScrolledWindow scroll;

        public SettingsEditor () {
            Object (orientation: Gtk.Orientation.VERTICAL,
                    spacing: 0);

            // content = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            content = new Gtk.Stack ();
            //scroll = new Gtk.ScrolledWindow (null, null);

            this.margin = 12;
            build_ui ();
            this.show_all ();
        }

        private void build_ui () {
            header = new SettingsHeader ();

            this.add (header);
            this.add (content);
            //this.add (scroll);
        }

        public void add_setting (Options.Option setting) {
            content.add_named (setting, setting.get_title ());
        }

        public void show_setting (Options.Option setting) {
            // update title
            header.set_icon_name (setting.get_icon_name ());
            header.set_title (setting.get_title ());

            content.set_visible_child_name (setting.get_title ());
            content.show_all ();
        }
    }
}
