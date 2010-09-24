Message-ID: <4C9C478B.60601@...515...>
Date: Fri, 24 Sep 2010 09:39:07 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050907010301060502080700"
Subject: [Openvpn-devel] Summary of the IRC meeting (23rd Sep 2010)
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
--------------050907010301060502080700
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 23rd Sep 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-09-23>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed next releases. Agreed that 4-6 weeks is a realistic estimate
for 2.2-beta4 and January for the final 2.2 release. So far there have
not been any major complaints about 2.2-beta3.

As there's plenty of time before 2.2-beta4 release, mattock will
postpone Windows building until after configuring buildbot and the
public OpenVPN test server.

--

Discussed Alon's build system patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/3991>

Jamesyonan tested the patch on Windows and was able to build on both
MingGW-32 and MSVC. Provided that the patch does not break anything on
*NIX, it's got James' ACK.

--

Discussed buildbot email notifications and build triggers:

<http://buildbot.net/buildbot/docs/0.7.12/#MailNotifier>
<http://buildbot.net/buildbot/docs/0.7.12/#Mail_002dparsing-ChangeSources>

Agreed that having two separate mailinglists would be best:

1) openvpn-commits

A read-only, moderated list which gets all commit messages. Buildbot
will parse these messages to generate s.c. "Changes", which trigger
builds. Using an open list (e.g. #openvpn-devel) would allow malicious
people to initiate builds.

2) openvpn-builds

A read-only, moderated list which gets all Buildbot notifications about
build failures etc. Buildbot can spam a lot, especially if there are
generic build failures or a misconfiguration somewhere, so using
#openvpn-devel is not wise.

--

Discussed Buildbot IRC notifications briefly:

<http://buildbot.net/buildbot/docs/0.7.12/#IRC-Bot>

Did not reach a consensus whether using an IRC bot would be wise or not.
Decided do discuss this issue later on.

--

Discussed splitting various parts of OpenVPN into seperate git trees or
git submodules. Currently changing any part of OpenVPN distribution
(e.g. build scripts, easy-rsa, TAP-driver) requires increasing the
OpenVPN version number. For example, 2.1.1 - 2.1.3 are essentially the
same, with only (Windows) build system changes.

This issue had been discussed earlier in this email thread:

<http://thread.gmane.org/gmane.network.openvpn.devel/3991>

Agreed that splitting easy-rsa into a separate git tree makes sense.
Isolating the TAP driver (tap-win32) into a separate project is
problematic, as it's refered to in OpenVPN (e.g. tun.h). A few solutions
were proposed:

1) Use "configure --with-tap-win32" to locate the header off tree

The problem here is that normal machines wouldn't have that header
because it's not needed to run openpvn. Also, devel machines
(cross-devel especially) won't have it either, because the TAP driver
won't be installed. The header file would thus have to be downloaded
separately.

2) Place the TAP driver into a git submodule inside OpenVPN git tree

This would allow tracking TAP driver development separately from
OpenVPN. This would make sense if the development and release cycles of
these projects were different; especially if the TAP driver would see
more frequent releases than OpenVPN. This is, however, unlikely.

Agreed that the TAP driver separation issue requires more discussion.

As mentioned above, changes to the Windows build system(s) require
increasing OpenVPN version number. There are two of those currently:

1) autoconf/automake tools and mingw -based
2) python-based which uses MSVC, loc

The python-based build system is in the 'win' directory and is
responsible for building the TAP driver.

Unneeded version number incrementation could be fixed by adding a build
number to Windows releases.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------050907010301060502080700
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-09-23.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-09-23.txt"

(21:07:26) mattock: ok, shall we start?
(21:07:38) mattock: from the bottom this time?
(21:07:41) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2010-=
09-23
(21:07:43) vpnHelper: Title: Topics-2010-09-23 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:07:44) dazo: yeah
(21:08:06) mattock: I'd like to know what to focus on after buildbot is ful=
ly functional (=3Dsoon)
(21:08:25) mattock: when will we release next beta?
(21:08:47) dazo: windows build are then getting a high-prio from my side
(21:08:49) mattock: that determines how fast I got to learn windows (+TAP d=
river) building
(21:09:24) mattock: Windows building could be a piece of cake, or not...
(21:09:56) dazo: next beta ... I'd like to complete the plugin_v3 patches .=
.. I have some new patches which just needs to be tested ... I'd like to se=
e that in v2.2, to give a little bit features as well ... unless somebody r=
ejects
(21:10:42) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:10:42) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(21:10:47) dazo: \o/
(21:10:48) mattock: beta4 in one month?
(21:10:52) mattock: hi james!
(21:11:00) jamesyonan: Hi!
(21:11:10) mattock: we were just discussing release date estimates for 2.2-=
beta4
(21:11:28) mattock: to give me an idea when to start working on the windows=
 building side of things
(21:11:38) cron2: mattock: buildbot-vpn-testing
(21:11:51) dazo: yeah, I think that's doable ... we're in the middle of som=
e big testing at work, and I've been blocked a week now with the training a=
nd exam ... so I think that's doable, but it's gonna be full speed working =
on it from my side
(21:12:10) mattock: cron2: could you decipher that :)
(21:12:16) dazo: good point, cron2!
(21:12:30) dazo: a test server ... for automated testing, the testing frame=
work he has written
(21:12:37) cron2: mattock: you were wondering what to do next.  buildbot is=
 building things, but not testing them.  test :-)
(21:13:02) mattock: yeah, I see
(21:13:13) mattock: it is testing the build, but the build is not testing o=
penvpn  :)
(21:13:15) ecrist: um, shouldn't betas limit the number of new code?
(21:13:40) cron2: mattock: it's good to have automated build for platform-d=
ependent breakage, but we can do better even :-)
(21:13:43) mattock: anyways, I mailed Wayne (the guy who offered the VPS to=
 us) and asked him to set it up with FreeBSD
(21:13:56) mattock: cron2: agreed
(21:13:57) dazo: ecrist: well, the changes we have in 2.2 so far, is really=
 not big ... it's actually more like a 2.1.10 release
(21:14:43) dazo: so we can dare to pull a little bit more in during the bet=
a ... especially when it's not directly connected to the VPN tunnel traffic=
 itself
(21:14:56) dazo: but that's just my opinion about it
(21:15:21) mattock: ok, so if a realistic release date for beta4 is +4-6 we=
eks, I can finish the  buildbot stuff and then move to the "testing server"=
 stuff
(21:15:28) mattock: and then to windows building
(21:15:34) cron2: that would be great
(21:15:34) dazo: sounds like a plan
(21:15:35) mattock: should be doable
(21:15:57) mattock: ok, then let's do that
(21:16:09) mattock: what if we discuss Alon's patch?
(21:16:23) mattock: jamesyonan could perhaps give it an ACK or NACK?=20
(21:17:14) dazo: http://thread.gmane.org/gmane.network.openvpn.devel/3991
(21:17:18) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:17:18) cron2: Alon is not a polite person :-)
(21:17:31) dazo: his edges are sharp ;-)
(21:17:33) mattock: yeah, we've noticed that :)
(21:18:07) dazo: but after all, it's not just nonsense ... if you see beyon=
d these edges, he got some points
(21:18:18) dazo: (generally speaking)
(21:18:27) cron2: I'm looking at the patch right now, but can't understand =
the acinclude.m4 stuff
(21:18:30) cron2: dazo: yes
(21:20:10) ***ecrist wishes some of those guys would come to a meeting and =
speak their minds.
(21:20:19) dazo: :)
(21:20:20) ecrist: they're obviously bright folks.
(21:20:28) mattock: yep...=20
(21:20:35) ecrist: despite the razor wire they wear.=20
(21:20:44) dazo: many bright people I know, stay away from irc ... they don=
't have time for it ....
(21:20:52) ecrist: *shrug*
(21:21:11) mattock: jamesyonan: any comments on Alon's patch?
(21:21:43) cron2: dazo: there is some wisdom in that!
(21:22:13) dazo: I think I've decoded the acinclude.m4 stuff a bit .... it =
basically forces mingw compilers to use  curl_cv_socklen_t_equiv=3Dint
(21:22:25) mattock: although IRC is like anything else... it only consumes =
you if you let it.
(21:22:39) dazo: otherwise (on unknown platforms) it does the compile tests=
 as defined, which was the normal procedure earlier
(21:24:19) jamesyonan: I'm not seeing Alon's patch -- only a discussion abo=
ut separating windows TAP driver into its own project.
(21:24:36) dazo: jamesyonan: http://thread.gmane.org/gmane.network.openvpn.=
devel/3991 ... scroll down a bit in the first mail
(21:24:37) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:24:48) mattock: it's here, appended to the first message: http://thread=
.gmane.org/gmane.network.openvpn.devel/3991
(21:24:50) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:24:58) dazo: mattock: you're slow!
(21:25:02) ***dazo runs and hides
(21:25:17) cron2: dazo: you know he's into artillery... no way to hide
(21:25:25) mattock: argh! :)=20
(21:25:30) mattock: I truly am...
(21:25:31) ***dazo had forgotten about that ...
(21:25:53) ***dazo fires up his shield and hope it works on ancient toys
(21:28:47) jamesyonan: any idea if Alon's patch has been tested on MinGW 32=
 bits?
(21:29:47) dazo: I've not heard anything else than what's in this mail thre=
ad ... so, not sure
(21:29:57) mattock: perhaps we should ask Alon?
(21:29:57) mattock:=20=20
(21:30:54) dazo: We can divide this one up in 2 parts .... one is the  curl=
_cv_socklen_t_equiv stuff ... that might be bitten by MinGW 32/64 bit stuff
(21:31:25) dazo: the other part is basically #include stuff ... which shoul=
d not have any effect at all on 32bit or 64 bit
(21:31:43) dazo: plus this on ... +    CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN=
_AND_MEAN"
(21:31:49) jamesyonan: I'm also wondering why he's removing the include "au=
todefs.h"
(21:33:39) dazo: He asks this question, related to autodefs.h:  "Also, when=
 did the autodefs.h went mandatory? Why is it in tap-win32/common.h while n=
o constant is actually used?"
(21:35:00) dazo: I've just done a autoreconf + ./configure + make ... and I=
 don't have that include file at all
(21:35:11) dazo: but that's not in a mingw environment
(21:36:21) mattock: ok, so removing autodefs.h include would be ok?=20
(21:36:49) dazo: I don't know where that file comes in ... except that it s=
eems to be auto generated on some platforms
(21:38:14) dazo: it might make sense to only include it if you're doing it =
via a autotools based platform (which sets HAVE_CONFIG_H) ... and non-autot=
ools platforms won't generate that file if needed
(21:39:55) jamesyonan: [ testing Alon's patch now ]
(21:40:01) mattock: nice!
(21:40:17) dazo: no wasting time here :)
(21:40:51) mattock: dazo: what about the splitting of easy-rsa and tap driv=
er to separate git trees?=20
(21:41:07) dazo: I think that's very much sensible=20
(21:41:08) mattock: anything new on that front?
(21:41:35) mattock: jamesyonan: what's your take on that idea?
(21:41:45) dazo: nope, I'll look into that _if_ people don't disagree with =
doing that ... and it will be when I redo the tree for the final 2.2 release
(21:42:51) mattock: regarding final 2.2 release... when will that be?
(21:43:04) dazo: after beta and rc? :-P
(21:43:18) dazo: before end of this year, I hope ...
(21:43:51) mattock: yeah, we haven't had any (negative) feedback on 2.2-bet=
a3 so far I think=20
(21:44:11) mattock: and it's been downloaded thousands of times
(21:44:19) mattock: so it must be relatively stable
(21:44:21) dazo: realistically, around january probably .... if we in about=
 a month pushes out beta4 ... (that's late october) ... and then we let the=
 RC run for a month or so
(21:44:57) dazo: 2.2 should not introduce much trash ... it's a really clea=
n progress from 2.1 ...=20
(21:45:33) dazo: mostly bugfixes, you know ... should make people happy :)
(21:45:49) mattock: I'd guess so
(21:46:16) mattock: too bad people only tell when things are broken, not wh=
en they're working
(21:46:17) dazo: the most "dangerous" patches are from cron2, enabling ipv6=
 on the wintap driver
(21:46:20) mattock: no matter how nice you ask :)
(21:46:26) dazo: :)
(21:46:48) mattock: no comments on my Debian/Ubuntu packages, which leads m=
e to believe they work just fine
(21:47:05) mattock: I'm sure _somebody_ has tested them, even without looki=
ng at webserver logs
(21:47:36) mattock: btw. I was thinking that we could release Debian/Ubuntu=
 packages for the next beta=20
(21:47:37) dazo: heh :)  Yeah, I did point someone on irc in that direction=
 as well ... so people have been asking
(21:47:44) dazo: sure can do!
(21:48:13) mattock: that'd make 8 different 2.2-beta4 packages + the usual =
(zip, tar.gz, exe)
(21:49:33) mattock: now, as were running out of time, a few buildbot questi=
ons.
(21:50:07) mattock: I'm thinking that we could have a single mailinglist fo=
r buildbot mails
(21:50:20) jamesyonan: mattock: splitting the openvpn, windows TAP, and eas=
y-rsa projects at the source level seems okay.
(21:50:36) jamesyonan: the easy-rsa is essentially a standalone package
(21:50:57) cron2: mattock: two lists would be fine as well, so people can j=
oin just "commit" (what's going on?) without being spammed by build messages
(21:51:02) dazo: jamesyonan: when you have some results from Alon's patch .=
.. can you either ping me here on IRC or (preferably just reply on Alon's m=
ail to the list with an ACK?
(21:51:23) dazo: cron2: +1
(21:51:23) cron2: I'd go for "two lists, moderated [=3Dread-only]"
(21:51:24) mattock: cron2: fair point
(21:51:32) jamesyonan: the windows tap driver is not quite standalone -- th=
ere's a common.h file which is included by both openvpn and tap
(21:51:57) jamesyonan: mattock: sure, I'm giving it a run now
(21:51:57) mattock: cron2: yeah, they definitely need to be moderated lists
(21:52:22) mattock: ok, so two lists
(21:52:25) mattock: both moderated
(21:52:26) cron2: IRC notifications, I'm not sure about.  Might be a bit no=
isy.
(21:52:54) mattock: the funny thing is that buildbot IRC bot allows doing s=
tuff to buildbot from the IRC
(21:53:00) mattock: e.g. get the status of buildslaves
(21:53:14) dazo: jamesyonan: is there stuff in common.h which can be split =
out?  I know some of the defines are used in OpenVPN ... but are all of the=
m used both in OpenVPN and in TAP driver?
(21:53:33) mattock: http://buildbot.net/buildbot/docs/0.7.12/#IRC-Bot
(21:53:35) vpnHelper: Title: BuildBot Manual 0.7.12 (at buildbot.net)
(21:54:23) dazo: well, having notify on failed builds on IRC for sure would=
 catch our attention
(21:54:43) mattock: we don't have to decide this right now, though
(21:54:55) mattock: check out the link I gave and see what you think
(21:55:30) cron2: having a single HEADS UP! build failed! message would be =
great - having 30 messages (because something broke and all 30 builds faile=
d) would be too nosiy
(21:55:33) cron2: noisy
(21:55:41) dazo: agreed
(21:55:47) jamesyonan: tap-win32/common.h really represents the the communi=
cation between openvpn and windows tap driver -- most of the stuff here is =
needed to be known by both
(21:55:48) mattock: cron2: I've been worrying about that...
(21:56:03) mattock: not yet sure how to fix that
(21:56:43) mattock: actually I think that binding all builds into a single =
"buildset" would do the trick
(21:56:57) dazo: jamesyonan: I see ... I'm just going through each of the d=
efinitions in common.h ... and I've not found any uses in tap-win32 yet ...=
 (only come to interval_t)=20
(21:57:06) dazo: (I'm using git grep to look for stuff)
(21:57:10) mattock: so one mail if _any_ of the 30 builds fails
(21:57:14) cron2: dazo: not common.h, but tap-win32/common.h
(21:57:26) dazo: ahh!
(21:57:35) ***cron2 fell into the same trap :)
(21:58:36) dazo: but ... please forgive my lack of knowledge here .... stuf=
f in tap-win32/, isn't that isolated to the TAP driver only?
(21:59:08) cron2: tun.h:#include "tap-win32/common.h"
(21:59:24) dazo: #ifdef WIN32
(21:59:36) dazo: fair enough, I see some link now
(22:00:06) dazo: well, a "work around" for this ... is to use git submodule=
=20
(22:00:55) dazo: openvpn-wintap.git will have the tap-win32/ stuff .... and=
 then openvpn.git will map openvpn-wintap.git to tap-win32/ using a sub-mod=
ule
(22:01:14) dazo: so when building on non-windows ... you checkout stuff lik=
e before, and build
(22:01:27) d457k: why not configure --with-tap-win32 to locate the header o=
ff tree?
(22:01:39) dazo: d457k: even better!
(22:02:11) cron2: I'm not convinced :-)
(22:02:25) cron2: normal machines wouldn't have that header (because you do=
n't need it to *run* openpvn)
(22:02:42) cron2: and devel machines (cross-devel especially) won't have it=
 either, because you won't install the tap driver there
(22:02:58) jamesyonan: mattock: Alon's patch seems okay on Windows -- I was=
 able to build on both MingGW-32 and MSVC
(22:03:10) d457k: i mean like --with-tap-win32=3D/home/foo/tap32/include no=
t autmagically
(22:03:23) cron2: sure, but where should the file come from?
(22:03:28) d457k: git
(22:03:33) mattock: jamesyonan: excellent! thanks for testing!
(22:03:38) dazo: from a separate checkout
(22:03:42) d457k: erm, i mean s vn =3D)
(22:03:44) cron2: d457k: sounds cumbersome
(22:04:01) d457k: if you build this software on windows you are as well =3D)
(22:04:02) dazo: well, using a git submodule would make it one step closer =
to the old behaviour though
(22:04:03) jamesyonan: Think of tap-win32/common.h as being the header file=
 for a library, where the TAP driver is the library
(22:04:08) dazo: yupp!
(22:04:27) cron2: ack, understoodf
(22:05:00) mattock: so just separate easy-rsa and leave TAP driver alone?
(22:05:20) dazo: using submodule you do:   git clone openvpn-testing.git ..=
. cd openvpn-testing ... git submodule init (which pulls down openvpn-winta=
p.git into tap-win32/, but tracks development separately) ... and then do t=
he normal build
(22:05:47) cron2: fun stuff
(22:06:15) dazo: submodule is really do track things separately, when split=
ting completely is awkward
(22:06:31) dazo: and you only need the tap-win32/ stuff when compiling for =
windows
(22:06:32) d457k: lets lean back and reconsider what advantages a separte t=
ap32 would bring
(22:06:44) mattock: d457k: +1
(22:07:08) dazo: that we can more easily ship a new and separate wintap dri=
ver
(22:07:09) cron2: independent development and release cycles is something I=
 can see - but that makes sense only if tap is developed more frequently th=
an openvpn
(22:07:16) cron2: +1
(22:07:28) d457k: i dont see that happen frankly
(22:07:54) d457k: afk brb
(22:07:55) dazo: the current situation is horrendous ... where we need to u=
pdate the version number on OpenVPN whenever we do some funky stuff with th=
e TAP driver and/or the build system
(22:08:40) cron2: splitting out the TAP driver won't help with the build sy=
stem
(22:08:42) dazo: which then makes, like with 2.1.x .... 2.1.0 and 2.1.1 onl=
y have one change, a fix to openvpn.spec
(22:08:42) mattock: increasing openvpn version number if build system chang=
es does not make much sense...
(22:09:05) dazo: 2.1.2 and 2.1.3 - windows build system updates ... no code=
 change
(22:09:22) mattock: how could we fix the build system issue?
(22:09:23) dazo: what is 2.1.3 today, should have been 2.1.1 in reality
(22:09:42) dazo: windows builds need to get a build number into the version
(22:09:54) dazo: which is only touching windows building
(22:10:08) mattock: so this is only an issue because of the windows builds?
(22:10:33) dazo: yeah
(22:10:37) cron2: well, if we can get windows building tested *before* tagg=
ing the next release, it's no issue at all
(22:10:37) jamesyonan: currently we actually have two windows build systems=
, one based on autoconf/automake tools and mingw, and the other based on MS=
VC with python scripts that do the driving.
(22:11:12) jamesyonan: the python-based build system is in the 'win' direct=
ory
(22:11:25) jamesyonan: also the python build system builds that TAP drivers
(22:12:28) mattock: anyways, already past dazo's 1 hour limit :)...
(22:12:37) dazo: ouch ... I noticed now
(22:12:49) dazo: too much fun on this channel :)
(22:13:07) mattock: so a summary: we definitely want to split easy-rsa into=
 a separate git tree
(22:13:16) jamesyonan: so any splitting of projects would need to also need=
 to intelligently split the build scripts as well
(22:13:28) jamesyonan: mattock: +1
(22:13:30) mattock: we're not 100% sure if splitting tap-driver into a git =
submodule is worth the effort
(22:13:36) dazo: yeah, that's a part of the conecpt
(22:13:42) mattock: and we definitely need to do something to the Windows b=
uild system
(22:14:20) cron2: .oO(automated tests of the resulting binary and driver...=
) *duck* *run*
(22:14:42) mattock: cron2: one test server coming up
(22:15:04) mattock: regarding Alon's patch... so it worked ok
(22:15:20) jamesyonan: yes
(22:15:23) mattock: do we need to get further information from Alon or can =
somebody (james?) give it an ACK?
(22:15:34) dazo: I'll apply that patch with Acked-by James then sometime ne=
xt week
(22:16:08) mattock: I think we should continue the "splitting stuff into se=
parate trees/submodules" discussion later
(22:16:23) dazo: mattock: jamesyonan have given an ACK here, as I read it .=
.. and so if you just state it in the meeting minutes, I'm happy
(22:16:33) mattock: dazo: ok, will do
(22:16:48) dazo: agreed ... splitting needs to be tackled a couple of more =
rounds
(22:16:52) jamesyonan: I haven't tested the patch on *nix yet, but I can AC=
K for Windows at this point
(22:17:27) mattock: I'll summarize our current view of the "splitting stuff=
" so that people on ml can comment on that
(22:17:51) mattock: ok, is that it? record time?
(22:18:01) mattock: dazo: you should definitely have a tight schedule every=
 week :P
(22:18:07) dazo: heh :)
(22:18:19) mattock: anything else, anyone?
(22:18:32) d457k: jamesyonan: i have shell code that build tap32 that could=
 be included in the autotools chain
(22:18:36) ***dazo need to complete some lab exercises for tomorrows exam
(22:18:50) d457k: dazo: good luck tomorrow
(22:18:51) mattock: dazo: good luck with the exam!
(22:18:54) dazo: thx!
(22:18:58) ***dazo heads out
(22:19:02) mattock: bye!
(22:19:16) cron2: d475k: do you think we could try automating client+tap te=
sts on windows?
(22:19:27) cron2: what we have on *ix now with t_client.sh / t_client.rc
(22:20:21) jamesyonan: d457k: tap build is tricky -- to build for Win2k thr=
ough Win 7 you need to use multiple versions of the DDK/WDK
(22:20:33) d457k: cron2: well is you hammer cygwin on the windows box you h=
ave all tool to do so
(22:20:54) mattock: jamesyonan: can the same DDK/WDK be used for WinXP -> W=
in7=20
(22:21:02) jamesyonan: yes
(22:21:02) d457k: jamesyonan: you do?
(22:21:09) cron2: d457k: mmmh, mingw already gives me that.  Need to go and=
 play with that.
(22:21:30) mattock: Win2000 is EOL... I think we decided to end support for=
 it at least for 2.2+
(22:21:35) cron2: d457k: latest WDK doesn't build 2k, earlier versions don'=
t build win7
(22:21:37) d457k: cron2: if you mean msys, that one's buggy as hell
(22:21:54) mattock: and only one guy responded to my mails asking if we sho=
uld keep win2k support
(22:21:55) cron2: d457k: yes, msys. it is?
(22:22:11) cron2: seemed to work for me
(22:22:22) d457k: cron2: i've tried to script our build system and left tow=
ards cygwin
(22:22:31) cron2: oh
(22:23:02) cron2: well, openvpn builds under msys, and seems to work :-)
(22:23:08) d457k: some crepy stuff like ln -s not working correctly lik und=
er unix
(22:23:31) cron2: who needs symlinks anyway :-) - but yes, it's "different".
(22:23:39) d457k: yeah if you don't rely on shell scripts
(22:23:44) cron2: how do you build with cygwin?  is it also "mingw-gcc"?  o=
r something else?
(22:24:02) d457k: they have mingw on board
(22:24:08) cron2: ah
(22:24:21) d457k: and the project is alive sort of, compared to msys
(22:25:07) d457k: and you can run a openssh server on windows =3D)
(22:25:35) mattock: d457k: very useful indeed
(22:25:38) cron2: I know *that* (I see the patches being sent o the openssh=
 list :) )
(22:25:46) cron2: s/ o / to /
(22:26:27) d457k: jamesyonan: about the ddk issue, that's a matter of --wit=
h-ddk=3D$path, isn't it?
(22:26:54) d457k: of course you'd have to configure whole ovpn again
(22:27:38) d457k: but i see tap32 as integral part of ovpn (on win32 at lea=
st) and no need to split it off forcefully
(22:28:57) mattock: I think I'll split now, you guys keep on going :)
(22:29:47) d457k: mattock: bye
(22:29:48) mattock: I think the official part ended officially when dazo le=
ft :)
(22:29:51) mattock: bye!

--------------050907010301060502080700--

