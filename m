Message-ID: <4D2714C1.6040000@...515...>
Date: Fri, 07 Jan 2011 15:27:29 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080406090608080809090809"
Subject: [Openvpn-devel] Summary of the IRC meeting (6th Jan 2011)
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
--------------080406090608080809090809
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 6th Jan 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-01-06>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

Cron2, Essobi, dazo, jamesyonan and mattock were present in this meeting.

--

Discussed the PREfast error messages related to TAP-driver building
using Visual Studio C compiler:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-01-06#PREfasterrorm=
essages>

Agreed that these are probably false positives, as building of the TAP
drivers works just fine. Also, jamesyonan will generate the signed TAP
drivers, so even if these errors were real, they probably affect only
mattock's Windows build. Therefore decided not to do anything at the moment.

--

Discussed a build warning given by Visual Studio during openvpn.exe build:

 ssl.c (1918): warning C4019: '=3D' : different 'const' qualifiers

Dazo wrote a simple patch to fix this issue:

<http://openvpn.pastebin.ca/2039696>

Cron2 gave the patch an ACK.

--

Discussed a build warning given by Visual Studio during openvpnserv.exe

openvpnserv.c(278) : warning C4101: 'error_string' : unreferences local
variable

Mattock tested removing this variable definition and it removed the
warning. He will provide a patch which fixes this issue.

--

Discussed the snprintf issue in service-win32/openvpnserv.c:

<http://thread.gmane.org/gmane.network.openvpn.devel/4325>

Apparently the least bad solution is to replace the mysnprintf function
in openvpnserv.c with a copy of openvpn_snprintf function in buffer.c.
Although this results in some duplicate code, it avoids creating a
dependency from openvpnserv code to openvpn code: currently these
codebases are completely separate. Also, including only one function
("openvpn_snprintf") from buffer.c object file is probably not possible.

The alternative would be to use one of the "safe" snprintf methods
Microsoft provides, but they might not work properly on all OpenVPN
build setups unlike openvpn_snprintf from buffer.c.

Mattock promised to create a patch that fixes this issue.

--

Discussed mattock's "Added copying of files from service-win32 directory
to build root directory" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4320>

This patch is ugly, but allows using a single msvc.mak file to build
both openvpn.exe and openvpnserv.exe. This is difficult because nmake's
does not handle subdirectories - in this case service-win32 - well.

However, as jamesyonan pointed out, openvpn and openvpnserv codebases
are separate, so that openvpnserv build could be driven by a separate
makefile. Agreed that this solution would be cleaner. Mattock promised
to split openvpnserv.exe building into a separate nmake makefile in
service-win32.

--

Discussed inclusion of "signtool" python module into Git. This module is
a wrapper around "signtool.exe", which is used to sign OpenVPN's TAP
drivers. Jamesyonan said that releasing the signtool code would not be
possible. As using signtool.exe directly is still possible, agreed that
this is not a big issue.

--

Discussed the "Add 'dev_type' environment variable" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4194>

Jamesyonan and cron2 gave this patch an ACK.

--

Discussed the "New v3 plug-in API" patchset:

<http://thread.gmane.org/gmane.network.openvpn.devel/4255>

Jamesyonan gave the patchset an ACK after one minor change which dazo
promised to make. The modification will be sent to openvpn-devel for review.

--

Discussed Essobi's FIPS140-2 compliance patchset. Essobi will try to get
the first public release out before next week's meeting.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------080406090608080809090809
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-01-06.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-01-06.txt"

(20:02:50) mattock: mkay, meeting time
(20:03:11) mattock: everybody set? James should be coming shortly
(20:03:19) ***dazo is ready
(20:03:33) mattock: ok, so topic list here: https://community.openvpn.net/o=
penvpn/wiki/Topics-2011-01-06
(20:03:35) vpnHelper: Title: Topics-2011-01-06 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:03:38) mattock: lots of ACKing to do
(20:03:56) mattock: what if we start with the buildsystem stuff while James=
 is on his way?
(20:04:32) dazo: works for me!
(20:04:53) mattock: the "Building on Windows" article is updated: https://c=
ommunity.openvpn.net/openvpn/wiki/BuildingOnWindows
(20:04:55) vpnHelper: Title: BuildingOnWindows =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:05:30) mattock: so, the last thing remaining is to finish the NSI insta=
ller script
(20:05:38) mattock: it's getting there
(20:05:42) mattock: then we can start testing
(20:05:45) dazo: \o/
(20:06:00) mattock: I have absolutely no clue if the openvpnserv.exe is sup=
posed to work
(20:06:12) mattock: probably
(20:06:29) ***dazo wonders if ReactOS  has become useful enough to do some =
smoketesting .....
(20:07:19) krzie ha abbandonato il canale (quit: Ping timeout: 272 seconds).
(20:07:35) mattock: maybe... but probably not :)
(20:07:52) dazo: mattock: I believe openvpnserv.exe is used to register ope=
nvpn as a service ... which is critical
(20:07:57) mattock: dazo: have you committed any of my patches already?
(20:08:09) dazo: d303k: you around?  able to help out testing out mattock's=
 builds?
(20:08:18) mattock: dazo: that's correct... it just a service wrapper, not =
much more
(20:08:27) mattock: no code-level dependencies to openvpn yet
(20:08:31) dazo: mattock: nope, not yet ... I'm waiting for more commits, t=
o bundle them
(20:08:36) mattock: ok
(20:08:47) dazo: or more ACKs, that is
(20:08:59) mattock: would you mind looking at the list of build warnings wh=
ile I find out which of my patches are lacking an ACK?
(20:09:13) dazo: sure!
(20:09:24) mattock: buildsystem-related -> build warnings
(20:09:36) mattock: the PREfast error messages are interesting... not sure =
if we should be worried
(20:10:19) cron2: mattock: where's that url?
(20:10:20) dazo: I have no idea what PREfast even is ... so=20
(20:10:46) mattock: cron2: the warnings are listed here: https://community.=
openvpn.net/openvpn/wiki/Topics-2011-01-06
(20:10:49) vpnHelper: Title: Topics-2011-01-06 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:11:06) mattock: dazo: it's some sort of automatic code analysis tool in=
cluded in WinDDK... so related to TAP-driver build
(20:11:15) dazo: mm
(20:11:16) mattock: it just pops up soon after build
(20:12:18) cron2: i think you can get more details by clicking
(20:12:28) dazo: "openvpnserv.c(278) : warning C4101: 'error_string' : unre=
ferences local variable"
(20:12:46) dazo: this one is an easy fix ... it seems  error_string is not =
used at all, remove that declaration
(20:12:54) dazo: (or in other words, not critical at all)
(20:13:10) mattock: worth fixing, though
(20:13:14) dazo: agreed
(20:13:32) s7r [~s7r@...1445...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:14:10) dazo: ssl.c:1918 ... on my Fedora 13 box, SSL_get_current_cipher=
s()  is declared using a const ... while the input variable in ssl.c is not=
 a const.  If it is kicking about that, I'm rather surprised
(20:15:11) cron2: well, it's warning that the "const" modifier is lost
(20:15:14) dazo: it might be that it expects also the result to be const ..=
. however, I find this a bit odd ... which OpenSSL version are you compilin=
g against?
(20:15:17) cron2: - which is reasonable
(20:16:41) dazo: well, normally you can define a function with const ... an=
d the function is not allowed to modify it ... while the place this functio=
n is called shouldn't need to be const (at least this is my experience with=
 gcc), which indirectly gives a kind of assurance that the input variable i=
s not modified in the function
(20:17:13) dazo: but the variable may be modified outside the function with=
 the const declaration=20
(20:18:09) dazo: so, it's pedantic ... but I'm not saying it's right or wro=
ng ... I don't remember what K&R says about it, and haven't read the ISO sp=
ec
(20:18:44) cron2: KR& has no const at all
(20:19:12) cron2: you can pass a non-const variable *to* a const variable/f=
unction just fine, but not a from const to non-const
(20:19:37) dazo: agreed
(20:19:49) mattock: ok, now the list should be complete: https://community.=
openvpn.net/openvpn/wiki/Topics-2011-01-06
(20:19:50) vpnHelper: Title: Topics-2011-01-06 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:19:52) cron2: if SSL_get_current_cipher is declared "const", it's assum=
ed that the returned pointer is not used to modify things
(20:20:01) dazo: what the man page for the function says is:          SSL_C=
IPHER *SSL_get_current_cipher(const SSL *ssl);
(20:20:15) dazo: abd the code section in ssl.c is:
(20:20:18) dazo:   ciph =3D SSL_get_current_cipher (c_ssl);
(20:20:23) cron2: it's not the call, it's the assignment it's warning about
(20:20:33) cron2: maybe they changed this in openssl 1.0.0
(20:20:36) dazo: where neither c_ssl nor ciph is const
(20:20:59) dazo: yeah, I'm wondering about that ... I'm on Fedora 13, which=
 got 1.0.0c
(20:21:09) cron2: the warning explicitely states "'=3D': ...", so it must b=
e ciph
(20:21:34) dazo: agreed
(20:21:58) dazo: mattock: (re-asking) which openssl do you compile against?
(20:22:06) mattock: 1.0.0a
(20:22:16) dazo: hmm
(20:22:28) mattock: I'll verify that, just in case
(20:22:54) dazo: what about to update to 1.0.0c?
(20:22:59) dazo: just to be more recent
(20:23:44) dazo: ssl.c: In function =EF=BF=BD=EF=BF=BD=EF=BF=BDprint_detail=
s=EF=BF=BD=EF=BF=BD=EF=BF=BD:
(20:23:44) dazo: ssl.c:1918: warning: assignment discards qualifiers from p=
ointer target type
(20:23:46) mattock: yep, 1.0.0a...=20
(20:23:51) dazo: hmm ... I get that one on my box now
(20:23:58) mattock: update wouldn't hurt... except me :)
(20:24:03) dazo: heh :)
(20:24:34) mattock: did they skip 1.0.0b?
(20:24:44) mattock: or make two releases really fast?
(20:24:51) dazo: the latter, I believe
(20:24:59) dazo: hmmm ... from ssl.h .... const SSL_CIPHER *SSL_get_current=
_cipher(const SSL *s);
(20:25:05) mattock: ok, I'll update to 1.0.0c
(20:25:12) dazo: that's not in the man page
(20:26:24) dazo: http://openvpn.pastebin.ca/2039696
(20:26:27) dazo: that patch fixes it
(20:27:22) cron2: ack
(20:27:24) mattock: mailed james
(20:27:38) cron2: shouldn't harm older versions either
(20:27:52) dazo: cron2: thx!  I'll commit it now so we can get this one int=
o beta2.2 too
(20:27:53) mattock: I get "500 - Internal Server Error"
(20:27:57) mattock: :D
(20:28:16) dazo: http://www.fpaste.org/FPnh/
(20:28:21) dazo: mattock: ^^=20
(20:28:25) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(20:28:32) mattock: hi jamesyonan!
(20:28:42) jamesyonan: hi!
(20:28:44) dazo: \o/
(20:29:03) mattock: topic list is here: https://community.openvpn.net/openv=
pn/wiki/Topics-2011-01-06
(20:29:05) vpnHelper: Title: Topics-2011-01-06 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:29:35) mattock: dazo: so you managed to handle the ssl.c and openvpnser=
v.c warnings?
(20:29:59) dazo: mattock: openvpnserv.c  have just a theoretical hunch ... =
ssl.c, cron2 just ack'ed
(20:30:48) mattock: jamesyonan: what do you think about the PREfast errors?
(20:31:03) mattock: are they something we should be worried about? they are=
 not fatal build errors at least
(20:31:04) dazo: mattock: but you may try to remove error_string declaratio=
n and compile it ... if that works, you've fixed it :)
(20:31:12) mattock: dazo: I'll try that
(20:33:19) jamesyonan: they look like false positives to me
(20:33:40) mattock: ok, good
(20:34:07) jamesyonan: does the compiler complain at all?
(20:34:28) mattock: I don't think so, but I can recheck
(20:34:53) mattock: ...checking
(20:35:40) jamesyonan: the PREfast errors are coming from MS code
(20:37:13) dazo: okay, buildsystem patches?
(20:37:18) mattock: ok, so after it has built the TAP driver, it says "4 fi=
les compiled, 6 warnings"
(20:37:30) mattock: but it does not show the warnings (by default, I assume)
(20:38:35) mattock: given that we need to use James' signed TAP driver anyw=
ays, this is not critical
(20:38:46) cron2: ack
(20:38:55) jamesyonan: I'm not sure that "6 warnings" is real -- the build =
script is supposed to throw a fatal error on a real warning
(20:39:07) mattock: jamesyonan: ok
(20:39:20) mattock: so let's leave it be for now :)
(20:39:39) mattock: so the un-ACKed buildsystem patches
(20:39:44) mattock: list on the topic page now
(20:40:12) mattock: the last three are more or less trivial
(20:40:34) mattock: except that last one has an ACK already :)
(20:41:19) dazo: mattock: ACK on this one -->  http://thread.gmane.org/gman=
e.network.openvpn.devel/4326
(20:41:21) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:41:31) mattock: ok, thanks!
(20:41:35) jamesyonan: re: snprintf -- at one point MS snprintf was unsafe =
and didn't guarantee a trailing null -- that's why we have openvpn_snprintf
(20:42:10) mattock: jamesyonan: any reason why mysnprintf (from openvpnserv=
.c) is used instead of openvpn_snprintf (from buffer.c) ?
(20:42:19) dazo: Even though this will make openvpnserv.exe depending on bu=
ffer.[ch] ... I think compiling and linking in that one and use openvpn_snp=
rintf() is the way to go
(20:42:31) dazo: (less duplicated code)
(20:42:51) jamesyonan: well openvpnserv.c is a separately linked exe
(20:43:36) dazo: but it shouldn't make a difference, if you link in the buf=
fer.o anyway, using that function from there?
(20:44:20) jamesyonan: that might pull in other modules
(20:45:04) dazo: also if those other functions are not used?  Isn't the lin=
ker that clever that it only takes those pieces it needs and not the comple=
te file?
(20:45:26) dazo: openvpn_snprintf() shouldn't bring it much extra, afair
(20:45:37) mattock: is _Visual Studio linker_ that smart? :)
(20:45:41) jamesyonan: it's certainly clever when dealing with libraries --=
 not sure if that cleverness extends to object files
(20:45:44) cron2: dazo: usually not
(20:45:57) cron2: normally objects are pulled in completely, or not at all =
(from libraries)
(20:46:20) jamesyonan: I would either (a) redefine openvpn_snprintf for the=
 service, or use one of the MS "safe" string functions
(20:46:53) mattock: jamesyonan: would these "safe" string functions work on=
 non-visual studio builds, too?
(20:47:36) dazo: cron2: interesting ... I use that technique with good succ=
ess in eurephia ... well, a lot of objects are compiled into a static libra=
ry ... and the linker only extracts those pieces it needs
(20:47:53) jamesyonan: not sure -- you would need to see if mingw header fi=
les define them
(20:47:58) cron2: dazo: well, from the library, yes, but normally it will p=
ull "whole objects" from the library
(20:48:20) cron2: not "individual functions from object files"
(20:48:26) dazo: ahh, I see
(20:48:32) mattock: I'm wondering if duplicating openvpn_snprintf would be =
safest... at least it is known to work
(20:48:41) dazo: agreed
(20:48:59) dazo: and that would fit well with Matthias' comment on the mail=
ing list as well
(20:49:17) jamesyonan: yeah, that makes sense
(20:49:18) mattock: I think so, got to read his post again
(20:49:56) mattock: if the fix is as trivial as I think, I can do it
(20:50:08) mattock: if it requires even least bit of C knowledge, I'll skip=
 it :)
(20:50:57) dazo: mattock: just throw out mysnprintf() ... and copy the comp=
lete openvpn_snprintf() function over ... and rename all mysnprintf() calls=
 to openvpn_snprintf()
(20:51:08) mattock: yep, that's what I meant about trivial :)
(20:51:19) dazo: it shouldn't require much more than that :)
(20:51:22) mattock: ok, so this one is still lacking ACK: http://thread.gma=
ne.org/gmane.network.openvpn.devel/4320
(20:51:24) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:51:43) mattock: my solution is ugly, but works
(20:52:01) mattock: jamesyonan: any ideas if nmake can manage source files =
located in subdirectories? e.g. service-win32?
(20:52:19) mattock: I tried it an it failed... and google results were most=
 depressing ("use GNU make") :)
(20:53:14) mattock: in a nutshell, I modified the Python files to copy stuf=
f from service-win32 to $BUILDROOT and clean up afterwards
(20:53:27) mattock: although msvc.mak does the cleaning up, to be exact
(20:55:14) jamesyonan: why is this needed?  why not just generate an approp=
riate .mak file in service-win32 and build from there?
(20:56:00) mattock: ok, so $BUILDROOT/msvc.mak.in is auto-generated from wi=
n/msvc.mak.in
(20:56:23) jamesyonan: basically, yes
(20:56:36) mattock: I'm not sure how to manage files in subdirectories with=
 nmake... probably a separate msvc.mak file inside service-win32 could also=
 do the trick
(20:56:49) mattock: and calling that from Python
(20:57:07) jamesyonan: yes, I don't think nmake has to be exposed to the su=
bdirectory structure
(20:57:24) mattock: subdirectory handling in nmake seemed to be crude... or=
 poorly documented at least
(20:58:08) mattock: any reason why service-win32 code is in a subdirectory =
in the first place, btw?
(20:58:40) jamesyonan: it's a different build target
(20:59:08) mattock: ok
(20:59:46) mattock: if there are no code-level dependencies between openvpn=
 and openvpnserv then another msvc.mak file would probably be a little clea=
ner
(20:59:58) jamesyonan: yes
(21:00:28) mattock: ok, I can change the approach then... shouldn't take lo=
ng
(21:00:55) mattock: on to the "Other" section if you don't mind...
(21:01:43) mattock: jamesyonan: does Python buildsystem support prebuilt TA=
P drivers already? Not that copying them manually into dist/i386 and dist/a=
md64 would be hard...
(21:02:01) jamesyonan: yes
(21:03:06) mattock: ok
(21:03:07) jamesyonan: see build_exe.py
(21:03:24) mattock: ok, excellent
(21:03:31) jamesyonan: this does a build of only openvpn.exe, not tap drive=
rs
(21:04:47) mattock: one more thing... could the SignTool python module be i=
ncluded in Git? I assume it's a fairly trivial wrapper and some people migh=
t want to sign their own TAP drivers
(21:05:08) mattock: and currently signing functionality is lacking
(21:05:42) mattock: I mean "signtool" python module
(21:07:08) mattock: (signtool.exe is the executable doing the hard work)
(21:07:41) jamesyonan: I'm not sure if we can release that
(21:08:50) mattock: it is just a wrapper, right?
(21:09:06) mattock: around signtool.exe
(21:09:12) jamesyonan: yes
(21:09:35) mattock: I just have the feeling that when somebody needs signed=
 drivers they'll rewrite the wrapper and post a patch
(21:10:01) mattock: not sure if people want to sign their own drivers, thou=
gh
(21:10:11) mattock: atm this not critical I think
(21:10:20) dazo: lets rather document it then, and state that we won't acce=
pt patches related to that
(21:10:40) jamesyonan: I'm thinking most people who sign drivers would just=
 use the existing MS tools
(21:11:32) dazo: true
(21:12:05) mattock: ok, let's move on, shall we?
(21:12:18) mattock: ... to leftovers: http://thread.gmane.org/gmane.network=
.openvpn.devel/4194
(21:12:20) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:12:20) dazo: :)
(21:13:10) cron2: ISTR I said last time that the code looks good and safe t=
o me
(21:13:43) cron2: (and I don't see myself actually *needing* that functiona=
lity, so I can't comment on whether we "want" to have this)
(21:14:00) jamesyonan: seems reasonable
(21:14:08) dazo: This feature is needed in those cases where you use f.ex. =
--learn-address script hook ... which in TAP mode will get a MAC address or=
 in TUN mode get an IP address
(21:14:18) dazo: jamesyonan: so that's an ACK from you?
(21:14:37) cron2: dazo: why not just name your devices "tunX" and "tapY" in=
 the first place?
(21:14:46) jamesyonan: yes, I'm fine with it
(21:14:51) dazo: cron2: some people want to be special :)
(21:15:03) dazo: that's why we have --dev-type too, isn't it?
(21:15:21) dazo: it might be platform specific too, for all what I know abo=
ut
(21:15:22) cron2: dazo: those people *could* just look at the address, a MA=
C look distinctly different :-)
(21:16:15) cron2: IIRC, --dev-type is needed on windows where the driver is=
 the same
(21:16:44) dazo: cron2: true, but in other parts, it behaves differently to=
o ... f.ex.  --learn-address isn't called on client disconnects in tun mode=
, while it is on tap mode ... and if you have some other scripts or C plug-=
ins with more hooks enabled, you need to catch this
(21:16:44) cron2: (--dev-node My Tap Driver, --dev-type tun)
(21:16:56) dazo: yeah
(21:17:21) cron2: but anyway, no objections from here, just rambling
(21:17:25) dazo: :)
(21:17:27) dazo: Thx!
(21:17:29) dazo: next one?
(21:17:36) mattock: yep: http://thread.gmane.org/gmane.network.openvpn.deve=
l/4255
(21:17:38) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:17:48) mattock: oh, a big one
(21:17:49) dazo: v3 plugin API ... that's a bigger one
(21:18:07) mattock: patch by patch from 1 to 4?
(21:18:23) ***cron2 abstains (I have seen the patches, but not looked close=
ly)
(21:18:30) cron2: ... and I need to leave now: $wife is hungry
(21:18:32) dazo: yeah, unless all gets an ACK
(21:18:39) dazo: cron2: enjoy!
(21:18:57) mattock: typo in the first patch: "Aruguments used to transport.=
.."
(21:19:08) dazo: grrrr
(21:19:11) mattock: twice=20
(21:19:18) mattock: you've been copying and pasting? :)
(21:19:25) dazo: never! :-P
(21:19:36) mattock: thrice!
(21:19:40) mattock: :D
(21:19:55) Essobi: Atleast he's consistent.
(21:20:01) dazo: Okay, I'll fix those ones ... you want to see new patches?=
 ;-)
(21:20:07) dazo: lol
(21:20:14) mattock: essobi: :)
(21:20:45) mattock: jamesyonan: thoughts regarding patch #1?
(21:21:12) dazo: They probably need to be seen as part of a complete set
(21:21:25) dazo: at least the two first ones
(21:21:27) Essobi: Hey, whenever the meeting is over.. Can a few people sti=
ck around for a few questions regarding the FIPS 140-2 patches please?  I'm=
 getting close to wrapping up testing everything and need to verify a few t=
hings.
(21:21:49) mattock: essobi: of course, or we can add them to agenda to make=
 them "official"
(21:22:46) jamesyonan: Plugin API patch set looks fairly reasonable
(21:22:59) Essobi: mattock: Thats fine if you want to add them.  I'm trying=
 to locate any cryptographic code that isn't OpenSSL, so I can wrap them in=
 configure --options.  they have to be disabled to comply with FIPS 140-2.
(21:23:03) dazo: jamesyonan: something you would like differently?
(21:23:33) jamesyonan: Essobi: yes, I will be around
(21:24:34) mattock: essobi: added to "Patches" section: https://community.o=
penvpn.net/openvpn/wiki/Topics-2011-01-06
(21:24:35) vpnHelper: Title: Topics-2011-01-06 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:26:58) jamesyonan: dazo: how do you version the new struct you are addi=
ng for communication with the plugin?
(21:27:55) dazo: it uses the OPENVPN_PLUGIN_VERSION ... and it should be an=
 argument to the openvpn_plugin_{open,func}_v3() functions
(21:28:41) dazo: I took that out of the struct and as an explicit argument =
to those functions, to be able to check version without looking inside the =
struct
(21:28:59) dazo: ... and _added_ as an expl....
(21:29:02) Essobi: mattock: Thanks.
(21:29:21) jamesyonan: dazo: if I add a new member to the struct, does that=
 mean that I have to increment OPENVPN_PLUGIN_VERSION?
(21:29:38) dazo: yes, that was the conclusion we ended up with last time
(21:30:01) dazo: I added a different constant for that, but was asked to us=
e OPENVPN_PLUGIN_VERSION instead
(21:30:17) dazo: But I can change that, if you want
(21:30:46) jamesyonan: usually what people do for structure versioning in C=
 is that they put an "int version" at the head of the structure
(21:31:29) dazo: Yeah, I know ... but I didn't see what that would benefit =
more than passing it as a function argument
(21:32:06) dazo: as the plug-in is compiled against version X ... and OpenV=
PN against version Y ... it still needs to read that variable and decide wh=
at to do
(21:33:03) jamesyonan: I guess the question is -- should the structure vers=
ioning be different from the OPENVPN_PLUGIN_VERSION
(21:33:57) dazo: My initial patch did differentiate that, as I thought that=
 would be cleaner.  But I'm not sure if it makes sense or not to differenti=
ate it or not
(21:34:07) jamesyonan: i.e. if I add a new member to structure, and this re=
quires incrementing OPENVPN_PLUGIN_VERSION, will this have side effects
(21:34:17) dazo: yes, agreed
(21:35:19) dazo: I can add a 5 patch to this patch-set, where I will re-add=
 another constant, and set it to 1 ... and pass that one as the *_v3 plugin=
 arguments
(21:35:42) dazo: (man I write horrible today ... 5th patch)
(21:35:51) jamesyonan: yes, I think that makes sense
(21:36:22) dazo: Okay, I'll fix that soon and send it to this mailing threa=
d ... and we can discuss it again next week
(21:37:06) mattock: essobi's patches now?
(21:37:43) dazo: I need to go very very soon ... but I believe james is pro=
bably better suited for the FIPS stuff anyway
(21:37:59) jamesyonan: yes, I can stick around for this
(21:38:31) mattock: excellent!
(21:40:38) dazo: c'ya!  thx for a good meeting!
(21:40:57) Essobi: Okay, so to meet compliance you need a very specific bui=
ld of openssl FIPS.  I've wrote a shell script to assist with this, and I'm=
 going to write up a white paper on the full details of how to do it by han=
d and to use the script, and how to docuement whats needed to meet complian=
ce.
(21:41:13) Essobi: Outside of that, I have to patch up ssl.c to meet compli=
ance.
(21:42:05) Essobi: The patch to ssl.c thus far is very small, but I need to=
 locate any cryptographic code that is called in openvpn natively, so I can=
 wrap configure options around them to disable them.
(21:42:45) jamesyonan: cryptographic code should only be called from ssl.c =
and crypto.c
(21:42:55) Essobi: One of the requirements to using the FIPS module and mai=
ntain compliance, is no cryptography code can be used inside the native app=
lication you're extending compliance to.  It has to be in the module only.
(21:43:19) jamesyonan: what's the definition of cryptographic code?
(21:43:22) Essobi: jamesyonan: Okay, I'll check out crypto.c.. Someone gave=
 me the impression there was more somewhere else.
(21:43:46) jamesyonan: code that is actually doing crypto, or code that is =
calling OpenSSL to do crypto?
(21:44:05) Essobi: Code that is doing actual encryption/decryption.
(21:44:11) Essobi: outside of the module.
(21:44:21) jamesyonan: also, is random number generation considered to be c=
rypto?
(21:44:50) jamesyonan: nothing in openvpn does crypto directly
(21:45:02) dazo =EF=BF=BD=EF=BF=BD ora conosciuto come dazo_afk
(21:45:02) Essobi: The RNG is part of the spec, but so long as it meets the=
 RNG requirements set fourth, it's usable.  it's not part of openssl per se=
 but they require it meet certain requirements.
(21:45:19) Essobi: jamesyonan: I was under the impression there was some NT=
LM legacy code for firewall traversal.
(21:45:31) Essobi: jamesyonan: But was unable to locate it, hence why I'm a=
sking here. :)
(21:46:07) Essobi: So.. If anyone can think of any encryption/decryption/sa=
lts/digests/etc that is done without openssl.. Please let me know. :)
(21:46:43) jamesyonan: you can take a look at ntlm.c
(21:46:49) Essobi: Roger that.
(21:47:21) jamesyonan: it's doing some fairly low-level protocol constructi=
on, but I don't know that it would constitute "crypto"
(21:48:20) jamesyonan: there is also cryptoapi.c and pkcs11.c that abstract=
s the RSA object so that RSA signing operations are done externally
(21:48:40) jamesyonan: this is needed when the TLS private key is non-local
(21:48:53) Essobi: I'd say no.  I believe it specifically applies to any cr=
yptographical methods that 1. could be implemented by openssl, but the app =
is doing itself, or anything that is using a cypher that isn't available to=
 the FIPS compliance as it's considered insecure.
(21:49:41) Essobi: jamesyonan: http://www.openssl.org/docs/fips/SecurityPol=
icy-1.2.pdf  that's the currect security policy regarding using the openssl=
 crypto libs
(21:49:58) Essobi: openssl FIPS object module, even.
(21:50:16) Essobi: 4.5 specifically outlines what's allowed
(21:51:30) Essobi: Hmm. for cryptographic algos
(21:53:00) Essobi: jamesyonan: I'll have to take a look at the pkcs abstrac=
tion isn't breaking the policy agreement, but if I understand what you're s=
aying, that may be disallowed completely by the security policy.
(21:54:33) jamesyonan: well the issue with pkcs11 is that offloading RSA op=
erations is essential for smart-cards and similar tech
(21:56:08) Essobi: Right from what I've gathered FIPS 140-2 and Smart-cards=
 may be mutually exclusive of each other.
(21:56:08) jamesyonan: I'm not as familiar with the pkcs11 code, but the ba=
sic idea is that you are overloading the RSA_sign method, and having an ext=
ernal agent (such as a smartcard) do the actual signing
(21:56:58) Essobi: unfortunately the spec is pretty near-sighted, and didn'=
t take much in the future into account.
(21:57:20) Essobi: They're working on a re-draft in the near future I under=
stand.=20=20
(21:57:33) mattock: I assume you guys will be ok if I leave?
(21:57:49) mattock: I'll write a summary tomorrow and sent it to openvpn-de=
vel
(21:57:53) Essobi: I don't see why not.
(21:57:56) Essobi: Thanks.
(21:58:39) jamesyonan: Essobi: are you saying that FIPS 140-2 allows smartc=
ards?
(21:58:49) Essobi: jamesyonan: I'll see if there's any open petitions/RFCs =
out for the next 140-2 draft, and request smart cards get in there.
(21:59:21) Essobi: jamesyonan: It does if it's part of the openssl specific=
 framework.
(21:59:35) Essobi: jamesyonan: Otherwise, it won't work.
(21:59:51) jamesyonan: it's kind of hard to believe that it would disallow =
smart cards, because they are extensively used in federal gov.
(22:00:04) Essobi: 140-2 was drafted long ago. ;)
(22:00:15) Essobi: It's up for re-draft in the next year of two, iirc
(22:01:18) Essobi: First publish was 2001, and I believe they started on it=
 in 1998.
(22:02:13) Essobi: Now.. Here's the thing, if the openSSL crpyto module can=
 support it, and that version gets verified, it's usable via the openssl ca=
lls.
(22:03:56) Essobi: It's scary when you see the list of credentials and alph=
abet soup agencies that worked on this draft, and how narrow-minded some of=
 it was done.
(22:03:57) jamesyonan: I'm thinking that there must be a policy interpretat=
ion that support it, because we know that (a) the fed gov is a huge user of=
 smartcards, and (b) the fed gov would require FIPS compliance
(22:05:06) Essobi: jamesyonan: It's not against ALL of the policies.  Just =
the OpenSSL FIPS 140-2 module.
(22:05:44) Essobi: that version (0.9.8 forked between f and j) didn't suppo=
rt loading the RSA sign from a smartcard.
(22:05:52) Essobi: and you're calling it outside of the module.
(22:06:18) Essobi: Now there might be a version of NSS, or someother crypto=
 lib that got FIPS compliance
(22:06:56) Essobi: You can however, take a FIPS compliant crypto accel that=
 is supported in that version of openssl, and use it and the net result is =
still compliant.
(22:07:52) jamesyonan: I see -- so you're saying the openssl FIPS 140-2 for=
k doesn't even include the capability to overload RSA sign?
(22:07:59) Essobi: So that's the thing.. if openssl gets smartcard support =
that works the same way, it tells me that a solution is available, but.. it=
 take about US $50K-80K and 3 years to get a version of anything with FIPS =
140-2 compliance.
(22:08:27) Essobi: jamesyonan: I'll double check, but from what I understan=
d, it's chopped down a lot.
(22:09:31) jamesyonan: how does the FIPS openssl branch deal with security =
issues that require patches?
(22:09:33) Essobi: jamesyonan: Also to note.. once 140-2 mode is enabled, i=
f you make a openssl function call that isn't supported, the module it abor=
ts everything, so testing could be potentially easy if you have someone who=
'd be willing to let me break their box. :)
(22:09:58) Essobi: jamesyonan: If it's something that appliess to it, they =
get an emergency review patch.
(22:10:20) Essobi: Major code changes are required to be re-certified.
(22:11:13) jamesyonan: does this really happen in practice? -- I've seen ma=
ny critical openssl patches that were not accompanied by a revised FIPS pac=
kage
(22:11:17) Essobi: so 1.0 is up in the works.. OSSI is trying to get the fu=
nding up for 1.0 but a lot of the commercial supports withdrew their moneta=
ry donations.
(22:11:53) Essobi: There's been 4-5 revisions now to the 0.9.8
(22:12:08) Essobi: but to be honest, FIPS 140-2 is always behind
(22:12:34) Essobi: Off the record, I think it's a scam in a lot of ways.=20=
=20
(22:12:47) Essobi: But at the same time, they require some things no one el=
se does.
(22:13:32) Essobi: For instance, it retests the RNG during runtime to confi=
rm it hasn't been tainted after the startup check is performed.
(22:14:08) Essobi: It also verifies a hash of the .so at startup to prevent=
 ld preload rootkits
(22:14:31) jamesyonan: this is really the achilles heel though -- even if c=
ritical FIPS 140-2 patches are released a day late, that could be catastrop=
hic from a security perspective
(22:14:43) Essobi: And verifies the signature in memory so that the module'=
s contents can't be modified.
(22:14:54) Essobi: jamesyonan: I'm not argueing that, believe me.
(22:15:45) Essobi: jamesyonan: They concentrated on a few particular things=
 regarding the cryptography, and left the protocols out flapping in the win=
d.
(22:16:13) jamesyonan: starting to sound like security theater
(22:16:26) Essobi: Well.. Tell the Feds that. ;)
(22:16:47) Essobi: Unfortunately ALL of the FIPS 140-2's have to play by th=
ose rules.
(22:17:03) jamesyonan: verifying the .so hash isn't going to stop someone f=
rom reading /dev/kmem
(22:17:43) Essobi: Windows, Android, RedHats, and OpenSSL's stacks all are =
stuck in the same boat with FIPS 140-2.
(22:18:02) Essobi: jamesyonan: GDB/strace/ktrace/ptrace/kmem are all disall=
owed.
(22:18:09) Essobi: *EYE ROLL*
(22:18:12) Essobi: I know.
(22:18:53) Essobi: There's even an EMF/EMI standard you can get under 140-2.
(22:19:10) Essobi: ... I didn't think there was much Van Eck phreaking goin=
g on still.. hehe.
(22:19:36) Essobi: and seriously.. If I've got gear good enough to read you=
r memory, remotely, you've got bigger problems.
(22:20:50) Essobi: jamesyonan: Red hat took it one step further and require=
s you to run the box in single-user mode, with a slightly modified initd to=
 run your app.=20
(22:22:57) jamesyonan: anyway, let's get back to the build discussion
(22:23:28) jamesyonan: re: RND -- see the prng_bytes function in crypto.c -=
- this is used for explicit IV generation
(22:24:10) Essobi: Okay.. IV?=20=20
(22:24:20) jamesyonan: this can be trivially modified to proxy RAND_bytes i=
f needed for compliance
(22:24:52) Essobi: here's what the spec states
(22:24:59) Essobi: The Module supports generation of DH, DSA, and RSA publi=
c=EF=BF=BD=EF=BF=BDprivate key pairs. The Module employs an ANSI X9.31 comp=
liant random number generator for creation of asymmetric and symmetric keys.
(22:25:03) Essobi: The developer shall use entropy sources that contain at =
least 128 bits of entropy to seed the RNG as the module is not capable of d=
etecting randomness or quality of the seeding material provided.
(22:25:49) Essobi: So long as the seeding is compliant I believe, that's fi=
ne.
(22:27:01) jamesyonan: yes, it's seeded from RAND_bytes
(22:28:47) Essobi: ah, yes, I see it.
(22:29:39) Essobi: so long as 128 bits are passed back that will suffice
(22:30:21) Essobi: I'm pulling up the docs on the function now.. I'll revie=
w them and make sure those all meet spec.
(22:34:01) Essobi: So it would appear that function requires explicitly tha=
t the PRNG provide the entropy.  I believe those are all seeded from the OS=
 level.
(22:35:05) jamesyonan: yes
(22:36:38) Essobi: PRNG is testest at startup, and during run-time of the m=
odule.  Seeding it will obviously be outside of OpenVPN.  I'll document how=
 to make sure you're seed is random enough.=20
(22:36:44) Essobi: tested, even
(22:37:59) Essobi: Hmm..  Any other points of interest you can think of?  I=
'd like to get the patch finished and put together before next weeks meetin=
g, and see if anyone has a problem with them.
(22:38:44) jamesyonan: do you have a draft of the patch online yet?
(22:39:35) jamesyonan: I think we've discussed all the places in the code w=
here crypto or RND functionality is touched
(22:41:30) Essobi: I havn't posted it yet.  online yet..=20
(22:41:46) Essobi: Initing the openssl functionality it really trivial.
(22:42:17) Essobi: It's literally...
(22:43:40) Essobi: OPENSSL_init(); if (FIPS_mode_set(1)) {fputs("FIPS mode =
enabled\n",stderr);}=20
(22:44:20) Essobi: So I need to write up the configure wrappers to enable t=
hat block and an else exit();
(22:45:39) jamesyonan: do you need to change the default cipher/MAC?
(22:47:27) Essobi: I'm not sure.
(22:48:00) Essobi: Is that an openssl init option or are you referring to a=
 openvpn specific config option?
(22:48:23) jamesyonan: have you actually built openvpn client/server and co=
nnected them up using FIPS module?
(22:48:38) Essobi: Yes.
(22:49:20) jamesyonan: because openvpn uses blowfish as its default cipher =
-- does FIPS 140-2 support this?
(22:49:51) Essobi: Using a config I had laying around.. It's was wrote by a=
 predecessor of mine, so likely he wrote it to use what met the spec.
(22:50:33) Essobi: No, blowfish isn't FIPS-approved
(22:51:20) Essobi: Any unapproved modules called once you're in FIPS mode, =
error out.
(22:51:40) jamesyonan: that's what I guessed -- so you would need to use AE=
S or something else
(22:51:55) Essobi: I suppose it would be better to change the defaults once=
 FIPS is enabled.
(22:52:03) Essobi: Where are the defaults defined?
(22:52:32) jamesyonan: options.c:  o->ciphername =3D "BF-CBC";
(22:52:37) Essobi: I'll include that in the patch set.
(23:13:14) Essobi: jamesyonan: Well.. Unless you can think of anything else=
, I'm going to go start putting this patch together.
(23:13:20) Essobi: jamesyonan: Thanks for all your help.
(23:13:31) jamesyonan: sure thing
(23:13:41) Essobi: jamesyonan: I've got a good outline of what I need to fi=
nish up now.
(23:25:48) Essobi: Thanks again everyone.
(23:38:24) Essobi: jamesyonan: AES-256-CBC is supported.
(23:38:53) jamesyonan: yes, that makes sense as a good default

--------------080406090608080809090809--

