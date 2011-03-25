Message-ID: <4D8CAA16.5040005@...515...>
Date: Fri, 25 Mar 2011 16:43:34 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090102010809080201020304"
Subject: [Openvpn-devel] Summary of the IRC meeting (24th Mar 2011)
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
--------------090102010809080201020304
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 24th Mar 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-03-24>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, ecrist, jamesyonan, krzee, mattock and psha were present
in this meeting.

--

Discussed OpenVPN's Debian packages. Noted that there are Debian 5 and
Ubuntu 10.04 packages for i386/amd64 architectures. This applies to
official releases, and packages are also automatically generated from
every push to the Git repo's "beta2.2" and "allmerged" branches,
provided that the build VMs (a.k.a. "buildslaves") are up. All packages
are available here:

<http://build.openvpn.net/downloads>

Mattock will create Debian 6 packaging VMs when he has some extra time.

--

Discussed the "Use \r\n as newline in log files on Windows" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4274>

Cron2 gave this patch an ACK.

--

Discussed the "Clarify default value for the --inactive option" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4536>

Cron2 gave this patch an ACK.

--

Discussed mattock's "--client-config-dir" man-page clarification patch.
Dazo gave it an ACK.

--

Discussed the possibility of having a Linux -> Windows cross-compilation
VM that could be used by (trusted) community members. Agreed that this
would be useful and relatively simple to accomplish.

--

Discussed Alon's cross-compile patch:

<http://article.gmane.org/gmane.network.openvpn.devel/4451>

Jamesyonan gave the patch an ACK.

--

Discussed the openvpnserv.exe bugs reported by Jason Haar:

<http://thread.gmane.org/gmane.network.openvpn.user/31994>

Agreed that the openvpnserv.exe should exit when there are 0 active
openvpn.exe processes. That way people could leverage on Windows service
auto-restart-after-crash capability. Mattock promised to add a Trac
ticket for this.

--

Discussed the "Kaspersky antivirus thinks OpenVPN 2.1.4 is a rootkit"
issue reported by reiffert. Mattock was unable to reproduce the problem
as Kaspersky's trial download links were broken. Mattock will retry
later. Agreed that Kaspersky should be contacted about this.

--

Dazo merged last set of patches to beta2.2 branch and tagged 2.2-RC2.
Mattock generated 2.2-RC2 release tarballs/zips and tested 2.2-RC2
Windows installer generated from the release ZIP file.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------090102010809080201020304
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-03-24.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-03-24.txt"

(19:53:46) mattock_: I'll be only semi-active until ~20.45, when I get home
(19:57:42) mattock_: topic list here: https://community.openvpn.net/openvpn=
/wiki/Topics-2011-03-24
(19:57:43) vpnHelper: Title: Topics-2011-03-24 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:03:59) psha: mattock_: so today meeting is postponed for 45 minutes?
(20:05:16) mattock_: nope, I'll try to multitask :)
(20:05:49) mattock_: dazo: can you take the lead at the beginning?
(20:05:54) dazo: sure can do
(20:06:03) mattock_: thanks!
(20:06:06) dazo: so who is here now?
(20:06:20) dazo: mattock_: can you send your trigger mail to james?
(20:07:20) mattock_: will do :)
(20:07:26) dazo: thx!
(20:07:29) psha_ [~Pavel@...1447...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:07:39) dazo: lets wait until james shows up then
(20:08:08) psha =EF=BF=BD=EF=BF=BD ora conosciuto come psha[away]
(20:08:12) psha_ =EF=BF=BD=EF=BF=BD ora conosciuto come psha
(20:08:45) psha[away]: dazo: may i ask you to ping 'psha' when debian packa=
ges will be discussed?
(20:08:59) dazo: psha[away]: sure can do!
(20:09:05) psha[away]: thx
(20:10:04) mattock_: mail sent
(20:10:25) dazo: thx!
(20:15:08) dazo: krzee: I agree with removing #openvpn-devel from #openvpn =
topic
(20:18:45) mattock_: I hope james makes it, most topics need him
(20:18:58) dazo: yeah, that's my thoughts exactly
(20:19:38) dazo: mattock_: as psha wants to discuss debian packages, I'll w=
ait for you to become ready for that
(20:21:29) mattock_: hmm, perhaps we should discuss debs now?
(20:21:45) mattock_: atm nothing important happening here
(20:22:22) mattock_: psha: there?
(20:25:06) psha[away]: yea
(20:25:43) mattock_: perhaps we could discuss deb pkgs now?
(20:25:56) psha[away]: sure. i've nothing special to say but this question =
is close to me
(20:26:50) mattock_: do you mean upstream packages? or those on build.openv=
pn.net?
(20:27:58) ***cron2_ is here but there's nothing really on the agenda I can=
 say much about
(20:28:53) mattock_: we got debian 5 and ubuntu 10.04 packages for beta2.2/=
allmerged branches and i386/amd64 architecturea
(20:28:56) mattock_: s
(20:29:38) psha[away]: yes, i've just checked that
(20:29:38) mattock_: psha: any suggestions or comments?
(20:29:45) dazo: cron2_: care to have a look at this one?  http://thread.gm=
ane.org/gmane.network.openvpn.devel/4274/focus=3D4283
(20:29:46) psha[away]: 5 is lenny
(20:29:48) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:29:50) psha[away]: is not it too old?
(20:30:20) mattock_: psha: well, squeeze was released a while back
(20:30:39) mattock_: but I suppose the packages work on it
(20:30:39) dazo: I'd say lenny should have some grace time=20
(20:31:04) psha[away]: yes, it's mostly backward compatible
(20:31:10) psha[away]: at least for packages like openvpn
(20:31:12) dazo: does dpkg contain ABI checks?  to check that the proper li=
braries and their ABI is consistent?
(20:31:50) psha[away]: dazo: it's possible to check exported symbols with d=
h_shilb[something was here]
(20:32:13) dazo: but is this done on these deb packages we produce?
(20:32:20) psha[away]: not dh_shlib, i'll find out what exactly
(20:32:23) dazo: If it is, then we might have a trap ... if not, then no wo=
rries
(20:32:34) psha[away]: don't think so - openvpn is not library so it's usel=
ess i guess
(20:32:40) mattock_: I'll start migrating to squeeze soonish and also updat=
e the packages
(20:32:49) psha[away]: mattock_: why not to build both?
(20:33:18) psha[away]: for our local packages at work we had ~5 versions: 2=
 ubuntu and 3 (testing, stable, oldstable) for debian
(20:33:29) mattock_: no reason... just dont have time to setup squeeze vms =
atm
(20:33:38) psha[away]: it's a bit overkill but 2 debian versions is not hard
(20:33:41) psha[away]: ah
(20:34:03) mattock_: the packages get built automatically by buildbot on ev=
ery commit
(20:34:18) mattock_: provided the vms (buildslaves) are up
(20:34:21) dazo: or, every push I do, to be precise
(20:34:29) mattock_: yeah
(20:34:47) psha[away]: yes, i see now
(20:35:10) dazo: are those build logs posted anywhere now? or do I still ne=
ed to check the webUI each time?
(20:36:25) psha[away]: mattock_: debian/ subdir is living outside of main r=
epo?
(20:36:26) mattock_: dazo: not yet, openvpn-builds list is available but I =
don't want to fill it with "spam" from buildbot
(20:36:48) mattock_: psha: yep
(20:36:51) dazo: okay
(20:37:10) psha[away]: mattock_: is it synced with official one?
(20:37:41) mattock_: not atm, the control files are from lenny packages
(20:38:44) mattock_: ok, going home now, be back in 20mins
(20:39:06) dazo: d12fk: mind having a look at this one as well?  http://thr=
ead.gmane.org/gmane.network.openvpn.devel/4274/focus=3D4283
(20:39:08) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:39:10) psha[away]: it seem that Alberto is actively maintainting it - l=
ast change was 22.03.2011
(20:39:29) dazo: Alberto =3D=3D agi here in this channel, iirc
(20:43:06) psha[away]: dazo: that's good :)
(20:44:08) mattock_ ha abbandonato il canale (quit: Ping timeout: 276 secon=
ds).
(20:45:23) cron2_: dazo: regarding the thread you'v epointed me to - seems =
I overlooked that in my mail heap, whatever.  But I agree with you - logfil=
es on windows should be readable for typical windows programs.  If someone =
wants to put those on a network share, and read them from unix, they are un=
typical enough that they need to work out this themselves
(20:45:48) dazo: cron2_: so I can take this as an ACK from you?
(20:45:52) cron2_: ack
(20:45:55) dazo: thx!
(20:46:07) cron2_: but I don't like the patch
(20:46:29) cron2_: open the log file in text mode
(20:46:57) cron2_: so ACK for the "fdopen( ..., "wt")" patch
(20:47:29) cron2_: and just ignore Karl Pinc - he's never sent in code, as =
far as I can see, just sending weird reasons why not to do something
(20:49:48) dazo: agreed
(20:53:46) dazo: cron2_: do you also have guts to ACK this one?  http://thr=
ead.gmane.org/gmane.network.openvpn.devel/3991
(20:53:48) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:54:30) ***dazo haven't done any particular windows development and is n=
ot confident enough to ack this one
(20:55:43) dazo: An ACK on this one would also be good: http://thread.gmane=
.org/gmane.network.openvpn.devel/4536
(20:55:44) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:56:01) dazo: (this one is a man page clarification)
(20:57:15) cron2_: dazo: regarding 3991 - no idea, but this should be somew=
hat easy to test "if someone has a working cross-build environment"
(20:57:37) dazo: yeah, based on mingw
(20:58:02) cron2_: ack 4536, sent to list
(20:58:07) dazo: thx!
(20:59:34) mattock: home sweet home
(21:01:37) mattock: it seems James is in an especially deep hole today...
(21:01:50) dazo: mm
(21:02:56) mattock: no response to my mail yet
(21:03:23) mattock: however, the good thing is that he was ok with me signi=
ng the releases in the future
(21:03:39) mattock: which would remove most of the delay
(21:04:38) mattock: cron2: you had a cross-compile environment earlier, rig=
ht?
(21:05:07) dazo: I think his cross-compile-environment is now on a broken b=
ox, iirc
(21:05:55) mattock: cron2: was the environment difficult to set up?
(21:06:36) mattock: I'm wondering if I should setup one in the future
(21:08:22) dazo: could probably be good to have ... however, that environme=
nt could be on a Linux box
(21:08:28) mattock: andrew told me james is uber-busy
(21:08:37) dazo: what's happening nowadays?
(21:08:42) cron2_: mattock: I had a cross-compile environment, wasn't that =
hard - the tricky bit was to pick the right openssl version, as all pre 1.0=
 don't really want to be cross-compiled
(21:09:06) cron2_: the machine is still around, but haven't looked at the t=
ree in 9 months, so stuff might have bit-rotted
(21:09:32) mattock: cron2: ok, then I think setting up a (public) cross-com=
pile box would be nice
(21:09:46) mattock: or semi-public rather, similarly to all community servi=
ces
(21:09:54) mattock: e.g. the WinXP build VM
(21:10:54) dazo: mattock: I don't know about Debian, but Fedora ships mingw=
 cross compiler, to build windows binaries ... I even think the needed extr=
a libs for a cross compile is available too
(21:11:14) mattock: I would guess debian has them too
(21:11:22) cron2_: I think debian has them as well
(21:11:38) cron2_: gentoo has crossdev to build what you need, on demand :)
(21:11:40) mattock: I'd prefer debian to avoid extra puppet configuration c=
omplexity
(21:11:58) mattock: "what's not in debian is not needed" :P
(21:12:02) dazo: That would be easier for us to work with ... compared to i=
nstalling mingw environment on windows
(21:12:05) dazo: lol
(21:12:20) dazo: My variant is: What's not possible to do on the command li=
ne is not worth doing
(21:12:21) mattock: dazo: what about the man-page patch I drafted yesterday?
(21:12:38) dazo: mattock: huh ... I might have forgotten, if I have seen it
(21:12:43) krzee: dazo, im right there with ya!
(21:12:53) mattock: ok, lemme copy-and-paste
(21:13:41) mattock: http://pastebin.com/nTeHWU25
(21:13:53) cron2_: dazo: LOTS easier than anything-on-windows
(21:14:00) krzee: mattock, btw i know a unix admin / puppet ninja at apple =
very well, if you get stuck in puppet he may be able to advise
(21:14:46) dazo: mattock: ACK
(21:14:49) mattock: krzee: ok, so far I've managed to solve everything
(21:14:53) dazo: mattock: send it over, and I'll add it now
(21:14:54) krzee: cool
(21:15:05) mattock: dazo: will do
(21:15:12) dazo: krzee: we have our own puppet ninja ;-)
(21:15:26) krzee: master of puppets!
(21:15:30) dazo: lol
(21:17:37) mattock: dazo: mail away!
(21:17:44) dazo: thx!
(21:17:57) mattock: krzee: puppet is fun, too bad I get to play it with so =
little :)
(21:20:55) mattock: if I had to speculate, I'd say James won't make it today
(21:21:29) mattock: do we have anything left that doesn't require james?=20
(21:21:30) ***krzee grabs mattock's arm and forces him to speculate
(21:21:34) krzee: lol
(21:21:54) mattock: krzee: "I'm pretty sure James won't make it today"
(21:21:55) mattock: :D
(21:22:03) krzee: ;]
(21:22:51) mattock: if he visits this channel could you guys point him to t=
he topic list anyways?
(21:23:19) psha ha abbandonato il canale (quit: Quit: AndroidIrc Disconnect=
ing).
(21:23:28) psha[away] =EF=BF=BD=EF=BF=BD ora conosciuto come psha
(21:23:36) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:23:37) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(21:24:10) mattock: hi jamesyonan! I lost hope ~1 minute ago, glad to have =
been proven wrong! :D=20
(21:24:10) dazo: mattock: ^^  talking about the sun :)
(21:24:24) mattock: excellent you could make it!
(21:24:31) dazo: indeed!
(21:24:46) jamesyonan: hi! -- sorry, working too late last night.
(21:24:55) mattock: jamesyonan: we got a few topics we couldn't handle ours=
elves
(21:25:01) mattock: no problem!
(21:25:17) dazo: can we do the patch first?
(21:25:21) mattock: Alon's patch: http://article.gmane.org/gmane.network.op=
envpn.devel/4451
(21:25:24) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:25:52) mattock: we're wondering if it's save to include, nobody has a f=
unctional cross-compile environment atm
(21:26:16) mattock: cron2's cross-compile box broke a while back
(21:26:18) dazo: the patch is found here: http://thread.gmane.org/gmane.net=
work.openvpn.devel/3991
(21:26:20) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:26:37) mattock: dazo: Alon said the latest patch is in the 4451 thread
(21:26:43) mattock: he sent me mail privately
(21:26:59) dazo: ahh
(21:27:08) dazo: I didn't notice the attachment
(21:28:15) dazo: grrr... it's just a diff, not a complete commit ... well, =
we'll write a commit message and put Alon as the author
(21:29:28) erika_ ha abbandonato il canale (quit: Remote host closed the co=
nnection).
(21:30:37) mattock: dazo: is that the last patch going into 2.2-RC2?
(21:30:43) jamesyonan: how much has Alon's patch been tested?
(21:30:56) dazo: only by Alon
(21:30:59) mattock: jamesyonan: probably not outside his own cross-compile =
env
(21:31:33) mattock: that's why it hasn't gotten an ACK yet, I guess
(21:31:54) mattock: is there something that could (obviously) cause problem=
s for others?
(21:32:38) jamesyonan: alon has always liked to cross-compile for a mingw w=
indows target on linux
(21:32:51) jamesyonan: so he's a kind of unusual data point
(21:33:10) mattock: what's the usual case?
(21:33:21) mattock: or has been..
(21:33:57) jamesyonan: well I think that most people are going to build for=
 windows on windows
(21:35:59) mattock: can this patch break pure *NIX builds?
(21:36:20) dazo: that shouldn't be an issue as I can see
(21:36:40) dazo: if it breaks something, it's related to those *mingw* plac=
es
(21:36:54) mattock: and mingw is for Windows building only?
(21:37:13) jamesyonan: yes, mingw for windows only
(21:37:35) jamesyonan: I'm looking at the change to acinclude.m4
(21:37:58) mattock: and this patch _could_ break mingw build on Windows, ri=
ght?
(21:39:20) dazo: potentially, but as mingw environment is closer to the *ni=
x environments, it shouldn't .... however, the acinclude.m4 changes is what=
 scares me in his patch
(21:40:58) jamesyonan: it seems like he's taken the socket_t code in acincl=
ude.m4 and making it only apply to mingw?
(21:45:13) dazo: yeah
(21:45:30) mattock: does the patch make sense to you?
(21:46:16) mattock: if not, what use cases would need testing to make sure =
it doesn't break anything?
(21:46:58) jamesyonan: the #ifdefing of #include autodefs.h seems reasonabl=
e, since the autoconf environment probably isn't going to build it
(21:47:35) jamesyonan: the CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN" s=
eems like something that mingw build on Windows might need
(21:48:07) jamesyonan: but I don't understand why the change to acinclude.m=
4 has to affect the code paths for non-mingw
(21:50:12) mattock: could we include the changes to syshead.h and tap-win32=
/common.h safely?
(21:50:16) dazo: -DWIN32_LEAN_AND_MEAN seems to be something more cross-com=
piling environments uses as well, seems pretty common ... winamp, pidgin an=
d libpurple uses it
(21:51:18) dazo: http://sourceforge.net/apps/trac/mingw-w64/wiki/winsock2.h=
%20include%20order
(21:51:21) vpnHelper: Title: winsock2.h include order =EF=BF=BD=EF=BF=BD=EF=
=BF=BD mingw-w64 (at sourceforge.net)
(21:53:15) mattock: dazo: interesting find
(21:53:45) dazo: just to solve issues with the order of #include windows.h
(21:55:14) mattock: so, what do we do?
(21:55:37) mattock: leave the patch waiting for testing
(21:55:42) mattock: or ask for clarifications
(21:55:50) ecrist: krzee: you never changed the channel topic...
(21:56:03) mattock: or include parts of the patch now and the rest later?
(21:56:16) mattock: something else: please define :)
(21:56:17) dazo: I don't like to split patches
(21:56:30) mattock: yep, might break things
(21:56:36) dazo: mm
(21:57:03) jamesyonan: yeah, I would say to wait until we can fully test it
(21:57:44) mattock: jamesyonan: which use cases should we test?
(21:57:53) mattock: mingw build on windows?
(21:59:24) jamesyonan: yes, we would need to test mingw on windows, python =
build on windows (to make sure the HAVE_CONFIG_H doesn't break it), and var=
ious unix builds to make sure that the acinclude.m4 doesn't break them
(22:00:18) mattock: ok, next topic?
(22:00:22) mattock: http://thread.gmane.org/gmane.network.openvpn.user/31994
(22:00:24) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:00:25) jamesyonan: can we get some clarification from alon on the acinc=
lude.m4 patch, i.e. why it needs to affect non-mingw code paths?  =08
(22:00:46) mattock: jamesyonan: of course
(22:01:12) mattock: jamesyonan: I guess you're the only openvpnserv.exe exp=
ert here
(22:01:18) mattock: what do you think about ^^^
(22:03:41) mattock: I think Alon summarizes the real issue
(22:05:21) jamesyonan: re: the service --he's right that the service doesn'=
t currently stop when the .exe stops.=20
(22:05:56) jamesyonan: also, the service can potentially run more than one =
openvpn config, so that somewhat complexifies the decision flow as to when =
to exit
(22:06:42) mattock: but still doable?
(22:07:41) jamesyonan: it's probably fair to just say that the service shou=
ld exit when there are 0 active openvpn.exe processes
(22:08:19) mattock: ok, let's make this a Trac task
(22:08:25) jamesyonan: and it's a good point he raises that by doing this, =
people can then leverage on Windows service auto-restart-after-crash capabi=
lity
(22:08:37) mattock: unless somebody feels like fixing this right away :)
(22:09:07) mattock: if not, then next topic would be: "Kaspersky (antivirus=
?) thinks OpenVPN 2.1.4 (and later?) is a rootkit"
(22:09:21) mattock: jamesyonan: is this a known problem?
(22:09:41) jamesyonan: haven't seen that before
(22:10:10) mattock: I tried reproducing it today, but Kaspersky's email tri=
al download links were broken
(22:10:54) mattock: still broken...
(22:11:01) jamesyonan: the problem is that if a virus writer out there incl=
udes parts of OpenVPN in his virus, the resulting virus signature to block =
it might affect OpenVPN as well
(22:11:10) mattock: I'll try to reproduce the issue later, it was reported =
by reiffert
(22:11:47) mattock: if we can reproduce this I think we should contact Kasp=
ersky
(22:11:55) jamesyonan: definitely
(22:12:12) mattock: ok, then we only have the 2.2-RC2 release
(22:12:34) mattock: jamesyonan: how shall we handle the signing issues? me =
or you?
(22:12:54) mattock: or handle signing, it's not really and issue :)
(22:13:17) jamesyonan: let me sign this one, and then going forward we will=
 get you set up for signing stuff yourself
(22:13:23) mattock: ok
(22:13:38) mattock: can you sign the TAP-driver I linked to today?
(22:14:00) mattock: in next 10 hours or so
(22:14:02) jamesyonan: yes, I can do it now
(22:14:06) mattock: excellent!
(22:14:28) mattock: do you have ~30 mins to spare? I could generate a new i=
nstaller and smoketest it
(22:14:38) mattock: then you could sign the installer and generate GPG sign=
atures
(22:14:51) dazo: mattock: that tap driver includes cron2's IPv6 patch?
(22:15:04) dazo: commit 0265cf3a6b646cc02a78cc3501dce77f99e81a5f
(22:15:05) mattock: it should, it's built from those sources
(22:15:23) dazo: from the untagged beta2.2?
(22:15:35) mattock: yep
(22:15:42) dazo: okay, then it should be fine :)
(22:16:10) mattock: dazo: is beta2.2 tree 100% ready for 2.2-RC2?
(22:16:45) dazo: yeah, it's just that Alon will probably scream out ... so =
let's mail him first, to avoid unneeded noise
(22:17:44) mattock: shall you?
(22:18:21) dazo: well, I probably don't have much to contribute in such a d=
iscussion
(22:18:47) mattock: jamesyonan: can you write a quick mail to Alon and ask =
for the clarifications?
(22:18:49) dazo: could you just summarize jamesyonan and your discussion fo=
r him, so he sees why it's on hold?
(22:19:29) jamesyonan: sure
(22:19:34) mattock: excellent!
(22:19:52) dazo: can a copy please go to openvpn-devel?
(22:19:59) mattock: good idea
(22:20:46) mattock: dazo: feel like dist-zip and dist-xz? :P
(22:21:01) mattock: tagging shouldn't make difference to those
(22:21:33) dazo: I can prepare them when I'll do the tagging ... I need to =
commit the version.m4 changes, and I like to have the tag pointing at that =
version commit
(22:24:02) mattock: ok
(22:25:07) mattock: dazo: do you still have time to do that?
(22:25:46) dazo: yeah, I'm just in the middle of a rebase of bugfix2.1 into=
 a brand new master branch, which is based on beta2.2
(22:25:53) mattock: nice!
(22:26:00) dazo: preparing the ground for the v2.3 development
(22:29:00) jamesyonan: guys, is it too late to include alon's patch -- now =
that I've looked at it more deeply, I'm thinking that it might be okay.
(22:29:44) mattock: jamesyonan: it's not too late yet
(22:29:47) mattock: does it get your ACK?
(22:30:00) jamesyonan: give me a few minutes
(22:30:05) mattock: ok, no hurry
(22:30:58) mattock: dazo: wait a moment before tagging ^^^
(22:36:58) dazo: we have time to wait :)
(22:41:00) mattock: this would be a great time for some waiting music :D
(22:41:13) mattock: or "elevator music" as we call it in Finland
(22:41:19) dazo: heh
(22:41:49) ***dazo is listening to some swinging gospel music .... and is n=
ot willing to call that "elevator music" :)
(22:42:13) mattock: definitely not
(22:42:36) mattock: maybe I'll listen to something at the other end of the =
spectrum
(22:42:39) mattock: :)
(22:42:48) dazo: heh :)
(22:45:03) jamesyonan: I just gave Alon's patch a quick run-through (unix b=
uild and windows python build) and I think it's fine
(22:45:18) mattock: thanks!
(22:45:24) mattock: I take that as an ACK
(22:45:25) dazo: cool! then I'll set "Acked-by: James Yonan" :)
(22:45:37) mattock: 2.2-RC2 is officially ready, then
(22:45:39) dazo: mattock: TAP driver should be 9.7?
(22:45:54) mattock: that's what cron2 used, check his TAP-driver commit log
(22:45:58) mattock: so I suppose it's ok
(22:46:11) dazo: sure!
(22:46:26) cron2_: I have no idea what I used, but let me check the code :)
(22:46:32) mattock: 9.7
(22:46:52) mattock: any reason to jump from 9.1 to 9.7?
(22:46:59) mattock: why not 9.2?
(22:47:00) cron2_: that wasn't me, but it should be 9.*8*
(22:47:05) mattock: oh
(22:47:29) cron2_: the tun.c source checks for "if it's before 9.7, it has =
no v6"
(22:47:40) cron2_: I think james bumped to 9.7 for 2.1, and I then bumped t=
o 9.8
(22:48:06) cron2_:         msg( M_INFO, "WARNING:  Tap-Win32 driver version=
 %d.%d does not support IPv6 in TUN mode.  IPv6 will be disabled.  Upgrade =
to Tap-Win32 9.8 (2.2-beta3 release or later) or use TAP mode to get IPv6",=
 (int) info[0], (int) info[1] );
(22:48:24) mattock: ok, 9.8
(22:48:42) dazo: okay, I'll bump it to 9,8
(22:48:59) dazo: diff --git a/version.m4 b/version.m4
(22:48:59) dazo: index 2e46645..a170b4e 100644
(22:48:59) dazo: --- a/version.m4
(22:48:59) dazo: +++ b/version.m4
(22:48:59) dazo: @@ -1,6 +1,6 @@
(22:48:59) dazo:  dnl define the OpenVPN version
(22:49:01) dazo: -define(PRODUCT_VERSION,[2.2-RC])
(22:49:02) modalit=EF=BF=BD=EF=BF=BD (+b *!~dazo@*openvpn/community/develop=
er/dazo) da vpnHelper
(22:49:02) dazo ha abbandonato il canale (Cacciato da vpnHelper: (Repeated =
flooding! You've repeatedly flooded this channel. Please come back later.)).
(22:49:15) mattock: hahaha,  a classic! :P
(22:49:19) mattock: happened to me a while back
(22:49:51) cron2_: can we de-sensify vpnHelper somewhat?  like "one screen =
full is ok"?
(22:50:47) mattock: ecrist, krzee? ^^^
(22:53:05) modalit=EF=BF=BD=EF=BF=BD (-b *!~dazo@*openvpn/community/develop=
er/dazo) da ChanServ
(22:53:11) dazo [~dazo@...1423.../community/developer/dazo] =EF=BF=BD=EF=BF=
=BD entrato nel canale.
(22:53:12) modalit=EF=BF=BD=EF=BF=BD (+o dazo) da ChanServ
(22:53:15) cron2_: welcome back
(22:53:31) mattock: huh
(22:53:48) dazo: I found chanserv being more co-operative using the right c=
ommand :)
(22:54:38) mattock: jamesyonan: actually we need to rebuilt the TAP-drivers=
 before you sign them
(22:54:44) dazo: mattock: cron2_: http://www.fpaste.org/mH5M/  ... this is =
all we need to do?
(22:54:50) mattock: due to version number (9.1 -> 9.8)
(22:54:52) dazo: to set  the right version on the TAP driver?
(22:54:56) jamesyonan: sure
(22:55:07) mattock: looks right
(22:55:31) mattock: the Python build system parses variables in version.m4 =
and uses them elsewhere (e.g. in tap-win32/*)
(22:55:40) dazo: goodie!
(22:56:30) mattock: after tagging I'll rebuilt the Win installer from tarba=
ll, do quick smoketests and check the TAP-driver version
(22:56:40) mattock: and then the drivers are ready for signing
(22:58:27) cron2_: dazo: looks like it
(22:58:44) cron2_: mattock: sounds great
(23:05:18) dazo: running 'make distcheck' now
(23:05:50) psha ha abbandonato il canale (quit: Quit: Lost terminal).
(23:10:56) dazo: git tree is pushed
(23:12:40) mattock: http://swupdate.openvpn.net/community/releases/openvpn-=
2.2-RC2.zip
(23:12:40) mattock: http://swupdate.openvpn.net/community/releases/openvpn-=
2.2-RC2.tar.gz
(23:12:40) mattock: http://swupdate.openvpn.net/community/releases/openvpn-=
2.2-RC2.tar.xz
(23:12:56) dazo: sweet :)
(23:13:42) mattock: building from zip
(23:17:24) mattock: hmm, I don't think this is a showstopper, but TAP_RELDA=
TE defined in win/settings.in is apparently wrong (=3Dnot updated)
(23:17:30) mattock: shouldn't affect anything, though
(23:17:45) mattock: "to be fixed by 2.2" material
(23:17:52) dazo: agreed
(23:17:57) dazo: dirty, but agreed
(23:18:15) dazo: any reason that date is not in version.m4?
(23:18:36) dazo: would be less "difficult" to forget to update it if TAP ve=
rsion and TAP date was in the same file
(23:18:57) mattock: jamesyonan: ^^^
(23:21:45) mattock: build seemed to work, let's see about the installers
(23:21:53) cron2_: great
(23:21:57) ***cron2_ goes to be now :)
(23:22:38) jamesyonan: originally version.m4 was just for the openvpn versi=
on and all the other win settings were in settings.in -- but then Alon want=
ed to be able to build openvpn.exe using mingw cross compiler on unix, and =
autoconf couldn't really interact with settings.in, so some stuff got put i=
n version.m4 for the benefit of mingw autoconf builds
(23:24:43) jamesyonan: so basically version.m4 is for parms that are needed=
 by both autoconf (for openvpn binary only) and python build systems
(23:25:18) mattock: could the TAP_RELDATE be there?
(23:30:58) mattock: smoketest passed on winxp x86
(23:41:07) mattock: win7 x64 failed to load the TAP-drivers, but I'm 99% su=
re it's just code signing issue
(23:41:25) mattock: the code signing logic is still vague to me
(23:46:23) andj =EF=BF=BD=EF=BF=BD ora conosciuto come andj_afk
(23:49:52) mattock: jamesyonan: the unsigned TAP-driver are here: http://bu=
ild.openvpn.net/tap-2.2-RC2.tar.gz
(23:50:05) jamesyonan: ok
(23:50:29) mattock: Win7 64-bit failed to load them, but it was a generic "=
code not signed" type error
(23:50:42) mattock: I've tested the same drivers previously with success
(23:52:17) mattock: jamesyonan: I'll do more testing with the signed TAP-dr=
ivers and prepare the staging server by 18:00 UTC
(23:53:11) mattock: if you can sign the rest at that time, 2.2-RC2 can be r=
eleased tomorrow
(23:53:29) mattock: got to get some sleep now, good (extended) meeting!


--------------090102010809080201020304--

