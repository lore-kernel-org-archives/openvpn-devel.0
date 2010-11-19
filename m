Message-ID: <4CE63DD9.60804@...515...>
Date: Fri, 19 Nov 2010 11:05:29 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040105060904000706020809"
Subject: [Openvpn-devel] Summary of the IRC meeting (18th Nov 2010)
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
--------------040105060904000706020809
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 18th Nov 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-11-18>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed next 2.2 release, which will include quite a few bugfixes and
few small new features compared to 2.2-beta3: see the attached changelog
for details. Because of the new features it was agreed that a new beta
is needed, even though no 2.2-beta3 -specific issues have been reported
so far. Decided to release 2.2-beta4 next week.

Discussed the "Dynamic iroute patch" which had been discussed in an
earlier meeting:

<http://thread.gmane.org/gmane.network.openvpn.devel/4059>
<http://thread.gmane.org/gmane.network.openvpn.devel/4080>

Decided to not include the patch in Git as it's author would not have
time maintain it.

Discussed the "MacOSX Keychain Certificate support" patch:

<https://community.openvpn.net/openvpn/ticket/8>

The patch itself has been ready for inclusion into Git for a long time,
but nobody has reported if works. Ecrist agreed to test the patch.
Mattock promised to advertise the patch on the "tunnelblick-discuss"
group to get more testers.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------040105060904000706020809
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-11-18.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-11-18.txt"

(20:08:30) mattock: ok, which topic first?
(20:08:42) mattock: security issue may have to wait until James arrives
(20:08:45) mattock: issues
(20:08:47) dazo: agreed
(20:09:25) dazo: OpenVPN-2.2-beta4?
(20:09:45) mattock: my thoughts exactly
(20:10:10) mattock: have there been any issues with beta3 specifically?
(20:10:43) mattock: to me it seems way too stable for a beta
(20:10:43) dazo: I have not noticed anything particular ... ecrist / krzee =
 have you heard anything?
(20:11:04) dazo: hence my question if a RC round is needed for this release
(20:11:28) ecrist: nothing at all.
(20:11:30) dazo: I'm running 2.2-beta3 on a server and a client ... 24/7 op=
erations, without any issues
(20:11:34) mattock: I don't think we need an RC if nobody has reported beta=
3 -specific problems
(20:11:39) ecrist: I'm running beta3 in a fairly simple vpn without issues.
(20:11:45) ecrist: only as a client, though, not as a server.
(20:12:24) dazo: I'm having a TAP setup, with the eurephia plug-in on the s=
erver side ... and it servers both 2.1 and the 2.2-beta client
(20:14:05) mattock: perhaps the changes between 2.1.x and 2.2-beta3 have be=
en too modest to introduce any serious issues
(20:14:25) mattock: dazo: what changes you think would go to beta4?
(20:14:38) ***dazo is looking at that right now :)
(20:15:07) ecrist: is there a draft release-notes somewhere for 2.2?
(20:15:29) dazo: nope, but that's a really good idea to have!
(20:15:37) mattock: if there are new features queued then perhaps one more =
beta followed quickly by a RC would make sense
(20:15:44) mattock: dazo: agreed
(20:16:04) mattock: or instead of RC the official 2.2 release
(20:17:25) dazo: maybe, we could just release RC1 now instead ... as the be=
ta has been so stable
(20:17:42) ecrist: imho, once you go RC, you stop adding features.
(20:17:59) ecrist: so, if you want to add features, go beta4
(20:18:02) mattock: ecrist: I was about to mention that...=20
(20:18:19) mattock: dazo: is beta4 going to get anything that would classif=
y as a "new feature"?
(20:18:23) mattock: instead of bugfix
(20:18:34) dazo: I'm posting the changes shortly now
(20:19:47) dazo: http://www.fpaste.org/1b9a/
(20:20:26) dazo: I think the gap is somewhat smaller, I think I might have =
taken the wrong "starting commit" from what I see now
(20:21:11) dazo: There are a few new features, but mostly fixes
(20:21:38) mattock: so this is beta3 -> beta4?
(20:21:50) dazo: probably then
(20:22:50) mattock: I would go for a new beta... and if that's stable, then=
 make an official release right after that
(20:23:06) dazo: I'll double check the changelog better .... as the bugfix2=
.1 and feat_misc branches are a bit fuzzy due to some nasty merges, this lo=
g is a bit misguiding ... I see several things (new features) now which has=
 been included in beta3 already
(20:23:07) mattock: just to follow the normal alpha-beta-rc conventions
(20:23:17) dazo: ack
(20:23:39) dazo: let's go that path .... the only reason for RC, is that mo=
re people might be willing to jump on the test-wagon
(20:24:12) mattock: yeah, that might be true
(20:24:51) mattock: btw. do we know how quickly *NIX distributions start di=
stributing our latest releases?
(20:24:53) dazo: but if I discover when going more carefully through it, th=
at it's only bugfixes ... we can have a talk about it?
(20:25:03) mattock: yeah
(20:25:17) ecrist: mattock: FreeBSD ports distributes same-day
(20:25:18) ecrist: ;)
(20:25:49) mattock: gentoo is still on 2.1.3
(20:26:01) dazo: Fedora + Fedora EPEL might take a couple of weeks for a re=
lease - depends on how quick the package maintainers are.  For RHEL5/RHEL6 =
it won't be upgraded, they will rather backport fixes primarily
(20:26:22) mattock: ubuntu is 2.1.0
(20:26:38) dazo: (but users who uses Fedora EPEL on RHEL/CentOS will get a =
newer version)
(20:26:55) dazo: openvpn-2.1.1-2.fc12.x86_64
(20:26:56) mattock: arch is on 2.1.3
(20:27:03) mattock: pretty conservative guys :)
(20:27:25) mattock: debian is 2.1.3 also
(20:27:38) mattock: god damn, only freebsd guys are crazy enough to use lat=
est versions :)
(20:27:40) dazo: well, for *NIX, it's been little need for updating it ... =
as most issues lately have been Windows related
(20:27:58) mattock: true, but they dare not upgrade to our betas :)
(20:28:27) dazo: nope :)
(20:28:52) mattock: dazo: what if you check if there are any significant ne=
w features and if not, let's do one RC and then a real release
(20:29:05) mattock: what's the timeline for the final release?
(20:29:13) dazo: yupp ... that sounds reasonable
(20:29:14) agi: actually debian is 2.1.4 (or 2.1.3 + patch) :)
(20:29:14) mattock: a Christmas release?
(20:29:18) ecrist: mostly, freebsd is updated so quickly becuase I'm active=
 here
(20:29:30) ecrist: m-a is also pretty on top of things for the -release
(20:29:44) dazo: mattock:  how's the download stats for beta3?
(20:29:47) mattock: agi: oh, packages.debian.org told me lies=20
(20:29:55) mattock: or I misread it
(20:29:59) mattock: dazo: just a sec
(20:30:20) agi: mattock: no, it says 2.1.3, and it's 2.1.3. but with 2.1.4 =
patch
(20:30:47) ecrist: which is really 2.1.2 with 2.1.4 patch. :)
(20:30:53) agi: heh
(20:32:50) dazo: yeah
(20:36:48) dazo: the gap is really much smaller
(20:38:58) dazo: http://www.fpaste.org/GoU2/
(20:39:05) dazo: this looks much more like the real gap
(20:39:25) dazo: the first attempt used the wrong commit ID from a merge
(20:39:40) dazo: in addition, some changes from feat_misc will be added
(20:40:44) dazo: http://www.fpaste.org/gmpW/
(20:40:54) ***dazo got dinner guests in 20 minutes
(20:41:45) mattock: sorry, something came up
(20:44:47) mattock: argh, can't get stats out right now
(20:45:44) mattock: so, a few minor features
(20:46:24) mattock: dazo: when would we make the next release? whether beta=
 or rc
(20:46:50) dazo: I think I can get ready for that during the weekend
(20:47:11) dazo: unless there are something among our open tickets we want =
to have included
(20:47:39) mattock: what if we stick to the "no new features in a RC" style=
 and make a new beta
(20:47:45) dazo: but I presume not ... https://community.openvpn.net/openvp=
n/report/13
(20:47:48) vpnHelper: Title: OpenVPN 2.2 Beta tickets =EF=BF=BD=EF=BF=BD=EF=
=BF=BD OpenVPN Community (at community.openvpn.net)
(20:48:06) dazo: okidok!  Let's do that then
(20:48:12) mattock: ok
(20:48:20) mattock: running out of time so let's see...
(20:48:39) mattock: maybe dynamic iroute? any developments there?
(20:48:56) dazo: well, I'm kind of lost on where that one stranded ...
(20:49:25) mattock: I think it kind of stalled when Sven-Ola didn't want to=
 maintain his patch
(20:49:41) mattock: he said he just wanted to get it out there
(20:49:50) dazo: ahh ... that's what I thought, but didn't find any referen=
ces to it
(20:50:24) mattock: there probably are no references, it was a private resp=
onse from him and I probably just mentioned it here
(20:50:33) dazo: mattock:  would you mind updating the ticket saying NAK as=
 we don't have resources to maintain this new feature too easily right now =
... without a committed maintainer
(20:50:39) mattock: ok, I'll do that
(20:51:13) dazo: we can always repoen this one if someone stands up and cla=
ims some responsibility for this
(20:51:18) mattock: the OSX keychain patch probably was left without an ACK
(20:51:24) mattock: or testers
(20:51:28) dazo: the latter
(20:52:07) mattock: so probably no need to modify the ticket at this point
(20:52:17) mattock: I fear this will never make it to the core
(20:53:29) mattock: the rest of the topics would require devs
(20:54:04) mattock: it seems James is not coming, so perhaps we should call=
 this a day
(20:54:05) mattock: ?
(20:54:06) dazo: If we can get ecrist / krzee or JJK to test this OSX patch=
 on their Macs ... I'm willing to carry this one in, as it is pretty much i=
solated and cleanly written
(20:54:19) dazo: (even with proper #ifdef's to disable this feature)
(20:54:37) mattock: dazo: good idea... actually we could ask for testers on=
 forums and -users
(20:54:41) ecrist: i'm more than happy to test if someone wants to point me=
 to the ticket
(20:54:46) mattock: people have probably just forgotten it
(20:54:51) mattock: https://community.openvpn.net/openvpn/ticket/8
(20:54:53) vpnHelper: Title: #8 (MacOSX Keychain Certificate support) =EF=
=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(20:54:55) dazo: ecrist:  http://thread.gmane.org/gmane.network.openvpn.dev=
el/3631 ... it's this patch
(20:54:57) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:55:18) ***ecrist reads
(20:55:44) dazo: actually the updated patch on May 1st from Brian
(20:57:27) mattock: it seems everything went well with the patch except for=
 the testers
(20:57:59) ecrist: I'll look at that in the next couple days more thoroughly
(20:58:10) dazo: exactly, and that's why I'm really finding it a pity to lo=
ose this one ... this feature is for sure useful on OSX ... and the guy beh=
ind it was willing to get involved
(20:59:20) ecrist: it looks like a neat feature.
(20:59:26) mattock: hmm, I wonder if this works with Tunnelblick...
(20:59:45) mattock: those guys would be definitely interested
(20:59:58) dazo: yeah, maybe that's the path to take here
(21:00:30) ecrist: mattock: I'm going to test it with tunnelblick
(21:00:36) mattock: ecrist: ok
(21:00:43) ecrist: tunnelblick is relatively simple
(21:00:47) mattock: I'll contact the tunnelblick users if they have a forum=
 or something
(21:00:48) dazo: ecrist:  thx a lot!
(21:00:56) mattock: just to let them know about this patch
(21:00:59) ecrist: usually, tbh, when I test code, I put the new openvpn bi=
nary inside the tunnelblick package.
(21:01:56) mattock: ok, there is a Tunnelblick discussion group here: http:=
//groups.google.com/group/tunnelblick-discuss
(21:01:58) vpnHelper: Title: tunnelblick-discuss | Google Groups (at groups=
.google.com)
(21:02:01) mattock: I'll send a message there, too
(21:02:14) ***dazo need to go now
(21:02:19) mattock: dazo: have fun!
(21:02:35) dazo: okay, didn't catch too much today ... but we'll continue o=
n next meeting :)
(21:02:38) mattock: I'll write a summary tomorrow
(21:02:45) mattock: yep, new try next week
(21:02:51) mattock: we're not in a hurry
(21:03:03) dazo: and I'll get next beta ready during the weekend
(21:03:20) mattock: dazo: ok, I can make the release early next week, proba=
bly tuesday
(21:03:35) dazo: cool ... that's a goal then :)
(21:03:44) dazo: and hopefully it'll make even cron2 happy :)
(21:03:58) ***dazo vanishes
(21:04:13) mattock: I'll send a message to tunnelblick-discussion and edit =
the dynamic-iroute patch, too
(21:04:19) mattock: see you!
(21:04:24) mattock: I'll vanish too :)

--------------040105060904000706020809
Content-Type: text/plain; charset="utf-8"; name=2.2-beta4-changelog.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="2.2-beta4-changelog.txt"

David Sommerseth (10):
      Clarified --explicit-exit-notify man page entry
      Clean-up: Remove pthread and mutex locking code
      Clean-up: Remove more dead and inactive code paths
      Clean-up: Removing useless code - hash related functions
      Use stricter snprintf() formatting in socks_username_password_auth() =
(v3)
      Fix compiler warnings about not used dummy() functions
      Fixed potential misinterpretation of boolean logic
      Only add some functions when really needed
      Removed functions not being used anywhere
      Merged add_bypass_address() and add_host_route_if_nonlocal()

Gert Doering (3):
      Integrate support for TAP mode on Solaris, written by Kazuyoshi Aizaw=
a <admin2@...628...>.
      Make "topology subnet" work on Solaris
      Improved man page entry for script_type

James Yonan (5):
      Fixed initialization bug in route_list_add_default_gateway (Gert Doer=
ing).
      Implement challenge/response authentication support in client mode
      Make base64.h have the same conditional compilation expression as bas=
e64.c.
      Fixed compiling issues when using --disable-crypto
      In verify_callback, the subject var should be freed by OPENSSL_free, =
not free

Jesse Young (1):
      Remove hardcoded path to resolvconf

Lars Hupel (1):
      Add HTTP/1.1 Host header

Pierre Bourdon (1):
      Adding support for SOCKS plain text authentication

Samuli Sepp=EF=BF=BD=EF=BF=BDnen (2):
      Added check for variable CONFIGURE_DEFINES into options.c
      Added command-line option parser and an unsigned build option to buil=
d_all.py

--------------040105060904000706020809--

