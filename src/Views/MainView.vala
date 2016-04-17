

namespace PantheonTweaks {

    public class Views.MainView : Gtk.Paned {

        private Widgets.SideBar sidebar;
        private Widgets.SettingsEditor editor;

        public MainView() {
            sidebar = new Widgets.SideBar ();
            editor = new Widgets.SettingsEditor ();

            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.add (editor);

            this.add1 (sidebar);
            this.add2 (scroll);

            sidebar.add_option.connect ((content) => {
                editor.add_setting (content);
            });

            sidebar.build_ui ();

            sidebar.option_selected.connect ((content) => {
                editor.show_setting (content);
            });

            sidebar.select_row (sidebar.get_row_at_index (1));
        }
    }
}
