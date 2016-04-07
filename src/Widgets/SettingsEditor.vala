
namespace PantheonTweaks {

    public class Widgets.SettingsEditor : Gtk.Box {
        private Gtk.Box content;
        private SettingsHeader header;

        public SettingsEditor () {
            Object (orientation: Gtk.Orientation.VERTICAL,
                    spacing: 0);

            content = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            this.margin = 12;
            build_ui ();
            this.show_all ();
        }

        private void build_ui () {
            header = new SettingsHeader ();

            this.add (header);
            this.add (content);
        }

        public void show_setting (Options.Option setting) {
            // update title
            header.set_icon_name (setting.get_icon_name ());
            header.set_title (setting.get_title ());
            // update content
            foreach (var child in content.get_children ()) {
                child.destroy ();
            }

            content.add (setting.get_content ());
            content.show_all ();
        }
    }
}
