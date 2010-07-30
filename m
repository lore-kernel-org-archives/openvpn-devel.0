Message-ID: <4C530430.1070404@...515...>
Date: Fri, 30 Jul 2010 19:56:16 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050608040400040803000806"
Subject: [Openvpn-devel] Summary of the IRC meeting (29th Jul 2010)
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
--------------050608040400040803000806
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 29th Jul 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-07-22>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the "Multiple --up scripts and no error" issue:

<https://community.openvpn.net/openvpn/ticket/20>

Agreed that verifying that the output from this patch is correct is
enough to give it an ACK.

--

Discussed OpenVPN 2.2 beta release. Dazo said the beta 2.2 branch is
ready for release when these issues are settled:

<https://community.openvpn.net/openvpn/ticket/18>
<https://community.openvpn.net/openvpn/ticket/20>

However, as James has not yet given any feedback on the original release
date (August 1st) it was decided to wait a little longer by postponing
the release date to August 9th. Agreed to aim for mid/late October
release date for the first release candidate (RC).

Agreed to use weekly source snapshots from  Buildbot as beta releases
for non-Windows platforms. Agreed that we should provide Windows client
binaries, too, but nobody has a Windows computer that could be used for
build purposes. Did not reach a consensus where to host the downloads:
build.openvpn.net or the official OpenVPN web pages (openvpn.net).

Mattock promised to handle the official announcements regarding the beta
2.2 release and to configure Buildbot to create beta2.2 source tarballs
and zips. He also promised to contact James and Francis about the 2.2
release to get some feedback. Ecrist will create new FreeBSD ports based
on the OpenVPN beta2.2 branch.

--

Discussed testing issues. Currently testing that OpenVPN behaves as
expected (dynamic black box testing) has to be done manually, which is
slow and error-prone. Agreed that setting up the Beaker test framework
(https://fedorahosted.org/beaker) would be the best solution. However,
currently no VM's have been allocated for it and there's no time to set
it up right now. Agreed that for now we should write standalone ("make
test") scripts, but make sure they can be migrated to Beaker easily.
Cron2 will soon write some standalone tests for his own purposes and
publish them.

--

Mattock gave an update on Buildbot. As agreed in an earlier meeting,
access to Buildbot will be provided to community members using an
OpenVPN tunnel. The buildbot web interface will provide build
status/history display. Buildslave interface will be used by
community-provided buildslaves which provide build testing (CI) and
packaging capabilities for specific OSes. Further details about Buildbot
access are available here:

<https://community.openvpn.net/openvpn/wiki/SettingUpBuildslave>

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock






--------------050608040400040803000806
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-07-29.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-07-29.txt"

(21:05:42) dazo_afk =EF=BF=BD=EF=BF=BD ora conosciuto come dazo
(21:05:47) cron2: hah!
(21:05:55) dazo: mattock:  sorry, I'm late
(21:06:00) mattock: dazo: no probs, just mailed james
(21:06:18) mattock: I added a new section to agenda
(21:06:28) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2010-=
07-29
(21:06:29) vpnHelper: Title: Topics-2010-07-29 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:08:33) dazo: let's try again
(21:08:59) mattock: let's start the meeting, shall we...
(21:09:07) dazo: \o/
(21:09:36) mattock: perhaps start with something that does not require/bene=
fit from James' presence...
(21:09:50) mattock: ticket 20?
(21:09:53) dazo: sure!
(21:10:00) dazo: it just needs a review
(21:10:27) mattock: cron2?
(21:10:38) dazo: it's from a support ticket ... a guy didn't make some scri=
pts work out as expected, because several --up scripts (or another hook) wa=
s used
(21:10:40) cron2: yes
(21:11:07) dazo: so the patch only adds warnings when multiple script hooks=
 of the same time is configured ... and the command line arguments override=
s the config file
(21:11:20) dazo: which maintains the standard behaviour of openvpn
(21:11:23) cron2: I've seen the patch, but didn't find time to closely look=
 at it yet
(21:11:48) cron2: from a cursory glance, it looked fine (but that's not suf=
ficient to send an ACK)
(21:12:10) dazo: yeah ... I don't care who gives an ack ... I just want an =
ack :-P
(21:12:22) ***cron2 wants an ack for the configure patch...
(21:12:42) dazo: fkr:  ^^^^
(21:13:12) dazo: cron2:  worst case, I'll setup a OpenBSD VM and try it mys=
elf
(21:14:59) dazo: but after all ... the ticket #20 patch is pretty much a no=
-brainer ... if( option) { msg(M_WARN, "Duplicate configs used"); } .... th=
is is done ~10 times or so
(21:15:26) cron2: indeed, but the reviewing is "has there been enough brain=
 to actually change the copy-paste'd text every time" :-)
(21:15:36) dazo: heh :)
(21:16:34) cron2: mmmh.  topic covered?
(21:16:51) dazo: yeah, we don't need to spin_lock() on this one
(21:16:56) mattock: guess so, just wondering why the same warning is printe=
d separately every time and not in a function :)
(21:17:03) mattock: I'm sure there's a good reason for it
(21:17:25) mattock: anyways, beta2.2?
(21:17:28) cron2: mattock: well, I seem to remember that the message is act=
ually different, listing the specific option that's duplicated
(21:17:32) dazo: mattock:  pretty much due to how the option parser is writ=
ten
(21:18:09) mattock: ok
(21:18:09) dazo: beta2.2!
(21:18:18) cron2: all for it!
(21:18:25) mattock: \=EF=BF=BD=EF=BF=BD/
(21:18:32) mattock: (king cheers)
(21:18:35) cron2: (wow, umlauts)
(21:18:43) krzee: \O/
(21:18:52) dazo: \=EF=BF=BD=EF=BF=BD/
(21:19:04) mattock: :)
(21:19:11) cron2: dazo: how's your end of 2.2 looking like?  branch ready?
(21:19:18) cron2: "august 1st"?
(21:19:36) dazo: yeah, I feel the beta2.2 branch is ready for the first rel=
ease
(21:19:51) mattock: dazo: did James respond to your email about beta2.2?
(21:19:54) dazo: I've sent an e-mail to James asking him to check it out ..=
. but no response=20
(21:20:02) mattock: oh
(21:20:15) krzee: is ipv6 getting included?
(21:20:16) ***dazo would hope James could pop in today and share some thoug=
hts
(21:20:16) mattock: he does not respond too eagerly
(21:20:29) cron2: krzee: only a small bit, the windows tap driver changes
(21:20:45) dazo: krzee:  no, only IPv6 enabled WINTAP driver ... to make su=
re that's stabilised=20
(21:20:47) krzee: ahh
(21:20:58) ***dazo is too slow today
(21:21:02) krzee: good idea
(21:21:09) ***cron2 runs circles around dazo
(21:21:18) mattock: I'll add "buildbotify beta2.2 branch" to my todo list
(21:21:20) ***dazo gets dizzy
(21:21:29) dazo: mattock:  nice!
(21:21:46) mattock: done
(21:21:58) dazo: so, the next thing is to set a release date for the beta2.=
2 branch .... and tbh, I'm not sure how much we should wait for James, if h=
e won't respond
(21:22:07) mattock: ok, so beta2.2 release date on August 1st...
(21:22:36) cron2: this is a half-joke, as August 1st is in 3 days - which i=
s a bit too soon if there's no feedback from James
(21:23:01) mattock: well, that's an issue...
(21:23:09) mattock: I'll send James another mail about this...
(21:23:18) dazo: good!
(21:23:33) mattock: btw. how shall we distribute beta2.2?
(21:23:40) mattock: through build.openvpn.net with links from openvpn.net
(21:23:48) dazo: The change set is not that big, and we have James latest b=
its into the tree ... so I'm not too worried about pushing out this as the =
first beta2.2
(21:23:51) mattock: or directly from openvpn.net?
(21:23:52) cron2: mattock: what are the options?
(21:23:59) mattock: cron2: ^^^ :)
(21:24:29) dazo: I'd say via the community server somehow .... preferably w=
ith some links from the official web pages=20
(21:24:31) ***cron2 doesn't fully understand the difference between "openvp=
n.net" and "build.openvpn.net"?
(21:25:05) dazo: build.openvpn.net/community.openvpn.net  that''s community=
 servers .... while openvpn.net is the official web page
(21:25:07) cron2: yes, links from the official "download here" page would b=
e needed
(21:25:12) cron2: dazo: ah!
(21:26:11) ***cron2 has no strong opinion, as long as the stuff can be easi=
ly put there by "who needs to do it" and the download pages link to it
(21:26:36) dazo: mattock:  will we be able to provide windows binaries like=
 the official stuff got?
(21:26:48) mattock: I'll ask James in the mail
(21:27:06) cron2: that would be VERY important to get the TAP driver change=
s tested
(21:27:36) dazo: mattock:  having source tarball, zip, windows binary + sig=
nature files would make it closer to the normal release rounds ... so that =
would be good
(21:28:28) mattock: ok, mail sent
(21:28:28) cron2: + having debian packages is a big plus :-)
(21:28:37) dazo: thx!
(21:28:46) mattock: hope james can attend, we'd sure need his feedback/expe=
rtise
(21:28:54) mattock: cron2: those are coming up
(21:29:11) cron2: mattock: yes, saw you mention this, this is great!
(21:29:36) mattock: btw. is there any reason to manually create the beta pa=
ckages? or will buildbot packages be enough?
(21:30:10) dazo: mattock:  buildbot could do it ... would be nice if it did=
 signatures as well then
(21:30:14) mattock: e.g. release every weekly build as new beta
(21:30:16) cron2: manually created packages are of course much superior to =
this machine-built crap!!!
(21:30:39) dazo: OpenVPN: hand made by cron2 and mattock
(21:30:47) mattock: cron2: especially if the manual guy does the exact same=
 steps as the machine :)
(21:30:50) dazo: the finest art that is
(21:31:03) cron2: seriously: I think buildbot-built packages are less error=
-prone than manually doing repetitive stuff every week on multiple platform=
s...
(21:31:13) cron2: and less human-time wasted
(21:31:15) dazo: completely agree
(21:31:17) mattock: running "autoreconf -vi" manually is so much better tha=
n the same done from a script :D=20
(21:31:35) mattock: ok, so buildbot packages it'll be
(21:32:10) mattock: so we want a source tarball, windows client binary and =
debian packages?
(21:32:14) dazo: the buildbot basically just needs to do:  autoreconf -vi; =
./configure ; make distcheck .... and you get a smoke test + a tar ball rea=
dy for distribution, including ./configure
(21:33:20) mattock: dazo: I'll add that process to buildbot todo
(21:33:24) dazo: mattock:  pretty much .... I don't care about debian :-P  =
(after all, it's not been a OpenVPN tradition to provide much binaries for =
Linux as packages usually does that)
(21:34:01) cron2: there seems to be a pretty active openvpn user group usin=
g debian, so that would help getting testers
(21:34:05) dazo: The only thing I need to do with the git tree is to tag th=
e version in ./version.m4 ... and make a git tag ... that's all
(21:34:11) mattock: yep, so source tarball and Windows binaries
(21:34:22) dazo: agi would know debian stuff
(21:34:26) dazo: mattock:  yes
(21:34:29) mattock: cron2: yep, and debian packaging is mostly ready
(21:34:39) ***ecrist waves
(21:34:48) ***dazo waves back
(21:35:15) mattock: btw. an update on buildbot status
(21:35:39) mattock: so OpenVPN now authenticates from LDAP instead of using=
 certificates
(21:35:56) mattock: so access to buildbot (for developers and/or buildslave=
 owners) is in place
(21:36:05) mattock: see this: https://community.openvpn.net/openvpn/wiki/Se=
ttingUpBuildslave
(21:36:07) vpnHelper: Title: SettingUpBuildslave =EF=BF=BD=EF=BF=BD=EF=BF=
=BD OpenVPN (at community.openvpn.net)
(21:36:08) dazo: neat!
(21:36:36) cron2: cool
(21:36:38) mattock: so you need some openvpn configs & certs, community ser=
vices account _and_ you need to belong to "builders" group in LDAP
(21:37:11) mattock: now there's one issue I need to fix... currently Buildb=
ot server gets a random IP
(21:37:32) mattock: it should get a static VPN address, so that people can =
access it=20
(21:37:37) mattock: otherwise all is working fine
(21:37:59) ecrist: mattock: is ldap directly accessible to any community me=
mbers?
(21:38:09) dazo: mattock:  dynamic IP can be tackled by --learn-address=20
(21:38:10) mattock: ecrist: nope
(21:38:20) ecrist: I know you're pushing backups to me, but that's the only=
 access I'm aware of.
(21:38:41) mattock: ok, so this is how our LDAP works..
(21:38:56) mattock: users (=3Danyone) can create an accounts using "pwm"
(21:39:13) mattock: they can also edit their own data (e.g. email) using pwm
(21:39:20) mattock: the LDAP server is behind a firewall
(21:39:38) mattock: there's no access to it directly from the Internet, onl=
y through the VPN
(21:40:16) mattock: and VPN is only accessible if the user has the ca.crt, =
ta.key, properly configured OpenVPN, has an LDAP account and belongs to "bu=
ilders" group in LDAP
(21:40:52) krzee: [11:38]  <mattock> so you need some openvpn configs & cer=
ts, community services account _and_ you need to belong to "builders" group=
 in LDAP
(21:40:55) krzee: thats clean =3D]
(21:41:18) dazo: sounds very reasonable to me
(21:41:28) cron2: +1
(21:41:37) mattock: we chose to eat our own dogfood, so :)
(21:41:50) ecrist: ditto, though I'd like for LDAP admin to be delegated to=
 community members, as well.
(21:41:56) ecrist: call me a control freak. ;)
(21:42:08) mattock: ecrist: that should be doable using pwm admin interface
(21:42:25) ***ecrist has yet to even look at pwm
(21:42:40) mattock: and might be beneficial to me, too, once more people st=
art using Trac/forums/whatever
(21:42:56) mattock: ecrist: click on "Register" or "Account" link in Trac
(21:42:59) mattock: that's pwm
(21:43:13) mattock: anyways, where were we?
(21:43:34) mattock: ah, debian packages...
(21:43:51) mattock: so I can do Debian amd64 and Ubuntu 9.10 i386 packages =
very soon
(21:44:16) mattock: haven't got any extra VM's for other OS'es
(21:44:46) mattock: does anyone know how to build Windows installers?
(21:45:06) cron2: sort of
(21:45:43) mattock: cron2: are they good enough for distributions?
(21:45:55) cron2: well, the "domake-win" script in the source tree knows ho=
w to do it :-)
(21:46:16) cron2: but it needs to run *on* windows
(21:46:27) ecrist: pwm seems pretty clean
(21:46:28) mattock: oh, so no build automation for windows packages
(21:46:38) mattock: ecrist: yep, it's pretty nice
(21:46:54) dazo: I think it should be doable to cross compile to Windows fr=
om Linux, or not?
(21:47:07) cron2: openvpn.exe, yes.  tap.sys, no
(21:47:08) mattock: cron2: didn't you try cross-compiling?
(21:47:13) dazo: aha
(21:48:18) mattock: what if we set a new release date, say 9th August (mond=
ay)?
(21:48:30) mattock: and try to get James' feedback before that
(21:48:39) dazo: sounds like a good idea
(21:49:05) dazo: and an RC mid/late October?
(21:49:24) cron2: +1
(21:49:26) mattock: sounds good
(21:49:31) ecrist: release for what on the 9th?
(21:49:39) dazo: first beta2.2
(21:49:53) mattock: and forums on 13th Aug
(21:50:06) mattock: _if_ the theming is in place then
(21:50:31) mattock: should we discuss testing issues now?
(21:50:35) ecrist: they haven't done anything with theming, other than thro=
wing a logo on there.
(21:50:45) mattock: ecrist: yep, that's what I thought
(21:50:49) ecrist: dazo, is there a branch or somthing for the beta2.2 rele=
ase?
(21:51:01) dazo: ecrist:  it is ... it's called beta2.2 ;-)
(21:51:07) mattock: they've been insanely busy with Access Server 1.5
(21:51:15) mattock: release a couple of weeks ago
(21:51:25) cron2: give me a moment, need to tend child
(21:51:34) mattock: cron2: take your time
(21:51:35) dazo: it's not tagged as beta2.2_1 yet ... but it's about to rea=
ch that soon
(21:51:56) ecrist: dazo: I'm not sure how best to handle the beta release w=
ith ports and proper versioning.
(21:52:16) ecrist: can we avoid underscores in release names?
(21:52:28) ecrist: beta2.2.1 would be better
(21:52:29) mattock: debian uses "-"
(21:52:36) mattock: e.g. 2.2-debian0
(21:52:37) dazo: ecrist:  I'll follow the old style ... so it will be openv=
pn-2.2_beta1 ... so version string is 2.2_beta1
(21:52:38) mattock: or something
(21:53:05) ecrist: freebsd ports appends _$PORTREVISION=20
(21:53:50) dazo: we can change it to 2.2-beta1, if that makes people happier
(21:54:02) ecrist: that would make me a bit happier.
(21:54:11) mattock: and it looks better to me
(21:54:45) dazo: I have no problem with that ... I just need to double chec=
k how Fedora packages will like that ... as they use -{build revision}
(21:54:53) ecrist: I'm going to create another port for this, openvpn-beta =
which will handle betas, so as not to screw with current -devel stuff
(21:55:03) dazo: that sounds very good!
(21:55:04) mattock: good idea
(21:55:22) ecrist: so, on FreeBSD, there will be three openvpn ports, openv=
pn (release), openvpn-beta (beta-releases), openvpn-devel (weekly git snaps=
hot)
(21:55:33) dazo: as we will continue to accept stuff into the working branc=
hes, and only merge in stuff from there into beta2.2, which fits the beta
(21:56:24) ecrist: so, when is the plan to freeze the tree for the beta rel=
ease, to give package maintainers time to build/commit?
(21:57:18) mattock: good point, we should make an official announcement abo=
ut beta2.2 release date a.s.a.p.
(21:57:23) mattock: -> todo list
(21:57:24) dazo: no, not freezing ... but the beta2.2 branch in git will on=
ly get merges with patches from other branches which we consider important =
to get into 2.2 ... I doubt that will be much changes
(21:57:45) ecrist: dazo, I think it's a good idea to freeze so all packages=
 are in-sync.
(21:57:49) dazo: and the allmerged branch + all feature/bugfix2.1 branches =
will continue to be modified
(21:58:08) ecrist: that way, we don't have to worry about freebsd having a =
patch that debian doesn't
(21:58:24) ecrist: and any commit to that branch should bump the version nu=
mber accordingly
(21:58:34) mattock: so the beta2.2 tree will be frozen, but the rest of the=
 trees will move forward
(21:58:55) ecrist: that's my thought
(21:58:59) dazo: ecrist:  it's no need to freeze ... because we will tag th=
e first beta2.2 .... as v2.2-beta1 ... and people will build from that tag =
.... then when feedback and fixes comes ... they go into the beta2.2 branch=
 and at next release point for beta, we tag it v2.2-beta2
(21:59:01) dazo: and so on
(21:59:11) ecrist: ok
(21:59:31) dazo: so you can call the tags "freeze points" ... but it will n=
ot completely freeze the tree
(21:59:44) ecrist: now we're splitting hairs
(21:59:56) mattock: ...thunderstorm coming, need to move inside... I'll be =
back soon
(22:00:05) ecrist: so, has beta1 been tagged yet?

--- Connection interruption, ignore wrong timestamps ---

(22:07:34) dazo: not yet
(22:07:34) dazo: we're trying to be nice and patient, waiting for James fee=
dback on the beta2.2 branch
(22:07:34) dazo: but I'm of the opinion that if we don't get any feedback b=
y August 9th, we're using that branch as the first beta release=20
(22:07:37) dazo: https://community.openvpn.net/openvpn/report/3 ... If you =
look for the beta2.2 milestone, that's stuff I want to see hit the beta2.2 =
branch during it's cycles.
(22:07:37) vpnHelper: Title: {3} Active Tickets by Milestone =EF=BF=BD=EF=
=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(22:07:40) dazo: We have patches for all except ticket #30 and #18
(22:07:43) mattock has quit (Ping timeout: 265 seconds)
(22:07:48) cron2: ok, back
(22:07:51) cron2: testing?
(22:07:51) dazo: sure ... we might need mattock on that one, as he knows mo=
re about the Beaker progress
(22:07:51) mattock (~samuli@...1392...) has joined #openvpn-devel

--- Stop ignoring timestamps :) ---

(22:06:56) modalit=EF=BF=BD=EF=BF=BD (+o mattock) da ChanServ
(22:06:59) dazo: talking 'bout the sun!
(22:08:20) mattock: ok, back to GPRS :)
(22:08:45) cron2: testing!
(22:08:56) mattock: testing!
(22:09:09) mattock: (I'll summarize the beta2.2 stuff on Saturday)
(22:09:24) mattock: cron2: could you share your thoughts first?
(22:09:49) dazo: (thx)
(22:09:58) cron2: where am I coming from?  "I build stuff with IPv6 payload=
 on about 6 different machines, and after each change, I want to make sure =
that everything still works"
(22:10:04) cron2: this is fairly time consuming
(22:10:17) mattock: it must be...
(22:10:39) mattock: so you had "make test" type of things in mind, right?
(22:10:40) cron2: I really need to verify that things like "address assignm=
ent to tun interface" works right, and that communication works (ping, run =
something like HTTP through the tunnel, ...)
(22:10:47) cron2: so the idea:
(22:10:53) cron2: compile
(22:10:56) cron2: run "make test"
(22:11:18) cron2: make test would then startup an openvpn client to a "well=
 known" server (or set of servers, udp/tcp, tun/tap)
(22:11:35) cron2: then the script would verify ping, http, ... connectivity=
 to a "well known" address inside the VPN tunnel
(22:11:46) cron2: if that works, kill off the openvpn client
(22:12:03) cron2: and report success
(22:12:09) cron2: caveat 1: "what is the server that I want to use?"
(22:12:17) cron2: caveat 2: "what protocols to test?"
(22:12:36) cron2: caveat 3: actual ifconfig/route tests need to be run as r=
oot
(22:12:50) cron2: caveat 4: this doesn't test server mode, or point-to-poin=
t mode
(22:13:25) cron2: for "4" I have thought of setting up a "call me back" CGI=
 script on the "well-known" server that would initiate an OpenVPN counterpa=
rt in the other direction
(22:13:34) cron2: caveat 4a: make sure this isn't abused...
(22:13:41) dazo: okay ... this the perfect candidate for Beaker ... Beaker =
allows you to write test scripts in whatever language you want, it runs thr=
ough a number of test cases and reports a status (fail/pass) ... it can the=
n use multiple pre-defined configs (dynamically exchanging IP addresses and=
 stuff, of course)
(22:14:14) cron2: the bit "how to run the tests" is not so hard ("make test=
" :) )
(22:14:38) cron2: the tricky part is "how does the test script know which s=
erver to connect to"
(22:15:02) dazo: the process of a Beaker test run is ... you send a "test t=
his script for me" to the scheduler.  The test script has defined which har=
dware and OS you want to run the tests on ... it provisions a system (or mo=
re, in multi-host testing scripts), installs the OS and the needed packages=
 ... runs the test script and logs the result with complete logs
(22:15:16) cron2: if I want to test, i might not want to connect to openvpn=
.net (due to "no IPv6 there yet") - if buildbot wants to test, it should co=
nnect to openvpn.net...
(22:15:38) cron2: ... and if we want to have these scripts in the git tree,=
 they should be generic enough so that they are useful for "the broad commu=
nity"...
(22:15:48) dazo: In the beaker-libraries, there are functions how to synchr=
onise communication between two test hosts ... and exchanging the IP addres=
ses
(22:16:09) cron2: dazo: oh, now *that* is cool
(22:16:13) mattock: I agree we should use Beaker for this... however, don't=
 count on me setting it up real soon. My TODO list is rather long :)
(22:16:13) cron2: "run test client *here*, test server *there*"
(22:16:34) mattock: also, we don't have test servers for beaker yet
(22:16:40) mattock: nor for buildbot, for that matter
(22:16:41) dazo: cron2:  we're using Beaker at Red Hat for most automated p=
ackage testing ... it really works well
(22:17:15) cron2: beaker is a bit heavyweight for my personal environment, =
though
(22:17:30) mattock: dazo: could we use standalone "make test" scripts for n=
ow and migrate them to beaker later on?
(22:17:47) dazo: mattock:  so we're still lacking the hardware?  I thought =
someone (not you, mattock) promised that to be a piece of cake
(22:17:50) cron2: but sufficiently generic test scripts could be used for b=
oth...
(22:17:51) dazo: yes!=20
(22:18:12) mattock: dazo: yep, I remember something like that, too :)
(22:18:32) cron2: dazo: how does parameter passing work inside beaker?  env=
ironment variables -> script?
(22:18:32) dazo: you can write beaker test scripts ... and run them locally=
, you'll just miss the provisioning and automated stuff in Beaker ... but y=
ou have the needed parts to test out the Beaker test, just as it would be r=
un in Beaker
(22:18:49) mattock: dazo: anything special one should know about Beaker tes=
t scripts?
(22:18:51) dazo: cron2:  you give whatever  parameters to the scheduler whe=
n scheduling a test run
(22:18:59) cron2: dazo: do you have a link how to write a beaker test scrip=
t "without beaker"?
(22:19:26) cron2: dazo: so that's command line, environment, "whatever you =
want"?
(22:19:30) cron2: dazo: how about passing around certificate files etc?
(22:19:30) ***dazo looks up Beaker docs
(22:19:45) dazo: cron2:  that's also doable ... you probably want to pass a=
n URL to files to fetch=20
(22:20:38) cron2: fetch certificates *here*, build temporary openvpn conf f=
rom this, and that environment variable ("*there* is the other side of the =
test setup")
(22:21:18) dazo: https://fedorahosted.org/beaker/
(22:21:21) vpnHelper: Title: beaker - Trac (at fedorahosted.org)
(22:21:21) cron2: this sounds definitely cool and we want this :-) (but I'm=
 *not* volunteering, sorry, I'm already way behind on my open issues)
(22:21:24) dazo: I can probably spare some time helping setting up Beaker
(22:21:29) cron2: child wrecks any sort of time planning :/
(22:21:57) mattock: cron2: can you write scripts to automate your own testi=
ng procedures?
(22:22:02) mattock: and publish them :)
(22:22:11) ***dazo might get some allowance to do this during work hours=20
(22:22:23) mattock: or was that the thing you're not volunteering for?
(22:22:42) dazo: cron2:  unfortunately, it seems that some of the docs is o=
nly available from within RH ... but I'll dig up something useful
(22:22:42) cron2: mattock: well, basically that's the reason why I brought =
this up - bounce the idea off you, see whether it's sound, send patches
(22:23:01) mattock: the idea is excellent!
(22:23:16) mattock: especially if the scripts are "Beaker compatible" from =
the start
(22:23:26) mattock: or at least easily convertable into Beaker format
(22:23:27) cron2: next thing on my list is "make sure the IPv6 payload stuf=
f works on OpenBSD", which should be fairly straightforward - but is a good=
 opportunity to start rolling auto-scripts
(22:24:03) dazo: it's usually no big deal to convert scripts afterwards=20
(22:24:32) mattock: cron2: so no reports from any OpenBSD guys so far?
(22:25:49) cron2: mattock: let's start with "something that works" and then=
 optimize :)
(22:25:49) dazo: you basically just source a beaker-functions script ... an=
d then call a beaker-report-result function at the end ... to say it overly=
 simple
(22:25:52) cron2: mattock: krzee plays dead :)
(22:25:52) krzee: huh?
(22:25:52) krzee: oh
(22:25:52) dazo: heh
(22:25:52) krzee: i tested the first patch, didnt work
(22:25:52) cron2: krzee: waiting for your feedback (and ACK) on the configu=
re patch :-)
(22:25:52) krzee: if there was something since, havnt checked
(22:25:52) cron2: there's a second patch now
(22:25:52) krzee: ahh good
(22:25:52) cron2: it's on the list and in the trac ticket
(22:25:52) krzee: im finally settling down after an insane migration
(22:26:11) cron2: regarding the IPv6 payload itself - I can test that local=
ly in the VM
(22:27:00) dazo: cron2:  mattock: beakerlib ... the part used in test scrip=
ts ... https://fedorahosted.org/beakerlib/wiki/Manual
(22:27:08) vpnHelper: Title: Manual - BeakerLib - Trac (at fedorahosted.org)
(22:27:16) cron2: dazo: *note*
(22:27:27) mattock: dazo: ok, I'll  check it when my connection is faster t=
han 4kbps :)
(22:27:32) cron2: ok, I'll play with this over the next days
(22:28:15) mattock: I think unit- and security testing stuff is too much fo=
r today
(22:28:18) mattock: what do you think?
(22:28:19) cron2: this was "my" testing part - unit tests and valgrind came=
 from mattock(?) - I need to have some food with $wife now, otherwise "no m=
ore playing with openvpn" for me :-) - I'll have an eye on the IRC
(22:28:28) mattock: cron2: yep, from me
(22:28:43) dazo: mattock:  agreed
(22:29:04) mattock: ok, so unless somebody has anything else on his/her min=
d, let's end the meeting
(22:30:00) mattock: I'll probably write the summary on Saturday, not tomorr=
ow
(22:30:16) dazo: sure!
(22:30:33) mattock: depends on when I'm returning to civilization :)
(22:30:48) mattock: anyways, good meeting again!
(22:30:59) dazo: :)
(22:31:22) mattock: let's try to reach James somehow within 7 days or so...
(22:31:36) mattock: I'm not sure which tactic would be best
(22:31:45) mattock: bombarding with emails does not seem to work well
(22:32:03) mattock: I have his Skype ID, I might have to try that instead
(22:32:31) dazo: I dunno ... I'm thinking that if we give him time to jump =
up and in worst case reject the progress, that's at least *feedback* ... an=
d if he doesn't do that, then we continue
(22:33:14) mattock: I agree we need to move on, even if James won't give fe=
edback
(22:33:40) dazo: waiting another week, that'll give him in total 2 weeks to=
 respond to my e-mail ... so if nothing, then we can't say we haven't tried=
 to give him time to respond
(22:33:43) mattock: I mean, we can't wait indefinitely
(22:33:56) mattock: yep, agreed
(22:34:01) dazo: exactly
(22:34:25) mattock: the only thing I'd rather not do without feedback is pu=
t stuff (e.g. announcements) on openvpn.net
(22:34:56) mattock: or beta2.2 releases
(22:35:00) mattock: to openvpn.net
(22:35:17) mattock: I need some sort of "OK" from somebody (James or Franci=
s)
(22:35:26) dazo: well, lets see how things goes ... we could consider to se=
tup a wordpress or drupal service on community server ... and host our own =
community web pages with more updates
(22:36:05) mattock: well, I have write access to (part of) openvpn.net web =
pages now
(22:36:25) dazo: and then just with time get stuff on openvpn.net point to =
community, which is community related ... and then OpenVPN Tech can keep th=
eir own pace
(22:37:08) mattock: I agree that for the most part the community should be =
able to work independently of the company
(22:37:42) mattock: and the company would be part of the community, of cour=
se
(22:38:02) mattock: I'd love to see the second part materialize :)=20
(22:38:13) dazo: that's my key point
(22:38:17) dazo: of course!
(22:38:33) cron2: definitely
(22:38:47) dazo: I don't mean to push them out :) ... but they need to want=
 to be involved, or else they will not be a part of it
(22:39:07) mattock: anyways, if James does not respond early next week, I'l=
l mail Francis... he's way more responsive (to emails)
(22:39:18) cron2: ... and that would risk a fork, which is not good
(22:39:25) dazo: and by "wanting to be involved", I mean that needs to be v=
isible in their priorities and actions
(22:39:35) mattock: yep, that's what I've tried to explain to them
(22:40:54) dazo: mattock:  could it be as simple as James are on a holiday?
(22:40:55) ***dazo just realised that now
(22:41:03) mattock: dazo: that's possible
(22:41:36) mattock: if there's no communication, there are tons of ways to =
misunderstand people's intentions
(22:41:46) mattock: or why they behave like they do
(22:41:50) dazo: yeah
(22:42:05) mattock: anyways, I'll send mail to James and Francis about beta=
2.2 et al
(22:42:13) dazo: perfect!
(22:42:14) mattock: and community involvement
(22:42:43) mattock: ok, enough for today :)
(22:42:57) dazo: :)
(22:43:02) mattock: bye guys!
(22:43:07) dazo: bye!

--------------050608040400040803000806--

