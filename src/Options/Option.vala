
namespace PantheonTweaks {

    public interface Options.Option : GLib.Object {
        // method getters
        public abstract string get_icon_name ();
        public abstract string get_title ();
        public abstract string get_description ();
        public abstract string get_category ();

        // get content
        public abstract Gtk.Box get_content ();
    }
}
