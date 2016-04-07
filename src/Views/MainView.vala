

namespace PantheonTweaks {

    public class Views.MainView : Gtk.Paned {

        private Widgets.SideBar sidebar;
        private Widgets.SettingsEditor editor;

        public MainView() {
            sidebar = new Widgets.SideBar ();
            editor = new Widgets.SettingsEditor ();

            this.add1 (sidebar);
            this.add2 (editor);

            sidebar.select_row (sidebar.get_row_at_index (1));

            sidebar.option_selected.connect ((content) => {
                editor.show_setting (content);
            });
        }
    }
}
