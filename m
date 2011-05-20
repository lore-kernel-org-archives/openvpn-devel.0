Message-ID: <4DD69FB8.9080404@...515...>
Date: Fri, 20 May 2011 20:07:04 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010700010704010304060803"
Subject: [Openvpn-devel] Summary of the IRC meeting (19th May 2011)
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
--------------010700010704010304060803
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 19th May 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-05-19>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, jamesyonan and mattock were present in this meeting.

--

Discussed the "Fix const declarations in plug-in v3 structs" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4629>

Cron2 gave this patch an ACK.

--

Discussed the "Make '--comp-lzo no' the default behaviour if LZO is
enabled":

<http://thread.gmane.org/gmane.network.openvpn.devel/4650>

Decided to NACK this patch as it would change the OpenVPN protocol.

--

Discussed "Visual Studio 2008 build errors in "master" branch" bug:

<https://community.openvpn.net/openvpn/ticket/137>

This is a composite of several unrelated issues. Debugged and fixed some
of these during the meeting. Mattock attached a patch and new buildlogs
to the ticket on Friday.

An another patch announced earlier on #openvpn-devel may fix some of
these build problems, too:

<http://codepad.org/tqq5hmHz>

--

Discussed the potential OpenVPN MI GUI and OpenVPN-GUI merging:

<http://openvpn-mi-gui.inside-security.de>
<http://sourceforge.net/projects/openvpn-gui>

Apparently nothing has happened on this front. Decided to continue with
the original plan of using new OpenVPN-GUI in Windows development
builds, and ultimately in OpenVPN 2.3 regardless of whether these
projects are merged or not.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------010700010704010304060803
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-05-19.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-05-19.txt"

(21:03:04) dazo: mattock: jamesyonan: meeting time?
(21:03:17) cron2: meeting time!
(21:03:17) ecrist: Thu May 19 18:03:17 UTC 2011
(21:03:36) cron2: building a 2.2+ipv6 windows build right now...
(21:04:28) mattock: hi
(21:04:34) dazo: \o/
(21:05:02) mattock: topic list: https://community.openvpn.net/openvpn/wiki/=
Topics-2011-05-19
(21:05:04) vpnHelper: Title: Topics-2011-05-19 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:05:35) cron2: ACK on the first patch (const / plugin-v3).  If it compil=
es both on Linux and Windows, make it so :-)
(21:05:49) mattock: maybe start from the top?
(21:05:56) mattock: oh, too fast
(21:06:25) mattock: what about --comp-lzo, then?
(21:06:30) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/4650
(21:06:31) dazo: that one is more tricky
(21:06:32) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:06:55) mattock: dazo: I assume you're thinking about Alon's more generi=
c approach to the problem
(21:07:12) dazo: I tried it ... and --comp-lzo off and not defining --comp-=
lzo  actually changes the protocol slightly
(21:07:48) dazo: so when adding my patch, the server needs to do --comp-lzo=
 disabled .... or unpatched clients need to do --comp-lzo
(21:07:58) cron2: I haven't looked at the traces and what exactly the patch=
 does
(21:07:59) dazo: so I'm sceptical to applying my own patch ;-)
(21:08:29) dazo: Alon's approach makes a lot of sense too ... but it attack=
s the issue from a different angle
(21:08:50) cron2: and has a far bigger impact on the code
(21:08:56) dazo: and with my patch ... when using --comp-lzo disabled ... i=
t would get enabled again on the second connection attempt
(21:09:06) cron2: now that sounds broken
(21:09:12) dazo: yeah
(21:09:22) mattock: jamesyonan: have you taken a look at that thread?
(21:10:01) dazo: so I've been looking at the code, to figure out where and =
when this push is applied ... and in that place, check what the state of --=
comp-lzo is, to consider if it should be honoured or not
(21:10:51) dazo: if --comp-lzo is disabled (not defined in the current rele=
ased versions), it should just ignore any pushed --comp-lzo statements from=
 the server ... or disconnect with an error if incompatible
(21:11:15) cron2: ack
(21:11:37) dazo: I've not had time to complete a patch for this ... but it'=
s on my todo list
(21:12:46) dazo: so, bottom line is ... I like Alon's way of thinking here =
... but I don't think it's really enough, in the perspective of user friend=
liness when comp-lzo options differ and are incompatible
(21:14:15) mattock: what do you mean by user friendliness?
(21:15:47) cron2: it should be clear what happens if something is configure=
d on the client end - "just try twice and it will be different" is "weird"
(21:15:50) dazo: that openvpn should handle incompatibility between server =
and client settings of comp-lzo better ... now it just keeps retrying forev=
er, claiming LZO header field is too short
(21:16:01) jamesyonan: is this just a matter of replacing "lzo no" with "lz=
o disabled"?
(21:16:36) dazo: jamesyonan: no, it also changes the default behaviour from=
 "not defined comp-lzo" to "comp-lzo no" as default
(21:16:44) mattock: cron2: true, that should never happen
(21:16:50) dazo: and my testing showed that that was not clever
(21:17:26) jamesyonan: yeah, but that could have protocol-breaking effects
(21:17:53) dazo: yeah, I noticed that ... I'm considering to withdraw that =
patch due to that
(21:17:57) jamesyonan: because if one side of the connection had this patch=
, and the other didn't, the protocol could break
(21:18:34) dazo: yeah, you then need either --comp-lzo no (for unpatched) o=
r --comp-lzo disabled (for patched) to stay compatible
(21:19:42) dazo: the enhancement of not needing to set --comp-lzo in client=
 configs might not be bad, to be able to push --comp-lzo easier ... however=
, it then needs to be really clear in release notes ... and it will cause i=
ncreased support needs ... so not sure if its worth it
(21:20:16) dazo: it sounds for me though that this is something we rather s=
hould consider for OpenVPN 3.
(21:22:07) mattock: perhaps this stuff should be written to the Roadmap? or=
 maybe a Trac ticket with milestone 3.0
(21:22:13) mattock: lest we forget
(21:22:21) dazo: yeah, agreed
(21:23:22) mattock: dazo: can you write this down? my knowledge of this pus=
hing stuff is fairly limited
(21:23:36) dazo: Sure can do
(21:23:52) dazo: it's actually not directly related to pushing ... it's def=
ault protocol features
(21:24:32) mattock: ok, excellent!
(21:24:34) mattock: next topic?
(21:24:48) mattock: visual studio build errors: https://community.openvpn.n=
et/openvpn/ticket/137
(21:24:50) vpnHelper: Title: #137 (Visual Studio 2008 builds fail on "maste=
r" branch) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.open=
vpn.net)
(21:24:58) mattock: everybody's favorite C compiler and toolchain :D
(21:25:14) mattock: cron2: you said fixing those errors would be painful?
(21:26:49) krzee ha abbandonato il canale (quit: Ping timeout: 248 seconds).
(21:27:28) mattock: jamesyonan: did you take a look at the VS build errors =
already?
(21:27:52) mattock: I assume you've gathered a fair amount of knowledge abo=
ut Visual Studio=20
(21:28:41) cron2: mattock: well, let me phrase it differently: fixing these=
 errors and then cherry-picking those bits that are "ipv6_payload" back to =
the 2.2-based patch, this will be lots of git work
(21:29:20) mattock: ok, that makes sense
(21:29:24) cron2: it seems that half of the errors is due to inet_pton and =
inet_ntop being predefined in visual studio (but not in msys/mingw), and th=
e declarations do not match
(21:29:30) mattock: so fixing the errors itself is relatively easy
(21:30:08) vpnHelper: RSS Update - testtrac: Fix const declarations in plug=
-in v3 structs <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenv=
pn/openvpn-testing.git;a=3Dcommitdiff;h=3D555fc5e34a9b1aca4bfa435023fe1aa33=
6557ec7>
(21:30:27) cron2: I'd assume that it's fairly trivial as soon as you know w=
hich are the bits that upset the compiler
(21:30:29) dazo: cron2: wouldn't those things just be #ifndef _MSC_VER ?
(21:30:42) cron2: all this "int followed by int" looks like a typdef gone w=
rong
(21:30:47) cron2: dazo: yes.
(21:31:05) cron2: dazo: unless it requires changing of function prototypes =
or such that affect both branches
(21:31:10) jamesyonan: the 2.1.3 branch is known to compile with visual stu=
dio
(21:31:26) cron2: jamesyonan: 2.2.0 does as well, it's one of the ipv6 bran=
ches that breaks this
(21:31:29) dazo: jamesyonan: this is related to some of the IPv6 support pa=
tches we=EF=BF=BD=EF=BF=BDre pulling in
(21:31:59) cron2: mmmh
(21:32:17) cron2: mattock: what's in "ws2tcpip.h" line 502?
(21:32:27) mattock: cron2: lemme try to find it...
(21:32:51) dazo: mattock bisected it to this commit as the offending one: h=
ttp://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn.git;a=
=3Dcommitdiff;h=3D49a945eafea2c64dbaa5cb2ecdfd4ca9a82aa26e
(21:32:52) vpnHelper: Title: SourceForge - openvpn/openvpn.git/commitdiff (=
at openvpn.git.sourceforge.net)
(21:33:16) cron2: yeah, that's jjo-contributed windows build fixes to ipv6_=
payload
(21:33:33) dazo: yupp
(21:34:04) cron2: mattock: if you just *remove* the "#include <ws2tcpip.h>"=
 from sysdeps.h, what will happen?
(21:34:10) cron2: (or put #ifndef _MSC_VER around it)
(21:34:12) mattock: cron2: we can try
(21:34:47) cron2: and put #ifndef _MSC_VER around the inet_ntop and inet_pt=
on stuff in win32.h and socket.c
(21:35:02) dazo: but doesn't it look like that Visual Studio now supports i=
net_ntop/inet_pton?
(21:35:17) dazo: or is it that MinGW is not having this support at all?
(21:35:37) cron2: dazo: that's why - the win32.h and socket.c changes are "=
add an implementation for MinGW" (which is needed, as far as I understand j=
jo - but at least it doesn't do harm there)
(21:35:45) cron2: well
(21:35:47) cron2: lemme test
(21:35:59) dazo: if the latter ... then it sounds like we should #ifdef out=
 all the inet_* stuff when compiling in VS
(21:36:41) cron2: indeed
(21:37:02) cron2: if #ifdef 0'ing that stuff, linking breaks in msys/mingw =
with undefined references to inet_ntop/inet_pton
(21:37:07) cron2: dazo: ack
(21:37:14) mattock: checking ws2tcpip.h...
(21:37:16) cron2: the error message very much looks like "it's there"
(21:37:55) mattock: oh, wrong one
(21:38:14) dazo: then we just need to verify that VS' variant (if it is the=
re) is compatible with the POSIX one (which has been implemented extra for =
MinGW)
(21:38:33) cron2: dazo: who can do that?
(21:39:41) dazo: somebody with all compilers available?  and compare result=
s from a test program?
(21:40:17) cron2: I was thinking of "someone who has access to visual studi=
o and can check docs" :)
(21:40:26) dazo: write a little test program, compile it in all compilers a=
nd compare result ... should be tested on Linux/*BSD, MingGW and VS
(21:40:38) cron2: too much work
(21:40:42) dazo: :)
(21:41:49) cron2: seriously: if the docs and the calling convention sounds =
like "it will do the same thing in VS as on Linux" that's good enough for m=
e - and then we can see whether it breaks by actually using OpenVPN on Wind=
ows :-)
(21:42:10) cron2: a number of folks have expressed interest in windows bina=
ries with IPv6, so if we can do test builds of "master" there will be teste=
rs
(21:44:42) mattock: commenting out ws2tcpip.h in syshead.h seemed to improv=
e things
(21:45:23) mattock: I'll hack win32.h and socket.c
(21:49:41) mattock: I'll generate a new buildlog and pastebin it
(21:53:04) mattock: http://pastebin.com/8G9KK670
(21:53:08) dazo: I'll write a little test program too, which we can test ..=
. I can test on Linux and do a mingw cross build which we can run on a wind=
ows box
(21:53:29) cron2: ah, damn
(21:53:45) cron2: so we need ms2tcpip.h, but it seems we need different pre=
requisites
(21:53:49) dazo: mattock: please fetch and rebase the master branch, then o=
penvpn-plugin stuff should be gone
(21:53:54) mattock: ok
(21:55:37) cron2: huh
(21:55:39) cron2: this is weird
(21:56:02) cron2: my win32.h does not have "addr6" in there
(21:56:49) mattock: ok, so line 502 in ws2tcpip.h says this:
(21:57:07) mattock: typedef int socklen_t;
(21:57:47) cron2: mmmh
(21:58:02) cron2: if that bombs, it means that someone else did "typedef in=
t socklen_t" before that
(21:58:17) cron2: or worse
(21:58:21) cron2: #define socklen_t int
(22:00:05) mattock: win/config.h.in?
(22:00:23) mattock: #define socklen_t unsigned int
(22:02:13) cron2: fighting git
(22:04:37) cron2: yeah, that could explain it
(22:04:53) cron2: could you put ws2tcpip.h back in, and remove that define =
from win/config.hin?
(22:05:06) dazo: mattock: there's a neat test program for inet_pton/inet_nt=
op here: http://www.qnx.com/developers/docs/6.5.0/index.jsp?topic=3D/com.qn=
x.doc.neutrino_lib_ref/i/inet_ntop.html
(22:05:07) vpnHelper: Title: Help - Eclipse SDK (at www.qnx.com)
(22:05:10) cron2: #ifdef _MSC_VER
(22:05:24) dazo: not sure how easy it works in VS
(22:08:16) mattock: dazo: I'll check it out
(22:09:23) dazo: I'm trying to make a mingw32 build now
(22:10:31) cron2: the "helper.c" compilation error is easy - I messed that =
up by adding code above the "const int dev =3D ..." declaration
(22:15:31) cron2: dazo: don't distract mattock :-) - I think we're fairly c=
lose to getting these errors down to just three different types
(22:15:40) dazo: nice!
(22:15:50) mattock: I'm already distracted :P
(22:16:05) cron2: mattock: so what's the result of "compile with ms2tcpip.h=
 enabled, but without #define socklen_t"?
(22:18:30) mattock: cron2: just a sec
(22:20:18) mattock: building..
(22:22:58) mattock: http://pastebin.com/NiezRX3K
(22:23:26) mattock: seems to have fixed the line 502 issue
(22:23:31) cron2: yeah
(22:23:45) mattock: one down, ntop to go
(22:23:58) cron2: next: please #ifdef _MSC_VER the inet_ntop/inet_pton decl=
arations in win32.h, and the code in socket.c (and leave the other changes =
as-is)
(22:24:19) cron2: that should fix the win32.h errors
(22:24:26) mattock: mkay, let's try it
(22:28:15) mattock: ok, I think most errors were fixed
(22:28:25) cron2: great :)
(22:28:47) mattock: for some reason openvpn-plugin.h stuff is still there, =
but that's git problem
(22:28:54) mattock: I'll copy and paste
(22:28:57) cron2: ok, next...
(22:29:02) cron2: helper.c
(22:29:03) dazo: mattock: did you fetch and git rebase origin/master?
(22:29:16) mattock: dazo: I did the "standard" git pull --rebase origin stu=
ff
(22:29:40) dazo: it might not have done the rebase if you had local (uncomm=
itted) changes to your tree=20
(22:30:08) cron2: mattock: can you please move helper.c lines 223...227 up,=
 to directly after #if P2MP_SERVER?
(22:30:11) cron2: the affected lines are:
(22:30:18) cron2:   /*
(22:30:18) cron2:    * Get tun/tap/null device type
(22:30:18) cron2:    */
(22:30:18) cron2:   const int dev =3D dev_type_enum (o->dev, o->dev_type);
(22:30:18) cron2:   const int topology =3D o->topology;
(22:30:34) mattock: cron2: will do
(22:30:35) cron2: they need to go up to line 145
(22:30:51) cron2: that should fix the errors in helper.c for good, and then=
 I'd like to see a new build log :)
(22:31:45) dazo: $ wine ./inet_test.exe=20
(22:31:46) dazo: fixme:win:RegisterDeviceNotificationW (hwnd=3D0x128168, fi=
lter=3D0x76e9f4,flags=3D0x00000001) returns a fake device notification hand=
le!
(22:31:46) dazo: inet addr: 10.1.0.29
(22:31:46) dazo: inet6 addr: dead:beef:7654:3210:fedc:3210:7654:ba98
(22:31:50) dazo: $ ./inet_test
(22:31:51) dazo: inet addr: 10.1.0.29
(22:31:51) dazo: inet6 addr: dead:beef:7654:3210:fedc:3210:7654:ba98
(22:32:10) cron2: looks dead :)
(22:32:14) dazo: heh :)
(22:33:06) dazo: the mingw32 binary is here: http://web.sommerseths.net/Ope=
nVPN/inet_test.exe
(22:33:31) dazo: and is based on the test program pasted earlier, with JJO'=
's implementation=20
(22:33:42) dazo: of inet_ntop/ptop
(22:33:59) cron2: jjo's implementation works :) otherwise my windows binari=
es wouldn't work, and I just verified that they do
(22:34:14) cron2: (just done a test build of 2.2.0 with the ipv6 fix from d=
atabeestje
(22:34:45) dazo: yeah ... but if we now get a VS compile to work with inet_=
pton/ntop ... with the same result ... we should be able to assume that it =
behaves similar=20
(22:35:06) mattock: building...
(22:35:07) cron2: that's true, this is the missing test.  but first, helper=
.c fixes :)
(22:35:40) dazo: agreed :)
(22:36:23) ***dazo brb
(22:36:33) mattock: helper.c errors fixed, pasting...
(22:36:41) cron2: great!
(22:37:16) cron2: the next HUGE batch of problems is that VS seems to break=
 on multiline macros with #ifdef in between
(22:37:21) cron2: msg( ... "some text"
(22:37:24) cron2: #ifdef PF_INET6
(22:37:27) cron2:  "some more text"
(22:37:29) cron2: #endif
(22:37:29) cron2: )
(22:37:46) mattock: http://pastebin.com/KEYGqYAF
(22:38:24) mattock: dazo: what's the commit id of the openvpn-plugin.h fix?
(22:38:26) cron2: mtcp.c and options.c is all this sort of issue
(22:38:35) mattock: or commit message
(22:39:17) ***cron2 defers plugin.c(302) and plugin.c(370) to dazo - seems =
VS doesn't want "named" structure initializations (how 1990's is that?)
(22:40:39) cron2: socket.c - in6_addr
(22:40:51) cron2: mattock: can you show me the in6addr.h file that windows =
uses?
(22:41:02) mattock: yep, I'll find it
(22:41:12) cron2: C:\Program Files\\Microsoft SDKs\Windows\v6.0A\include\in=
6addr.h
(22:41:19) cron2: "that was easy" :)
(22:44:25) mattock: http://pastebin.com/kJACmXNr
(22:44:45) dazo: mattock: commit 555fc5e34a9b1aca4bfa435023fe1aa336557ec7
(22:45:07) mattock: dazo: ok
(22:45:27) cron2: ouch
(22:45:46) dazo: ?
(22:46:17) cron2: that one is a problem.  my code uses a 32 bit accessor to=
 the "in6_addr" union of 16 chars / 8 16bitwords / 4 32bitwords
(22:46:26) cron2: and windows doesn't declare the 32 bit accessor in its un=
ion
(22:46:37) dazo: ouch
(22:47:34) cron2: (and other platforms don't have the 16 bit accessor, so I=
 can't just change it to use 16 bits)
(22:48:04) mattock: dazo: I'm using openvpn.git and the fix is only in open=
vpn-testing.git
(22:48:05) cron2: it's not a major issue, but not easily fixed just now=20
(22:48:18) dazo: mattock: ahh!  sorry!  I forgot to push it to stable
(22:49:01) cron2: the other thing I'm not sure what to do about is the NDIS=
_IF_MAX_STRING_SIZE stuff - $someone defines IF_NAMESIZE to be NDIS_IF_MAX_=
STRING_SIZE, and *that* is not found
(22:49:08) ***dazo is way too nice ... he could have just pushed it in sile=
nce and responded "What!?!? No, it's not missing!"
(22:49:09) dazo: :-P
(22:49:42) mattock: I would have still had a screenshot with today's newspa=
per next to it :P
(22:50:27) dazo: heh :-P
(22:50:50) mattock: is there anything else we can do atm?
(22:50:51) ***cron2 has no idea where the IF_NAMESIZE changes came from "no=
t mine"
(22:51:30) dazo: cron2: commit 6dbf82a96253add5ed5f6c923080f4de4366c874
(22:51:53) cron2: mattock: I don't think so.  What we should do is send you=
r patches to the list so far
(22:51:57) cron2: dazo: huh?
(22:52:14) dazo: IF_NAMESIZE was introduced in that commit
(22:52:15) cron2: dazo: how do I ask git what exactly this commit changed?
(22:52:21) mattock: cron2: I'll do that tomorrow
(22:52:24) dazo: magic :)
(22:52:30) cron2: ah, git show
(22:52:41) mattock: or git diff
(22:52:55) cron2: dazo: nah
(22:53:05) dazo: cron2: git log -p ... and then I searched for IF_NAMESIZE =
... even though, it's possible to use more fancy ways, with git grep, I bel=
ieve
(22:53:08) cron2: that commit just #define's it to "16" if it's not there
(22:53:18) cron2: but the actual code that fails is
(22:53:23) cron2:       char ifname[IF_NAMESIZE] =3D "[undef]";
(22:53:47) mattock: I got to take the cat out, he's getting restless :)
(22:53:52) dazo: that came in commit 5d6dbb03776de4d38f45e429ef674313a2bda8=
cc
(22:54:09) cron2: mattock: it's a cat, not a dog :)
(22:54:20) mattock: I assume nothing has happened on OpenVPN MI GUI vs. Ope=
nVPN-GUI front
(22:54:28) mattock: cron2: actually, he's a cat :)
(22:54:40) cron2: mattock: I wasn't aware that there was a MI gui :-) - but=
 I think we need d21fk to answer that
(22:54:43) dazo: mattock: correct, MI GUI developer is reluctant to merge w=
ith GUI
(22:55:05) mattock: dazo: that's how I understood it also
(22:55:29) mattock: not sure why everyone wants to write their own GUI for =
openvpn
(22:55:33) mattock: I guess it's too easy
(22:55:43) dazo: Well, as long as d12fk is the successor of OpenVPN GUI 1.0=
.3 which we ship now ... I feel safer by going that path for 2.3 now
(22:56:02) mattock: yep, I agree=20
(22:56:16) dazo: I have a sense that he is on the right path, and he implem=
ents the management interface too, if I'm not totally wrong
(22:56:21) mattock: he does
(22:56:30) cron2: yep
(22:56:40) mattock: and when this Windows build stuff is fixed, we can bund=
le the new gui with snapshot installers
(22:56:50) dazo: then it's decided ... and d12fk can decide if he wants to =
pick things from MI GUI ... and then we'll leave it at this point
(22:56:55) cron2: damn
(22:56:58) mattock: if the target for it is 2.3 anyways=20
(22:57:06) mattock: sounds good
(22:57:15) cron2: someone posted a patch here, for getting windows compiles=
 back to order
(22:57:26) dazo: if the MI GUI developer wants to help d12fk, that's great =
.... but I won't push it any further
(22:57:27) cron2: 1st of may
(22:57:43) cron2: but I didn't save the actual patch, just grabbed at a few=
 bits *I* need to cleanup
(22:57:54) mattock: cron2: to openvpn-devel?
(22:58:02) cron2: no, just here in the channel
(22:58:17) mattock: hmm, I'll check my logs
(22:58:44) mattock: ouch, missing 1st of May in my logs
(22:58:51) cron2: I think it was a pastebin-type URL with a long patch that=
 mostly cleanup all the msg() stuff, but also renamed inet_pton() to openvp=
n_inet_pton() and suck
(22:59:06) mattock: that's one drive-by patch...
(22:59:11) dazo: this one? http://codepad.org/tqq5hmHz
(22:59:12) vpnHelper: Title: Plain Text code - 439 lines - codepad (at code=
pad.org)
(22:59:23) mattock: ok, got to go now
(22:59:31) cron2: dazo: yeah, this one
(22:59:52) mattock: I'll write the summary tomorrow, feel free to continue =
:)

--------------010700010704010304060803--

