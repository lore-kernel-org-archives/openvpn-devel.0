Message-ID: <4B9102D4.5050708@...515...>
Date: Fri, 05 Mar 2010 15:10:44 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080000050502090206000702"
Subject: [Openvpn-devel] Summary of the IRC meeting (4th Mar 2010)
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
--------------080000050502090206000702
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 4th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:
 http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics=
-2010-03-04

Next meeting next week, same place, same time.


SUMMARY

Decided to start using our "Feature Removal Process" (FRP) with James'
blessing:

* http://www.secure-computing.net/wiki/index.php/OpenVPN/FRP

Decided to merge the following patches into "testing":

* Gentoo patch for glibc-2.8, needing to #define _GNU_SOURCE in socket.c
  - patch should be sane and safe as it is
* [PATCH] bash->bourne script cleanup
  - http://thread.gmane.org/gmane.network.openvpn.devel/3162)
  - patch should be sane and safe as it is
* [Feedback needed] - Fix cross compile support
  - http://thread.gmane.org/gmane.network.openvpn.devel/3176
  - decided to merge, given that support for autotools/autoconf 2.59 and
    up is maintained

Decided to merge the following patches into "allmerged" branch in
"testing" tree after proper regression testing:

* MacOSX / Darwin funny in the code
  - http://thread.gmane.org/gmane.network.openvpn.devel/3158
  - cron2 will create a patch and send it for testing
  - mattock will contact the maintainer of Tunnelblick and ask his
    opinion in this issue
* [PATCH] make ipv6_payload compile under windows
  - http://thread.gmane.org/gmane.network.openvpn.devel/3167
  - cron2 will test this in the proper environment when he has time
* [PATCH] Implement --passtos for tagged ethernet frames
  - http://thread.gmane.org/gmane.network.openvpn.devel/3165
  - decided to ask for testing help in the mailinglists
* [PATCH] Add CID to the management status overview
  - http://thread.gmane.org/gmane.network.openvpn.devel/3148
  - decided to ask OpenVPN user interface developers to test this

The following patch needs more discussion to clarify the issue and
decide exactly how to fix it:

* Win XP problem with framedyn.dll and PATH settings
  - http://thread.gmane.org/gmane.network.openvpn.devel/3161
  - see full chatlog for details

The following issue was settled soon after the meeting:

* Special-case code for OpenBSD
  - http://thread.gmane.org/gmane.network.openvpn.devel/3153

---

Full chatlog as an attachment


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------080000050502090206000702
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-03-04.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-03-04.txt"

(19:53:37) d12fk_: good evening
(19:56:03) mattock: d12fk: good evening
(20:00:25) jamesyonan: Hi all
(20:00:31) dazo: Hi! :)
(20:00:50) cron2: Hi!
(20:01:05) dazo: Topics for today .... unless someone objects :)  http://ww=
w.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics-2010-03-04
(20:01:05) vpnHelper: Title: OpenVPN/IRC meetings/Topics-2010-03-04 - Secur=
e Computing Wiki (at www.secure-computing.net)
(20:01:16) dazo: (consider it as suggestions!)
(20:01:26) mattock: hi all
(20:01:40) mattock: I guess we can begin
(20:01:48) dazo: \o/
(20:02:04) mattock: james, have you had time to check out today's topics?
(20:02:04) agi: hi all
(20:02:09) mattock: hi agi
(20:02:33) jamesyonan: yes
(20:03:15) mattock: starting from the top... do you think feature removal p=
rocess (FRP) is ok?
(20:03:46) jamesyonan: FRP looks good
(20:03:52) mattock: great!
(20:04:10) cron2: now that was easy :-) - next: OpenBSD special handling
(20:04:29) dazo: jamesyonan:  any objections to introducing deprecated.[ch]=
 and the inlined function there with warnings?
(20:05:10) dazo: (it was to get a place where to place those deprecated fea=
ture warnings at startup)
(20:05:41) jamesyonan: that looks good
(20:06:06) mattock: OpenBSD special handling?
(20:06:11) cron2: re OpenBSD: can you remember why OpenBSD is doing do_ifco=
nfig/open_tun the other way round as all other BSDs do it?
(20:06:17) dazo: jamesyonan:  thanks!
(20:07:05) jamesyonan: I wrote that code probably in '03 or '04 and at the =
time, the ordering made sense
(20:07:39) mattock: I assume it depends on OpenBSD version
(20:07:59) jamesyonan: I don't use OpenBSD any longer
(20:08:09) cron2: my assumption is that it's done that way to be able to do=
 "ifconfig tun0 destroy" to cleanup first
(20:08:36) dazo: wouldn't that behaviour need to be similar on most of the =
*BSDs?
(20:08:44) jamesyonan: right, that makes sense
(20:09:05) cron2: dazo: well, that's the weird thing.  NetBSD also does des=
troy/create, but does the "normal ordering"
(20:09:07) jamesyonan: that's why there's a disclaimer about "no problem if=
 failure" on the initial destroy
(20:09:42) mattock: shall we switch the order and see what happens?
(20:09:56) dazo: cron2:  do you got access to a OpenBSD installation?
(20:09:56) cron2: I wonder why the "destroy tun, create tun" stuff isn't do=
ne in open_tun()?
(20:10:20) cron2: dazo: not currently.  I'm planning to setup a VM with Ope=
nBSD "soonish" to make sure the IPv6 ifconfig/route setting works
(20:10:54) mattock: you _could_ try sending a mail to devel with subject [T=
ESTING NEEDED] prefix and see what happens
(20:11:05) mattock: perhaps somebody on -users paid attention to my mail
(20:11:05) ***dazo suggest to try out the reverse (that is, "normal") order=
ing on OpenBSD ... if it works, we should probably consider to flip it
(20:11:05) cron2: mmmh, ok, "open_tun" doesn't deal with ifconfig at all, a=
nd do_ifconfig *does* have all the argv/exec stuff...
(20:11:47) cron2: jamesyonan: something else I have been wondering about wh=
ile fighting with NetBSD (which also has persistent tun interface).  Should=
 we run "ifconfig tun0 destroy" on "close_tun()"?
(20:12:03) jamesyonan: open_tun is a lower level function; the destroy/recr=
eate semantics would be handled at a higher level
(20:12:35) cron2: I somewhat disagree here :-) - both do_ifconfig and open_=
tun are called from the same caller
(20:12:44) cron2: do_open_tun() in init.c
(20:14:05) jamesyonan: I'm talking about the platform specific open_tun fun=
ctions in tun.c
(20:14:45) cron2: Ah, ok.  But those are the ones that know how to deal wit=
h their platform...
(20:15:28) mattock: shall we try switching the order and see what happens?
(20:15:50) mattock: try to get somebody to test the change before it goes t=
o "testing"
(20:15:59) mattock: and if it work, switch the order
(20:16:04) dazo: that would be a good idea
(20:16:26) jamesyonan: sounds good
(20:16:44) cron2: mattock: I'll do that when I go and test IPv6-on-OpenBSD.=
  It's not an obstacle for IPv6, but it does make all the BSDs behave the s=
ame (at least, inside OpenVPN)
(20:16:46) ***dazo could pull in that change into the feat_ipv6_payload bra=
nch to get it into the openvpn-testing.git tree .... reverting commits are =
easy later on
(20:17:05) cron2: dazo: OK
(20:17:13) dazo: (git revert <commit ID>)
(20:17:18) mattock: cron2, dazo: ok
(20:17:18) mattock: now what about "MacOSX / Darwin funny in the code"
(20:17:18) d12fk_: i know two openvpn guys. i'll ask them tomorrow at work =
if they could try the reverse order, just need a patch
(20:17:31) mattock: d12fk: that'd be great!
(20:17:31) d12fk_: openvpn on openbsd that is
(20:17:52) cron2: d12fk_: cool.  If you look at my e-mail, it's quite obvio=
us.  Just let me grab the URL
(20:18:06) cron2: http://thread.gmane.org/gmane.network.openvpn.devel/3153
(20:18:09) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:18:19) d12fk_: if you posted it on -devel i have it
(20:18:25) cron2: I did
(20:18:41) d12fk_: ok, wil respond to the mail once i get feedback from them
(20:18:45) mattock: that's settled then :)
(20:18:57) mattock: the next one... "MacOSX / Darwin funny in the code"
(20:19:03) cron2: ok, MacOS X / Darwin funny - the code calls "ifconfig tun=
0 delete", and "delete" is "just a hostname" on OSX 10.5
(20:19:16) cron2: so it tries to resolve "delete" to an IP address and ifco=
nfig tun0 to that...
(20:19:43) cron2: man page says "destroy is what you want to use", but I do=
n't know whether this might be due to "old MacOS X" vs "new MacOS X"
(20:20:13) mattock: I can actually test this on 10.4
(20:20:33) cron2: mattock: can you check "man ifconfig" to see whether it l=
ists "delete"?
(20:20:54) mattock: not right now, I'm on the Linux side (like 99,9% of the=
 time)
(20:20:57) mattock: but tomorrow, yes
(20:21:04) cron2: in the SYNOPSIS section
(20:21:06) mattock: or perhaps I'll just mount the drive...
(20:21:10) mattock: OS X drive
(20:21:25) cron2: but while that would be helpful, it doesn't tell us about=
 10.0...10.3
(20:21:47) cron2: what's the earliest MacOS X version that is considered "O=
penVPN is supported and tested here"?
(20:23:31) cron2: (of course that question is actually somewhat wider - "fo=
r all supported platforms, what is the oldest version that needs to be tend=
ed?" - if doing system-specific patches, testing older OS versions can be a=
 major pain)
(20:23:37) dazo: Could we do something with #define here on MacOSX ... defa=
ulting to 'destroy' ... but when built with --enable-old-macosx ... it woul=
d use delete?
(20:24:15) dazo: (just #define 'delete' or 'destroy' ... and use that defin=
e in the code?)
(20:24:35) cron2: dazo: that would be a possible fix, *if* we can be sure t=
hat this was not a typo on day one, and should have never been "delete" in =
the first place...)
(20:24:35) mattock: ok, so this is what it should be doing, right: ifconfig=
 interface destroy
(20:24:45) cron2: mattock: on 10.5, yes
(20:24:50) mattock: and on 10.4
(20:24:57) mattock: that's from 10.4's man page
(20:25:21) dazo: cron2:  agreed!
(20:25:40) mattock: delete is something else entirely: "delete  Another nam=
e for the -alias parameter."
(20:26:06) cron2: indeed, if used in combination with an address
(20:26:08) mattock: " -alias  Remove the network address specified..."
(20:26:44) cron2: ifconfig tun0 delete 2001:608::2=20
(20:27:17) mattock: I guess something like that
(20:27:37) mattock: and if you want to destroy the entire interface, then "=
ifconfig <ifname> destroy"
(20:27:42) cron2: yes
(20:27:58) mattock: and in this case we want to destroy the entire interfac=
e, right?
(20:28:10) cron2: on 10.4 and up, and all NetBSD versions I have seen
(20:28:16) cron2: yes
(20:28:24) mattock: ok, so that definitely needs fixing
(20:28:46) cron2: the OpenBSD code in tun.c is quite explicit about it (nee=
ding to destroy and recreate the tun0, to be sure that no leftover config i=
s hanging around)
(20:29:05) cron2: the Macos X code states "Darwin ... seems to exhibit simi=
lar behaviour to OpenBSD"
(20:29:52) mattock: is this once again in the "ask somebody to test -> chan=
ge in testing if it works" class?
(20:30:14) cron2: mattock: I'm afraid it is, if we can find someone with Ma=
cOS "older than 10.4"
(20:30:40) mattock: I guess I'll be sending a few mails to -users and -deve=
l tomorrow :)
(20:30:47) mattock: can we move on?
(20:31:23) cron2: mattock: good plan.  (Just changing delete -> destroy mig=
ht actually backfire, as it will then destroy the tun0 interface, and anoth=
er call to "ifconfig tun0 create" might be needed - at least on NetBSD it's=
 that way)
(20:31:37) cron2: I'll do a patch, test on 10.5, and send for testing
(20:31:44) mattock: cron2: great!
(20:31:51) mattock: next on agenda: "Win XP problem with framedyn.dll and P=
ATH settings"
(20:32:07) cron2: oh yes, the Windows problems :-)
(20:32:16) dazo: cron2:  we can create a separate branch for these changes =
... and you can push it via opevpn-testing.git then, if you want
(20:32:20) jamesyonan: "Jonathan K. Bullard" <jkbullard@...277...> is the c=
urrent Tunnelblick maintainer -- he would be the one to ask about proposed =
OS X changes
(20:32:32) cron2: jamesyonan: oh, cool.  *note*
(20:33:48) cron2: dazo: let's discuss the specifics "what branch do I want =
to base this on, and which branch should it go to" later ("when I come arou=
nd to actually doing this")
(20:34:00) dazo: cron2:  sure!
(20:34:05) mattock: cron2, do you want to contact Jonathan or shall I?
(20:34:31) cron2: mattock: if you could establish contact, this would save =
me some time, which is good :-)
(20:35:40) cron2: jamesyonan: regarding Windows and $PATH.  My patch works,=
 but is a very ugly workaround.  What we need is a way to get a reasonable =
PATH into the Windows environment used by CreateProcess() from win32.c
(20:36:01) mattock: cron2: I'll do that then
(20:36:09) cron2: jamesyonan: what would be your suggestion?
(20:36:11) cron2: mattock: thanks!
(20:37:05) jamesyonan: handling PATH is tricky because of the security impl=
ications
(20:37:28) cron2: yes, and you can't just hard-code anything because the wi=
ndows base path might be different
(20:37:58) dazo: (I have a related issue, with \Windows installed on D: ...=
. not C: ...)
(20:38:16) cron2: but having popup boxes about framedyn.dll not being found=
 isn't so pretty either :-)
(20:38:20) d12fk_: yes that came up with our support as well
(20:38:46) cron2: dazo: "win-sys env" should actually handle that
(20:39:07) d12fk_: iirc route.exe failed on vista with windws xp on c: and =
vista on d:=20
(20:39:16) jamesyonan: maybe the solution is to have execve (i.e. CreatePro=
cess) set a rational path
(20:39:38) dazo: cron2:  My suggestion is to move default behaviour of --wi=
n-sys to be env .... and  it can be overridden to whatever .... C:\Windows =
to get the old behaviour
(20:39:58) dazo: cron2:  if --win-sys solves your issue as well
(20:40:14) cron2: dazo: doesn't solve my issue (as my windows is on C:\Wind=
ows)
(20:40:27) dazo: ah
(20:40:28) cron2: my problem is that PATH is not set in the CreateProcess()=
 call *at all*
(20:40:59) cron2: ... and when I hard-code a "sane" path (C:\WINDOWS;C:\WIN=
DOWS\SYSTEM\Wbem), this will break, of course, if Windows is on D:
(20:41:01) dazo: then jamesyonan suggestion sounds more correct .... based =
on --win-sys, I'd presume
(20:41:01) cron2: so the issues are related
(20:41:44) cron2: jamesyonan: I was thinking in this direction as well.  Bu=
ild a path with the most important windows component directories from "win-=
sys" setting, and set this up before calling CreateProcess
(20:41:59) cron2: what would be "the right" place to setup the path?
(20:42:13) d12fk_: maybe we should just use %systemdrive% and hardcode the =
rest
(20:42:53) dazo: d12fk_:  isn't it possible to tweak \Windows to something =
else under installation?
(20:43:06) ***dazo haven't installed Windows in many years, so he don't rem=
ember
(20:43:15) d12fk_: it is but then we can look it up in the registry
(20:43:37) d12fk_: probably the best thing to do anyways
(20:43:46) dazo: good point
(20:44:09) d12fk_: read %systemroot% from there and append system32 system/=
wbem
(20:44:32) d12fk_: that looks like the std path in my windows xp
(20:44:54) cron2: jamesyonan: add a new function "win32_setup_path()" in wi=
n32.c, and call that from openvpn.c/main, right after env_set_add_win32()? =
 Would that be an acceptable approach for you?
(20:45:21) dazo: jamesyonan:  cron2: ^^  is d12fk_ suggestion more likely t=
o be successful?
(20:45:45) jamesyonan: yes, that makes sense (i.e. win32_setup_path functio=
n)
(20:46:02) cron2: jamesyonan: ok, I'll go and code something and send a pat=
ch for review
(20:47:05) mattock: how about this then: "[PATCH] make ipv6_payload compile=
 under windows"
(20:47:13) cron2: dazo: it's related.  I need the windows base directory to=
 build the path from it ("win-sys ...") - so if the method to figure out *t=
hat* one changes, "my" part will auto-adjust
(20:47:30) cron2: mattock: ok, that's the tough one :-)
(20:47:54) dazo: cron2:  good!  let's review your patch when that comes :)
(20:48:00) cron2: dazo: yep
(20:48:33) jamesyonan: you need the "Windows Driver Kit" to compile the TAP=
 driver
(20:48:38) cron2: ok, regarding the next topic.  I am not using windows nor=
mally, but people are bugging me for IPv6 payload support on windows.  So I=
 would be willing to hack on it, but I'm stuck due to the fact that tapdrvr=
 doesn't do v6
(20:48:59) cron2: jamesyonan: does the DDK contain a C compiler?
(20:49:03) jamesyonan: yes
(20:49:08) cron2: aha!
(20:49:47) jamesyonan: All the support support files needed for building th=
e TAP driver exist under tap-win32, with the exception of driver signing
(20:50:02) cron2: understood
(20:50:27) cron2: so what's the sequence of things (sorry, I'm really a uni=
x guy)
(20:50:29) jamesyonan: the domake-win script does a full build of the Windo=
ws installer from source including the TAP driver
(20:50:34) cron2: - extract OpenVPN source
(20:50:35) d12fk_: cron2: get the value from here KEY_LOCAL_MACHINE\SOFTWAR=
E\Microsoft\Windows NT\CurrentVersion\SystemRoot
(20:50:46) cron2: - go to tap-win32 directory
(20:50:53) cron2: - run "domake-win" shell? batch? script?
(20:51:05) jamesyonan: it's a bash script
(20:51:18) jamesyonan: I usually run it from MingGW/MSYS environment
(20:51:29) cron2: ah!  another missing bit :-)
(20:51:40) cron2: so you install mingw/msys and ddk
(20:51:50) jamesyonan: yes
(20:51:58) jamesyonan: see comments in domake-win script
(20:52:09) cron2: d12fk_: I don't want to dabble with win-sys, $PATH is eno=
ugh for me
(20:52:36) d12fk_: cron2: yes but take that as a base for you path
(20:52:56) d12fk_: it contains e.g. C:\WINDOWS
(20:52:59) cron2: d12fk_: I will take whatever bits end up in the "win-sys"=
 config variable inside OpenVPN
(20:53:09) cron2: (which usually contains C:\WINDOWS, but might be override=
n by the user)
(20:53:43) cron2: jamesyonan: thanks.  I have noted this all now, and will =
go fight it "soon" (I have no windows machine right now that has enough dis=
k space to install DDK and mingw)
(20:53:43) d12fk_: ok, I might post the patch to get win-sys right then
(20:54:16) dazo: d12fk_:  that's the place to initially grab the registry .=
.. thus --win-sys env ;-)
(20:54:19) cron2: d12fk_: sorry for sounding rude, I just want to avoid get=
ting too much stuff on my plate
(20:54:43) d12fk_: i didnt get that impression
(20:54:50) cron2: dazo: well, more like "--win-sys registry" :) - env just =
does a getenv on %SystemRoot%
(20:54:59) d12fk_: you sounding rude, not th eplate thing =3D)
(20:55:11) dazo: cron2:  good point
(20:55:41) cron2: ok, regarding the windows side of things, I'm fine - we c=
an go to dazo / gentoo now :-)
(20:55:56) mattock: great!
(20:56:04) mattock: "Gentoo patch for glibc-2.8, needing to #define _GNU_SO=
URCE in socket.c"
(20:56:04) dazo: http://fpaste.org/33eg/  ... this is the mail I sent James=
 last week
(20:56:07) d12fk_: cron2: i'm more like getting it from the registry by def=
ault
(20:56:33) dazo: d12fk_:  we can take that topic very soon ... it's connect=
ed to a sf.net tracker
(20:56:51) d12fk_: link?
(20:56:56) dazo: jamesyonan:  it seems older glibc needs #define _GNU_SOURC=
E to compile
(20:57:12) mape2k: hi
(20:57:23) jamesyonan: that doesn't surprise me
(20:57:36) dazo: jamesyonan:  would a solution for this be to define that o=
n all Linux version? or is there a way how to detect glibc versions?
(20:58:23) dazo: what would be possible drawbacks be to define _GNU_SOURCE,=
 in f.ex. socket.c to limit the impact
(20:58:52) jamesyonan: Is the AC_GNU_SOURCE in configure.ac not enough?
(20:58:52) dazo: d12fk_:  look at item 5.2 in the agenda
(20:59:09) cron2: dazo: oh, indeed :)
(20:59:35) dazo: jamesyonan:  it seems not, as Gentoo still have that one i=
ncluded
(20:59:42) mape2k: jfyi: the patch is used in gentoo every time - i'm using=
 glibc 2.10 and have no problem if this patch was applied
(21:00:04) mattock: mape2k: does compile fail without the patch?
(21:00:21) jamesyonan: do you have a link to the patch?
(21:00:26) mape2k: *try*
(21:00:28) dazo: that's the thing ... Gentoo is the only distro I've seen w=
hich has this one ....=20
(21:00:52) dazo: jamesyonan:  it's here: http://fpaste.org/33eg/ ... it's c=
opy-paste of the patch
(21:01:05) cron2: ... and Gentoo doesn't even need it :-) - I compile from =
the git tree, without that patch, and nothing breaks...
(21:01:09) mape2k: look at http://bugs.gentoo.org/show_bug.cgi?id=3D245181
(21:01:12) vpnHelper: Title: Gentoo Bug 245181 - net-misc/openvpn-2.1_rc13 =
fails to build with glibc-2.8 (at bugs.gentoo.org)
(21:01:42) dazo: cron2:  not any longer ... it's only for older glibc
(21:02:06) cron2: ah, ic
(21:03:12) jamesyonan: I think the patch makes sense -- the peercred refere=
nce is relatively new, and is used when the management interface is being d=
riven by a unix domain socket
(21:03:38) dazo: jamesyonan:  so we should enable it in general, or just on=
 Linux?
(21:03:45) mape2k: mattock, compile works - but i use glibc 2.10 ;)
(21:03:54) mattock: mape2k: ok
(21:04:34) jamesyonan: Yes, I believe peercred is a linux-only feature
(21:04:56) dazo: jamesyonan:  okay, I'll propose a patch then for enabling =
this in socket.c when target is Linux
(21:05:07) jamesyonan: the BSD-based unices use getpeereid
(21:05:42) dazo: [PATCH] Implement --passtos for tagged ethernet frames ...=
. anyone looked at this patch?
(21:05:51) dazo: http://thread.gmane.org/gmane.network.openvpn.devel/3165
(21:05:52) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:06:00) mattock: jamesyonan: do we still have time for a couple of patch=
es?
(21:06:06) mattock: =3Ddo you :)
(21:06:21) dazo: ouch ... /me forgot about time :)
(21:06:25) cron2: dazo: not really.  looking now.
(21:06:55) dazo: I'd like to get the next two patches discussed if time ...=
. to get them ACK/NACKed
(21:07:31) mattock: ok, let's keep it fast then
(21:07:34) mattock: "[PATCH] Implement --passtos for tagged ethernet frames"
(21:08:08) jamesyonan: passtos patch seems like a good idea -- we just need=
 testing to verify that it works properly and doesn't break previous passto=
s functionality
(21:08:14) cron2: dazo: I'm not sure how that would need to be set up on th=
e TAP side
(21:08:42) dazo: jamesyonan:  Well, that's why we have the openvpn-testing =
tree, isn't it? ;-)
(21:09:24) dazo: If nobody objects, I'll create a feat_passtos branch and p=
ut it there ... to be able to revert it easier
(21:09:53) dazo: if I can interpret jamesyonan's answer as an ACK
(21:09:53) cron2: dazo: I'm not ACK or NACKing this, the patch looks really=
 simple, but to ACK it I would need to read through the code to understand =
what passtos does
(21:10:18) dazo: cron2: yeah ... that's why I'm asking ... because I'm not =
such a network expert :)
(21:10:23) jamesyonan: I say that because the passtos feature is probably u=
sed by a very small percentage of OpenVPN users, but for whom the feature i=
s very important
(21:10:40) dazo: agreed
(21:11:07) cron2: what the code does is teach the part that looks at an eth=
ernet packet "is this IPv4 inside?" to understand ethernet frames with 802.=
1q headers (VLAN tagging plus priority)
(21:11:14) dazo: the patch arrived sf.net July 2009 ... so it should be pos=
sible to get some response to it, hopefully
(21:11:37) ***dazo expects this patch to be tested before inclusion into st=
able anyway
(21:11:40) mattock: [TESTING NEEDED] stuff again?
(21:11:47) dazo: yes
(21:11:52) mattock: before inclusion into "testing"
(21:12:05) mattock: if no responses -> include anyways, see what happens?
(21:12:08) dazo: Nope, I'll create a branch for it ... and testing can go t=
hrough that channel
(21:12:13) dazo: before merge into allmerged, that is
(21:12:14) mattock: dazo: sounds good
(21:12:27) mattock: next one?
(21:12:33) dazo: Next one .... [PATCH] Add CID to the management status ove=
rview  ....  http://thread.gmane.org/gmane.network.openvpn.devel/3148
(21:12:34) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:13:08) dazo: this is a simple one as well .... it was a little discussi=
on about what CID really is .... and I found traces that it is client-ID, a=
s Gert assumed
(21:13:18) dazo: jamesyonan:  does this patch make sense in your eyes?
(21:13:24) jamesyonan: I would just run the patch by the various UI develop=
ers (that use the management interface) and make sure it won't break anythi=
ng
(21:14:12) dazo: jamesyonan:  do you have any contacts worth checking up ag=
ainst? ... Tunnelblick, I assume is one of them
(21:14:33) jamesyonan: Yes, I agree the CID should be included in the statu=
s output
(21:15:04) dazo: perfect, I'll take that an ACK ... and get some attention =
to the ML about this change
(21:15:04) jamesyonan: the CID is a relatively new addition, so it didn't m=
ake it into the original status implementation
(21:15:39) mattock: next?
(21:15:47) mattock: "[Feedback needed] - Fix cross compile support"
(21:16:09) dazo: If I get three today, that's lovely! :)
(21:16:31) mattock: it'd be great to go through all mailing list patches
(21:16:41) dazo: Alon Bar-Lev made a comment here which is pro partly inclu=
ding it .... Gert got some reservations, but that was to the amount of chan=
ges
(21:17:05) dazo: (the last one should be very easy)
(21:17:21) dazo: http://thread.gmane.org/gmane.network.openvpn.devel/3176  =
(cross compile support)
(21:17:22) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:17:35) jamesyonan: It's important that configure.ac can build on older =
versions of autotools
(21:18:02) dazo: jamesyonan:  what would be the oldest autotools version yo=
u imagine we would support?
(21:18:52) jamesyonan: autoconf 2.59-5 (that's the version bundled with RHE=
L 4)
(21:19:31) dazo: jamesyonan:  good!  I got access to that at work .... test=
ing on RHEL4.7 or 4.8 would be sufficient?
(21:20:08) mattock: dazo: I think most RHEL installations _should_ be updat=
ed to 4.7/4.8
(21:20:28) mattock: unless there are proprietary applications depending on =
older minor versions (4.0, 4.1, etc.)
(21:20:48) dazo: yeah ... has not arrived yet 4.8, I believe ... but I thin=
k I have access to some pre-releases
(21:20:55) jamesyonan: I regularly build on "Red Hat Enterprise Linux ES re=
lease 4 (Nahant Update 6)"  -- this is what I consider the lower-bound on L=
inux support
(21:21:19) ***dazo will see if he can dig up a 4.6 installation
(21:21:19) mattock: I believe these minor Redhat updated contain small chan=
ges to software versions (not just security fixes)
(21:21:52) dazo: RHEL4 is mostly only security now ... I think 4.7 was the =
last with real software updates
(21:22:24) mattock: dazo: ok
(21:22:41) cron2: jamesyonan/mattock: I think it would be really good if we=
 could have a list of "oldest versions of operating systems supported"
(21:22:49) mattock: cron2: agreed
(21:22:54) jamesyonan: agreed
(21:24:02) ***dazo got RHEL4.6-ES available ... will run some compilation t=
ests in a VM
(21:24:34) mattock: did this answer the cross-compile patch question?
(21:24:35) dazo: If that compiles, I presume I can consider the cross-compi=
le patch as ACKed?  any objection to that?
(21:25:02) jamesyonan: agreed
(21:25:20) dazo: Final one
(21:25:22) dazo: [PATCH] bash->bourne script cleanup=20
(21:25:27) dazo: http://thread.gmane.org/gmane.network.openvpn.devel/3162
(21:25:28) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:25:51) cron2: dazo: please do not change all the HOST/TARGET definition=
s in the code
(21:26:10) dazo: I got one comment that the client-up/down scripts should b=
e rewritten to not use arrays ... to be "proper" /bin/sh compatible
(21:26:17) dazo: I say that's another patch
(21:26:29) dazo: but if this one can get an ACK ... it would be good
(21:26:49) dazo: cron2:  agreed ... I will follow Alon's suggestion ... not=
 changing #define's
(21:26:59) cron2: dazo: ACK to that
(21:27:08) dazo: cron2:  what did you ACK now? ;-)
(21:27:22) cron2: dazo: cross-compile fix with Alon's addition
(21:27:32) agi: dazo: as long as the script are using bashisms, they should=
 point to /bin/bash
(21:27:34) dazo: cron2:  good! agreed :)=20
(21:27:48) jamesyonan: the script cleanup looks good
(21:27:50) dazo: agi:  it's only client-up/down which are bashish .... the =
rest is not
(21:28:01) dazo: I'll take that as an ACK as well
(21:28:04) agi: ok
(21:28:24) dazo: mattock:  I'm done for today then :)  sf.net trackers next=
 week :)
(21:28:35) openvpn2009: samuli, please check your PM
(21:28:39) mattock: dazo: agreed, better leave something for next week :)
(21:28:47) dazo: and we're 30 min overdue :)
(21:29:05) mattock: but we got lots of stuff done, which is great
(21:29:05) cron2: I think this was a very very productive meeting.  Thank y=
ou all a lot!
(21:29:06) dazo: mattock:  will you manage to summarise those items which g=
ot ACKed here?
(21:29:14) dazo: yeah, this was a great meeting!
(21:29:16) mattock: dazo: I'll do my best :)
(21:29:22) dazo: mattock:  thx!
(21:29:30) jamesyonan: take care guys!
(21:29:38) agi: bye james
(21:29:43) dazo: I'll be travelling from early tomorrow morning until Monda=
y evening ... so I won't be able to do much OpenVPN stuff
(21:29:43) mattock: bye james!
(21:29:44) cron2: bye
(21:29:46) dazo: jamesyonan:  you too!
(21:29:55) cron2: dazo: this is good, this gives us others time to catch ou=
r breath :)
(21:30:04) agi: cron2: indeed :D
(21:30:17) dazo: unless I get some sleepless nights :-P
(21:30:50) mape2k: mattock, the latest snapshot tarballs on your ftp... wil=
l they be updated/build regularly?
(21:31:15) dazo: mape2k:  I'd ask ecrist on ##openvpn .... he is the one wh=
o creates them
(21:31:47) ***dazo think he said he wanted to create them weekly
(21:31:52) mape2k: many package systems (openwrt, freetz) did not support g=
it-checkout support - so there we should use snapshots
(21:32:24) mape2k: dazo, weekly is regularly enough ;)
(21:32:34) dazo: mape2k:  yeah, ecrist's script does git checkout and boots=
traps them before taring them down
(21:32:43) ***agi will start work on debian packages in a couple of weeks, =
ENOTIME right now
(21:32:55) dazo: bootstrap =3D=3D prepare for ./configure to be runnable
(21:33:14) cron2: agi: the first users on ##openvpn already asked :-) - but=
 ENOTIME is a well-understood problem
(21:33:17) mattock: agi: nice! "testing" is probably seeing too little test=
ing as it is
(21:33:39) dazo: :)
(21:33:57) ***dazo would like to see some heavy testing ... but respects -E=
NOTIME :)
(21:34:04) mape2k: dazo, build openvpn with uclibc for freetz (MIPS) works =
fine these days
(21:34:12) dazo: mape2k:  cool!
(21:34:26) mape2k: maybe more tests this weekend
(21:34:32) dazo: mape2k:  when's the latest snapshot you got?
(21:34:47) cron2: mape2k: cool.  I'm looking forward to the OpenWRT package=
 :-)
(21:35:06) ***dazo too!
(21:35:46) mape2k: dazo: i create my own snapshot *g*
(21:36:34) mape2k: but we should provide some "official" snapshots for all =
users
(21:36:51) dazo: mape2k:  ahh! :)
(21:37:14) dazo: mape2k:  yeah, that's what ecrist is working on ... he nee=
ds that for FreeBSD ports
(21:38:21) cron2: ok, $wife is calling with $food.  That has priority now -=
 bye :-)
(21:38:42) ***dazo got a NMI from his wife as well :)
(21:40:11) mape2k: cron2: we'll order some pizza now ;)
(21:45:19) mattock: cron2: bye!
(21:50:33) d12fk_ ha abbandonato il canale (quit: Remote host closed the co=
nnection).
(21:52:41) ***agi leaves too. g'nite all
(21:52:54) dazo =EF=BF=BD=EF=BF=BD ora conosciuto come dazo_afk

--------------080000050502090206000702--

