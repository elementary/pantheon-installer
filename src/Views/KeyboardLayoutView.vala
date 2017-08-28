// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2017 elementary LLC. (https://elementary.io)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class KeyboardLayoutView : AbstractInstallerView {
    public signal void next_step ();

    construct {
        var image = new Gtk.Image.from_icon_name ("input-keyboard", Gtk.IconSize.DIALOG);
        image.valign = Gtk.Align.END;

        var title_label = new Gtk.Label (_("Keyboard Layout"));
        title_label.get_style_context ().add_class ("h2");
        title_label.valign = Gtk.Align.START;

        var input_language_list_box = new Gtk.ListBox ();
        input_language_list_box.add (new Gtk.Label ("test_layout"));
        input_language_list_box.add (new Gtk.Label ("test_layout"));
        input_language_list_box.add (new Gtk.Label ("test_layout"));
        input_language_list_box.add (new Gtk.Label ("test_layout"));
        input_language_list_box.add (new Gtk.Label ("test_layout"));

        var back_button = new Gtk.Button.with_label (_("Input Language"));
        back_button.halign = Gtk.Align.START;
        back_button.margin = 6;
        back_button.get_style_context ().add_class ("back-button");

        var keyboard_layout_list_box = new Gtk.ListBox ();
        keyboard_layout_list_box.expand = true;
        keyboard_layout_list_box.add (new Gtk.Label ("test_variant"));
        keyboard_layout_list_box.add (new Gtk.Label ("test_variant"));

        var keyboard_layout_grid = new Gtk.Grid ();
        keyboard_layout_grid.orientation = Gtk.Orientation.VERTICAL;
        keyboard_layout_grid.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);
        keyboard_layout_grid.add (back_button);
        keyboard_layout_grid.add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
        keyboard_layout_grid.add (keyboard_layout_list_box);

        var stack = new Gtk.Stack ();
        stack.expand = true;
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
        stack.add (input_language_list_box);
        stack.add (keyboard_layout_grid);

        var keyboard_map_button = new Gtk.Button.from_icon_name ("input-keyboard-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

        var action_bar = new Gtk.ActionBar ();
        action_bar.get_style_context ().add_class (Gtk.STYLE_CLASS_INLINE_TOOLBAR);
        action_bar.add (keyboard_map_button);

        var selection_grid = new Gtk.Grid ();
        selection_grid.orientation = Gtk.Orientation.VERTICAL;
        selection_grid.add (stack);
        selection_grid.add (action_bar);

        var frame = new Gtk.Frame (null);
        frame.add (selection_grid);

        content_area.column_homogeneous = true;
        content_area.margin_end = 10;
        content_area.margin_start = 10;
        content_area.attach (image, 0, 0, 1, 1);
        content_area.attach (title_label, 0, 1, 1, 1);
        content_area.attach (frame, 1, 0, 1, 2);

        var cancel_button = new Gtk.Button.with_label (_("Cancel Installation"));

        var next_button = new Gtk.Button.with_label (_("Next"));
        next_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

        action_area.add (cancel_button);
        action_area.add (next_button);

        cancel_button.clicked.connect (() => cancel ());
        next_button.clicked.connect (() => next_step ());

        back_button.clicked.connect (() => {
            stack.visible_child = input_language_list_box;
        });

        input_language_list_box.row_activated.connect (() => {
            stack.visible_child = keyboard_layout_grid;
        });
    }
}
