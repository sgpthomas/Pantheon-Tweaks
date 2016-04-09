
namespace PantheonTweaks.Settings {

    public class WM : Granite.Services.Settings {

        // keys
        public string action_double_click_titlebar { get; set; }
        public string action_middle_click_titlebar { get; set; }
        public string action_right_click_titlebar { get; set; }
        public bool auto_raise { get; set; }
        public string button_layout { get; set; }
        public string focus_mode { get; set; }
        public string mouse_button_modifier { get; set; }
        public bool resize_with_right_button { get; set; }

        private WM () {
            base ("org.gnome.desktop.wm.preferences");
        }

        private static WM? instance = null;

        public static WM get_default () {
            if (instance == null) {
                instance = new WM ();
            }

            return instance;
        }
    }
}
