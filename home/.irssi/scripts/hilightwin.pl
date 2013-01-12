#
# Print hilighted messages & private messages to window named "hilight" for
# irssi 0.7.99 by Timo Sirainen
#
# Modded a tiny bit by znx to stop private messages entering the hilighted
# window (can be toggled) and to put up a timestamp.
# Also added a setting to specify the windowname to log to.
#

use Irssi;
use POSIX;
use vars qw($VERSION %IRSSI); 

$VERSION = "0.03";
%IRSSI = (
    authors     => "Timo \'cras\' Sirainen, Mark \'znx\' Sangster, Gerfried Fuchs",
    contact     => "tss\@iki.fi, znxster\@gmail.com, rhonda\@deb.at",
    name        => "hilightwin",
    description => "Print hilighted messages to window named \"hilight\"",
    license     => "Public Domain",
    url         => "http://irssi.org/",
    changed     => "Mon, 12 Mar 2012 10:14:05 +0100"
);

sub sig_printtext {
    my ($dest, $text, $stripped) = @_;

    my $opt = MSGLEVEL_HILIGHT;

    if(Irssi::settings_get_bool('hilightwin_showprivmsg')) {
        $opt = MSGLEVEL_HILIGHT|MSGLEVEL_MSGS;
    }
    
    if(
        ($dest->{level} & ($opt)) &&
        ($dest->{level} & MSGLEVEL_NOHILIGHT) == 0
    ) {
        $window = Irssi::window_find_name(Irssi::settings_get_str('hilightwin_windowname'));
        
        if ($dest->{level} & MSGLEVEL_PUBLIC) {
            $text = $dest->{target}.": ".$text;
        }
        $text = strftime(
            Irssi::settings_get_str('timestamp_format')." ",
            localtime
        ).$text;
        $window->print($text, MSGLEVEL_NEVER) if ($window);
    }
}

Irssi::settings_add_str('hilightwin','hilightwin_windowname', 'hilight');
$window = Irssi::window_find_name(Irssi::settings_get_str('hilightwin_windowname'));
Irssi::print("Create a window named '" . Irssi::settings_get_str('hilightwin_windowname') . "'") if (!$window);

Irssi::settings_add_bool('hilightwin','hilightwin_showprivmsg',1);

Irssi::signal_add('print text', 'sig_printtext');

# vim:set ts=4 sw=4 et:
