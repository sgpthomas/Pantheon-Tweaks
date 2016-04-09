
namespace PantheonTweaks.Widgets {

    public delegate void Revert();

    public static void add_category (Gtk.Grid grid, string name, ref int row) {
        var label = new Gtk.Label (name);
        label.get_style_context ().add_class ("h4");

        label.hexpand = true;
        label.valign = Gtk.Align.CENTER;
        label.halign = Gtk.Align.START;

        grid.attach (label, 0, row);

        row ++;
    }

    public static void add_option (Gtk.Grid grid, string title, Gtk.Widget option, ref int row, Revert revert, string des = "", string warn = "") {
        var label = new Gtk.Label (title + ":");
        label.hexpand = true;
        label.halign = Gtk.Align.END;
        label.valign = Gtk.Align.CENTER;

        if (option is Gtk.ComboBox) {
            option.halign = Gtk.Align.FILL;
        } else if (option is Gtk.Scale) {
            option.halign = Gtk.Align.FILL;
        } else {
            option.halign = Gtk.Align.START;
        }

        option.valign = Gtk.Align.CENTER;

        grid.attach (label, 0, row);
        grid.attach (option, 1, row);

        var default_button = new Gtk.Button.from_icon_name ("document-revert", Gtk.IconSize.LARGE_TOOLBAR);
        default_button.set_tooltip_text (_("Revert to default setting"));
        default_button.set_relief (Gtk.ReliefStyle.NONE);

        default_button.clicked.connect (() => revert ());

        grid.attach (default_button, 2, row);

        var col = 3;
        if (des != "") {
            var info_button = new Gtk.Image.from_icon_name ("dialog-information", Gtk.IconSize.BUTTON);
            info_button.set_tooltip_text (des);
            grid.attach (info_button, col, row);
            col ++;
        }

        if (warn != "") {
            var warn_button = new Gtk.Image.from_icon_name ("dialog-warning", Gtk.IconSize.BUTTON);
            warn_button.set_tooltip_text (warn);
            grid.attach (warn_button, col, row);
        }

        row ++;
    }
}
