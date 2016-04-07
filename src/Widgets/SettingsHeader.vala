
namespace PantheonTweaks {

    public class Widgets.SettingsHeader : Gtk.Grid {
        private Gtk.Image app_image;
        private Gtk.Label app_label;

        public SettingsHeader () {
            build_ui ();
        }

        public void set_title (string title) {
            app_label.set_label (title);
            app_label.get_style_context ().add_class ("h2");
        }

        public void set_icon_name (string icon_name) {
            app_image.set_from_icon_name (icon_name, Gtk.IconSize.DIALOG);
            app_image.set_pixel_size (48);
        }

        private void build_ui () {
            this.column_spacing = 12;

            app_image = new Gtk.Image ();

            app_label = new Gtk.Label (null);
            app_label.use_markup = true;
            app_label.halign = Gtk.Align.START;
            app_label.hexpand = true;

            this.attach (app_image, 0, 0, 1, 1);
            this.attach (app_label, 1, 0, 1, 1);
        }
    }
}
