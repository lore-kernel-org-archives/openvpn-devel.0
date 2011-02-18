Message-ID: <4D5E2A03.4060001@...515...>
Date: Fri, 18 Feb 2011 10:12:51 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040903000301080109090002"
Subject: [Openvpn-devel] Summary of the IRC meeting (17th Feb 2011)
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
--------------040903000301080109090002
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 17th Feb 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-02-17>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, ecrist, jamesyonan, mattock and psha were present
in this meeting.

--

Discussed mattock's buildsystem patchset:

<http://thread.gmane.org/gmane.network.openvpn.devel/4406>

Jamesyonan gave the patchset his ACK if it's modified slightly:

1) Remove variables added to version.m4 and use win/settings.in instead
2) Add ENABLE_<FEATURE> configuration to win/settings.in instead of
   parsing config-win32.h for them

Mattock will provide modified patches after which the patchset can be
merged to beta2.2 branch.

--

Discussed "Coverity Scan" project briefly. Mattock contacted Coverity
yesterday asking them to grant a few new developers access to the
OpenVPN "Scan" results. He also asked them to update the codebase
they're tracking, which is obsolete. There has not been any reply from
Coverity yet.

--

Discussed t_client.rc + buildbot integration. Today mattock configured
buildbot to run "make check" after "make". This means that automated
connection test script, "t_client.sh", is run after each build. However,
currently all IPv6 tests on all buildslaves fail, causing buildbot to
(incorrectly) mark every build as FAILED.

Decided to turn off IPv6 tests until buildslaves are configured to
properly handle IPv6 payload over IPv4 transport.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------040903000301080109090002
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-02-17.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-02-17.txt"

(20:02:12) mattock: jamesyonan: there?
(20:02:20) jamesyonan: yes
(20:02:27) mattock: excellent!
(20:02:35) mattock: it's meeting time, dazo probably won't be here
(20:02:46) ecrist: slacker
(20:02:51) mattock: here's the topic list: https://community.openvpn.net/op=
envpn/wiki/Topics-2011-02-17
(20:02:53) vpnHelper: Title: Topics-2011-02-17 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:03:11) mattock: I suggest starting with my patchset
(20:03:45) mattock: jamesyonan: in last week's meeting we decided not to re=
lease 2.2-rc until these patches are merged to beta2.2 branch: http://threa=
d.gmane.org/gmane.network.openvpn.devel/4406
(20:03:46) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:04:40) mattock: jamesyonan: have taken a look at those already?
(20:05:46) mattock: or anybody else here, of course
(20:06:24) jamesyonan: mattock: yes, I did look at them.  The things I woul=
d like to see are (a) all build settings in one place (i.e. settings.in), (=
b) openvpn.exe can be built standalone, (c) autotools not required for wind=
ows build
(20:06:51) mattock: jamesyonan: ok
(20:06:53) jamesyonan: I noticed that you started to move more stuff from s=
ettings.in to version.m4 and I'm not sure that's a good idea
(20:07:24) mattock: I think we reached that conclusion in an earlier meetin=
g... to avoid duplication of configuration data
(20:07:43) mattock: same with using config-win32.h instead of putting ENABL=
E_* stuff to settings.in
(20:07:47) jamesyonan: version.m4 is exists so that the autoconf build syst=
em and the python build system can access version info in one place
(20:09:01) mattock: what if I move back the few new variables from version.=
m4 to win/settings.in?
(20:09:33) jamesyonan: also, I rely very much on build_exe.py, so I'm hopin=
g that your changes don't affect the ability to run this script standalone
(20:09:53) mattock: it should not
(20:10:10) mattock: haven't done any modifications to it
(20:10:16) jamesyonan: I also noticed that you are parsing config-win32.h
(20:10:28) mattock: yep, that's true
(20:10:28) jamesyonan: are you extracting build settings from it?
(20:10:37) mattock: yep, the ENABLE_<FEATURE> stuff
(20:10:56) mattock: so that it's not duplicated
(20:11:39) jamesyonan: yeah, I'm not sure about that.  I think settings sho=
uld stay in settings.in.
(20:12:40) mattock: fine with me, reduces complexity... I believe dazo pref=
erred to avoid data duplication, hence the config-win32.h parsing code
(20:12:41) jamesyonan: it's simpler if the build is driven by one config fi=
le
(20:12:44) mattock: agreed
(20:13:40) mattock: besides these issues was the patchset ok?
(20:13:41) jamesyonan: I would rather have all the settings in settings.in,=
 and then if necessary, dynamically generate a .h file to communicate those=
 settings to C
(20:14:11) jamesyonan: I haven't tested it, but overall it looks fine
(20:14:18) mattock: ok, excellent!
(20:15:07) mattock: so the patchset get your ACK if I do a few modification=
s:
(20:15:07) mattock: - move stuff from version.m4 to win/settings.in
(20:15:07) mattock: - remove config-win32.h parser code
(20:15:07) mattock: - put config-win32.h ENABLE_* statements to win/setting=
s.in
(20:15:10) mattock: right?
(20:18:45) mattock: cron2: what about the IPv4/IPv6 split in t_client.sh?
(20:19:27) psha: mattock: many testing systems have not only passed/failed =
for tests
(20:19:37) psha: but also 'skipped'
(20:19:37) psha: which is not error
(20:19:46) psha: so maybe make something like this for ipv6?
(20:20:06) mattock: psha: good point... maybe check for "fping6" and skip t=
ests if it's not available?
(20:20:08) psha: if ipv6 is available on host - test it, if not - skip with=
out raising error
(20:20:09) jamesyonan: I wouldn't eliminate version.m4 because the autoconf=
 build system still needs it, but I would remove anything else that does no=
t need to be shared between the autoconf and python build systems
(20:20:44) mattock: jamesyonan: yes, that was what I meant... moving back t=
he variables to win/settings.in
(20:21:49) mattock: cron2: could you add some ipv6 support tests to t_clien=
t.sh?
(20:23:01) psha: mattock: fping6 is not right test
(20:23:05) mattock: jamesyonan: ACK with modifications?
(20:23:26) jamesyonan: ack
(20:23:58) psha: i'd check for something like 'ip -6 ro'
(20:24:02) psha: or similar
(20:24:09) mattock: psha: BSDs?
(20:24:16) psha: netstat -r
(20:24:36) psha: netstat -r6
(20:24:39) mattock: jamesyonan: good! we can release 2.2-rc tomorrow or on =
monday at latest
(20:25:18) psha: netstat -r -f inet6
(20:25:31) psha: for BSD
(20:25:33) psha: for linux -r6
(20:25:39) psha: or ip -6 ro
(20:25:56) mattock: jamesyonan: I'll be sending you my Windows installer a.=
s.a.p. for signing
(20:26:06) psha: for windows 'not available' ;)
(20:26:08) mattock: psha: quite a few options :)
(20:26:48) psha: also instead of fping6 i guess 'ping6' is more common prog=
ram
(20:27:02) mattock: psha: could be, not sure why fping* is used
(20:27:38) psha: it's a form of advanced pin as i understand
(20:28:11) mattock: ok
(20:28:24) mattock: jamesyonan: thanks for reviewing the patchset, much app=
reciated!
(20:28:35) mattock: anything else, people?
(20:28:44) mattock: topic list is exhausted already, in record time :)
(20:29:03) psha: mattock: ifconfig | grep -q inet6
(20:29:04) psha: :)
(20:29:11) psha: working on both bsd and linux
(20:29:16) mattock: psha: that might not be all that bad, actually
(20:30:11) mattock: anybody read my split-ACK mail on openvpn-devel?
(20:32:59) psha: i've read but don't understand anything ;)
(20:34:55) ***cron2 is back
(20:35:13) mattock: psha: ok, perhaps too high-level brainstorming :)
(20:35:27) cron2: mattock: t_client.sh tests what *YOU* tell it to test.  D=
on't put ipv6 stuff in t_client.rc, then it's not going to do IPv6
(20:35:47) mattock: cron2: ah, excellent! did not realize that
(20:35:59) mattock: then we don't have an issue :)
(20:36:18) cron2: but much better: just install fping6 - whether or not the=
 client has IPv6 "natively" doesn't matter for the tunnel tests - if OpenVP=
N is up, and the openvpn+ipv6 works, the system *has* IPv6 as soon as openv=
pn is running
(20:36:30) cron2: psha: wrong approach
(20:36:48) cron2: psha: the point is not "is there ipv6 in the system befor=
e openvpn runs" but "is ipv6 across the tunnel working *while* openvpn runs"
(20:37:26) mattock: so ipv6 payload
(20:37:45) mattock: over ipv4 transport
(20:37:50) cron2: fping6 is used instead of ping6 because it's much more sa=
ne across platforms - no ping6 program on solaris, weird output and/or retu=
rn codes on other platforms
(20:38:14) cron2: mattock: over whatever transport you configure in t_clien=
t.rc - but right now, only v4 transport, as the test host doesn't have v6 i=
n DNS
(20:38:41) psha: cron2: maybe :) actualy i've not seen t_client.sh - just s=
uggested what's going on other test systems
(20:38:46) mattock: cron2: thanks for the clarifications!
(20:38:47) cron2: standardizing on fping/fping6 means "well-known and well-=
defined return codes"
(20:39:24) mattock: I'll fix the buildbot + t_client.rc issue tomorrow
(20:39:27) cron2: psha: it's pretty trivial - read config file, foreach($te=
st_stanza) { start openvpn; test predefined ipv4 ping hosts ; test predefin=
ed ipv6 ping hosts ; }
(20:39:49) mattock: cron2: I sent mail to Coverity today
(20:39:55) mattock: no response yet
(20:40:06) cron2: mattock: ah, looking forward to that :-)
(20:40:08) mattock: asked for user accounts for you guys
(20:40:17) mattock: and also that they update the codebase they're tracking
(20:40:33) mattock: hope they're not "turned off" by the corporate aspect o=
f OpenVPN
(20:41:19) mattock: their "Coverity Scan" FAQ is somewhat vague in that reg=
ard
(20:41:27) cron2: mattock: if you know that a certain client is broken wrt =
IPv6, just unset the EXPECT_IFCONFIG6_<n>=3D... definition and PING6_HOSTS_=
<n>=3D... definition from t_client.rc (for that buildslave)
(20:42:20) cron2: since t_client.rc is actually a shell script, you could h=
ave switch/case statements *in* there (if [ "$thishost" =3D "slave5" ] ; th=
en EXPECT_IFCONFIG6_3=3D'' ; fi  # known broken)
(20:42:57) mattock: for now I'll disable IPv6 tests, but look into fixing t=
hem later
(20:43:43) cron2: having IPv4 tests is at least a good baseline for "the co=
mpile went right, networking bits are working, packets are flowing", yes
(20:44:22) mattock: agreed
(20:44:28) mattock: cron2: do you have access to the community VPN?
(20:45:02) cron2: I'm not sure - I think you sent me some bits some long ti=
me ago, but I've never setup & configured anything yet
(20:45:19) mattock: ok, let me know if you need those bits again :)
(20:45:31) mattock: buildbot lives at http://10.7.36.101:8010/
(20:45:56) cron2: will check, and see what I find in my mail heap :)
(20:46:16) mattock: I have not configured it to mail to openvpn-build, beca=
use I've had to switch off the buildslaves constantly due to my Windows work
(20:46:32) mattock: (time to buy some extra RAM for the server)
(20:46:58) cron2: do we need collect donations?
(20:47:06) ***cron2 has some 32MB SIMMs lying in the basement
(20:47:18) mattock: excellent! then it's 2048 + 32MB :)
(20:47:29) mattock: significant improvement
(20:47:31) cron2: that should do for one linux buildslave extra :)
(20:48:01) mattock: default Debian install seems to be happy with 128MB
(20:48:09) mattock: Ubuntu 10.04 complains with the same amount
(20:48:21) mattock: so, they're memory hogs compared to OpenBSD or something
(20:48:29) cron2: for all that graphics fanciness you need lotsa RAM!
(20:49:45) mattock: hmm, actually just the console... but not sure how much=
 lower they could go. Ubuntu may have had some crap running that eats memory
(20:49:56) mattock: anyways, unless there's something else, let's call this=
 a day!
(20:50:18) cron2: short meeting then :-) - enjoy your evenings (or day time)
(20:50:18) mattock: btw. I asked dazo to merge my buildsystem patches (with=
 tomorrow's modifications) during weekend
(20:50:31) cron2: great
(20:50:38) mattock: if he has time, then 2.2-rc release would be Mon-Tue?
(20:51:06) mattock: jamesyonan: got time to sign the windows installer, tar=
balls etc. on Monday/Tuesday?
(20:51:19) jamesyonan: yes
(20:51:24) ecrist: w00t
(20:51:26) mattock: nice!
(20:51:37) mattock: I fear the 2.2-rc release is imminent, then!
(20:52:30) mattock: I'll write the summary tomorrow
(20:52:33) mattock: see you later!

--------------040903000301080109090002--

