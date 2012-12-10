use strict;
use warnings;
use Irssi;
use Irssi::Irc;

our $VERSION = '0.01';
our %IRSSI = (
    authors => "Chris Baker",
    contact => 'dosman711\@gmail.com',
    name => 'irssi-bitlbee-gtalk-rename',
    description => 'Rename XMPP Gmail and G+ contacts in bitlbee to human-readable names. Based on http://github.com/avar/irssi-bitlbee-facebook-rename',
    license => 'GPL',
);

#  description:
#
#  irssi-bitlbee-gchat-rename.pl will automatically watch for joins in the
#  BitlBee channel from Google contacts and will rename them to more
#  human-readable names.
#
#  Options:
#
#  /set ibgr_bitlbee_channel <string>
#    Sets the name of the BitlBee channel. Defaults to '&bitlbee'
#
#  /set ibgr_gplus_server <string>
#    Sets the name of the Google+ talk server. Defaults to 'public.talk.google.com'
#
#  /set ibgr_gmail_server <string>
#    Sets the name of the Gmail talk server. Defaults to 'gmail.com'
#
#  /set ibgr_rename_gplus_contacts <bool>
#    Sets a boolean whether or not to rename G+ contacts. Defaults to 'ON'
#
#  /set ibgr_rename_gmail_contacts <bool>
#    Sets a boolean whether or not to rename Gmail contacts. Defaults to 'OFF'


my %nicksToRename = ();

sub message_join
{
  # "message join", SERVER_REC, char *channel, char *nick, char *address
  my ($server, $channel, $nick, $address) = @_;
  my ($username, $host) = split /@/, $address;
  
  my $bitlbeeChannel = Irssi::settings_get_str('ibgr_bitlbee_channel');
  my $gplushost = Irssi::settings_get_str('ibgr_gplus_server');
  my $gmailhost = Irssi::settings_get_str('ibgr_gmail_server');

  if ($channel =~ m/$bitlbeeChannel/ and substr $nick,1 =~ m/$username/)
  {
    if((Irssi::settings_get_bool('ibgr_rename_gplus_contacts') and $host =~ m/$gplushost/) 
        or (Irssi::settings_get_bool('ibgr_rename_gmail_contacts') and $host =~ m/$gmailhost/))
    {
      $nicksToRename{$nick} = $channel;
      $server->command("whois -- $nick");
    }
  }
}

sub whois_data
{
  my ($server, $data) = @_;
  my ($me, $nick, $user, $host) = split(" ", $data);

  if (exists($nicksToRename{$nick}))
  {
    my $channel = $nicksToRename{$nick};
    delete($nicksToRename{$nick});

    my $ircname = substr($data, index($data,':')+1);

    $ircname = munge_nickname( $ircname );

    if ($ircname ne $nick)
    {
      $server->command("msg $channel rename $nick $ircname");
      #$server->command("msg $channel save");
    }
  }
}

sub munge_nickname
{
  my ($nick) = @_;

  $nick =~ s/ä/ae/g;
  $nick =~ s/ü/ue/g;
  $nick =~ s/ö/oe/g;
  $nick =~ s/ß/ss/g;
  $nick =~ s/[^A-Za-z0-9-]/_/g;
  #$nick = "svz_" . $nick;
  $nick = substr $nick, 0, 24;

  return $nick;
}


Irssi::settings_add_str('IBGR', 'ibgr_bitlbee_channel', '&bitlbee');
Irssi::settings_add_str('IBGR', 'ibgr_gplus_server', 'public.talk.google.com');
Irssi::settings_add_str('IBGR', 'ibgr_gmail_server', 'gmail.com');
Irssi::settings_add_bool('IBGR', 'ibgr_rename_gplus_contacts', 1);
Irssi::settings_add_bool('IBGR', 'ibgr_rename_gmail_contacts', 0);

Irssi::signal_add_first 'message join' => 'message_join';
Irssi::signal_add_first 'event 311' => 'whois_data';
