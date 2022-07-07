# Copyright 2009-2010 Jérôme Pasquier

# This file is part of backup_prog.

# backup_prog is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# backup_prog is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with backup_prog.  If not, see <http://www.gnu.org/licenses/>.

use strict;

# This file is used to define Widget preferences for the GUI
# This values should later be placed in YAML files

use constant {
# If 1, force the drawing of the widget's background with
# white space characters. 
    force_bce => 1,

#   widget_name, position, size, color_pair_id, borders
#   According to the Widget.pm constructor
    true  => 1,
    false => 0,

    null  => 0
};

# exports
use Exporter qw(import);
our @EXPORT_OK   =  qw(true false null);
our %EXPORT_TAGS = (Booleans => [qw(true false null)]);

1;
