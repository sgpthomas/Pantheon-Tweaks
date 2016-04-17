
namespace PantheonTweaks {

    public class Options.Window : Gtk.Box, Options.Option {

        // interface methods
        public string get_icon_name () {
            return "multitasking-view";
        }

        public string get_title () {
            return _("Windows");
        }

        public string get_description () {
            return _("Test Description");
        }

        public string get_category () {
            return _("System");
        }

        public Window () {
            /* Grid Setup */
            var grid = new Gtk.Grid ();

            grid.halign = Gtk.Align.CENTER;
            grid.column_spacing = 12;
            grid.row_spacing = 6;

            var row = 0;

            /* General */
            Widgets.add_category (grid, "General", ref row);
            var description = "";
            var warning = "";

            // attached modal dialogs
            var modal_toggle = new Gtk.Switch ();
            description = "When active, instead of having independent titlebars, modal dialogs appear attached to the titlebar of the parent window and are moved together with the parent window";
            Widgets.add_option (grid, "Attach Modal Dialogs", modal_toggle, ref row, () => {
                    Settings.GalaAppearance.get_default ().schema.reset ("attach-modal-dialogs");
                }, description);
            Settings.GalaAppearance.get_default ().schema.bind ("attach-modal-dialogs",
                modal_toggle, "active", SettingsBindFlags.DEFAULT);

            // resize with secondary click
            var resize_toggle = new Gtk.Switch ();
            description = "Hold 'super' + 'secondary-click' to resize window from anywhere within the window";
            Widgets.add_option (grid, "Resize with Secondary-click", resize_toggle, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("resize-with-right-button");
                }, description);
            Settings.WM.get_default ().schema.bind ("resize-with-right-button",
                resize_toggle, "active", SettingsBindFlags.DEFAULT);

            // window action combo
            var window_action_combo = new Gtk.ComboBoxText ();
            description = """Clicking a window while holding down this modifier key will move the window (primary click) or, if enabled, resize the window (secondary click)""";
            Widgets.add_option (grid, "Window Action Key", window_action_combo, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("mouse-button-modifier");
                }, description);
            window_action_combo.append ("<Alt>", "Alt");
            window_action_combo.append ("<Super>", "Super");
            window_action_combo.append ("disabled", "Disabled");
            window_action_combo.set_active_id (Settings.WM.get_default ().mouse_button_modifier);
            window_action_combo.changed.connect (() => {
                Settings.WM.get_default ().mouse_button_modifier = window_action_combo.get_active_id ();
            });

            // focus mode
            var focus_mode_combo = new Gtk.ComboBoxText ();
            var auto_raise_toggle = new Gtk.Switch (); // created here so that it can be sensitive or not
            description = """The window focus mode indicates how windows are activated. It has three possible values: "click" means windows must be clicked in order to focus them, "sloppy" means windows are focused when the mouse enters the window, and "mouse" means windows are focused when the mouse enters the window and unfocused when the mouse leaves the window""";
            Widgets.add_option (grid, "Focus Mode", focus_mode_combo, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("focus-mode");
                }, description);
            focus_mode_combo.append ("click", "Click");
            focus_mode_combo.append ("mouse", "Mouse");
            focus_mode_combo.append ("sloppy", "Sloppy");
            focus_mode_combo.set_active_id (Settings.WM.get_default ().focus_mode);
            focus_mode_combo.changed.connect (() => {
                Settings.WM.get_default ().focus_mode = focus_mode_combo.get_active_id ();

                if (focus_mode_combo.get_active_id () == "click") {
                    auto_raise_toggle.sensitive = false;
                } else {
                    auto_raise_toggle.sensitive = true;
                }
            });

            // automatically raise windows
            description = """If turned on, and the focus mode is either "sloppy" or "mouse" then the focused window will be automatically raised after a delay specified by the auto-raise-delay key. This is not related to clicking on a window to raise it, nor to entering a window during drag-and-drop.""";
            Widgets.add_option (grid, "Automatically Raise Windows", auto_raise_toggle, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("auto-raise");
                }, description);
            Settings.WM.get_default ().schema.bind ("auto-raise", auto_raise_toggle,
                "active", SettingsBindFlags.DEFAULT);
            if (focus_mode_combo.get_active_id () == "click") {
                auto_raise_toggle.sensitive = false;
            } else {
                auto_raise_toggle.sensitive = true;
            }

            /* Titlebar Actions */
            Widgets.add_category (grid, "Titlebar Actions", ref row);

            // double click combo
            var double_combo = new Gtk.ComboBoxText ();
            description = "Action that occurs when the titlebar is double-clicked";
            Widgets.add_option (grid, "Double-click", double_combo, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("action-double-click-titlebar");
                }, description);
            foreach (var key in Settings.WM.get_titlebar_actions ().keys) {
                double_combo.append (key, Settings.WM.get_titlebar_actions ().get (key));
            }
            double_combo.set_active_id (Settings.WM.get_default ().action_double_click_titlebar);
            double_combo.changed.connect (() => {
                Settings.WM.get_default ().action_double_click_titlebar = double_combo.get_active_id ();
            });

            // middle click combo
            var middle_combo = new Gtk.ComboBoxText ();
            description = "Action that occurs when the titlebar is middle-clicked";
            Widgets.add_option (grid, "Middle-click", middle_combo, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("action-middle-click-titlebar");
                }, description);
            foreach (var key in Settings.WM.get_titlebar_actions ().keys) {
                middle_combo.append (key, Settings.WM.get_titlebar_actions ().get (key));
            }
            middle_combo.set_active_id (Settings.WM.get_default ().action_middle_click_titlebar);
            middle_combo.changed.connect (() => {
                Settings.WM.get_default ().action_middle_click_titlebar = middle_combo.get_active_id ();
            });

            // secondary click combo
            var secondary_combo = new Gtk.ComboBoxText ();
            description = "Action that occurs when the titlebar is secondary-clicked";
            Widgets.add_option (grid, "Secondary-clicked", secondary_combo, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("action-right-click-titlebar");
                }, description);
            foreach (var key in Settings.WM.get_titlebar_actions ().keys) {
                secondary_combo.append (key, Settings.WM.get_titlebar_actions ().get (key));
            }
            secondary_combo.set_active_id (Settings.WM.get_default ().action_right_click_titlebar);
            secondary_combo.changed.connect (() => {
                Settings.WM.get_default ().action_right_click_titlebar = secondary_combo.get_active_id ();
            });

            /* Titlebar Buttons */
            Widgets.add_category (grid, "Window Control Layout", ref row);

            // button layout widget
            var button_layout = new Widgets.WindowControl ();
            description = "Changes where window controls will be located";
            warning = "This widget is not fully implemented yet. Most combinations are currently possible but the widget may have glitches in rendering";
            Widgets.add_option (grid, "Window Control Layout", button_layout, ref row, () => {
                    Settings.WM.get_default ().schema.reset ("button-layout");
                }, description, warning);

            /* HiDPi */
            // Widgets.add_category (grid, "HiDPI", ref row);

            // window scaling
            /* var scale_slider = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0.0, 2.0, 1.0);
            scale_slider.set_value_pos (Gtk.PositionType.RIGHT);
            scale_slider.format_value.connect ((val) => {
                if (val == 0) {
                    return "Auto";
                }
                return val.to_string ();
            });
            description = "Factor used to scale windows and Gtk elements";
            Widgets.add_option (grid, "Window Scaling", scale_slider, ref row, () => {
                    Settings.Interface.get_default ().schema.reset ("scaling-factor");
                }, description);
            scale_slider.set_value ((int) Settings.Interface.get_default ().scaling_factor);
            scale_slider.value_changed.connect (() => {
                message (scale_slider.get_value ().to_string ());
                Settings.Interface.get_default ().scaling_factor = (uint32) scale_slider.get_value ();
            });*/

            /* Update all the things */
            Settings.WM.get_default ().changed.connect (() => {
                window_action_combo.set_active_id (Settings.WM.get_default ().mouse_button_modifier);
                focus_mode_combo.set_active_id (Settings.WM.get_default ().focus_mode);
                double_combo.set_active_id (Settings.WM.get_default ().action_double_click_titlebar);
                middle_combo.set_active_id (Settings.WM.get_default ().action_middle_click_titlebar);
                secondary_combo.set_active_id (Settings.WM.get_default ().action_right_click_titlebar);
            });

            /* Settings.Interface.get_default ().changed.connect (() => {
                scale_slider.set_value ((int) Settings.Interface.get_default ().scaling_factor);
            }); */

            /* Add Grid to box and return it */
            grid.show_all ();
            // var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            this.add (grid);
        }

        public void terminate () {
            message ("something");
        }
    }
}
