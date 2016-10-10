References: <f315ec02-c70b-0793-f29f-4fd03794c4eb@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f48dd34a-40c8-f30d-99ae-7261f3d5ee3b@...515...>
Date: Mon, 10 Oct 2016 23:26:27 +0300
MIME-Version: 1.0
In-Reply-To: <f315ec02-c70b-0793-f29f-4fd03794c4eb@...515...>
Content-Type: multipart/mixed; boundary="------------CC3FB2D0886E1D0F3A710FBD"
Subject: [Openvpn-devel] Summary of today's (Monday,
	10th Oct 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------CC3FB2D0886E1D0F3A710FBD
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of yesterday's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 10th October 2016
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-10-10>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, danhunsaker, jamesyonan, lev, mattock, plaisthos, snair and=20
syzzer participated in this meeting.

---

Discussed testing procedures for the "Windows: do_ifconfig() after=20
open_tun()" patch version 2. While the patch passed cron2's test=20
scripts, it was agreed that we should give people a chance to test the=20
patch in their environments before releasing 2.4-alpha1.

Installers that contain the patch are already available here:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifconfi=
g-after-tun-v2-I601-i686.exe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifconfi=
g-after-tun-v2-I601-x86_64.exe>

Things/use-cases that should be tested in particular are:

- Running without OpenVPN-GUI
- Running without the Interactive Service
- Running --server (on Windows)
- Using more than one tap adapter
- General openvpnserv2 testing

Mattock will make announcements about these installers (and subsequent=20
installers) to the mailing lists as well as forums.


---

Discussed the "hide the scary message during Windows install" issue. The=20
message is caused by

"sc.exe start OpenVPNServiceInteractive"

and it looks a lot like an error/warning, even though it is benign.

Mattock will try to make sc.exe less verbose.

---

Discussed management of IV_* (capability) values that clients send to=20
the server. It was agreed that binding an IV_PROTO=3D<x> level to a set of=
=20
more fine-grained IV_<capability> advertisements makes sense. While the=20
space available for IV_* values is limited, OpenVPN 3 has worked around=20
this without changing the protocol:

<https://github.com/OpenVPN/openvpn3/commit/2255bab03af5484f494b62a93d3aff4=
fa924a016>

The same approach makes sense for OpenVPN 2.4 also. Adding receive=20
(server) support would be safe to implement, but adding send (client)=20
support needs to be done carefully so as not to break anything. This=20
capability was not seen as a "must have" for OpenVPN 2.4-alpha1.

---

Discussed OpenVPN-GUI fixes from snair that should be included in=20
2.4-alpha1:

<https://github.com/OpenVPN/openvpn-gui/pull/86>

Mattock will have a look tomorrow and produce new installers as necessary.

--

Discussed OpenVPN 2.3.13 release. Three things are missing:

1. recursive routing
2. block-outside-dns v2
3. 64MB renegotiation for 64-bit block ciphers

Cron2 will take care of 1-2, and syzzer will tackle 3.

--

Preliminary release date for OpenVPN 2.4-alpha1 was set to late this=20
week. If we don't get Windows test reports then we may have to postpone=20
the release a bit. OpenVPN 2.3.13 release date was set to "early next week".

--=20

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------CC3FB2D0886E1D0F3A710FBD
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-10-10.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-10-10.txt"
Content-Transfer-Encoding: quoted-printable

(21:00:23) L'argomento per #openvpn-meeting =C3=A8 stato impostato da val=
dikss!~valdikss@...2175...:7aa0:1619::2c32:9c23 a 21:38:35 su 22/08/2016
(21:00:39) lev__: sorry for that :(
(21:00:41) mattock: howdy
(21:01:07) syzzer: lev__: sorry?  no need, this is needed refactoring.
(21:01:34) ***lev__ was trying to make a joke
(21:01:39) cron2: more lkke "thanks for taking this" :)
(21:02:33) syzzer: ok, good ;)
(21:02:51) mattock: so meeting time now
(21:02:57) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
6-10-10
(21:02:58) vpnHelper: Title: Topics-2016-10-10 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:03:13) mattock: request in #1 was fulled hours ago
(21:03:25) mattock: fulfilled :)
(21:03:29) ***cron2 likes to borrow that time machine
(21:04:59) ibins [~ibins@...2176...] =C3=A8 entrato nella=
 stanza.
(21:05:50) mattock: sent mail about it 5 hours ago, but the links are on =
the agenda
(21:06:25) cron2: I've seen the mail (and I think I already said thanks) =
:-)
(21:06:47) mattock: ok
(21:06:55) mattock: did you have time to run the tests?
(21:07:09) cron2: so - if this isn't breaking people's windows setups, we=
 can merge it, and have all "MUST HAVE!" bits for 2.4_alpha1
(21:07:45) cron2: there's more stuff out there that should go into 2.4 (T=
CP_NL, recursive routing, push option cleanup, ...) but this is more easi=
ly testable
(21:09:30) cron2: mattock: looking at plaisthos' TCP_NL patch - do you ha=
ve an OpenVPN 3 test server available that we can test this against?
(21:09:41) mattock: no, I don't have one, but james might
(21:10:08) danhunsaker: James has ALL THE v3 SERVERS.
(21:10:18) cron2: *g*
(21:11:02) mattock: regarding windows testing: perhaps we should announce=
 the installers I created so that (in theory) somebody would test it befo=
re 2.4-alpha1 release
(21:11:11) mattock: give people a few days to test their setup wiht it
(21:11:25) cron2: +1
(21:11:35) mattock: ok, that I can do
(21:11:43) mattock: I'll send an announcement to forums also
(21:12:06) syzzer: yes, good plan
(21:12:28) plaisthos: cron2: I tested it against james server  if that he=
lps
(21:13:12) cron2: plaisthos: well, it does, but I had hoped to test mysel=
f :)
(21:16:34) mattock: regarding the installer - I have another installer re=
ady for testing that gets rid of the scary (sc.exe) message at the end of=
 the install
(21:16:34) snair [~snair@...2116...:3c03:e001:3b00::1004] =C3=A8 entrato nella =
stanza.
(21:16:48) mattock: scary as in "did it fail?"
(21:17:27) mattock: I just have yet had time to verify if the fix works
(21:17:40) mattock: will do that tomorrow
(21:20:46) mattock: anything else for 2.4-alpha1?
(21:21:38) cron2: all my urgent topics are covered :)
(21:22:12) cron2: (windows testing could be improved, but having the basi=
c run/run2.bat scripts helped me quite a bit)
(21:22:34) mattock: ok, great!
(21:23:08) mattock: so I'll announce a pre-alpha1 installer tomorrow
(21:23:22) mattock: we could probably publish 2.4-alpha1 by the end of th=
e week then
(21:24:14) mattock: so move on to 2.3.13?
(21:24:30) cron2: syzzer, lev__: any comments on 2.4_alpha1?  plaisthos?
(21:25:05) plaisthos: I would like my two patches in it=20
(21:25:06) syzzer: nope, would be good to get it out asap
(21:25:12) plaisthos: but otherwisee, get going
(21:25:23) cron2: plaisthos: vpn-helper is slow today
(21:25:42) plaisthos: are we upping IV_PROTO?
(21:25:52) plaisthos: or do we keep IV_GW_IPV6 and co?
(21:25:56) cron2: have we agreed on anything?  this is a good point indee=
d
(21:26:24) lev__: well, recursive routing would be nice to have - we got =
quite a few compains from customers about that (until it was fixed, well =
almost)
(21:26:46) cron2: lev__: not forgotten, but doesn't *need* to be in alpha=
1 (needs to be in 2.4-release)
(21:26:55) plaisthos: steffan wanted some hash negoiation and then do tha=
t in one go
(21:27:08) cron2: syzzer: *poke*
(21:27:41) syzzer: yes, I need to do that
(21:28:17) syzzer: I think increasing IV_PROTO makes sense
(21:28:51) cron2: but this needs to be coordinated with james, so the 2.4=
 and 3 can properly interop...
(21:28:59) syzzer: indeed
(21:29:56) snair: What about topology -- recall a mention that subnet wil=
l be the default in 2.4
(21:30:59) danhunsaker: Oh, hey, just remembered that AS is already using=
 3...  So I actually do have a v3 test server or three.
(21:31:05) mattock: maybe I'll email james?
(21:31:10) cron2: danhunsaker: regular AS?
(21:31:17) danhunsaker: Yeah.
(21:31:19) cron2: cool
(21:31:45) cron2: is the bundle to-be-installed on ubuntu also using 3 co=
de?
(21:31:45) plaisthos: cron2: if you announche TCP_NL without actually sup=
porting it it should brea pretty quickly
(21:32:04) plaisthos: snair: difficult
(21:32:11) danhunsaker: Should be.  As I understand it, AS has been using=
 3 for a while.
(21:32:12) plaisthos: would break existing configs
(21:32:25) cron2: plaisthos: will that depend on the number of cores and =
traffic on the 3 server side?  Or will it always produce async packets?
(21:32:54) plaisthos: cron2: with james ec2 cloud server it broke after 2=
-3s after starting wget
(21:33:31) cron2: ok, so this will be easy to test... just need to upgrad=
e my ancient AS, then
(21:34:20) cron2: mmmh
(21:34:34) cron2: danhunsaker: I'm not sure I agree... looking at one of =
our customer servers, I get
(21:34:39) cron2: [root@...2177... ~]# /usr/local/openvpn_as/sbin/openvpn-polars=
sl --version
(21:34:39) cron2: OpenVPN 2.3_AS11c x86_64-unknown-linux-gnu [SSL (PolarS=
SL)] [LZO] [SNAPPY] [LZ4] [EPOLL] [MH] [IPv6] built on Jun 29 2016
(21:34:49) cron2: this looks definitely 2.x-ish
(21:35:03) mattock: I have not heard of AS using OpenVPN 3.x, and James d=
id not mention anything along those lines in the Helsinki hackathon
(21:35:05) danhunsaker: Hrm.  I might be misled.  Lemme investigate furth=
er.
(21:35:11) cron2: thanks :)
(21:35:19) plaisthos: https://www.privatetunnel.com/home/ might be openvp=
n3
(21:35:53) mattock: that one is
(21:36:12) mattock: anyhow, I sent email to james - let's see if he could=
 pop in for a minute
(21:36:26) mattock: he has been sending emails within a few minutes
(21:37:18) jamesyonan [~jamesyona@...2094...] =C3=
=A8 entrato nella stanza.
(21:37:27) plaisthos: Whee James! :)
(21:37:32) mattock: hi james!
(21:37:50) jamesyonan: Hi guys
(21:37:51) mattock: (21:28:17) syzzer: I think increasing IV_PROTO makes =
sense
(21:37:51) mattock: (21:28:51) cron2: but this needs to be coordinated wi=
th james, so the 2.4 and 3 can properly interop...
(21:39:04) syzzer: this is about plaisthos' proposal to 'squash' several =
of the IV_* values into IV_PROTO=3D3
(21:40:29) plaisthos: basically the idea is no longer announce IV_COMP_SU=
Bv2, IV_TCP_NL and IV_RGI6 and if syzzer finishes soon enough also pushab=
le --auth=20
(21:40:56) plaisthos: and iirc also pushable/negoiable key derviation (no=
 longer use md5 there)
(21:42:46) jamesyonan: I would tend to agree from experience that squashi=
ng protocol features into a bundle is simpler from an implementation and =
compatibility standpoint than trying to be fine-grained about everything.
(21:44:44) danhunsaker: cron2: Seems I was confusing PrivateTunnel and AS=
 in my head while reading internal emails.  Sorry about that.  AS is, ind=
eed, not on v3 yet.
(21:45:12) jamesyonan: for example in our OpenVPN-3 based server, we real=
ly only have two protocol modes, (a) legacy CBC/HMAC mode, and (b) AEAD/G=
CM mode with IV_NCP >=3D 2, IV_PROTO >=3D 2, and IV_COMP_STUBv2 >=3D 1.
(21:45:51) plaisthos: we can probably not include IV_NCP into IV_PROTO 3
(21:46:00) plaisthos: as openssl might be buld without aead
(21:46:24) cron2: or NCP might be turned off...
(21:49:22) jamesyonan: How about an approach where we stay fine-grained i=
n the IV_x capability markers, but reserve the right at the implementatio=
n level to be coarse about which IV_x capabiities are required in order t=
o elevate to the higher implementation level.
(21:49:52) jamesyonan: We are sort of doing that with OpenVPN 3 server in=
 that we expect those three IV_x capabilties to line up before we upgrade=
 to GCM.
(21:51:07) plaisthos: yeah, idea what more to include everything that is =
pretty much alwys there in IV_PROTO 3
(21:51:26) plaisthos: e.g. IV_PROTO 3 mean that the other features are al=
so present
(21:52:20) plaisthos: to keep the IV list a bit smaller and cleaner
(21:52:38) plaisthos: 2.3 announced almost othing=20
(21:52:59) plaisthos: and 2.4 has 13 things it announces
(21:53:36) plaisthos: and tcpnl and stubv2 and peer id is not going away =
I think
(21:55:51) syzzer: indeed, I think those should be implied by IV_PROTO=3D=
3
(21:56:04) syzzer: as would a possible switch of the PRF to SHA2
(21:57:02) cron2: that is an interesting one - the server would need to p=
ush that, *if* IV_PROTO=3D3 *and* the server can do it
(21:59:28) plaisthos: yeah, so?
(21:59:48) jamesyonan: If we are going to wrap these capabilties down to =
a scalar value, then keep in mind that OpenVPN 3 might accrue new protoco=
l features on a different timeline than OpenVPN 2
(21:59:52) cron2: just pointing out that the PRF change cannot be done un=
ilateraly
(22:00:16) plaisthos: jamesyonan: no ssingle sclar value
(22:00:36) jamesyonan: Like as I mentioned about, OpenVPN 3 has essential=
ly defined a protocol level that is met when IV_NCP >=3D 2, IV_PROTO >=3D=
 2, and IV_COMP_STUBv2 >=3D 1.
(22:00:36) cron2: jamesyonan: right.  So we'll always have some sort of I=
V_PROTO=3D<x> which is synced, and then IV_ that add to it - and every so=
 often, we can re-sync
(22:00:38) plaisthos: IV_PROTO=3D3 + IVs that are not included in IV_PROT=
O=3D3
(22:04:01) jamesyonan: so you're saying that we sync IV_ values from time=
 to time into a new IV_PROTO level, only when OpenVPN 2 and 3 can both su=
pport the syncing?
(22:04:35) danhunsaker: (I'm not sure it could be properly called a 'sync=
' otherwise...)
(22:10:33) jamesyonan: But what is wrong with keeping the IV_ values fine=
-grained, and then having the implementation check all of the values and =
fall back to legacy mode if all of the expected values are not met?
(22:11:10) cron2: you once mentioned that the amount of space for IV_ stu=
ff is limited, so collapsing stuff sounded like a useful way forward
(22:11:16) jamesyonan: That seems to satisfy the goal of isolating the ca=
pability description IV_ values from the actual implementation.
(22:12:13) jamesyonan: Actually OpenVPN 3 has an improved implementation =
of the peer info handshake that raises the limit to 64KB without actually=
 changing the protocol.
(22:12:33) cron2: (as a side note, we're sending the client version - so =
IV_RGI6 can go as soon as the client calls itself "2.4")
(22:14:07) jamesyonan: https://github.com/OpenVPN/openvpn3/commit/2255bab=
03af5484f494b62a93d3aff4fa924a016
(22:14:08) vpnHelper: Title: OpenVPN protocol core : added logic to contr=
ol channel =C2=B7 OpenVPN/openvpn3@...2178... =C2=B7 GitHub (at github.com)
(22:14:56) plaisthos: jamesyonan: what happens if a 3 server sends that t=
o a v3 server?
(22:16:56) jamesyonan: I believe if a 3 client sends a large message to a=
 2 server, it would break.
(22:17:52) jamesyonan: however because this doesn't change the wire proto=
col, it's possible for a 2 server to add this capability without breaking=
 existing clients
(22:17:53) syzzer: yes, it currently would
(22:18:09) syzzer: on my list too...
(22:18:27) syzzer: I'll add it to the 2.4 status page
(22:19:17) syzzer: do we believe this is a MUST?  (I do)
(22:20:15) plaisthos: but going incompatible to <=3D 2.4 isn't a good ide=
a, is it?
(22:20:25) plaisthos: even 2.2 is still around
(22:21:42) syzzer: We might want to refrain from sending that way, but we=
 should be able to receive that way
(22:21:56) syzzer: which is the same code needed to support TLS record sp=
litting
(22:22:23) syzzer: (trac #554)
(22:23:30) syzzer: I'll put it under 'minor' for now, we can bump it if n=
eeded
(22:23:44) danhunsaker: How soon will you have access to the client versi=
on?
(22:24:29) danhunsaker: Because if you know that before sending the serve=
r IV_*, you can select legacy-vs-large based on that.
(22:26:09) syzzer: either the client or the server has to send something =
before knowing whether the other supports this
(22:28:01) danhunsaker: Indeed.  But who generally goes first?
(22:30:21) jamesyonan: the client goes first on this
(22:31:00) danhunsaker: So the server could decide whether to send a larg=
e IV_* reply based on version number, no?
(22:31:01) jamesyonan: The client is essentially advertising its capabili=
ties with the IV_ peer info, and the server is responding with pushed opt=
ions.
(22:31:30) jamesyonan: No the IV_ stuff is really a client to server tran=
smission.
(22:32:22) jamesyonan: The options push is the server to client response =
to the IV_ stuff pushed by the client.
(22:32:46) danhunsaker: Got it.
(22:33:35) danhunsaker: So the 2.4 client would need to try a large messa=
ge, fail, and try again with a legacy message to connect to a <2.4 server=
.
(22:34:39) cron2: re (sorry, had to phone mom...)
(22:34:57) plaisthos: which is bad since tls-timeout is 60s in deafult co=
nfig
(22:35:17) jamesyonan: Since IV_ peer info is a client to server transmis=
sion, then implementing the large message receiver on the server doesn't =
break anything.
(22:35:53) plaisthos: yeah
(22:35:58) danhunsaker: Not for <2.4c --> >=3D2.4s
(22:36:08) plaisthos: but sending too much IV_* stuff does :/
(22:36:36) cron2: jamesyonan: how big is the limit in current 2.x code?  =
"one MTU" or "something like 4k"?
(22:36:37) danhunsaker: >=3D2.4c --> <2.4s is another story.
(22:36:44) jamesyonan: Right, but existing IV_ data isn't exceeding 1024 =
bytes in most cases.
(22:36:57) plaisthos: that is why we want something that is basically IV_=
alwaysin24=3D1
(22:37:11) ***cron2 has no idea what limits we're talking about...
(22:37:26) cron2: (but it plays into the "username and password bumped to=
 2048 bytes" discussion)
(22:37:33) jamesyonan: So a large message sender will only break a legacy=
 receiver once the IV_ data exceeds an SSL buffer, which I believe is 102=
4 bytes.
(22:46:38) mattock: so have we reached a consensus on how to handle this?
(22:46:43) mattock: and when
(22:46:54) syzzer: so, to round this up, am I right that for 2.4, we'll a=
dd support to receive larger tls records, but won't send larger ones?
(22:47:26) cron2: add support to receive: good plan
(22:47:43) cron2: for sending: needs more thought how to get there in a c=
ompatible way
(22:49:20) cron2: syzzer: is james' 1024 bytes figure right?
(22:49:45) syzzer: I think so
(22:49:47) syzzer: didn't check
(22:55:08) syzzer: (I'm fighting my jenkins so I can properly run tests b=
efore ACKing...)
(22:56:58) cron2: hrhr :)
(22:57:04) cron2: ok, it's late - any comments on 2.3?
(22:58:16) snair: I would have liked to see the 'block-outside-dns fix' i=
n 2.3.13 -- but we don't have a review yet.
(23:01:04) cron2: oh, I missed that mail
(23:01:20) cron2: so, recursive routing and block-outside-dns v2
(23:02:05) cron2: (I've found the mail now, just hadn't really seen it be=
fore)
(23:03:32) mattock: I have nothing in particular for 2.3.13
(23:04:51) cron2: ok, I'll take a stab at these two patches in the course=
 of the week, and then we can aim for 2.3.13 early next week
(23:05:13) mattock: are we still ok with 2.4-alpha1 late this week (or ea=
rly next week)?
(23:05:17) snair: sounds good
(23:05:26) mattock: this IV_PROTO stuff is not "must have" for alpha1, ri=
ght?
(23:05:38) cron2: if we can get a few test reports on the windows install=
er, yes
(23:05:52) cron2: (especially people running without gui, without iservic=
e, etc.)
(23:06:10) mattock: yeah
(23:06:21) mattock: any particular corner-cases to test?
(23:06:59) cron2: --server, more than one tap adapter, openvpnserv2
(23:08:57) snair: And, 2.4-alpha1 will get GUI master branch, right. It w=
ould be good to have the bug fixes I posted in so that alpha-test reports=
 we get would reflect unknown bugs.
(23:09:25) cron2: so that would need a new test installer... mattock?
(23:09:37) mattock: could somebody proof-read the IV_* discussion summary=
: http://pastebin.ca/3727344
(23:09:58) snair: I will also test the open-tun-before-ifconfig patch
(23:10:10) cron2: v2 :)
(23:10:11) mattock: 2.4-alpha1 has openvpn-gui 11 (=3Dmaster branch right=
 now)
(23:10:29) mattock: yeah, the patch attached to cron2's email
(23:10:30) snair: sure.
(23:11:04) mattock: snair: re: openvpn-gui: I saw the bug fix PR, but did=
 not have time to review it
(23:11:08) mattock: will try to do that tomorrow
(23:11:28) snair: thanks.
(23:11:29) mattock: I will generate new 2.4-alpha1 installers as necessar=
y
(23:11:39) syzzer: cron2: we might want to add the 64MB renegotiation for=
 64-bit block ciphers to 2.3.next
(23:12:10) danhunsaker: ^-- That's probably a must.
(23:12:12) cron2: that one got sort of stuck, indeed
(23:12:27) syzzer: I'll cook up a patch
(23:12:37) syzzer: should be fairly trivial
(23:13:06) syzzer: would be nice to get it out before the talk (20-someth=
ing Oct)
(23:14:14) syzzer: also, I'm getting too tired, so ready to call it a day=
... (jenkins has won, for now, but I will tame this beast!)
(23:14:30) cron2: yeah.  bases touched, more on the list...
(23:14:48) snair: ok, g'nite all
(23:14:55) cron2: g'nite :)
(23:15:02) syzzer: g'nite
(23:15:08) danhunsaker: Silly Europe, already letting the sun set.
(23:15:25) danhunsaker: Er.  I mean.  Sleep well, all!
(23:15:45) mattock: good night!
(23:16:06) snair ha abbandonato la stanza.
(23:16:08) lev__: gn!
(23:16:40) plaisthos: good night

--------------CC3FB2D0886E1D0F3A710FBD--

