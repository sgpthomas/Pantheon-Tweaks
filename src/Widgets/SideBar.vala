

namespace PantheonTweaks {

    public class Widgets.SideBar : Gtk.ListBox {

        public signal void add_option (Options.Option setting);
        public signal void option_selected (Options.Option setting);

        private Gee.HashMap<string, int> category_map;

        public SideBar () {
            category_map = new Gee.HashMap<string, int> ();

            connect_signals ();

            this.width_request = 160;
            this.show_all ();
        }

        public void add_setting (Options.Option setting) {
            // var description = setting.get_description ();
            var category = setting.get_category ();

            var insert_index = 0;

            if (!category_map.has_key (category)) { // have never seen this before
                insert_index = (int) (this.get_children ().length () + 1);
                category_map.set (category, insert_index);
                this.add (new CategoryHeader (category));
            } else { // have seen this before
                insert_index = category_map.get (category) + 1;
                category_map.set (category, insert_index);
            }

            add_option (setting);
            var item = new SideBarItem (setting);
            this.insert (item, insert_index);
        }

        public void build_ui () {
            add_setting (new Options.Appearance ());
            add_setting (new Options.Font ());
            add_setting (new Options.Window ());
            add_setting (new Options.Terminal ());
        }

        private void connect_signals () {
            this.row_selected.connect ((row) => {
                if (row == null) {
                    return;
                }

                if (!(row is SideBarItem)) {
                    return;
                }

                option_selected (((SideBarItem) row).get_setting ());
            });
        }
    }

    private class SideBarItem : Gtk.ListBoxRow {

        private string icon_name;
        private string title;
        private string description;

        private Options.Option setting;

        public SideBarItem (Options.Option setting) {
            this.setting = setting;

            icon_name = setting.get_icon_name ();
            title = setting.get_title ();

            build_ui ();
            connect_signals ();

            this.show_all ();
        }

        public Options.Option get_setting () {
            return this.setting;
        }

        private void build_ui () {
            var hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            // generate widgets that will be used in the row
            var themed_icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.DND);
            var title_label = new Gtk.Label (title);
            var description_label = new Gtk.Label (description);

            // gtk widget properties
            themed_icon.halign = Gtk.Align.START;
            title_label.expand = true;
            title_label.halign = Gtk.Align.START;
            title_label.get_style_context ().add_class ("h3");

            // populate widgets
            hbox.add (themed_icon);
            hbox.add (title_label);

            this.add (hbox); // add hbox to this row
        }

        private void connect_signals () {

        }
    }

    private class CategoryHeader : Gtk.ListBoxRow {

        public CategoryHeader (string title) {
            this.add (new Gtk.Label (title));
            this.set_selectable (false);
            this.halign = Gtk.Align.START;
            this.get_style_context ().add_class ("h4");
        }
    }

}
