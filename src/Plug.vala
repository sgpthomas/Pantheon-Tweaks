// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2014 YOUR NAME (http://launchpad.net/your-project)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Corentin Noël <tintou@mailoo.org>
 */
namespace PantheonTweaks {

    public static Plug plug;

    public class Plug : Switchboard.Plug {

        private Gtk.Stack stack;

        private Views.MainView main_view;
        private Views.AlertView alert_view;

        public Plug () {
            Object (category: Category.PERSONAL,
                    code_name: Build.PLUGCODENAME,
                    display_name: _("Tweaks"),
                    description: _("Tweak your elementary desktop"),
                    icon: "applications-development");
            plug = this;

            build_ui ();
            connect_signals ();
        }

        private void build_ui () {
            var show_alert = true;

            stack = new Gtk.Stack ();
            main_view = new Views.MainView ();
            alert_view = new Views.AlertView ();

            stack.add_named (main_view, "main");
            stack.add_named (alert_view, "alert");

            stack.show_all ();

            if (show_alert) {
                message ("show alert view");
                stack.set_visible_child_name ("alert");
            } else {
                stack.set_visible_child_name ("main");
            }
        }

        private void connect_signals () {
            alert_view.action_activated.connect (() => {
                stack.set_visible_child_name ("main");
            });
        }

        public override Gtk.Widget get_widget () {
            return stack;
        }

        public override void shown () {

        }

        public override void hidden () {

        }

        public override void search_callback (string location) {

        }

        // 'search' returns results like ("Keyboard → Behavior → Duration", "keyboard<sep>behavior")
        public override async Gee.TreeMap<string, string> search (string search) {
            return new Gee.TreeMap<string, string> (null, null);
        }
    }
}

private void load_stylesheet () {
    var css_file = Build.PKGDATADIR + "/style/style.css";
    var provider = new Gtk.CssProvider ();
    try {
        provider.load_from_path (css_file);
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
        message ("Loaded %s", css_file);
    } catch (Error e) {
        error ("Error with stylesheet: %s", e.message);
    }
}

public Switchboard.Plug get_plug (Module module) {
    message ("Activating Pantheon Tweaks");
    load_stylesheet ();
    var plug = new PantheonTweaks.Plug ();
    return plug;
}
