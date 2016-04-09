
namespace PantheonTweaks {

    public class Options.Font : GLib.Object, Option {

        // interface methods
        public string get_icon_name () {
            return "preferences-desktop-font";
        }

        public string get_title () {
            return _("Fonts");
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

            var description = "Default font used by gtk+";
            var def_button = new Gtk.FontButton.with_font (Settings.Interface.get_default ().font_name);
            def_button.set_font_name (Settings.Interface.get_default ().font_name);
            Widgets.add_option (grid, "Default Font", def_button, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("font-name");
                }, description);

            def_button.font_set.connect (() => {
                Settings.Interface.get_default ().font_name = def_button.get_font_name ();
            });


            description = "Default font for reading documents";
            var doc_button = new Gtk.FontButton.with_font (Settings.Interface.get_default ().document_font_name);
            Widgets.add_option (grid, "Document Font", doc_button, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("document-font-name");
                }, description);

            doc_button.font_set.connect (() => {
                Settings.Interface.get_default ().document_font_name = doc_button.get_font_name ();
            });

            description = "Default monospaced (fixed-width) font for use in locations like terminals";
            var mono_button = new Gtk.FontButton.with_font (Settings.Interface.get_default ().monospace_font_name);
            Widgets.add_option (grid, "Monospace Font", mono_button, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("monospace-font-name");
                }, description);

            mono_button.font_set.connect (() => {
                Settings.Interface.get_default ().monospace_font_name = mono_button.get_font_name ();
            });

            // description = "This is a test description";
            // var button4 = new Gtk.FontButton.with_font (Font.get_default ().monospace_font_name);
            // Widgets.add_option (grid, "Titlebar Font", button4, ref row, ()=>{}, description);

            Settings.Interface.get_default ().changed.connect (() => {
                def_button.set_font_name (Settings.Interface.get_default ().font_name);
                doc_button.set_font_name (Settings.Interface.get_default ().document_font_name);
                mono_button.set_font_name (Settings.Interface.get_default ().monospace_font_name);
            });

            grid.show_all ();
            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            box.add (grid);
            return box;
        }
    }
}
