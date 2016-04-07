
namespace PantheonTweaks {

    public class Settings.Interface : Granite.Services.Settings {

        // fonts
        public string font_name { get; set; }
        public string document_font_name { get; set; }
        public string monospace_font_name { get; set; }

        // themes
        public string cursor_theme { get; set; }
        public string gtk_theme { get; set; }
        public string icon_theme { get; set; }

        private Interface () {
            base ("org.gnome.desktop.interface");
        }

        private static Interface? instance = null;

        public static Interface get_default () {
            if (instance == null) {
                instance = new Interface ();
            }

            return instance;
        }

        /**
         * Gets and returns a list of the current themes by path and condition.
         */
        public static Gee.List<string> get_themes (string path, string condition = "") {
            var themes = new Gee.ArrayList<string> ();

            string[] dirs = {
                "/usr/share/" + path + "/",
                Environment.get_home_dir () + "/." + path + "/",
                Environment.get_home_dir () + "/.local/share/" + path + "/"};

            foreach (string dir in dirs) {
                try {
                    var enumerator = File.new_for_path (dir).enumerate_children (FileAttribute.STANDARD_NAME, 0);
                    FileInfo file_info;
                    while ((file_info = enumerator.next_file ()) != null) {
                        var name = file_info.get_name ();
                        var checktheme = File.new_for_path (dir + name + "/" + condition);
                        var checkicons = File.new_for_path (dir + name + "/48x48/" + condition);
                        if ( ( checktheme.query_exists() || checkicons.query_exists() ) &&
                                name != "Emacs" && name != "Default" && name != "default" && !themes.contains(name))
                            themes.add(name);
                    }
                } catch (Error e) { /* warning (e.message); */ }
            }

            return themes;
        }
    }
}
