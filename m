Message-ID: <4D9ED052.7040009@...515...>
Date: Fri, 08 Apr 2011 12:07:30 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050701010100030100030402"
Subject: [Openvpn-devel] Summary of the IRC meeting (7th Apr 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050701010100030100030402
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 7th Apr 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-04-07>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, ecrist, jamesyonan, krzee and mattock were present
in this meeting.

--

Discussed 2.2-RC2 release. So far it has seemed solid, as there have
been no complaints and it has been downloaded (from openvpn.net) several
thousands of times. Krzee also verified during the meeting that the
"--server" functionality works on Windows again; this was a regression
introduced in 2.2-RC.

--

Discussed the patch queue for 2.2 (final). There's one outstanding issue:

<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-test=
ing.git;a=3Dcommit;h=3D77d24405096452541700fb24aacd6f8a589fce3b>

In addition, there are several less critical patches/proposed patches
queued for 2.2. Discussed the "Change the default --tmp-dir path to a
more suitable path" first:

<http://thread.gmane.org/gmane.network.openvpn.devel/4561>

Agreed that having a configure option is unnecessary; instead we need a
useful error message when --tmp-dir needs to be set, and is not. Dazo
will provide updated version of the patch.

The following are for mattock:

 * Fix Windows README UNIX linefeed issue with release tarballs/zips
 * Fix TAP_RELDATE in win/settings.in
 * Make sure make_dist.py copies $TAP_PREBUILT/<arch>/tapinstall.exe to
dist/<arch> automatically
 * Remove mention of Win2k from Windows installer

--

Discussed undocumented features found in 2.2:

<https://community.openvpn.net/openvpn/wiki/ManPageUpdatesFor2.2>

Noted that --push-continuation is an internal option not used on the
command-line and removed it from "ManPageUpdatesFor2.2" list.

Cron2 and jamesyonan clarified a few options: "If --register-dns is set,
openvpn needs to call itself in a sub-process to execute the required
functions in a non-blocking way, and uses --rdns-internal to signal
that". Cron2 will provide a documentation patch.

Decided to go through the remaining options with jamesyonan in another
IRC meeting.

--

Discussed 2.2 release schedule. Ended up with this:

 - windows installer with new --tmp-dir patch out by next Monday
 - all queued 2.2 patches ready by 13th Apr (Wednesday)
 - a preview 2.2 installer ready by 14th Apr (Thursday)
 - final 2.2 release will be made after that by 22nd Apr (Friday)

--

Discussed the deviation of 2.1 branch maintained by James and 2.2 branch
maintained by dazo. Latest 2.1 -> 2.2 merges are ~4 months old.
Decided to include one important bugfix from 2.1 branch to 2.2 (final):

svn log -v -r7127 http://svn.openvpn.net/projects/openvpn/branches/2.1

Another important bugfix is too invasive at this point and will be go
into 2.3:

svn log -v -r7127 http://svn.openvpn.net/projects/openvpn/branches/2.1

James estimated that he could start using 2.2 branch internally within a
few months.

--

Discussed two issues reported by Jason Haar, both of which are now Trac
tickets:

<https://community.openvpn.net/openvpn/ticket/110>
<https://community.openvpn.net/openvpn/ticket/113>

Both are queued for the 2.3 release.

--

Discussed 2.3 release date. Dazo estimated late September for the final
2.3 release, with first alpha release on June.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------050701010100030100030402
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-04-08.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-04-08.txt"

(20:57:03) mattock: everybody set for the meeting?
(20:58:21) cron2: sort of
(20:58:46) mattock: that's a start :D
(20:58:47) cron2: we're just starting dinner, took longer than expected to =
convince $daughter to sleep...
(20:58:58) cron2: but laptop is sitting next to the tables, I just might be=
 slow in responding :)
(21:00:19) mattock: cron2: no problem!
(21:00:28) mattock: dazo: there?
(21:00:36) dazo: I am
(21:01:03) mattock: mkay
(21:01:21) ecrist: sup d00ds?
(21:01:33) ecrist: date -u
(21:01:45) mattock: ecrist: yep
(21:01:48) cron2: ecrist: you're right on time :)
(21:01:51) ecrist: :)
(21:02:04) mattock: topics here: https://community.openvpn.net/openvpn/wiki=
/Topics-2011-04-07
(21:02:05) vpnHelper: Title: Topics-2011-04-07 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:03:49) mattock: I mailed James
(21:03:59) mattock: maybe start from the top...
(21:04:13) mattock: anybody heard any feedback on 2.2-RC2?
(21:04:31) mattock: regressions or similar?
(21:04:47) dazo: Not more than this --tmp-dir issue, which is not really a =
regression
(21:05:12) mattock: does the server functionality now work on Windows, btw?
(21:05:21) dazo: (but might be considered to be regression for some not kno=
wing the details)
(21:06:18) dazo: krzee: ecrist: have you spotted anything regarding --mode =
server on Windows with RC2?
(21:06:59) dazo: mattock: that could probably be spotted by running openvpn=
 --version ... to see the ENABLE flags
(21:07:46) mattock: yep, except that the python build cobbles those togethe=
r based on win/settings.in
(21:08:07) mattock: I'll double check
(21:08:16) dazo: yeah, but that generates config.h, right?
(21:08:27) dazo: but yeah, I see the possible issue
(21:09:17) mattock: so config.h is generated from win/config.h.in, but some=
 variables in config.h.in are fetched from win/settings.in
(21:10:01) mattock: anyways, I don't think --version stuff can be trusted 1=
00%
(21:10:19) mattock: because something might happen when stuff moves from wi=
n/settings.in to config.h
(21:10:33) dazo: ouch, not too good ... but that can be improved for later
(21:11:04) mattock: is there an easy check for verifying --server stuff wor=
ks on Windowns?
(21:11:06) mattock: windows
(21:11:46) dazo: Do you see --server mentioned if running openvpn --help?
(21:11:47) krzee: ok 1min
(21:11:55) krzee: i have a windows VM where i am right now
(21:12:04) mattock: krzee: great!
(21:12:05) dazo: cool!
(21:12:17) krzee: actually very NOT cool, but its required for work
(21:12:18) mattock: I added a few minor patch suggestions to the topic list
(21:12:23) krzee: im the only non-windows user here ;]
(21:13:02) dazo: mattock: we do have one outstanding issue ... if your read=
 commit commit 77d24405096452541700fb24aacd6f8a589fce3b
(21:13:09) mattock: dazo: just a sec
(21:13:15) cron2: krzee: I'm very much a non-windows user!
(21:13:16) krzee: im testing the RC from openvpn.net/download right?
(21:13:26) krzee: cron2, here being my office
(21:13:30) mattock: krzee: yes, 2.2-RC2
(21:13:37) cron2: krzee: ah :)
(21:13:54) dazo: krzee: The closest I get to Windows on my work and private=
 laptops is WINE ;-)
(21:13:56) krzee: this channel *here* is FULL of non windows users
(21:13:56) krzee: heheh
(21:14:01) mattock: dazo: oh yes, the snprintf stuff
(21:14:05) dazo: yeah
(21:14:31) mattock: krzee: also, I don't use Windows either, I just chose t=
o take the beating because I get paid for it :D
(21:14:31) dazo: I just remembered that now
(21:14:53) krzee: sounds like the only reason i have a windows VM here
(21:14:54) krzee: heheh
(21:15:12) dazo: :)
(21:15:30) mattock: dazo: any ideas about the INSTALL-win32.txt linefeed is=
sue with the tarballs?
(21:15:47) mattock: if I build an installer from Git code, all is fine
(21:16:13) mattock: if I build one from a release tarball/zip, the README f=
ile has UNIX linefeeds (=3Dall in one line in notepad.exe)
(21:16:15) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:16:15) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(21:16:21) mattock: hi jamesyonan!
(21:16:38) jamesyonan: hi!
(21:16:53) mattock: jamesyonan: I just added a few patch suggestions to the=
 topic list: https://community.openvpn.net/openvpn/wiki/Topics-2011-04-07
(21:16:54) vpnHelper: Title: Topics-2011-04-07 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:17:13) dazo: mattock: that's some nasty git trickery :(
(21:17:23) mattock: do you know what's causing it?
(21:17:40) dazo: when you extract that file on Windows, git understands aut=
omatically it needs to convert it to CRLF ... while only use LF on *nix
(21:18:00) krzee: hrm, first thing i notice is that after starting openvpn =
gui, it loads to the taskbar but double clicking it isnt bringing it up
(21:18:14) mattock: krzee: is it supposed to?
(21:18:20) mattock: I've always used right-click
(21:18:41) mattock: jamesyonan: have you heard any complaints of 2.2-RC2?
(21:18:44) krzee: oh its cause im using .conf
(21:18:46) krzee: heh
(21:18:47) krzee: damn windows
(21:19:02) mattock: none of us has heard anything negative
(21:19:06) jamesyonan: mattock: no I haven't
(21:19:22) dazo: so when I do 'make distcheck' on Linux, it will only have =
NL (not CRLF) ... while if it's done on Windows (ie. via make dist-zip) fro=
m a git tree, it will be correct
(21:19:30) mattock: it's downloaded several thousands of times now, so I su=
ppose it's pretty solid
(21:19:51) krzee: interesting, i never know you cant use --log or --daemon =
in windows with the gui
(21:20:19) krzee: right clicking it does bring up the menu - proxy settings=
 about exit
(21:20:27) krzee: errm
(21:20:30) krzee: mis-fire
(21:20:36) mattock: krzee: I can also test it, I got everything setup corre=
ctly
(21:21:01) mattock: dazo: what do you suggest we do about the linefeed issu=
e?
(21:21:08) krzee: Options error:  unrecognized option or missing parameter(=
s) in server.ovpn:9:server (2.2-RC)
(21:21:12) mattock: manual fixing before release?
(21:21:25) mattock: krzee: I'll verify that
(21:21:28) dazo: krzee: you need 2.2-RC2 ... 2.2-RC is missing --server
(21:21:49) krzee: i just downloaded from openvpn.net/download
(21:21:49) dazo: this was one of the main reasons for spinning RC2
(21:22:13) krzee: if im supposed to grab from somewhere else, where?
(21:22:51) dazo: it should be the correct one on this page: http://openvpn.=
net/index.php/open-source/downloads.html
(21:22:53) vpnHelper: Title: Downloads (at openvpn.net)
(21:22:58) krzee: oh the DL page has both
(21:23:01) krzee: (why!?)
(21:23:37) krzee: still has beta too!?
(21:24:15) ***krzee puts in a vote to only have most recent stuff on the DL=
 page
(21:25:01) krzee: i replaced openvpn 2.2-RC with 2.2-RC2, i now have 4 open=
vpn gui icons on my desktop
(21:25:02) ***dazo agrees with krzee=20
(21:25:04) krzee: heh
(21:25:08) dazo: heh
(21:25:21) mattock: krzee: lovely, 4 icons... :)
(21:25:35) krzee: server running, no errors
(21:25:42) mattock: krzee: which Windows version?
(21:25:45) mattock: krzee: cool!
(21:25:47) krzee: XP
(21:26:10) mattock: krzee: how did you manage to get 4 GUI icons? did you r=
un openvpn-gui during uninstall?
(21:26:27) krzee: i exited it before installing 2.2-RC2
(21:26:32) mattock: ok
(21:26:33) krzee: i never uninstalled at all
(21:26:41) krzee: i just installed 2.2-RC2 over 2.2-RC
(21:26:51) mattock: ok, I'll try to reproduce that
(21:27:09) mattock: the long-term solution would be to run the _old_ uninst=
aller before running the _new_ installer
(21:27:43) mattock: in an automated fashion, I mean
(21:27:52) krzee: sure, but cant expect they will
(21:27:55) ***cron2 also agrees regarding download page - those versions th=
at we know to be broken should go to "archive" or such
(21:27:56) krzee: ahh right
(21:27:58) krzee: agreed
(21:28:17) krzee: although no garuntee the old uninstaller will work
(21:28:29) mattock: cron2, krzee: I'll remove the old versions from openvpn=
.net
(21:28:43) dazo: I just noticed one thing ... running the installer via WIN=
E ... it says in the opening screen "Note that the Windows version of OpenV=
PN will only run on Win 2000, XP or higher" ... we need to change that one
(21:29:01) mattock: yep, remove Win2k
(21:29:06) cron2: good point
(21:29:14) krzee: ahh no more 2k?
(21:29:19) krzee: 2k3 still good?
(21:29:26) dazo: nope 2.1.3 was the last Win 2k
(21:29:28) dazo: 2k3 is good
(21:29:35) krzee: cool good to know
(21:29:48) dazo: 2k3 =3D=3D Windows XP for servers, if I'm not totally wrong
(21:30:16) krzee: erm
(21:30:18) krzee: not really
(21:30:23) mattock: win2k has been EOL for, what, 6 months already?
(21:30:24) krzee: more like 2000
(21:30:38) dazo: not really, but it's linked to features WinXP supports=20
(21:30:45) krzee: really only 6 months!?
(21:31:11) mattock: or was it 12? not sure
(21:31:24) krzee: either way, microsoft supported win2k til 2010!?
(21:31:42) mattock: krzee: yes... the extended, paid support
(21:31:48) krzee: wow
(21:31:58) mattock: most people lost support several years ago I think
(21:31:58) krzee: thats like if freebsd3 was still supported
(21:32:05) mattock: silly, isn't it :)
(21:32:06) krzee: seriously, thats what was out in 2000 ;]
(21:32:17) krzee: i remember running fbsd3 in '99
(21:32:19) cron2: krzee: nah, we already had fbsd4 in 2000!
(21:32:29) krzee: oh, well not for very long then!
(21:32:34) cron2: .oO(some of these boxes are still in service...)
(21:32:52) cron2: sorry for distraction :)
(21:33:06) krzee: my fault ;]
(21:33:16) mattock: ok, back to business? :P
(21:33:44) mattock: krzee: so --server _is_ working in 2.2-RC2?
(21:33:48) mattock: just double-checking
(21:34:02) krzee: i cant confirm by connecting anything, but yes
(21:34:17) krzee: 2.2-RC died with error, 2.2-RC2 starts as expected
(21:34:22) mattock: ok, then it's active
(21:34:29) dazo: agreed
(21:34:46) mattock: dazo: what's the state of this patch: http://thread.gma=
ne.org/gmane.network.openvpn.devel/4561
(21:34:48) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:34:50) dazo: there's a forum thread which discovered this issue ... not=
 sure if there's a thread there
(21:35:01) mattock: "Change the default --tmp-dir path to a more suitable p=
ath"
(21:35:18) dazo: there seems to be some confusing consensus on the ML right=
 now
(21:35:27) cron2: for the --tmp-dir patch I'd go with dazo + Alon
(21:35:43) cron2: a) change it, b) leave configure alone, c) use %SystemRoo=
t% on Windows and $TMPDIR on Leenux
(21:35:47) mattock: I think the fallback to c:\<something> can be omitted
(21:35:56) dazo: the reason this patch written was that openvpn started com=
plaining with --plugin auth-pam.so
(21:36:10) dazo: due to that it could not write any tmp files in CWD
(21:36:20) dazo: now, it seems Peter Stuge and Alon don
(21:36:22) cron2: dazo: I already agreed with you, no need to defend the pa=
tch :-)
(21:36:42) dazo: don't want to see a hard coded tmp-dir ... even when $TMPD=
IR is not found=20
(21:36:46) cron2: as far as I read Peter and Alon, they agree with the idea=
, but disagree with having a configure option
(21:37:03) cron2: and I'd side with them
(21:37:08) krzee: in windows we could always just toss in a program files/o=
penvpn/tmp
(21:37:13) dazo: okay, so they say /tmp hard coded and otherwise $TMPDIR or=
 --tmp-dir?
(21:37:20) cron2: dazo: for unix, yes
(21:37:32) dazo: okay, then I'll throw out the configure stuff
(21:37:33) cron2: unix always has /tmp
(21:37:38) dazo: agreed
(21:37:46) krzee: and windows can always have program files/openvpn/tmp
(21:38:07) cron2: windows always has %SystemRoot%\Temp (or whatever it was)
(21:38:08) krzee: if we say so ;)
(21:38:15) dazo: krzee: windows is no problem ... there are %TEMP%, %TMP%, =
%SysRoot%\Temp and C:\Windows\Temp
(21:38:25) krzee: oh ok, then whats the issue?
(21:38:36) mattock: krzee: actually, TEMP can be C:\Users\<username>\someth=
ing if the process is unprivileged
(21:38:39) cron2: basically, whether or not to have a configure option
(21:38:50) mattock: (on Vista and above)
(21:38:53) mattock: and even on XP
(21:39:22) krzee: cron2, why would we *not* have a configure option?
(21:39:32) dazo: krzee: compile time configure option
(21:39:38) krzee: right
(21:39:43) krzee: as in ./configure
(21:39:43) cron2: krzee: if it has no real benefits, it's just bloat
(21:39:47) dazo: as a hard coded default, which is changable
(21:40:21) krzee: cron2, i see that point...
(21:40:45) krzee: i mean even if you want your tmp somewhere special (ramdi=
sk?) you symlink it to be /tmp still
(21:41:03) cron2: krzee: you call "openvpn --tmpdir" or set $TMPDIR if you =
want that
(21:41:18) cron2: compile-time options are something a "normal user wants /=
tmp on ramdisk" user can't change anyway
(21:41:54) krzee: we already have --tmpdir and $TMPDIR and are talking abou=
t making it compile-time ALSO ?
(21:42:18) cron2: we do not have "fall back to /tmp or $TMPDIR" yet - this =
is new "part 1"
(21:42:21) dazo: we've always had --tmp-dir ... but not the other options, =
default before was $cwd
(21:42:28) cron2: and compile-time is "change the value of '/tmp'"
(21:43:12) krzee: seems to me that if we have --tmpdir already, then theres=
 no need for a compile-time option, just a need for a useful error when the=
 user NEEDS to set --tmpdir
(21:43:50) dazo: anyway, I will need to have some of the autoconf stuff the=
re ... to support mingw cross compilations ... which needs to set DEFAULT_T=
MPDIR to %SysRoot%\Temp
(21:44:08) dazo: or maybe not?
(21:44:10) ***dazo thinks
(21:44:13) cron2: why not just do #ifdef windows?
(21:44:40) cron2: (well, WIN32, but that is set for mingw as well)
(21:44:44) dazo: which it already is ... and I think I need to expand %SysR=
oot% via getenv() and concat '\Temp' to the result
(21:44:58) cron2: yep
(21:45:08) dazo: which means I can kick out DEFAULT_TMPDIR all in all
(21:46:05) cron2: now that was easy :)
(21:46:18) mattock: cron2, dazo: all clear? :P
(21:46:26) dazo: yes :)
(21:46:28) cron2: mattock: yes
(21:46:30) mattock: excellent!
(21:46:51) dazo: I'll get the patches out today ... cron2 any chance you ca=
n ack them by tomorrow or so?
(21:47:07) mattock: dazo: what about the man-page?
(21:47:20) cron2: dazo: chances are good
(21:48:01) dazo: yeah, we have quite some undocumented features ... I'm fin=
e at shipping 2.2 without any man page changes ... if people complain, we c=
an point people at the wiki=20
(21:48:10) dazo: and mail thread where we ask for help
(21:48:33) cron2: no response from users yet?
(21:48:38) dazo: sure cheeky, but we need to get more people involved some =
way or another
(21:48:42) dazo: no response yet
(21:49:00) dazo: as janjust said, most people on the ML are consumers
(21:49:12) dazo: there's quite some truth in that
(21:49:55) mattock: dazo: where were the undocumented features listed?
(21:50:09) dazo: https://community.openvpn.net/openvpn/wiki/ManPageUpdatesF=
or2.2
(21:50:10) vpnHelper: Title: ManPageUpdatesFor2.2 =EF=BF=BD=EF=BF=BD=EF=BF=
=BD OpenVPN Community (at community.openvpn.net)
(21:50:41) mattock: dazo: I don't mind fixing those which are documented _s=
omewhere_
(21:50:46) mattock: e.g. openvpn --help
(21:51:48) mattock: jamesyonan: what are --push-continuation and --rdns-int=
ernal used for?
(21:51:57) dazo: that would be great, and that's a starting point, at least=
 for others to be able to improve the docs ... however, my hope is fading t=
hat people will do that ... but something is still better than nothing
(21:52:45) mattock: I think those options are not used much, because they'r=
e not documented
(21:52:50) mattock: so, nobody knows what they do
(21:53:00) cron2: oh, push-contination is something internal
(21:53:09) cron2: I seem to remember
(21:53:17) mattock: jamesyonan: could you help us document those undocument=
ed feature?
(21:53:18) mattock: s
(21:53:24) mattock: maybe not now, but at some meeting?
(21:53:32) cron2: this is used if the "push" packet for optinos to client i=
s too big, and needs to be split into multiple messages
(21:53:35) cron2: let me check
(21:53:53) dazo: I think that sounds correct
(21:54:03) dazo: sounds very familiar
(21:54:11) cron2: push.c
(21:54:30) dazo: I generated that list of options based on a grep/awk on op=
tions.c
(21:54:34) cron2: push-continuation is not something that can be on the com=
mand line
(21:54:39) cron2:   else if (streq (p[0], "push-continuation") && p[1])
(21:54:39) cron2:     {
(21:54:39) cron2:       VERIFY_PERMISSION (OPT_P_PULL_MODE);
(21:54:56) cron2: the VERIFY* bit accepts this only when in the pulled opti=
ons
(21:55:11) dazo: ahh! so that's how that works
(21:55:41) krzee: ohh so its part of the "more soup for you" patch
(21:55:51) krzee: not to be confused with the "NO soup for you" patch
(21:55:55) mattock: https://community.openvpn.net/openvpn/ticket/112
(21:55:56) vpnHelper: Title: #112 (Undocumented option: --push-continuation=
) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:56:00) dazo: heh ... not exactly, but almost :)
(21:56:09) cron2: yeah, same corner of the kitchen :-)
(21:56:19) mattock: wiki updated, too
(21:56:27) cron2: but it was already there in 2.1, not our doing
(21:56:41) dazo: right :)
(21:57:12) cron2: rdns-internal is... special
(21:57:21) krzee: hah
(21:57:23) cron2: this seems to be a one-shot command to "do things and the=
n exit"
(21:57:57) vpnHelper: RSS Update - tickets: #112: Undocumented option: --pu=
sh-continuation <https://community.openvpn.net/openvpn/ticket/112>
(21:58:31) cron2: if that option is encountered *and* register-dns is set, =
it will call ipconfig_register_dns (NULL); and then exit(0)
(21:58:33) mattock: cron2: shall I remove ticket 112, then? :)
(21:58:41) cron2: mattock: yes
(21:59:19) dazo: --rdns-internal seems to be a feature which should only be=
 called/forked out when --register-dns is in use
(21:59:27) dazo: but I have no idea why it needs to do this fork
(21:59:34) cron2: this is for windows - it will cal netsh stop dnscache, ne=
tsh start dnscache, ipconfig /flushdns, ipconfig /registerdns
(21:59:48) cron2: maybe because these commands take a while and openvpn doe=
sn't wants to block
(22:00:18) cron2: fork_register_dns_action() in tun.c
(22:01:27) dazo: which calls fork_to_self() in win32.c
(22:01:57) dazo: and here stops my understanding ... don't know anything ab=
out the CreateProcess() calls
(22:02:10) cron2: I think this is just "fork()/exec()" stuff in windowlese
(22:02:43) dazo: yeah, but I can't tell if this is blocking or non-blocking=
, I just presume it is non-blocking as that would make most sense
(22:03:11) mattock: http://msdn.microsoft.com/en-us/library/ms682425%28v=3D=
vs.85%29.aspx
(22:03:13) vpnHelper: Title: CreateProcess Function (Windows) (at msdn.micr=
osoft.com)
(22:03:26) ***cron2 assumes that the unix-style "fork(), call required func=
tions, exit" stuff will not work on windows, and so the extra option is nee=
ded
(22:03:42) dazo: mattock: you really want to pull us down into the windows =
dirt!?!? ;-)
(22:04:05) mattock: we can wonder... or we can read MSDN :P
(22:04:16) ***cron2 opts for making a notice somewhere that "this is for in=
ternal use together with register-dns on windows" and close this ticket
(22:04:45) dazo: it could be documented as a code comment
(22:04:57) cron2: or specifically "if --register-dns is set, openvpn needs =
to call itself in a sub-process to execute the required functions in a non-=
blocking way, and uses --rdns-internal to signal that"
(22:05:10) cron2: jamesyonan: is that accurate enough?
(22:05:19) krzee: cron2, if accurate, +1
(22:05:38) mattock: sounds good
(22:06:08) mattock: I suggest going through the remaining options with Jame=
s at some point
(22:06:13) mattock: some other meeting
(22:06:26) dazo: agreed
(22:06:34) cron2: ok
(22:06:39) mattock: ok, release date then?
(22:06:51) mattock: or rather, our _goal_ for a release date :P
(22:07:08) mattock: 22nd? 29th?
(22:07:20) cron2: get /tmp acked + in, release RC3 next wednesday, and aim =
for 22nd, yes
(22:07:27) jamesyonan: mattock: --push-continuation and --rdns-internal are=
 normally used internally
(22:07:52) jamesyonan: push-continuation is used when the push list is very=
 large and needs to be fragmented across multiple messages
(22:08:31) cron2: too much soup
(22:08:57) dazo: heh
(22:09:07) jamesyonan: rdns-internal is used internally on Windows for call=
ing some DNS methods
(22:09:32) dazo: and that is done non-blocking?  hence the fork() approach?
(22:09:44) mattock: jamesyonan: is cron2's suggestion accurate: "if --regis=
ter-dns is set, openvpn needs to call itself in a sub-process to execute th=
e required functions in a non-blocking way, and uses --rdns-internal to sig=
nal that"
(22:10:43) jamesyonan: yes, exactly
(22:10:57) mattock: great!
(22:11:25) mattock: cron2: care to add the description somewhere?
(22:11:44) cron2: uh, ok, *mail to self*, will send patch ASAP
(22:11:52) mattock: nice!
(22:12:37) dazo: thx!
(22:12:37) mattock: cron2: any particular reason for 2.2-RC3? why not 2.2 f=
inal?=20
(22:12:47) cron2: code changes
(22:13:13) mattock: dazo, jamesyonan: what's your take on this?
(22:14:12) dazo: I say doc changes don't need another RC ... and if we smok=
etest the next round of --tmp-dir patches, we can go live ... but it would =
be good to have a smaller scale test version which someone could commit to =
try out a little bit
(22:14:44) mattock: dazo: generating a new installer with latest --tmp-dir =
stuff is no prob
(22:14:59) dazo: I might be able to convince one of my users on a site to t=
ry this, in client mode
(22:15:13) cron2: ok, in that case, we could go for release - the change is=
 quite isolated
(22:15:22) mattock: given that it takes at least 2-3 weeks to push out a re=
lease I'd vote for "limited smoketesting -> 2.2 final"
(22:15:27) dazo: yes, and it only affects startup
(22:15:48) mattock: any thoughts on release date of the first 2.3 alpha?
(22:15:52) dazo: if it passes startup with sensible options->tmp_dir, there=
 are no chance for things to wrong
(22:15:56) mattock: right after 2.2 final?
(22:16:47) dazo: I'd say 2.3 beta can go already in in June some time .... =
alpha, can probably be released as soon as I've reworked JJO's IPv6 patches=
, and cron2 has rebased his tree
(22:17:24) mattock: ok, gives us some time to breathe
(22:17:59) ***cron2 feels pushed (but that's good)
(22:18:05) dazo: :)
(22:18:45) dazo: allmerged is updated with latest stuff from master ... stu=
ff from master seems to work out pretty nicely as well (even though haven't=
 checked buildbot since last allmerged push)
(22:19:17) mattock: what about this schedule:
(22:19:17) mattock: - next version of --tmp-dir installer ready on next Mon=
day/Tuesday
(22:19:17) mattock: - all queued 2.2 patches ready by 14th (Thursday)
(22:19:17) mattock: - a preview 2.2 installer available 15th (Friday)
(22:19:17) mattock: - release a.s.a.p. after that
(22:20:59) dazo: Sounds good to me ... however, I'd suggest to move the dat=
es one day earlier .... I can ACK the doc patches which comes ... and we ca=
n have a go/no-go on Friday for the installer, with the 2.2 preview release=
 already on Friday
(22:21:57) mattock: you mean 2.2 release? or 2.2 preview "release"?
(22:22:31) dazo: the latter :)
(22:22:49) mattock: ok
(22:23:05) dazo: and if that preview release looks good ... that's what we =
release the 22nd, just renamed
(22:23:17) dazo: or 21st, for that matter
(22:23:23) mattock: ok, sounds good
(22:23:43) mattock: I guess the TAP_RELDATE fix will force us to resign the=
 TAP-drivers
(22:23:43) jamesyonan: is the 2.2 branch up to date with recent patches to =
2.1 branch?
(22:24:32) ***krzee gets james' autograph on his drivers
(22:24:36) dazo: jamesyonan: not all changes ... I have not checked since y=
ou renamed your SVN branch
(22:24:54) jamesyonan: in particular, r7125 and r7127 fix longstanding bugs
(22:24:57) dazo: we did a feature freeze when we started the RC phase
(22:25:04) ***dazo looks then up
(22:28:54) dazo: jamesyonan: how do I show only the change r7125 and r7127 =
does?  I don't have my git svn tree available on this box, and it takes a w=
hile to parse that
(22:29:10) mattock: hmm, it seems my openvpn.net documentation updates are =
not online yet
(22:29:10) cron2: dazo: svn diff -r7124:7125
(22:29:25) dazo: cron2: thx!
(22:30:06) mattock: the correct URL is this: http://svn.openvpn.net/project=
s/openvpn/branches/2.1/openvpn/
(22:30:07) vpnHelper: Title: Revision 7146: /branches/2.1/openvpn (at svn.o=
penvpn.net)
(22:30:23) dazo: yeah, I have that URL
(22:31:47) jamesyonan: svn diff -r7124:7125 http://svn.openvpn.net/projects=
/openvpn/branches/2.1
(22:31:47) vpnHelper: Title: Revision 7146: /branches/2.1 (at svn.openvpn.n=
et)
(22:33:43) dazo: ouch ... that merge is not going to be pleasant
(22:34:58) dazo: jamesyonan: I'll try to port these commits to the beta2.2 =
branch ... can you validate my commits afterwards to see that I haven't des=
troyed the patch?
(22:35:08) ***cron2 has no idea what 7125 does
(22:35:58) dazo: cron2: svn log -r7125?
(22:36:12) jamesyonan: svn log -v -r7125 http://svn.openvpn.net/projects/op=
envpn/branches/2.1
(22:36:13) vpnHelper: Title: Revision 7146: /branches/2.1 (at svn.openvpn.n=
et)
(22:36:23) cron2: dazo: well, I was looking at the code change, not the docs
(22:36:29) dazo: :)
(22:38:36) mattock: dazo: do these need wider testing (=3D2.2-RC3), or will=
 a preview version be sufficient?=20
(22:39:37) dazo: I'm not sure I dare to patch r7125 ... it seems we need to=
 backport much more commits from SVN, packet_id_init() has grown it's funct=
ion arguments from 3 to 6 arguments
(22:39:49) dazo: looking at r7127 now
(22:40:19) dazo: r7125 is something which needs to go into the 2.3 release,=
 due to that the SVN tree has diverged too much from the beta2.2  base
(22:40:46) mattock: yep
(22:40:55) mattock: agreed
(22:41:00) dazo: r7127 looks trivial though
(22:41:16) cron2: dazo: there's so much difference in SSL packet handling i=
n 2.1->2.2?
(22:41:37) mattock: jamesyonan: when do you think OpenVPN Tech could move t=
o 2.2 internally?
(22:41:57) jamesyonan: I'm hoping in the next few months
(22:42:11) dazo: not 2.1->2.2 ... but as james have not rebased against the=
 git tree at all, so he is actually far behind us right now
(22:42:25) dazo: quite some 100 commits, probably
(22:43:01) cron2: yeah, but if those don't really affect these places, it m=
ight still be safe
(22:43:01) mattock: so lots of work will be needed
(22:44:07) mattock: oh, Jason Haar sent me email, proposing a meeting topic
(22:44:08) dazo: http://www.fpaste.org/1MOO/  ... this is the complete merg=
e conflict
(22:44:42) dazo: and based on the packet_id.[ch].rej stuff ... it tells me =
we need more patches which follows updates this code
(22:45:20) dazo: as the version before r7125 have 5 arguments for packet_id=
_init() ... while beta2.2 have 3 arguments
(22:45:23) mattock: http://pastebin.com/uz7R9iVC
(22:45:46) cron2: oh
(22:46:42) mattock: any comments on --push-peer-info?
(22:47:01) jamesyonan: the bug that is fixed by 7125 is that if you are usi=
ng adaptive mode (where the client tries UDP and then falls back to TCP) th=
e replay detection code is basically broken
(22:47:20) jamesyonan: so 7125 is only needed if you use adaptive mode
(22:47:27) cron2: mattock: mmmh?
(22:47:52) mattock: cron2: ^^^ uz7R9iVC
(22:48:53) cron2: ah
(22:49:00) dazo: then I feel the r7125 can wait for 2.3, as we start the al=
pha/beta pretty soon after the 2.2 release ... I'm sorry I don't dare to pu=
sh too much new code into the 2.2-RC2 ... and this seems to be an issue not=
 too many users hit into
(22:49:46) dazo: jamesyonan: do you agree to that?  ^^
(22:50:01) mattock: regarding http://pastebin.com/uz7R9iVC ... I think the =
"openvpnserv.exe should exit when no openvpn.exe process are around" should=
 go into 2.3
(22:50:20) dazo: (after all, 2.2-RC2 seems to be pretty stable at the momen=
t)
(22:50:31) dazo: mattock: agreed
(22:50:34) mattock: dazo: +1
(22:50:45) mattock: I don't think we should poke 2.2 too much at this point
(22:50:59) mattock: minimal, "safe" changes only
(22:51:08) mattock: and aim for releasing 2.3 soon
(22:51:34) mattock: by August or so?
(22:51:45) jamesyonan: dazo: yes, I'm fine with that
(22:51:53) dazo: goodie!
(22:52:28) mattock: can anybody comment on Jason's "How about getting "--pu=
sh-peer-info" finished off" comment?
(22:52:34) dazo: mattock: I think we can have late September as a realistic=
 goal for a final 2.3 release ... unless the IPv6 code is too much broken :=
-P
(22:52:43) cron2: heh
(22:52:46) ***cron2 has heard that
(22:52:52) dazo: ;-)
(22:53:09) mattock: well, the good thing is IPv4 addresses have then been l=
ong gone... so we might get somebody to test the code
(22:53:33) jamesyonan: dazo: what is the point in 2.1 branch where you stop=
ped merging changes into 2.2?
(22:53:43) dazo: btw ... I'm running your openwrt release of openvpn on ope=
nwrt with IPv6 enabled ... and I route my IPv6 traffic through my router wh=
erever I am without any issues :)
(22:53:58) dazo: that's around Christmas ... I'll check the git log
(22:54:36) dazo: jamesyonan: r6712 is the last SVN commit I merged into bet=
a2.2
(22:54:37) cron2: cool :)
(22:55:44) dazo: (version 2.1.3d)
(22:56:46) dazo: cron2: now if OpenVPN would support a IPv6 only config ins=
ide the tunnel ... I could really test that feature well out, as my whole h=
ome network is fully IPv6 enabled=20
(22:57:23) cron2: dazo: it sort of does
(22:57:23) dazo: (avoid "leaking" IPv4 traffic through the tunnel)
(22:57:45) cron2: dazo: config "--route-nopull" and "--route-ipv6 2000::/3"=
 on the client side
(22:57:59) mattock: dazo, cron2: any ideas how much money I would have to s=
pend to get a IPv6-enabled 4-port switch?
(22:58:02) cron2: that way it will not add any IPv4 routes, and manually ad=
d an IPv6 default route
(22:58:03) dazo: duh!  I'll add that :)
(22:58:11) mattock: the really cheap and crappy ones don't support IPv6, do=
 they?
(22:58:20) cron2: mattock: a *switch* should not care
(22:58:36) dazo: unless it's a managed switch probably?
(22:58:40) cron2: so a $10 5-port 10/100 switch will do IPv4 or IPv6 or IPX=
 or Appletalk or Decnet just fine
(22:58:54) mattock: cron2: ok, I'll check that
(22:59:03) mattock: I got to IPv6-enable my home network, like dazo
(22:59:11) dazo: mattock: or did you mean router?
(22:59:25) cron2: the $200 class is trickier - they tend to have "managemen=
t capabilities" (which usually are IPv4-only), and sometimes they have "mul=
ticast optimizations!" which completely FAIL on anything that's not IPv4
(22:59:29) ***krzee is leaving early later fellas
(22:59:56) dazo: mattock: setting up Hurricane Electric IPv6 tunnel on a Op=
enWRT based router, with radvd for stateless autoconfig is quite easy actua=
lly
(23:00:09) mattock: well, it's a stupid little box I bought for 12=EF=BF=BD=
=EF=BF=BD=EF=BF=BD :)
(23:00:21) cron2: a router-with-switch and IPv6 support is somewhat hard to=
 get - there's a few models from D-Link and AVM, or (as dazo says)
(23:00:37) mattock: I'll check what my box can do
(23:00:49) cron2: mattock: in that case, it's propably a pure l2-switch tha=
t has no idea what is inside the ethernet packets - and thus should happily=
 do v6
(23:01:01) cron2: mmmh
(23:01:03) mattock: yeah, probably
(23:01:07) mattock: I hope so
(23:01:32) cron2: $wife declared "it's 22:01, $daughter will be up at 6:som=
ething, time to go to bed now"
(23:01:36) cron2: good night folks
(23:01:38) mattock: cron2: +1
(23:01:45) dazo: cron2: good night!
(23:01:49) mattock: I think we're done
(23:01:57) dazo: I think so too
(23:02:16) dazo: mattock: the --push-peer-info stuff, that's v2.3 stuff any=
way ... so lets wrap it here
(23:02:22) mattock: dazo: fine with me
(23:02:35) mattock: I'll write the summary tomorrow
(23:02:41) dazo: thx a lot!
(23:02:43) mattock: and start churning out patches :)
(23:02:52) mattock: thanks everyone!
(23:02:54) ***dazo goes to write some patches :)
(23:03:05) mattock: talk to you guys later!

--------------050701010100030100030402--

