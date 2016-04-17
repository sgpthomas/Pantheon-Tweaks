
namespace PantheonTweaks {

    public class Options.Appearance : Gtk.Box, Option {

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

        public Appearance () {
            var grid = new Gtk.Grid ();

            grid.halign = Gtk.Align.CENTER;
            grid.column_spacing = 12;
            grid.row_spacing = 6;

            var row = 0;

            var description = "Set Gtk+ applications to prefer dark theming over standard theming";
            var warning = "Many themes are not designed to use this option and may cause graphical glitches";
            var dark_button = new Gtk.Switch ();
            Widgets.add_option (grid, "Prefer Dark Theme", dark_button, ref row, () => {
                    Settings.Gtkini.get_default ().prefer_dark_theme = false;
                }, description, warning);
            dark_button.set_active (Settings.Gtkini.get_default ().prefer_dark_theme);
            dark_button.notify["active"].connect (() => {
                Settings.Gtkini.get_default ().prefer_dark_theme = dark_button.get_active ();
            });

            /* Gtk Theme Combo Box */
            description = "Theme used to draw Gtk+ applications";
            var theme_toggle = new Gtk.ComboBoxText ();
            Widgets.add_option (grid, "Gtk+ Theme", theme_toggle, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("gtk-theme");
                }, description);
            foreach (var theme in Settings.Interface.get_themes ("themes")) {
                theme_toggle.append (theme, theme);
            }
            theme_toggle.set_active_id (Settings.Interface.get_default ().gtk_theme);
            theme_toggle.changed.connect (() => {
                Settings.Interface.get_default ().gtk_theme = theme_toggle.get_active_text ();
            });

            /* Icon Theme Combo Box*/
            description = "Theme used to draw application icons";
            var icon_toggle = new Gtk.ComboBoxText ();
            Widgets.add_option (grid, "Icon Theme", icon_toggle, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("icon-theme");
                }, description);
            foreach (var icon in Settings.Interface.get_themes ("icons", "index.theme")) {
                icon_toggle.append (icon, icon);
            }
            icon_toggle.set_active_id (Settings.Interface.get_default ().icon_theme);
            icon_toggle.changed.connect (() => {
                Settings.Interface.get_default ().icon_theme = icon_toggle.get_active_text ();
            });

            /* Cursor Theme Combo Box */
            description = "Theme used to render the cursor";
            var cursor_toggle = new Gtk.ComboBoxText ();
            Widgets.add_option (grid, "Cursor Theme", cursor_toggle, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("cursor-theme");
                }, description);
            foreach (var cursor in Settings.Interface.get_themes ("icons", "cursors")) {
                cursor_toggle.append (cursor, cursor);
            }
            cursor_toggle.set_active_id (Settings.Interface.get_default ().cursor_theme);
            cursor_toggle.changed.connect (() => {
                Settings.Interface.get_default ().cursor_theme = cursor_toggle.get_active_text ();
            });

            Settings.Gtkini.get_default ().notify["prefer-dark-theme"].connect (() => {
                dark_button.set_active (Settings.Gtkini.get_default ().prefer_dark_theme);
            });

            Settings.Interface.get_default ().changed.connect (() => {
                theme_toggle.set_active_id (Settings.Interface.get_default ().gtk_theme);
                icon_toggle.set_active_id (Settings.Interface.get_default ().icon_theme);
                cursor_toggle.set_active_id (Settings.Interface.get_default ().cursor_theme);
            });

            grid.show_all ();
            this.add (grid);
        }
    }
}
