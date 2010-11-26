Message-ID: <4CEF8D73.4050202@...515...>
Date: Fri, 26 Nov 2010 12:35:31 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090801090104080801040806"
Subject: [Openvpn-devel] Summary of the IRC meeting (25th Nov 2010)
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
--------------090801090104080801040806
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 25th Nov 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-11-25>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Busch, dazo, d457k, mattock and krzee were present in this meeting.

--

Discussed the "WinXP: route setup broken after standby" issue:

<https://community.openvpn.net/openvpn/ticket/56>

Reached the conclusion that in most cases this can be fixed with simple
configuration parameters - see ticket comments for details. Decided to
close the bug report if people report that the suggested configuration
changes help.

--

Discussed the "Windows route add command failed" issue:

<https://community.openvpn.net/openvpn/ticket/68>

This lead into more high-level discussion about whether failing to add
route(s) should be treated as a fatal OpenVPN error. Agreed that this is
the case if OpenVPN fails to add non-existing routes, but not if OpenVPN
fails when adding routes that already exist (e.g. local routes). Also
agreed that OpenVPN should print a meaningful error message to logs
(e.g. "Admin rights needed") if user lacks privileges to add routes.
This message should also be pushed to the Windows GUI using the
management API "echo" command.

One alternative would be to parse the (undocumented) return values of
the OS-specific route command and do something fancy with them; however,
this is probably one big can of worms. One long-term solution for 2.3 or
later would be to use NETLINK APIs or similar to add routes in route.c.

--

Discussed the "No magic limitation on socket size" issue:

<https://community.openvpn.net/openvpn/ticket/35>

This is probably related with OpenVPN's reportedly poor performance on
fast links. Decided to wait for James' comments on why a magic
limitation has been implemented for socket size.

--

Discussed the "Floating TLS" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4106>

Decided to ask james and mailing list if anyone can see any serious
(security) issues with this patch.

--

Discussed the "MacOSX Keychain Certificate support"

<https://community.openvpn.net/openvpn/ticket/8>

Mattock had asked people in "tunnelblick-discuss" group to test this
patch, but so far nobody has sent any test results. Krzee volunteered to
test the patch when he has time.

--

Mattock gave an update of the status of the new Python build system:

- building openvpn.exe and and the TAP driver works
- building openvpn service (openvpnserv.exe) does not work yet
- NSI installer generation is not yet implemented

Mattock has been migrating the NSI stuff to the new build system, fixing
various issues with it and adding openvpnserv.exe stuff to
win/msvc.in.mak. A realistic deadline for fully functional Python build
system is "by the end of this year".

--

Discussed a build failure in the Python-based build system:

"socks.obj : error LNK2019: unresolved external symbol _snprintf
referenced in function _socks_username_password_auth"

Traced this down to usage of snprintf instead of openvpn_snprintf in the
new in new SOCKS auth code introduced in 2.2-beta4. Mattock created and
sent a patch to the -devel mailinglist.

A side-effect of this patch is that we need to move on from 2.2-beta4 to
2.2-beta5, as beta4 has been tagged already.

--

Discussed a build failure in the Python-based build system caused by
missing "configure.h" file. Agreed that it's best if the new build
system generates this file similarly to what GNU tools do. The
variables in this file (CONFIGURE_CALL and CONFIGURE_DEFINES) could then
be filled with data that makes sense in the Python build system context.
Mattock will provide a patch to fix this issue.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------090801090104080801040806
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-11-25.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-11-25.txt"

(20:00:05) cron2: oh, meeting
(20:00:08) ***cron2 happens to be here
(20:00:44) d457k: if Busch doesn't rejoin in the next 15 minutes you have t=
o handle his issue as I'll be on my way home
(20:01:30) dazo_afk =EF=BF=BD=EF=BF=BD ora conosciuto come dazo
(20:02:00) Busch [~Busch@...1433...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:02:16) d457k: Busch: welcome back
(20:02:31) mattock: let's start with https://community.openvpn.net/openvpn/=
ticket/56
(20:02:35) vpnHelper: Title: #56 (WinXP: route setup broken after standby) =
=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(20:02:51) d457k: can we pull the suspend issue up dront
(20:02:53) mattock: cron2: good thing you made it!
(20:03:05) mattock: d457k: yep, as I suggested above ;)
(20:03:12) krzee: oh cool the meeting starts earlier now
(20:03:27) dazo: krzee:  wintertime ;-)
(20:03:30) mattock: yeah, winter time... always bites you
(20:03:40) mattock: busch: did you get the logs?
(20:03:45) d457k: mattock: oh my, attention span of a brick today... sry
(20:04:02) mattock: no prob
(20:05:12) Busch: mattock: Here`s the Log anfter standby with verb 5: http:=
//dpaste.org/Rbzk/=20=20
(20:05:20) Busch: -anfter +after
(20:05:58) krzee: The reconnection fails
(20:05:58) krzee: because the route to the server is _not_ restored
(20:05:58) krzee: after standby.
(20:06:06) krzee: the route to server should never be removed
(20:06:08) mattock: d457k: does that look the problem you fixed in your GUI?
(20:06:29) krzee: when redirect-gateway is used, a direct route to the vpn =
server is made, otherwise the vpn would fail after connecting
(20:06:59) Busch: Sometimes it fails, sometimes it works after a couple "Ro=
ute: Waiting for TUN/TAP interface to come up..."
(20:07:19) krzee: ahh, try adding route-delay to your config
(20:07:20) d457k: mattock: no the gui restarts ovpn correctly
(20:07:26) mattock: ok
(20:07:32) krzee: thats a somewhat normal issue with windows
(20:07:56) krzee: it happens when booting if you start ovpn as a service, s=
ince you dont you only get it when waking
(20:08:03) krzee: not a -devel issue
(20:08:13) krzee: (assuming it fixes it for you)
(20:08:44) krzee: Busch, can you test that?
(20:09:02) Busch: Im not using the service
(20:09:07) krzee: i know
(20:09:30) krzee: you are waking and triggering something that often happen=
s to people who start on boot
(20:09:44) krzee: just put route-delay in the config and test it please =3D]
(20:09:47) Busch: ok
(20:10:12) Busch: How many seconds? 5 ?
(20:10:13) mattock: if that fixes the issues then I'll update the bug repor=
t with krzee's information
(20:10:31) mattock: as a workaround
(20:11:14) d457k: krzee: so are the route not there even the log says so or=
 what's the issue here?
(20:11:57) dazo: mattock:  d457k: correct me if I'm wrong ... but isn't Bus=
ch issue different from that ticket?
(20:12:15) d457k: dazo: i fell like agreeing
(20:12:23) krzee: dazo, according to the ticket... but the ticket includes =
false info
(20:12:28) Busch_ [~Busch@...1433...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:12:42) krzee: dazo, it says this:
(20:12:43) krzee: The reconnection fails
(20:12:43) krzee: because the route to the server is _not_ restored
(20:12:43) krzee: after standby.
(20:12:48) krzee: which is plain ol false
(20:13:05) krzee: there is no route to the server needing to be "restored"
(20:13:32) krzee: if the routes get dropped, there is nothing to override, =
if they dont there is already a route direct to server
(20:13:44) dazo: mm
(20:13:54) krzee: and theres no way its dropping only *some* routes
(20:14:07) krzee: Busch, howd that work for ya?
(20:14:19) dazo: agreed
(20:14:27) dazo: it's all or nothing
(20:14:45) d457k: the routes (to the remote networks i suppose) are removed=
, because the gui stops ovpn alltogether and reestablishes the tunnel when =
the sys comes back up
(20:15:34) krzee: d457k, can you replicate the bug? and if so, have you tri=
ed the setting i recommended?  also you could try adding    persist-tun   t=
o your config
(20:16:05) Busch ha abbandonato il canale (quit: Ping timeout: 276 seconds).
(20:16:12) d457k: krzee: persist wouldn't help as the ovpn process is stopp=
ed on suspend
(20:16:30) d457k: krzee: but no, I can't replicate
(20:16:48) Busch [~Busch@...1433...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:17:23) Busch_ ha abbandonato il canale (quit: Ping timeout: 265 seconds=
).
(20:18:19) Busch: I added "route-delay 5" to my config. It seems to work
(20:18:46) d457k: Busch: glad it worked
(20:18:51) mattock: what if I add a comment to the ticket along these lines=
: "This issue may be caused by routes being brought up too soon either by t=
he openvpn service (on boot) or openvpn-gui (on suspend/hibernate). Using r=
oute-delay 5 in your configuration may help - if it does, please mention it=
 so this bug report can be closed."=20
(20:18:59) d457k: all: I'm outta here
(20:19:04) mattock: d457k: bye!
(20:19:10) mattock: thanks for popping in!
(20:19:25) krzee: Busch, 5 will still give problems sometimes
(20:19:34) krzee: remove the 5, default of 30 will be good
(20:19:45) Busch: krzee: ok
(20:19:56) d457k: mattock: no need to
(20:20:03) d457k: bye
(20:20:15) krzee: mattock, i think that is good, but remove 5 from the rout=
e-delay
(20:20:28) mattock: ok
(20:20:44) krzee: tell them if they continue to have this problem with rout=
e-delay, to include a log of it at verb 5 as an attachment
(20:21:01) mattock: do you think we can close this bug report?
(20:21:07) krzee: i do
(20:21:21) krzee: maybe give them a lil time to respond
(20:21:36) krzee: like next week during the meeting we can close it if they=
 havnt responded
(20:21:44) mattock: ok, I'll update the ticket and we'll close it later... =
next week sounds good
(20:24:08) mattock: https://community.openvpn.net/openvpn/ticket/56
(20:24:10) vpnHelper: Title: #56 (WinXP: route setup broken after standby) =
=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(20:24:12) mattock: shall we move on?
(20:24:27) dazo: +1
(20:24:39) mattock: bugs or patch queue?
(20:24:43) dazo: bugs
(20:24:45) dazo: :)
(20:24:50) cron2: there are no bugs
(20:24:51) cron2: next
(20:25:00) dazo: lol
(20:25:01) mattock: there is one possible bug: https://community.openvpn.ne=
t/openvpn/ticket/68
(20:25:03) vpnHelper: Title: #68 (Windows route add command failed) =EF=BF=
=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(20:25:09) mattock: but as we have no bugs, ... next
(20:25:12) mattock: :)
(20:25:28) Busch: mattock: Now it fails: http://dpaste.org/8AOJ/
(20:25:31) dazo: cron2:  almost .... it might be we possibly have one bug .=
... unless we #define it as NOTABUG
(20:26:29) mattock: busch: with route-delay 30?
(20:26:41) Busch: mattock: yes
(20:27:06) Busch: mattock: here is the clients config: http://dpaste.org/04=
K9/
(20:27:49) krzee: mattock, can that be considered a bug?  he didnt set a pa=
ram that seems to be needed for windows
(20:27:59) cron2: well, this is a more general question - I think that "add=
 route failed" should be fatal
(20:28:01) krzee: when he compiled his own exe
(20:28:05) cron2: not just windows
(20:28:16) krzee: that i +1
(20:28:41) mattock: busch: can you do more extensive tests with the route-d=
elay 30 to see if it helped at all?
(20:28:41) cron2: i've run into this a while ago as well - the user had not=
 enough permissions, so adding routes failed, but openvpn seemed to succeed=
 - so I spend quite a while searching the bug in the server config
(20:28:58) krzee: mattock, dont need "30" it is default
(20:29:02) mattock: ok
(20:30:05) krzee: interesting
(20:30:22) krzee: Busch, can you include netstat -rn from each scenario ple=
ase
(20:30:35) krzee: also, are you using def1 flag in your redirect-gateway?
(20:30:38) krzee: if not, that explains it
(20:31:09) dazo: I tend to lean against that failing to add routes is a fat=
al failure .... it's definitely a failure for the user experience, but tech=
nically it's not a OpenVPN failure
(20:31:31) cron2: it is.  it's not doing what it's supposed to do
(20:31:46) krzee: dazo, if it cant add routes in a routed setup, what good =
is the vpn being up?
(20:31:47) mattock: is there any scenario where failing routes would be ok?
(20:31:52) cron2: why would "failure to add a route" be less or more fatal =
than "failure to do ifconfig"?
(20:32:24) mattock: if failing routes always cause openvpn to fail, then I =
think it's certainly an openvpn issue
(20:32:31) dazo: krzee:  that's the user experience you are describing ther=
e ;-)
(20:32:51) cron2: ok, I can see a potential issue - the server might push s=
omething that conflicts with already-installed local routes, so the thinkin=
g might be "fail softly, and live with the *rest* of the routes, at least"
(20:33:06) krzee: dazo, a vpn that cant be used for *anything* should not b=
e considered fatal?
(20:33:18) cron2: dazo: but with the gui, it's "silently not working" FAIL,=
 and that's something I consider completely inacceptable in any software
(20:33:25) cron2: either work, or complain, or at least warn
(20:33:34) krzee: ild think if the route to the server itself (ie: 10.8.0.1=
) fails, it is fatal
(20:33:34) dazo: krzee:  again, that is the user experience ... the tunnel =
will work ... but you will only be able to access the VPN end-point
(20:33:49) Busch: krzee: The server does: push "redirect-gateway def1"
(20:33:49) krzee: dazo, no vpn endpoint access if the route to it fails
(20:34:10) krzee: Busch, interesting... pls include the netstat -rn in all =
scenarios then
(20:34:12) cron2: kzree: that's ifconfig, so the vpn server is usually work=
ing
(20:34:30) dazo: krzee:  but on most OSes, that route comes automatically (=
at least in subnet topology) when doing ifconfig
(20:34:40) cron2: what I said :)
(20:34:55) dazo: yeah :)
(20:35:06) krzee: ahh ok
(20:35:17) cron2: dazo: well, except for all the other OSes that do not do =
so, like "Solaris"... *roll eyes*
(20:35:33) cron2: but that's a different can of worms
(20:35:40) mattock: ok, so what's the conclusion?
(20:36:09) krzee: maybe at least like a warning that you need to be root /a=
dmin or something of that sort ...?
(20:36:09) mattock: is there something we need to fix?
(20:36:11) cron2: "cron2 and dazo disagree"
(20:36:25) dazo: it's a failure *if* it failes to add non-existing routes .=
... if it fails when adding routes which already exists, it is not a failure
(20:36:41) krzee: dazo, +1
(20:36:43) mattock: makes sense
(20:36:50) cron2: yep
(20:37:01) krzee: thats likely a different error code from route command
(20:37:13) mattock: I assume openvpn _does_ check if the route exists?
(20:37:24) mattock: before trying to add it
(20:37:25) ***cron2 giggles
(20:37:43) dazo: And tbh ... I think this is the can of worms James avoided=
 by not doing a fatal failure if adding route fails
(20:37:45) krzee: mattock, even if not, should be a different error code fr=
om route command ild assume
(20:38:09) dazo: krzee:  I would not take that for granted among all the OS=
es we support
(20:38:15) cron2: BSD "man route" doesn't even mention return values, so it=
's definitely not *documented*
(20:38:21) krzee: tru (thinks of windows)
(20:38:35) cron2: windows has 4 different ways to set the route...
(20:38:36) cron2: (or so)
(20:38:37) mattock: perhaps we should organize a big "Route return value ha=
ckfest?"
(20:38:38) dazo: neither Fedora man pages says anything
(20:38:39) cron2: can of worms
(20:39:01) dazo: I would rather see a different approach for adding routes =
all in all
(20:39:07) cron2: also, the whole "setting of routes on windows for non-adm=
in users" is all broken
(20:39:11) cron2: yep
(20:39:13) krzee: maybe just change the error to mention you need elevated =
privs and call it a day?
(20:39:24) dazo: for Linux and BSD use of the NETLINK API could be better .=
... and I suppose Windows got something similar
(20:39:31) cron2: openvpn service...
(20:39:36) dazo: and adding routes via external binaries is the last fallba=
ck
(20:39:37) cron2: dazo: that's one of the 4 different windows ways
(20:39:54) dazo: cron2:  how is it on Solaris?  Any NETLINK API?
(20:40:31) cron2: dazo: most likely some weird solaris specific stuff.  One=
 could check the "route" source from OpenSolaris
(20:40:41) dazo: good point
(20:40:48) mattock: dazo: any reason to maintain a fallback option (=3Dexte=
rnal route program)?
(20:41:18) mattock: shouldn't NETLINK API (or whatever) be reliable and rel=
atively stable?
(20:41:18) krzee: mattock, definitely in windows... route-method exe fixes =
common issues in some versions of windows
(20:41:20) cron2: but this might indeed be worth a try for 2.3 - rip out mo=
st of route.c and replace by NETLINK stuff
(20:41:24) dazo: mattock:  safety if the API is incompatible?
(20:41:43) cron2: (and tun.c)
(20:41:59) Busch_ [~Busch@...1434...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:42:01) mattock: if there's not too much code to maintain, then I have n=
o complaints...=20
(20:42:26) cron2: it's easier for porting to new platforms, though, just to=
 find the right external calls to do, instead of figuring out how the syste=
m calls work
(20:42:42) dazo: I know the NETLINK API in Linux is design by looking at th=
e BSD implementation ... so I expect them to be similar ... but compatible?=
  I dunno
(20:43:33) cron2: long-term thing anyway
(20:44:23) mattock: so is it enough to print out "Admin privileges needed" =
-style message as krzee suggested? And consider more advanced (and reliable=
?) API stuff later
(20:45:05) dazo: that's a short-term solution, to at least give a hint to c=
heck it ... but should only be printed once
(20:45:14) cron2: it would be useful to be able to push that message to the=
 GUI
(20:45:17) Busch ha abbandonato il canale (quit: Ping timeout: 240 seconds).
(20:45:18) cron2: no idea whether that can be done
(20:45:43) mattock: d457k could shed some light on that
(20:45:53) dazo: there's an "echo" feature in the management API, which the=
 new GUI uses ... and it can also read the logs from the management API
(20:46:15) Busch_: krzee: netstat -rn if, [No VPN connection: http://dpaste=
.org/hjxT/ ], [Successful VPN connection: http://dpaste.org/fCxU/ ], [Faile=
d VPN connection: http://dpaste.org/PTvU/ ]
(20:46:35) Busch_: sorry, its a german routing table :)
(20:46:49) dazo: Busch_:  but german routing tables should be more exact!
(20:46:53) dazo: :-P
(20:47:02) cron2: fully so!
(20:47:42) krzee: you still have your route
(20:47:46) krzee: so that isnt the issue
(20:48:13) mattock: can we move on to the next issue? I can update the tick=
et with a mention we discussed the long-term solution here
(20:48:37) dazo: mattock:  short-term - log entry ... long-term, need to mo=
ve to NETLINK and similar APIs
(20:48:50) krzee: +1
(20:49:07) mattock: +1
(20:49:24) dazo: cron2:  do you have libnl available on BSD?
(20:49:28) krzee: hrm maybe Busch_ in fact does have a bug
(20:50:00) krzee: hey Busch_ try adding route-method exe to your config
(20:50:05) krzee: and retest
(20:50:24) mattock: next topic when you guys are ready: https://community.o=
penvpn.net/openvpn/ticket/35
(20:50:25) vpnHelper: Title: #35 (No magic limitation on socket size) =EF=
=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(20:50:31) krzee: Busch_, pls feel free to reply in msg so we can move on i=
n the meeting
(20:50:43) Busch_: krzee: ok
(20:51:00) cron2: dazo: no.  what functions are in there?
(20:51:10) dazo: cron2:  http://libnl.sourcearchive.com/documentation/1.1-6=
/main.html
(20:51:12) vpnHelper: Title: libnl sourcecode, main.html, 1.1-6 (at libnl.s=
ourcearchive.com)
(20:51:31) cron2: just tell me something that's needed, and I check whether=
 a corresponding man page exists
(20:51:46) dazo: rtnl_route_add()
(20:51:47) krzee: mattock, now thats an interesting topic... i hear a lot o=
f talk of openvpn not performing well (but low cpu usage) on very fast link=
s... that could be part of it
(20:52:26) cron2: dazo: nothing
(20:52:47) ***dazo thought so=20
(20:52:48) cron2: ok, guys, need to leave (sorry).  Wife is hungry.
(20:52:58) krzee: adios cron2=20
(20:53:00) dazo: cron2:  have fun and enjoy :)
(20:53:31) mattock: bye cron2!
(20:54:20) dazo: mattock:  ticket #35 would need james eyes as well, as thi=
s one needs a broader and deeper discussion
(20:54:24) Busch__ [~Busch@...1433...] =EF=BF=BD=EF=BF=BD entrato nel canal=
e.
(20:54:36) mattock: hmm, let's see if James is lurking in Skype
(20:54:41) mattock: he has not read his emails today
(20:55:24) mattock: that man can be hard to reach :)
(20:56:41) mattock: no, not on skype
(20:57:01) dazo: okay, next week then
(20:57:30) mattock: I'll try to reach him via Andrew... what about this the=
n:
(20:57:30) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/4106
(20:57:35) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:57:51) krzee: dazo, do you think #35 could be part of why FAST links ge=
t degraded throughput?
(20:57:54) dazo: the new feature (--tls-float), here I'd like to hear more =
thoughts from more people
(20:58:14) Busch_ ha abbandonato il canale (quit: Ping timeout: 264 seconds=
).
(20:58:18) krzee: or is that a matter of the tuntap device as i have previo=
usly been stating to users
(20:58:20) dazo: krzee:  yes, indeed ... but I know too little about the de=
fault values of socket buffers
(20:58:26) krzee: oh cool
(21:00:37) dazo: krzee:  that kind of states how much data to keep in kerne=
l space before something really needs to be done with the data, IIRC
(21:01:03) dazo: which means, having it too high or too little can impact t=
he performance ... and it may depend on available resources on the box as w=
ell
(21:01:15) krzee: the user reported a 25MB file of what seems to be network=
 swapfile
(21:01:24) dazo: kernel memory is usually more restricted than what user sp=
ace needs
(21:01:41) krzee: which seems a great explanation of why FAST links get suc=
h degraded performance
(21:01:44) dazo: what user space *is*
(21:02:10) Busch [~Busch@...1433...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:03:02) dazo: yeah, if it's emptied too fast ... that can really hurt th=
e performance .... but if it takes too long before something is happening w=
ith the buffer, due to the kernel wanting to fill it up more, then you have=
 the side-effect of having a too big buffer
(21:03:23) krzee: i see
(21:03:33) ***dazo wonders if this should be a tunable parameter and not ha=
rd coded
(21:03:47) krzee: so if possible by you code ninjas maybe it could either b=
e tunable or even adaptive
(21:05:33) dazo: tunable is doable .... adaptive will require a lot more re=
search
(21:05:55) dazo: as that can be very OS dependent
(21:05:56) Busch__ ha abbandonato il canale (quit: Ping timeout: 255 second=
s).
(21:06:00) krzee: tunable would be a giant leap for those guys ild assume
(21:06:24) krzee: hell adaptive could even wait for 3.x
(21:06:29) dazo: yeah :)
(21:06:29) mattock: so this value can't be obtained/derived from anywhere e=
lse?
(21:06:38) mattock: a reasonable default, I mean
(21:06:51) krzee: mattock, a reasonable default is hard-coded currently
(21:06:58) dazo: There's always a default ... but this code obviously came =
with this hard coding into the code for a reason
(21:07:04) krzee: but the reasonable default isnt good for guys with FAST l=
inks
(21:07:17) mattock: in any case I think tunable value would make sense
(21:07:46) krzee: yep, definitely worth the ninjas looking into ;]
(21:08:12) krzee: so is this one basically on hold til james can say why it=
s hardcoded?
(21:08:25) mattock: +1
(21:08:35) dazo: Yeah, at least we shouldn't implement anything before we k=
now more his view of it
(21:09:15) mattock: what about floating tls, then?=20
(21:09:17) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/4106
(21:09:19) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:09:31) mattock: any security implications?
(21:09:43) mattock: sounds really neat
(21:09:59) dazo: mattock:  that one is also one I'd like to see James respo=
nse to ... as I sense there might be some security issues here
(21:10:17) mattock: me too
(21:10:44) dazo: theoretically, it makes it easier to hijack a session ... =
but I didn't catch how big the number replacing the IP address is and how t=
hat number is "generated"
(21:11:39) mattock: also, the patch is pretty big... needs thorough review
(21:11:46) dazo: anyhow ... this patch enables it by default and it's a com=
pile time directive .... I'm not sure I like that
(21:12:05) krzee: i know i would never want that option on one of my machin=
es, makes me uncomfy for the reasons dazo said
(21:14:01) mattock: ok, how about this:
(21:15:11) mattock: - ask james and mailing list if anyone can see any seri=
ous (security) issues with this
(21:15:11) mattock: - if not, ask the author if he/she is willing to mainta=
in this functionality and make it opt-in
(21:15:25) dazo: ACK
(21:16:18) mattock: ok, then the last topic on the list
(21:16:36) mattock: https://community.openvpn.net/openvpn/ticket/8
(21:16:38) vpnHelper: Title: #8 (MacOSX Keychain Certificate support) =EF=
=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:16:55) dazo: ecrist:  ^^^ you around?
(21:17:00) krzee: sorry ive been so distant lately, i should be testing that
(21:17:01) mattock: so, as promised, I asked people on tunnelblick-discuss =
about this
(21:17:29) mattock: checked the responses today... 1 response, the guy said=
 he'd test it, but no test results=20
(21:18:21) mattock: I'm guessing OSX is somewhere between Windows and Linux=
 in difficulty of building openvpn... more on the *NIX side though
(21:18:34) mattock: so lack of testers might not mean lack of users
(21:18:46) mattock: ... of this feature
(21:18:52) krzee: as far as user experience, it is as easy to compile as an=
y OS can be
(21:19:04) krzee: just make install clean and done
(21:19:25) mattock: ok
(21:19:47) mattock: krzee: can you test that feature soon?
(21:20:04) krzee: hopefully
(21:20:21) mattock: dazo: how thorough testing do you want?
(21:20:25) krzee: ive been working my butt off lately... didnt sleep last n=
ight just coded away on my scripts
(21:20:36) mattock: krzee: take your time, no hurry
(21:20:39) dazo: mattock:  that it works and don't rock the stability
(21:20:41) krzee: now im at work still coding on them (and talking here of =
course)
(21:21:04) dazo: both in situations where this feature is used/configured a=
nd where it is not configured (ie - old behaviour)
(21:21:16) mattock: dazo: a little more than a smoke-test
(21:21:19) mattock: ?
(21:21:22) dazo: yeah
(21:21:26) mattock: ok
(21:21:52) mattock: if there's nothing else on this, I suggest a new topic.=
.. "Status of new python build system"
(21:21:56) mattock: mostly monologue from me :)
(21:22:16) krzee: fire away
(21:22:22) dazo: shoot!  I also wonder about 2.2-beta4
(21:22:37) mattock: dazo: me too
(21:22:44) mattock: anyways, python build system
(21:22:50) dazo: hahaha .... the socket buffer size stuff ... *is tunable* =
.... --rcvbuf and --sndbuf
(21:23:03) dazo: default is 64KB
(21:23:14) dazo: (on non-windows)
(21:23:45) ***dazo just tracked it down in the code
(21:24:15) krzee: ohhh lol i recently saw someone mention that (maybe on th=
e forum?) but didnt connect the dots
(21:24:28) krzee: would be interesting to hear if that fixes the issue for =
the user
(21:24:44) mattock: Python buildsystem for Windows in a nutshell: building =
openvpn.exe works, and apparently building (and signing?) the TAP driver
(21:25:08) mattock: however, building the openvpn service (openvpnserv.exe)=
 does not yet, the makefile (msvc.in.mak) is still missing it
(21:25:32) mattock: also, the NSI installer generation is still missing
(21:26:06) mattock: I've been migrating the NSI stuff to the new build syst=
em, fixing various issues with it (more patches coming) and adding openvpns=
erv.exe stuff to msvc.in.mak
(21:26:17) mattock: in any case, it's a bigger task I anticipated
(21:26:27) dazo: mattock:  but doesn't james use this to build his binaries=
?   or is there some stuff he has not shared with us?
(21:26:56) mattock: it's clear James has not used the Python build system a=
ll by itself
(21:27:01) dazo: krzee:  the ticket reporter is an anonymous person for us =
:(
(21:27:14) mattock: he's probably been using it in conjunction with the old=
 one
(21:27:20) dazo: yeah
(21:27:24) dazo: grrr
(21:27:34) dazo: mattock:  how much effort is it to fill the last gaps?
(21:27:59) mattock: hard to tell... I'd estimate 2-5 workdays
(21:28:11) dazo: I'd like to see us independent of james, especially when w=
e're starting on the 2.3 cycle
(21:28:28) dazo: okay, it's not *that* bad ... it's not easy,  but hard eno=
ugh
(21:28:49) mattock: yep, we could then do more frequent, unofficial "snapsh=
ot" releases on Windows, too
(21:28:57) dazo: exactly
(21:29:31) mattock: the only issue is the TAP driver which needs to be sign=
ed with a MS-approved certificate pair
(21:29:40) mattock: for Vista/7 64bit
(21:29:50) mattock: but if the TAP driver does not change often, that's not=
 an issue
(21:29:52) dazo: that's fair enough ... we don't need to build the TAP driv=
er as often
(21:30:11) dazo: our build scripts just need to wrap in the precompiled bin=
ary
(21:30:37) mattock: anyways, I'm pretty confident the build system is 100% =
functional by the end of the year
(21:30:47) dazo: sounds good! :)
(21:31:02) mattock: not too many pieces missing
(21:31:25) mattock: dazo: did you notice the Visual Studio C compiler error=
 about SOCKS auth I pasted here?
(21:31:52) dazo: mattock:  I saw it before I went for a meeting .... and fo=
rgot about it :)
(21:31:56) krzee: dazo, if a request for people with throughput issues on F=
AST links goes to the maillist i bet people will bite
(21:32:39) mattock: ok, just for reference: socks.obj : error LNK2019: unre=
solved external symbol _snprintf referenced in function _socks_username_pas=
sword_auth
(21:32:52) mattock: seems related to the new stuff in beta2.2
(21:33:53) dazo: mattock:  that's odd ...
(21:33:57) mattock: dazo: could you clarify... is https://community.openvpn=
.net/openvpn/ticket/35 a non-issue (configurable)?
(21:33:58) vpnHelper: Title: #35 (No magic limitation on socket size) =EF=
=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:34:11) dazo: mattock:  will update ticket
(21:34:17) mattock: ok, thanks!
(21:36:24) Busch ha abbandonato il canale (quit: Quit: Leaving).
(21:36:29) dazo: mattock:  I see the issue ... the patch was not using open=
vpn_snprintf() just snprintf() ...
(21:36:35) ***dazo digs a little bit more
(21:37:11) dazo: mattock:  can you try to just change snprintf() to openvpn=
_snprintf() on line 124 in socks.c?
(21:37:21) mattock: ok, I'll do it right away
(21:37:34) krzee: re ticket #35, sounds like it (need someone with the same=
 problem to be sure)
(21:39:23) mattock: building...
(21:40:20) mattock: ok, built just fine without an error
(21:40:23) mattock: pathc?
(21:40:27) mattock: oops... patch?
(21:40:32) dazo: yes please :)
(21:40:46) dazo: Send it to the ML and I'll ACK it immediately
(21:40:50) mattock: one more thing I noticed today...
(21:40:59) mattock: or rather, was pondering
(21:41:29) ***dazo see that we now do need a beta5 ... again, just because =
of windows crap :-P
(21:41:43) mattock: is this acceptable (in options.c):
(21:41:43) mattock: #ifndef _MSC_VER
(21:41:43) mattock: #include configure.h
(21:41:43) mattock: #endif
(21:41:51) mattock: without something like this build fails (again)
(21:42:09) mattock: but _if_ one is using MSVC with the old build system, t=
his will probably break his build
(21:42:21) dazo: How old is old?
(21:42:25) mattock: that detects the compiler
(21:42:31) mattock: I mean the one James is using :D
(21:42:37) mattock: in reality
(21:43:34) mattock: so, to put it in other words... it will (probably) brea=
k all autoconf/configure/make builds which use Visual Studio for compiler
(21:44:24) mattock: and I'm worried that "use of Visual Studio C compiler" =
!=3D "user of the new build system"=20
(21:44:35) dazo: I see
(21:44:35) mattock: so, any suggestions how to workaround this are welcome =
:)
(21:44:57) mattock: I _could_ generate an empty configure.h file in the Pyt=
hon code... but that's pretty nasty
(21:45:40) dazo: well, if the user is using autoconf with VC compiler .... =
that would normally mean that autoconf stuff is from a cygwin or msys envir=
onment, right?
(21:46:12) dazo: which possibly have {g,}awk available, right?
(21:46:33) mattock: probably I guess
(21:46:46) dazo: if so, then your #ifndef _MSC_VER should not be risky at a=
ll
(21:47:13) mattock: you mean awking our way out of this? ;)
(21:47:24) dazo: nope :)
(21:47:36) dazo: the autotools stuff uses awk to generate configure.h
(21:48:11) dazo: so if built via autotools, you should normally have config=
ure.h ... and if you're building via python, you would not .... however!
(21:48:44) dazo: python could generate configure.h with some useful build t=
ime options ... so that openvpn --version would show how it was built
(21:49:05) dazo: F.ex:
(21:49:07) dazo: #define CONFIGURE_CALL "  $ ./configure CFLAGS=3D-Wall"
(21:49:12) dazo: that's one example
(21:49:47) dazo: but it could for python #define CONFIGURE_CALL to somethin=
g which makes more sense for the python build env
(21:49:52) dazo: mattock:  do you follow?
(21:50:03) mattock: yeah
(21:50:05) mattock: makes sense
(21:50:41) dazo: configure.h is generated anyway ... so of python scripts g=
enerates it, it's nothing bad about that
(21:50:41) mattock: perhaps that's the best solution... it also removes the=
 need for my earlier patch related to "openvpn --version" (which uses CONFI=
GURE_CALL etc)
(21:51:19) dazo: nah, that's not bad to have ... I expected CONFIGURE_CALL =
to always be present ... and that's a bit cheeky of me, so your patch there=
 is fine
(21:51:50) dazo: (CONFIGURE_CALL is not strictly needed, it's a convenience=
 string for debuggin)
(21:52:02) mattock: I'm not emotionally attached to that patch, so we can r=
emove it if it makes sense :)
(21:52:13) dazo: NACK ;-)
(21:52:41) dazo: it's your first openvpn patch .... you *should* be emotion=
al to that one ;-)
(21:52:59) dazo: (at least the first I've added into the git tree :))
(21:53:30) mattock: ok ;)
(21:54:33) mattock: one more thing... I got tons of commits in my git tree =
and this sprintf commit is at HEAD... how can I generate a patch that does =
not pull all of the other crap with it?
(21:54:38) mattock: am I just too tired? :)
(21:55:10) dazo: mattock:  can you pastebin 'git status'?
(21:55:20) ***dazo is not sure he understands exactly what mattock says
(21:55:48) dazo: ahh ... you have more changes to your tree?
(21:55:49) mattock: ok, so I've committed stuff to my local repo... and thi=
s socks.c fix is on the top (HEAD)
(21:55:55) mattock: yep
(21:56:00) mattock: many, many commits
(21:56:19) dazo: git format-patch HEAD~1 .... that take only the last commit
(21:56:25) mattock: ok
(21:56:49) mattock: ok, I _was_ too tired
(21:56:53) mattock: thanks dazo!
(21:57:08) dazo: no worries :)
(21:57:35) mattock: care to review before I send it: http://pastie.org/1326=
277
(21:57:46) dazo: sure
(21:58:30) dazo: looks fine .... but would you mind doing this and recreate=
 your patch?
(21:58:50) dazo: git commit -s --amend
(21:58:51) dazo: and just save it
(21:58:51) dazo: and the git format-patch HEAD ~1
(21:59:21) mattock: ok
(21:59:55) ***dazo likes to see those "Signed-off-by: " lines in the commit=
 messages .... which is added by 'git commit -s'
(22:00:39) mattock: ok, now it's the same expect for the Signed-off
(22:00:42) mattock: I'll send it to -devel
(22:00:58) dazo: perfect!
(22:01:04) ***dazo fires up thunderbird
(22:02:02) mattock: tested building on Ubuntu - did not break anything
(22:02:28) mattock: probably openvpn_sprintf is there because of Windows an=
d/or unstandard sprintf behavior
(22:04:19) mattock: anyways, I'll fix the "configure.h" issue tomorrow and =
send in another patch
(22:05:58) mattock: unless there's anything else, let's call this a day
(22:06:44) mattock: I'll write the summary tomorrow
(22:07:05) mattock: and if anybody sees James here, bombard him with questi=
ons about 2.2-beta4 :D
(22:08:44) mattock: ok, me go now, good night!
(22:10:03) dazo: g'night
(22:10:35) dazo: mattock:  we probably need to spin a beta5 now ... with yo=
ur last patch, as it fixes VC building
(22:10:55) mattock: argh... should have kept the patch private :)
(22:11:09) dazo: heh :)
(22:11:31) dazo: well, this won't happen when we can really test our own wi=
ndows builds better as well
(22:11:41) mattock: yep
(22:11:52) mattock: can you regenerate the tarballs and (re)mail james?
(22:12:03) dazo: I'll do that
(22:12:07) mattock: ok, excellent
(22:12:50) mattock: we definitely need to improve our release times... we'v=
e skipped quite a few betas already...3 out of 5 if I counted correctly :)
(22:13:20) cron2: +1 :)
(22:13:25) dazo: heh ... yeah :)
(22:13:34) mattock: maybe we're just developing too fast=20
(22:13:41) dazo: and all of these skips just because of Windows troubles
(22:13:50) mattock: hmm, yes...=20
(22:13:55) dazo: we should consider stop supporting windows :-p
(22:14:24) mattock: that would work
(22:14:32) dazo: :)
(22:15:02) mattock: anyways, good night guys, got to go!
(22:15:08) mattock: see you tomorrow!
(22:16:01) dazo: c'ya

--------------090801090104080801040806--

