Message-ID: <4C5C0DE1.6020903@...515...>
Date: Fri, 06 Aug 2010 16:28:01 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010806080706030702060607"
Subject: [Openvpn-devel] Summary of the IRC meeting (5th Aug 2010)
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
--------------010806080706030702060607
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 5th Aug 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-08-05>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed things which are blocking the release of first OpenVPN 2.2 beta:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-08-05>
<https://community.openvpn.net/openvpn/report/13>

Agreed that none of the Trac tickets are severe enough to block the
release. Decided to release beta 2.2 next Friday (13th August) along
with the Trac wiki/bug tracker (community.openvpn.net) and the new
forums (forums.openvpn.net). Decided to proceed as follows:

Mattock a.k.a. Samuli will
- edit openvpn.net website and add links to forums, trac and new downloads
- provide some very basic beta2.2 packages (tar.gz, zip and perhaps
debian/ubuntu packages)
- configure Apache on build.openvpn.net to distribute the new downloads
(which buildbot creates)
- make minor modifications to forums and migrate the ovpnforum.com user
accounts to LDAP
- send announcements about the releases to mailing lists and forums

Mattock will send announcements to the guys at company so that they can
 take care of twitter and openvpn.net web site announcements.

Jamesyonan will provide the Windows client + signed TAP driver binaries
for the first beta 2.2 release until cross-compilation on Linux works
and builds (using a precompiled TAP driver) can be automated.

Ecrist will update phpbb, dump the latest database to new forums server
and send the user account list to mattock for LDAP migration.

Dazo will prepare the Git source code tree for beta2.2 release and merge
the few remaining patches.

--

Jamesyonan gave an ACK to dazo's "Multiple --up scripts and no error" patch:

<https://community.openvpn.net/openvpn/ticket/20>

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock







--------------010806080706030702060607
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-08-05.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-08-05.txt"

(21:02:23) jamesyonan [~jamesyona@...1321...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:02:34) mattock: hi james!
(21:02:35) jamesyonan: Hi
(21:02:44) dazo: ih!
(21:03:00) mattock: so meeting topics are here: https://community.openvpn.n=
et/openvpn/wiki/Topics-2010-08-05
(21:03:01) vpnHelper: Title: Topics-2010-08-05 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:03:28) mattock: the idea is to figure out solutions to the beta 2.2 rel=
ease showstoppers today
(21:03:50) mattock: I think the biggest issue is providing the Windows bina=
ries
(21:03:55) mattock: shall we begin with that?
(21:04:07) dazo: +1
(21:04:26) mattock: cron2: are you present?
(21:04:39) ***krzee is
(21:04:54) ***dazo knows cron2 was around earlier today
(21:05:28) jamesyonan: I can provide signed tap drivers
(21:05:49) mattock: jamesyonan: that would be great!
(21:05:56) krzee: whoa, i thought that costs a bunch of $ to do
(21:06:06) mattock: so if I understood correctly, cross-compiling Windows c=
lient is possible
(21:06:22) mattock: but signing the drivers is only possible in Windows
(21:06:53) mattock: dazo: any ideas how many times we might have to change =
(=3Dresign) the TAP driver?
(21:06:56) jamesyonan: I can sign the TAP drivers with OpenVPN Tech sig. --=
 that's no problem
(21:07:10) dazo: but the windows building, doesn't that wrap driver + openv=
pn binary + configs + installer into one binary?
(21:07:12) krzee: ahh coolness
(21:07:21) jamesyonan: the tap driver changes very rarely
(21:07:48) mattock: I was just wondering if we could automatically build Op=
enVPN for Windows and just use the one and same TAP driver?
(21:07:50) dazo: Unless some nasty bugs related to the IPv6 stuff cron2 has=
 added to the driver, I don't expect anything particular
(21:08:09) mattock: automatically using buildbot, that is
(21:08:19) mattock: or does the build process try to build the TAP driver t=
oo?
(21:08:20) ***cron2 is hee
(21:08:25) mattock: cron2: hi!
(21:08:36) cron2: mattock: the build process (on windows) builds the TAP dr=
iver
(21:08:48) dazo: we might be able to do that ... but by having the installe=
r signed as well, you might avoid other Windows warnings as well ... but th=
at's more important for beta, rc and full releases, not allmerged stuff
(21:09:20) mattock: dazo: good point, with "allmerged" signing everything i=
s not as important
(21:09:48) dazo: cron2:  but it's possible to hack the windows build to wor=
k as a cross-build, just wrapping in the already built and signed TAP drive=
rs?
(21:10:05) mattock: jamesyonan: does windows (vista/7) complain if the TAP =
driver is signed, but the OpenVPN installer (or binary) is not?=20
(21:10:20) cron2: dazo: dunno how the "take all the bits and build an insta=
ller from there" can be done on linux
(21:10:58) dazo: cron2:  afaik, the installer is NSIS based ... and there's=
 makensis for Fedora at least, which builds a windows binary
(21:11:22) jamesyonan: mattock: it will complain when you initially run the=
 installer, and then when you install the driver, it will ask if you want t=
o trust software from OpenVPN Tech.
(21:11:33) mattock: ok
(21:12:00) mattock: so reusing the signed TAP driver is possible... and the=
 rest of the build could be automated cross-compilation on Linux=20
(21:12:10) jamesyonan: yes
(21:12:14) cron2: cool
(21:12:18) mattock: is this supported out-of-the-box?
(21:12:24) mattock: =3Dwithout hacking the build scripts
(21:12:30) mattock: or makefiles
(21:12:41) ***dazo doubts that
(21:13:01) jamesyonan: yeah, I think the build scripts allow you to provide=
 precompiled drivers
(21:13:09) mattock: great!
(21:13:26) cron2: it's supported to use precompiled stuff, but I don't thin=
k that the scripts "as of today" support nsis building on linux
(21:13:32) cron2: but that should not be THAT hard
(21:13:50) dazo: basically:  $ makensis openvpn.nsis
(21:14:10) mattock: cron2: do you feel like digging into this? I got whole =
farm of VM's to buildbotify...
(21:14:17) jamesyonan: in install-win32/maketap see the comment:
(21:14:19) jamesyonan: # $DRVBINSRC, if defined, points to prebuilt TAP dri=
ver and
(21:14:19) jamesyonan: # tapinstall.exe.
(21:14:35) cron2: mattock: I'm still busy with the testing stuff
(21:14:39) mattock: cron2: ok
(21:15:25) mattock: jamesyonan: could you build the OpenVPN client (+signed=
 TAP drivers) for Windows say, every week or fortnight?
(21:15:45) mattock: at least initially, until the the cross-compilation stu=
ff is working properly
(21:16:12) mattock: then we can automate it
(21:16:29) d303k [~heiko@...1393...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:16:56) jamesyonan: yeah, I can do that, but sometimes my latency is not=
 very good
(21:17:00) cron2: we noticed :) *duck&run*
(21:17:04) mattock: :)
(21:17:27) mattock: even providing the initial build would help
(21:17:39) cron2: yep
(21:17:46) mattock: first beta release, that is
(21:18:08) mattock: speaking of which... dazo: what's the progress with the=
 remaining bugs?
(21:18:15) mattock: #18 and #20
(21:18:23) d303k: hi btw
(21:18:43) dazo: Ticket #20 still needs an official ACK
(21:19:02) dazo: Ticket #18 needs to come in the next beta release, I've no=
t had time to poke into that yet
(21:19:39) ***cron2 pokes krzee regarding the OpenBSD patch
(21:19:39) mattock: is this the correct list of unfixed issues: https://com=
munity.openvpn.net/openvpn/query?status=3Dassigned&status=3Dnew&status=3Dac=
cepted&status=3Dreopened&group=3Dstatus&milestone=3Dbeta+2.2
(21:19:40) vpnHelper: Title: Custom Query =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenV=
PN (at community.openvpn.net)
(21:20:07) dazo: mattock:  yes
(21:20:33) krzee: cron2, dont have my laptop with me today, but it looks li=
ke i wont be working 13+ hour days much more
(21:20:50) krzee: and tuesday i go on vacation, so then it will be way easi=
er too
(21:20:51) mattock: seem like relatively minor issues... except the build f=
ailure on OpenVPN
(21:20:52) dazo: The assigned ones are actually also needing ACKs ... I hav=
e my hands on #5 as well, not had time to test out the patch on an older Op=
enSSL lib yet
(21:21:49) dazo: #31 is accepted, and will be merged in today
(21:22:10) dazo: #30 is non-critical
(21:22:57) jamesyonan: #20 looks good.  It might be better to functionize t=
he warning, e.g. multiple_script_warning("tls-verify")
(21:23:30) jamesyonan: this saves space for the platforms where every byte =
counts (like OpenWRT)
(21:24:25) dazo: ahh ... I didn't think about byte-saving ... I just though=
t the practical code-wise benefit would be too small
(21:24:39) mattock: is the "build failure on OpenBSD 4.7  IFF_MULTICAST" a =
showstopper?
(21:24:59) cron2: no
(21:25:42) dazo: that is not a regression as far as I've understood
(21:25:53) cron2: (this was for mattock - I'd like to see it ACKed and incl=
uded, but that's mainly "me wanting to close an open end")
(21:26:22) cron2: dazo: well, it's broken, and needs fixing :) - but OpenBS=
D and NetBSD are certainly not our mainstream targets
(21:26:42) mattock: so building on OpenVPN and NetBSD fails every single ti=
me? Or only with some configuration options?
(21:26:49) cron2: mattock: always
(21:26:53) dazo: yeah, agreed ... if it had been a regression, I'd be leani=
ng more towards a blocker bug ... but it's not
(21:27:07) cron2: a system header file (net/if.h) is not properly detected =
and so tun.c cannot compile
(21:27:23) mattock: ecrist: doesn't OpenBSD have a openvpn-devel port?
(21:27:25) jamesyonan: byte-saving is usually a non-issue, except for platf=
orms like OpenWRT where the whole linux distro + apps must fit in 4MB.
(21:27:46) dazo: jamesyonan:  agreed ... I can fix that
(21:27:48) ecrist: mattock: no idea, afaik, they use the freebsd ports tree
(21:28:08) mattock: but the openvpn builds on OpenBSD, even if FreeBSD port=
s tree is used
(21:28:08) krzee: ecrist, openbsd has their own patches as well
(21:28:15) ecrist: but, I don't test for or config for net/open
(21:28:24) mattock: I was just wondering if OpenBSD guys had already fixed =
this issue
(21:28:31) krzee: they did
(21:28:56) krzee: i forget who, but someone here IS the openbsd guy
(21:29:15) krzee: aka, manages their patches and stuff
(21:29:23) mattock: krzee: interesting...
(21:29:38) mattock: so OpenBSD guys are lurking here
(21:29:39) mattock: :)
(21:29:47) krzee: if anyone cares to dig through the log of this channel fr=
om when i brought up the bug, he spoke up about it
(21:29:52) mattock: anyways, so we have no real showstoppers
(21:30:06) mattock: when is the release date for first beta 2.2?
(21:31:23) mattock: or rather, what day shall we set as the release date
(21:31:36) cron2: mattock: no, the openbsd port is not building
(21:31:44) mattock: cron2: ok
(21:31:59) ecrist: dazo - has beta 2.2 been tagged yet?
(21:32:06) dazo: nope, not yet
(21:32:23) dazo: it will be tagged when we're announcing the first beta rel=
ease
(21:32:51) ecrist: :(  would be nice to get a jump on it...
(21:33:02) cron2: ecrist: just checkout beta2.2
(21:33:09) cron2: it has been branched, just not tagged
(21:33:19) ecrist: oh, semantics
(21:33:25) mattock: :D
(21:33:44) cron2: ecrist: well, the branch is still changing, and a tag wou=
ld freeze a certain source set at "day X"
(21:33:47) ecrist: I'll start work on the openvpn-beta freebsd port, then.
(21:34:02) dazo: ahh ... yeah, the branch is there :)
(21:34:05) mattock: ecrist: sounds good
(21:34:09) ecrist: and I'll make available a tarball soon.
(21:34:32) ecrist: after it's announced
(21:34:46) mattock: is releasing beta 2.2 officially within a week realisti=
c?
(21:35:02) mattock: original plan was to release it on August 1st
(21:35:48) dazo: it should be ... even though, I have packed weekend, but m=
ight get some hacking time on Sunday evening again
(21:36:43) mattock: dazo: I'm in no hurry, forum release date is closing in=
 fast... :)
(21:37:12) dazo: maybe a joint release could give a better effect?
(21:37:23) ***dazo is just thinking from a PR point of view
(21:37:33) mattock: hmm... why not... it's August _Friday_ 13th, after all
(21:37:41) dazo: heh :-P
(21:37:53) mattock: perhaps I should officially announce the Wiki at that d=
ay, too
(21:37:55) mattock: :)
(21:37:58) cron2: heh
(21:38:08) mattock: no risk, no fun
(21:38:22) d303k: perfrect fit as ovpn is kind of a swiss chainsaw =3D)
(21:38:41) mattock: actually, a joint Trac/beta 2.2 release makes sense, so=
 that people know where to file bugs
(21:38:49) dazo: yeah
(21:38:57) dazo: and!  then we need to close the sf.net tracker!
(21:38:57) mattock: and where to ask for help (forums)
(21:39:02) mattock: dazo: agreed
(21:39:13) mattock: that's easy, but is there anything worth migrating ther=
e?
(21:39:23) ecrist: mattock: on the subject of forums, a notice was posted, =
and I've disabled new user registrations on the current forum.
(21:39:29) mattock: ecrist: great!
(21:39:35) mattock: then we're all set
(21:40:15) ecrist: I need to do the upgrade to the current forum, and I'll =
ship the DB over to forums. and pull a user list for you
(21:40:25) ecrist: that'll give you a little over a week to convert and imp=
ort to ldap
(21:40:53) ecrist: friday morning, then, I'll copy the db one last time
(21:41:14) mattock: ecrist: thanks!
(21:41:58) mattock: ok, so the plan is to release/announce everything (beta=
 2.2/forums/trac) simultaneously
(21:42:07) mattock: risky, but probably fun
(21:42:33) mattock: and August 13th is ok for everybody?
(21:43:00) d303k: i'll do an announcement for the gui alpha then too =3D)
(21:43:09) mattock: d303k: sounds like a plan :D
(21:43:52) dazo: jamesyonan:  Something like this?  http://pastebin.com/g74=
CDviK
(21:44:07) ecrist: when will the beta be 'ready' so I can submit to ports t=
ree?
(21:44:13) dazo: mattock:  sounds like a plan :)
(21:44:53) dazo: ecrist:  I'll have that ready latest a couple of days befo=
re ... or even earlier if I see no late minute changes will go into the bet=
a branch
(21:45:10) jamesyonan: dazo: yeah that looks great
(21:45:23) mattock: jamesyonan: can you provide the first Windows client bi=
nary + TAP driver before next Friday?
(21:45:27) dazo: jamesyonan:  I'll take that as an ACK then ... and I'll co=
mmit it directly
(21:45:56) cron2: dazo: that looks indeed very nice
(21:46:11) jamesyonan: any changes to the build system between 2.1 and 2.2?
(21:46:24) jamesyonan: i.e. Windows build system
(21:46:42) mattock: ok, announcing the releases is a non-issue... the guys =
at the company promised to take care of that
(21:46:59) mattock: and I can do the forums/mailinglist stuff
(21:46:59) dazo: cron2:  ^^^ you might know most here, as you've done most =
hacking on the windows side=20
(21:47:03) cron2: jamesyonan: nothing fundamental.  version numbers / relea=
se date for the tap driver
(21:47:59) cron2: (in install-win32/settings.in)
(21:48:09) cron2: but no new files, changed scripts, anything of that sort
(21:48:38) dazo: I believe we have managed to separate out all the windows =
changes to the feat_ipv6_wintap branch
(21:50:04) jamesyonan: sure, I can do the build.  Which source tree?  testi=
ng?
(21:50:11) dazo: yeah
(21:50:18) dazo: it would be from the beta2.2 branch
(21:50:39) dazo: (or rather, a tag ... v2.2-beta-1
(21:50:42) dazo: )
(21:51:55) jamesyonan: what is the syntax to check it out?
(21:52:14) mattock: I assume something along these lines: https://community=
.openvpn.net/openvpn/wiki/TesterDocumentation
(21:52:16) vpnHelper: Title: TesterDocumentation =EF=BF=BD=EF=BF=BD=EF=BF=
=BD OpenVPN (at community.openvpn.net)
(21:52:18) dazo: jamesyonan:  git checkout -b beta2.2 origin/beta2.2=20=20
(21:52:29) mattock: replacing "allmerged" with something else
(21:52:31) mattock: dazo?
(21:53:00) dazo: (git checkout -b <local branch name> <remote branch name> =
 =3D=3D checkout <remote branch name> as <local branch name> on my box)
(21:53:14) dazo: dazo:  yeah, basically
(21:54:24) mattock: ok, so after cloning the repository, you can do a "git =
branch -la" to list all branches=20
(21:55:03) dazo: yupp
(21:55:50) mattock: oh, blindly following instructions was not a good idea =
:)
(21:56:01) mattock: tried to rebase against origin...
(21:56:35) mattock: I'll try again
(21:58:28) mattock: dazo: so if a branch is selected (as shown in "git bran=
ch"), that branch will be built
(21:58:29) mattock: right?
(21:58:32) mattock: nothing else is required
(21:58:37) dazo: yes
(21:58:41) cron2: yes, the branch with the "*"
(21:58:57) mattock: ok, so full steps are these:
(21:58:59) mattock: git clone git://openvpn.git.sourceforge.net/gitroot/ope=
nvpn/openvpn-testing.git
(21:59:08) mattock: cd openvpn-testing
(21:59:17) mattock: git checkout -b beta2.2 origin/beta2.2
(21:59:20) mattock: and then just build
(21:59:30) cron2: yep
(21:59:31) mattock: needed to know that myself, too :)
(21:59:46) mattock: all the rebasing, checkouting, pulling etc. is still so=
mewhat vague to me
(21:59:52) mattock: in practice
(22:00:11) mattock: ok, the final issue for me is "where we host the beta2.=
2 downloads"
(22:00:12) ***cron2 agrees :)
(22:00:32) mattock: I suggests the plan outlined here: https://community.op=
envpn.net/openvpn/wiki/Topics-2010-08-05
(22:00:34) vpnHelper: Title: Topics-2010-08-05 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(22:00:45) mattock: host on build.openvpn.net (=3Dno copying from buildbot =
server)
(22:00:51) cron2: fine with me
(22:00:56) mattock: link to releases from openvpn.net
(22:01:02) dazo: fine with me too
(22:01:04) mattock: jamesyonan: is that ok for you?
(22:01:20) cron2: (ObNit: build.openvpn.net has no IPv6 connectivity...)
(22:01:39) dazo: (heh)
(22:02:40) jamesyonan: mattock: yeah, that's fine
(22:02:47) mattock: build.openvpn.net is hosted on SoftLayer...=20
(22:02:56) cron2: what's that?
(22:03:24) cron2: softlayer.com?
(22:03:43) mattock: jamesyonan: what are the official "announcement" channe=
ls? Twitter, website, mailing lists... anything else I should know of?
(22:03:54) mattock: cron2: yep
(22:04:17) cron2: mattock: the start page (www.softlayer.com) lists "IPv6" =
under the "network" title...
(22:04:52) cron2: well, it just did, but the start page keeps changing
(22:05:04) jamesyonan: mattock: yes, usually we announce to openvpn mailing=
 lists (including openvpn-announce) and post something on website
(22:05:26) mattock: cron2: yes, saw that... so there is ipv6 support somewh=
ere
(22:05:43) mattock: I'll check what's up with it
(22:05:45) cron2: www.softlayer.com has IPv6 address 2607:f0d0:1000:11:1::1
(22:05:50) cron2: "they have it" :)
(22:05:58) cron2: thanks
(22:06:47) mattock: I'll see how it can be activate... I assume using some =
server console / self-service web interface
(22:07:07) mattock: is there anything else on Beta 2.2 release?
(22:07:13) mattock: it's going to be a busy week for me
(22:07:14) mattock: :)
(22:09:00) ***dazo got nothing more now
(22:09:06) mattock: so the plan as I see it:
(22:09:27) mattock: I will take care of editing openvpn.net website (links =
to forums, trac and new downloads)
(22:09:50) mattock: I will take care of providing some very basic beta2.2 p=
ackages (tar.gz, zip and perhaps debian/ubuntu packages)=20
(22:10:33) mattock: jamesyonan will provide the Windows client + signed TAP=
 driver binaries for the first beta 2.2 release (until build automation is =
in place)
(22:10:50) mattock: I will setup build.openvpn.net to serve the downloads (=
e.g. using Apache)
(22:11:33) mattock: I will make minor modifications to forums and migrate t=
heir user accounts to LDAP
(22:11:58) dazo: sounds good
(22:11:59) mattock: ecrist will update phpbb, dump the latest database and =
send the user account list to me
(22:12:40) krzee: [11:36]  <cron2> mattock: no, the openbsd port is not bui=
lding
(22:12:41) mattock: I'll send the announcements to mailing lists (and forum=
s?)
(22:12:43) krzee: that is not true
(22:12:53) krzee: openvpn from openbsd ports does build
(22:13:13) mattock: and somebody in the company (andrew, patel) will take c=
are of twitter + openvpn.net web site announcements
(22:13:18) d303k ha abbandonato il canale (quit: Ping timeout: 265 seconds).
(22:13:22) mattock: I guess that's it...
(22:13:25) mattock: (hopefully) :)
(22:13:35) cron2: krzee: it does?
(22:13:42) cron2: last time you said it doesn't
(22:13:54) krzee: the port
(22:14:03) krzee: the src does not, the port does
(22:14:19) cron2: last time you said the port doesn't build either (with so=
me other error)
(22:15:22) krzee: iirc it didnt for my friend, but it did for me (and he wa=
s a version of obsd prior, i was on latest)
(22:15:44) mattock: krzee: are you talking about the "openvpn" port as on t=
his page: http://openports.se/net
(22:15:47) vpnHelper: Title: OpenPorts.se | The OpenBSD package collection =
(at openports.se)
(22:16:00) cron2: krzee: that could explain things, yes
(22:16:30) krzee: mattock, i believe thats a yes
(22:16:46) mattock: so there's no "openvpn-devel" port for OpenBSD?
(22:17:40) krzee: looks like there isnt, but that shouldnt matter much anyw=
ays
(22:17:48) mattock: ok
(22:18:12) krzee: since afaik the devel branch is for getting a wider audie=
nce to test stuff
(22:18:21) krzee: and openbsd isnt exactly a wide audience
(22:19:02) mattock: fkr is the "OpenBSD guy" :)
(22:19:10) mattock: check the changelog: http://openports.se/net/openvpn
(22:19:11) vpnHelper: Title: OpenPorts.se | The OpenBSD package collection =
(at openports.se)
(22:19:21) dazo: that is correct -devel is just to make it easier for peopl=
e to test out bleeding edge stuff
(22:19:35) krzee: ahh right
(22:20:00) mattock: ok, are we done for today?
(22:20:15) krzee: maybe we should be trying to get fkr to ack that openbsd =
patch then
(22:20:23) krzee: since he likely has more access to openbsd
(22:20:25) mattock: krzee: good idea
(22:20:45) ***cron2 doesn't really care *who* does the ACK, but fkr seems t=
o be somewhat busy...
(22:21:04) krzee: i bet hes less busy than ive been ;)
(22:21:34) dazo: the patch needs to be tested, as it is a compile fix - the=
 test is easy ... does it compile or not. ... If it compiles, then it's an =
ACK
(22:21:52) mattock: perhaps somebody could mail him:  fkr+AT+openbsd.org
(22:22:39) krzee: either way i should be able to finally do it very soon
(22:22:49) mattock: I guess the meeting is slowly fading away... :)
(22:23:27) mattock: perhaps fkr would be interested in providing an OpenBSD=
 buildslave, too
(22:24:22) krzee: good call
(22:25:16) mattock: I think Felix (fkr) is pretty active on -users or -deve=
l, too
(22:25:28) mattock: I can contact him about the openbsd buildslave
(22:26:29) mattock: ok, I'll leave now as you guys are so passive :D
(22:26:45) dazo: heh :)
(22:26:49) mattock: bye!
(22:27:01) dazo: see y'all!
(22:27:05) mattock: see you!
(22:27:06) cron2: n8 all :)

--------------010806080706030702060607--

