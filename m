References: <7a23f8c5-a8c8-219b-0b19-5100fcd0db3a@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <aa7a724d-d7c1-b8e6-5ff7-3b624141ee39@...515...>
Date: Tue, 16 Aug 2016 16:58:06 +0300
MIME-Version: 1.0
In-Reply-To: <7a23f8c5-a8c8-219b-0b19-5100fcd0db3a@...515...>
Content-Type: multipart/mixed; boundary="------------C661A33D15C52B23E1BE196B"
Subject: [Openvpn-devel] Summary of the IRC meeting on 15th August 2016
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
--------------C661A33D15C52B23E1BE196B
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of yesterday's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 15th August 2016
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-08-15>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, janjust, mattock, snair, syzzer and Thermi participated in=20
this meeting.

---

Discussed the "Implement option to disable source IP check of ARP=20
requests" patch to tap-windows6:

<https://community.openvpn.net/openvpn/ticket/721>

The patch was given a feature-ACK, and cron2 felt comfortable doing the=20
code review (and ACK/NACK) later.

---

Discussed the OpenVPN 2.3.12 release. It is lacking the not yet=20
published "small block cipher warning" patch. There might also be a bug=20
related to auth-user-pass, which dazo will investigate (and fix) before=20
the release. Remaining 2.3.x tickets will be postponed.

---

Discussed how to test (the rather fragile) auth-user-pass option=20
(semi)automatically. Snair has a script for the purpose which we could=20
build on. Cron2 will create a new test server that can be used to test=20
--fragment as well as --auth-user-pass.

---

Discussed what everyone is doing, and where we're at. Dazo started=20
working for OpenVPN Technologies, Inc. 14 days ago. He will focus on=20
getting an RFC in place for the wire protocol, look into unification of=20
misc end-user UI (if that is possible/doable), systemd stuff and he's=20
been asked to look at modernizing the management API. He'll also start=20
looking at Trac tickets to see what could be fixed.

Mattock has no (personal) blockers or major remaning tasks as far as=20
2.3.12 or 2.4-alpha1 are concerned.

Snair has been working on a patch to improve signal handling and has=20
found a few more bugs.

---

Discussed the OpenVPN 2.4-alpha1 release. As --fragment and --mssfix are=20
broken, as is --inetd in certain cases, 2.4-alpha1 can NOT go out right now:

<https://community.openvpn.net/openvpn/ticket/715>
<https://community.openvpn.net/openvpn/ticket/716>

Besides that the release is in really good shape:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn24>

---

Discussed OSTIF.org, which has managed to raise a substantial sum for=20
auditing VeraCrypt. They're now working on getting funding for an=20
OpenVPN audit next, and it was agreed to arrange a meeting the upcoming=20
Monday (22nd) at 20:00 CEST (18:00 UTC), and have a chat with a=20
representative from OSTIF.org.

--.

Discussed Windows testing procedures briefly. Cron2 earlier email to=20
openvpn-devel has not yet produced anything tangible. It was agreed,=20
however, that more systematic testing is needed. Getting a test=20
framework ready for 2.4-alpha1 is probably not realistic, but aiming for=20
2.4-betas sounds reasonable.

--=20

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------C661A33D15C52B23E1BE196B
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-08-15.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-08-15.txt"
Content-Transfer-Encoding: quoted-printable

[18:25:40] * Topic for #openvpn-meeting set by ecrist!~ecrist@...2144.../con=
tributor/openvpn.ecrist (Mon Dec 14 18:40:43 2015)
[18:43:51] <dazo> I'll try to appear as soon to meeting time as possible =
... putting daughter to bed now, and hopefully she'll accept that quickly
[18:58:58] <cron2> yeah, same here - summer holiday, kids slightly behind=
 normal schedule
[18:59:03] <mattock> hi
[19:00:44] <dazo> lets see how long it lasts ... having hopes
[19:01:28] <janjust> hi y'all again
[19:01:29] <syzzer> good evening
[19:01:47] <dazo> hey!
[19:01:52] <mattock> hi all!
[19:02:18] <mattock> https://community.openvpn.net/openvpn/wiki/Topics-20=
16-08-15
[19:02:21] <vpnHelper> Title: Topics-2016-08-15 =E2=80=93 OpenVPN Communi=
ty (at community.openvpn.net)
[19:02:52] <mattock> I made the topic list a numbered list
[19:03:00] <mattock> hi snair!
[19:03:06] <snair> hi mattock
[19:03:07] <cron2> hiya!
[19:03:09] <mattock> do we start from the top, topic #1?
[19:03:11] <snair> hi guys
[19:03:13] <janjust> may I add a topic? I'm very interested in a 2.4 rele=
ase
[19:03:14] <Thermi> mattock: If it's non-obvious: I am the person that co=
ntacted you via mail regarding the patches
[19:03:15] <janjust> hi selva
[19:03:23] <mattock> hi thermi!
[19:03:27] <Thermi> (just so you know I'm here)
[19:03:31] <snair> hi janjust
[19:03:32] <mattock> so the tap-windows6 patches, which we should discuss=
 a bit
[19:03:39] <Thermi> Exactly
[19:03:46] <mattock> thermi: do you have a link handy?
[19:04:14] <Thermi> https://bpaste.net/show/a813e1789d76
[19:04:36] <Thermi> I just pasted the patch into a pastebin for now. The =
original email(s) to the devel list are in the archive
[19:04:42] <mattock> ah, ok
[19:05:15] <janjust> first thing that I see in the diff is a copyright me=
ssage
[19:05:32] <mattock> guys: what if we start by deciding what to do with t=
he tap-windows6 patches - on a general level
[19:05:57] <mattock> as in: can we give a feature-ACK, and if so, who can=
 do a code-ACK?
[19:06:11] <janjust> what's the feature to check?
[19:06:25] * cron2 did not have time to understand what the change is, an=
d what implications it might have - so, "no"
[19:06:30] <cron2> (not me, that is)
[19:06:36] <Thermi> So basically what the patch does is it adds an option=
 to disable the source IP check the driver does on ARP requests for the c=
onfigured IP of the network device. It defaults to being disabled, so wit=
h that feature not explicitely turned on, the behaviour does not differ t=
o the known behaviour.
[19:07:08] <Thermi> This allows me (and other persons) to use the driver =
for purposes where the local IP is not inside the remote subnet
[19:07:25] <Thermi> e.g. IPsec
[19:08:42] <janjust> how does one disable the source IP check? is a corre=
sponding patch for the openvpn code needed?
[19:08:43] <cron2> so if I understand that right, this is for the fake-ar=
p-reply in tun-mode code inside tapdrv?
[19:09:06] <cron2> janjust: ioctl(), and if it defaults to "the old behav=
iour", no patch for openvpn needed
[19:09:12] <Thermi> cron2: Yes, that is for the fake ARP.
[19:09:44] <janjust> cron2: ok, thanks. just wondering what would need to=
 change in openvpn if someone wants to actually turn ON the feature
[19:09:54] <cron2> mmmh.  this code predates my involvement (by a decade =
or so), but I guess it's a) because the RFC requires this and b) as a saf=
eguard in case someone builds a bridge and "spurious ARPs" bleed in...
[19:10:16] <Thermi> Yes, I think that was/is the purpose behind the sourc=
e check
[19:10:38] <cron2> but if the default is not changed, I think a feature-A=
CK is ok - it needs some warning stickers ("if you turn this on, be aware=
 what you're asking for")
[19:10:41] <Thermi> But I don't think there's any RFC regarding this, bec=
ause building TUN devices on top of fake ethernet devices is unheard of
[19:11:31] <mattock> as for the code-ACK - we can try to get James to rev=
iew the code, or even the guy who wrote tap-windows6 (that will cost extr=
a, of course, but is doable)
[19:11:41] <Thermi> There's the thread: https://sourceforge.net/p/openvpn=
/mailman/openvpn-devel/thread/169423fa-c98c-1e3b-42e9-f4bd9165bbb5%40fami=
lie-kuntze.de/#msg35210916
[19:11:41] <Thermi> Sorry for the HTML emails. Despite me having configur=
ed for plaintext, it seems it sends HTML again. :/
[19:11:43] <vpnHelper> Title: OpenVPN / Mailing Lists (at sourceforge.net=
)
[19:12:09] <Thermi> mattock: I sent an email to James shortly after I got=
 your reply, so he should be somewhat in the loop already. I attached the=
 diff to the email.
[19:12:14] <cron2> Thermi: well, ARP and Ethernet is governed by RFCs - a=
nd windows still thinks "it's an ethernet"
[19:12:34] <janjust> could also be that the source check was added to bet=
ter mimick the linux tun driver model
[19:12:38] <cron2> I think I'm qualified to code-review that but I was se=
riously out of time
[19:12:49] <mattock> cron2: ah, most excellent!
[19:12:53] <cron2> janjust: the tun driver doesn't ARP at all, so "no che=
ck" would mimick that better
[19:13:03] <cron2> tun is "stuff it in, out it goes" with no checks whats=
oever
[19:13:13] <Thermi> Well, tun transports IP packets
[19:13:17] <Thermi> so there's no ethernet frame
[19:13:43] <Thermi> cron2: Exactly, ARP and Ethernet are. But I don't thi=
nk there's an RFC regarding exactly the behaviour of the implementation o=
f a TUN/TAP device that builds on top of Ethernet
[19:13:49] <cron2> .oO(need to find out if there's any OS where the tun d=
river would do appletalk, ipx, etc. )
[19:13:50] <janjust> alright, I think I've thoroughly disqualified myself=
 by now to do any code review on this
[19:14:10] <dazo> The tun in a fake ethernet is a Windows construct ... I=
 doubt any drivers can do it differently in Windows without requiring som=
e changes in the Windows kernels networking stack ... so it's not really =
appropriate to compare tun/tap between Windows and non-Windows
[19:14:17] <Thermi> Btw, the default behaviour for Linux for ARP requests=
 is to reply to any that ask for a valid local IP, irrespective of the ac=
tual source IP address that asks for it
[19:14:27] <cron2> Thermi: of course no RFC would cover that, but if it's=
 behaving like ethernet underneath, it needs to behave like the RFC says =
an ARP-over-Ethernet thing does
[19:14:42] <Thermi> cron2: Agree. That's what I was wanting to express.
[19:14:49] <cron2> ok
[19:15:17] <Thermi> dazo: Exactly. But(!) The Agile VPN Client (IPsec, SS=
TP, ...) uses a tunnel driver, which seems to implement TAP/TUN, too
[19:15:20] <Thermi> It's the IKEv2 miniport
[19:15:27] <Thermi> So I think it *is* possible, but Just on Win7 and new=
er
[19:15:38] <cron2> worth having a look at - is that one open source?
[19:15:42] <Thermi> No, closed source.
[19:15:46] <Thermi> Comes with Windows
[19:15:46] <cron2> bah
[19:15:55] <Thermi> But One can look at the routing table.
[19:16:00] <Thermi> and of course the ARP table
[19:16:36] <cron2> (as a side note, win10 has a VPN API for "Apps" to use=
 - so if we're terribly bored, we could use that one as well...)
[19:16:56] <Thermi> I wonder what that entails - but it reminds me of the=
 API for Android and iOS
[19:17:32] <cron2> which is quite nice, actually - "hey, OS, I want a VPN=
 for <prefix list>" and not having to bother with routes, DNS, and all th=
at shit
[19:18:13] <Thermi> Yes, it's even App specific (at least on iOS)
[19:18:34] <Thermi> Actually, on Android that should be possible, too.
[19:18:40] <janjust> cron2: that can be achieved on windows already. it's=
 redirect-gateway that's impossible
[19:18:49] <cron2> janjust: and IPv6
[19:19:21] <janjust> cron2: no IPv6 via dhcp advertisementes?
[19:19:39] <janjust> (we're getting offtopic here, BTW)
[19:19:41] <cron2> janjust: no... (there is no "here are your routes!" in=
 DHCPv6)
[19:20:06] <Thermi> Windows doesn't have PBR, so it's not possible to exc=
ept the actual openvpn/Ipsec traffic from the route lookup. Therefore it'=
s not possible to secure access to the gateway's public address
[19:20:35] * cron2 wonders how the Win10 VPN API would do it - and if the=
re really is no PBR there...
[19:20:35] <Thermi> cron2: Well, couldn't you just use the win-IPH (IP he=
lper) API to install IPv4/IPv6 routes?
[19:20:38] <janjust> what's PBR?
[19:20:42] <Thermi> Policy based routing
[19:20:49] <Thermi> On Linux what you can do with marks and routing rules
[19:20:56] <janjust> gotcha
[19:20:59] <cron2> Thermi: that's what we do today
[19:21:08] <cron2> (in the iservice)
[19:21:17] <Thermi> cron2: Oh? Okay.
[19:21:20] <janjust> Thermi: that's what we currently use but it does req=
uire full privileges
[19:21:34] <Thermi> janjust: Makes sense
[19:22:05] <janjust> yep, but if we could use DHCP (which the tap-win dri=
ver supports) then we don't have to require full privs
[19:22:25] <cron2> janjust: we can't
[19:22:26] <janjust> but, as cron2 points out, that won't work for IPv6 r=
outes
[19:23:03] <cron2> theoretically there is router advertisement with IPv6 =
routing info in it, but that's a bit underspecified (what if your routes =
do not fit a single packet?) AND windows does not support it
[19:23:21] <cron2> (only default routes are learned from RA, not specific=
s)
[19:23:26] <dazo> could it support radv announcements? you can push route=
s that way, or not?
[19:23:34] <cron2> see two lines up
[19:23:41] <dazo> heh
[19:26:50] <Thermi> Yes, I don't see any definition in RFC 4861 that woul=
d allow the inclusion of routes in an RA
[19:27:12] <Thermi> To whom it may concern: https://tools.ietf.org/html/r=
fc4861#section-4.2
[19:27:13] <vpnHelper> Title: RFC 4861 - Neighbor Discovery for IP versio=
n 6 (IPv6) (at tools.ietf.org)
[19:28:37] <cron2> https://tools.ietf.org/html/rfc4191
[19:28:38] <vpnHelper> Title: RFC 4191 - Default Router Preferences and M=
ore-Specific Routes (at tools.ietf.org)
[19:29:49] <Thermi> Uh, the redirect mechanism.
[19:30:21] <Thermi> Just say you're the default router and then do some s=
henanigans with the routing table and redirect all the stuff you're not i=
nterested in over the former router?
[19:30:32] <Thermi> "A router on one link cannot redirect a host to a rou=
ter on another link."
[19:30:35] <Thermi>
[19:32:14] * janjust repeats: we're getting off topic ....
[19:32:53] <cron2> slightly
[19:35:15] <mattock> so we're still at the "needs code-ACK" phase?
[19:35:34] <janjust> mattock: I think we've passed "feature ACK" so that'=
s progress
[19:35:39] <mattock> yeah
[19:35:40] <dazo>
[19:35:48] <Thermi> \o/
[19:37:12] <Thermi> Okay, I'll wait for the response from James regarding=
 this.
[19:37:20] <Thermi> Thank you for your cooperation
[19:37:34] <mattock> I believe cron2 almost volunteered to do the code re=
view
[19:38:33] <cron2> put my name on it, put stuff in trac and assign it to =
me, but be not offended if it takes unduly long - apologies in advance
[19:38:43] <mattock> ok, that's a plan
[19:38:53] <mattock> if james get there first that is probably fine too
[19:40:33] <janjust> next topic?
[19:41:32] <janjust> I see "2.3.12 release" mentioned. what's scheduled t=
o go into this release?
[19:41:55] <cron2> what do you want in it?
[19:42:05] <janjust> nothing, I want 2.4.0
[19:42:10] <cron2> the tree has quite a bit of this-and-that already...
[19:42:57] <mattock> um, my fedora 23 decided to make my screen gray and =
not respond to anything
[19:43:15] <mattock> back on Debian 8
[19:43:16] <dazo> I need to dig into one of the issues Thermi spotted in =
my systemd patches ... I've noticed that passwords aren't read from file =
lately for user-pass auth
[19:43:18] <cron2> it should receive the "small block cipher warning patc=
h" and be shipped...
[19:43:26] <dazo> (lately on EL7, that is)
[19:43:28] <cron2> dazo: that was snair, I think
[19:43:32] <Thermi> dazo: I wasn't that
[19:43:35] <dazo> sorry!  yeah
[19:43:42] <syzzer> cron2: and possibly the follow-up patch?
[19:44:09] <syzzer> but at least the warning patch, ys
[19:44:12] <syzzer> *yes
[19:44:21] * syzzer has a lot of issues typing today
[19:47:43] <cron2> syzzer: the warning patch has an ACK, but is lacking p=
ublicity, aka "transparency"
[19:48:02] <syzzer> ok, so I'll send it to the list
[19:48:05] <cron2> so basically it only needs to be sent to the list, I c=
ould merge it to master+2.3, and ship 2.3.12...
[19:48:47] <cron2> (there's more 2.3.x bugs in trac that should see some =
love, but having 2.3.12 with the bugfixes we already have in-tree out wou=
ld still be good)
[19:48:51] <dazo> the user-pass fix should be a fairly simple fix for 2.3=
.12 too
[19:49:09] <cron2> dazo: is it broken in 2.3 as well?
[19:49:11] <dazo> I can manage that next week when I'm back at full speed
[19:49:12] <dazo> yeah
[19:49:23] <snair> hm.. why would 2.3.12 require user-pass fix ?
[19:49:45] <cron2> dazo: "as it is" or "2.3 with your patch set"?
[19:50:17] <dazo> as the thing you spotted with password and stdin is a s=
imilar issue on the 2.3 code base .... I've in july that it happened to m=
e on my SL box
[19:50:22] <dazo> cron2: nope, just this fix
[19:50:55] <dazo> (the full systemd/query-user stuff need to be looked at=
 later on once we have something ready for git master/2.4)
[19:51:15] <snair> the if (password_from_stdin) was there before your pat=
ch, I think you have to just add that toyoru patchset and shoudl work.
[19:51:47] <janjust> syzzer: seems you're not the only one with typing is=
sues
[19:51:51] <cron2> dazo: "next week" =3D "starting today" or "starting Au=
g 22"?
[19:51:53] <snair> hehe
[19:52:11] <dazo> cron2: starting 22nd .... this week is quite full alrea=
dy
[19:52:15] <cron2> ic
[19:53:03] <cron2> just as a side note: I'll go to vacation coming Wednes=
day, but will check into mail/irc about once per day
[19:55:20] <cron2> mattock: any word from James whether he wants to come =
to Helsinki?
[19:55:21] <dazo> snair: you might be right ... as I said in the mail, I =
haven't had time to dig into it ... but will do a bisect to fully underst=
and when this stopped working
[19:55:35] <mattock> cron2: I have not asked yet, but I will
[19:55:37] * cron2 takes all blame (we already agreed about that yesterda=
y)
[19:55:58] <dazo> !blame
[19:56:07] <dazo> meh, vpnHelper is sleeping
[19:56:07] <snair> It works fine "as is" for me on both 2.3 and master
[19:56:32] <dazo> snair: hmmm ... that's truly odd ... reading username/p=
assword from a file?
[19:56:47] * cron2 is fairly sure we fixed *that*
[19:57:01] <cron2> "username+password" plus "username only, and password =
from console"
[19:57:15] <snair> username/password from file, username only from file w=
ith or withour static-challenge response from stdin
[19:58:34] <dazo> snair: well, it doesn't work for me :/ ... I fought tha=
t a bit during some tests I did in July and ended up pasting passwords ma=
nually .. but I'll dig into it
[19:59:10] <cron2> dazo: definitely works for me - my "openvpn access the=
 buildmaster" VPN uses that
[19:59:25] <dazo> cron2: But you might not use --enable-systemd
[19:59:37] <dazo> it only fails when built with that
[19:59:50] <snair> dazo: see commit 6f31a83827627bbef58aaf073911e33136991=
9b7
[19:59:52] <cron2> true, but the systemd code is spun off from "ask conso=
le", which should not even get invoked if there is nothing to ask for
[20:00:25] <dazo> snair: yeah, spotted that one
[20:00:42] <cron2> get_console_input() is not called if get_user_pass_cr(=
) is sufficiently happy
[20:00:43] <dazo> cron2: in theory, what you say makes sense
[20:01:32] <dazo> snair: got a test script/config handy for testing the c=
hallenge/response protocol?
[20:01:48] <dazo> protocolS ... as it's basically two different ones
[20:01:53] <cron2> get_console_input() is only called inside this clause
[20:01:56] <cron2>       if (username_from_stdin || password_from_stdin |=
| response_from_stdin)
[20:02:10] <cron2> ... which should never be reached if the "read user+pa=
ssword from file" code is happy...
[20:02:23] <cron2> ah
[20:02:46] <cron2> snair: why is       if (username_from_stdin || passwor=
d_from_stdin || response_from_stdin)
[20:02:49] <cron2> sorry
[20:03:04] <snair> dazo: I have  a test server that tests static and dyna=
mic challenge
[20:03:25] <cron2> mmmh, convoluted code
[20:04:45] <snair> cron2: yes the code is ugly.. it has been repeatedly b=
eaten up to a sorry state.
[20:04:54] <dazo> snair: is it possible to generalize it so we could add =
it to our test boxes as well? ... cron2 have configured a handful of open=
vpn servers to test various stuff, I'd like to see user-auth tested
[20:05:33] <cron2> dazo: I want to add one extra server for --fragment an=
yway, we could use that to play with --auth-user-pass variants
[20:05:47] <cron2> s/want/need/
[20:05:57] <snair> dazo: currently its a crappy script taht prompts you f=
or the value of pi or 1+1 to do dynamic challenge..
[20:06:20] <snair> I just cant type...
[20:06:38] <dazo> cron2: sounds like a good plan
[20:07:22] <cron2> we might even get it to do challenge stuff, depending =
on the username passed
[20:07:29] <cron2> no idea
[20:07:38] <dazo> snair: well, I won't blame you if you don't want to sha=
re it ... but having a starting point to build upon would be better than =
to rewrite all from scratch
[20:07:47] <cron2> snair: could you post something to -devel that shows h=
ow the challenge stuff can be done?
[20:07:53] <dazo> +1
[20:08:03] <snair> snair: will do
[20:08:05] <cron2> "what dazo said" :)) - crappy script that asks for 1+1=
 is more than I have right now
[20:08:06] <dazo> thx!
[20:08:43] * cron2 wonders how to test "read from stdin" in t_client...
[20:09:00] <janjust> man expect  ?
[20:09:06] <dazo> cron2: management interface
[20:09:30] <dazo> but true ... would be good to test stdin too ... expect=
 is a reasonable one
[20:09:31] <cron2> management interface is not "read from stdin", you kno=
w... (and this is half the reason for the convolutions in there)
[20:09:44] <cron2> echo user\npass |openvpn ...
[20:09:54] <cron2> works perfectly well, just t_client cannot do this tod=
ay
[20:10:40] <dazo> we'll figure out something
[20:11:34] <janjust> is this challenge/response stuff in 2.3 ?
[20:11:50] <cron2> ancient, 2.0 stuff, just secret
[20:12:06] <dazo> janjust: yeah
[20:12:19] <cron2> commit eab3e22f8261c07d5f906c05fce69917034d9e53
[20:12:19] <cron2> Author: James Yonan <james@...515...>
[20:12:19] <cron2> Date:   Fri Jun 3 21:21:20 2011 +0000
[20:12:23] <cron2>     Added support for static challenge/response protoc=
ol.
[20:12:25] <cron2>     Version 2.1.3x.
[20:12:33] <cron2> ok, not 2.0 stuff, but still
[20:12:34] <janjust> ouch... THAT old, huh
[20:12:41] <cron2>     git-svn-id: http://svn.openvpn.net/projects/openvp=
n/branches/BETA21/openvpn@...2159... e7ae566f-a301-0410-adde-c780ea21d3b5
[20:12:50] <cron2> (unfortunately the svn.openvpn.net server went away)
[20:12:58] <dazo> but challenge/response is two protocols ... a static on=
e and a dynamic one
[20:12:59] <janjust> still strange that I've never run into - I've browse=
d the sources often enough
[20:13:15] <cron2> ENABLE_CLIENT_CR
[20:13:20] <snair> cron2: does piping user/pass to stdin work with getpas=
s?
[20:14:16] <dazo> heh ... I was sure you had seen these code paths, janju=
st   .... considering all the other undocumented things you've found ....=
 challenge/response is actually documented in doc/management.txt
[20:14:26] <cron2> snair: "sometimes" - I think it only works if you have=
 no controlling tty, so opening /dev/tty fails
[20:14:35] <cron2> dazo: both variants?
[20:14:45] <dazo> cron2: I believe so, yes
[20:14:53] <dazo> it's a while since I looked at it
[20:14:53] <janjust> I *have* seen ENABLE_CLIENT_CR in the past, just nev=
er dove into it well enough to find out what it did...
[20:15:01] <dazo>
[20:15:52] * cron2 seems to remember that plaisthos wanted to get rid of =
that #ifdef...
[20:16:22] <cron2> why does it depend on ENABLE_MANAGEMENT if it can do "=
read from stdin" as well...
[20:16:50] <dazo> cron2: nowadays it can tackle stdin ... it couldn't ear=
lier on
[20:17:00] <dazo> (iirc)
[20:17:13] <cron2> dazo: shall I go back and look in BSD 4.2 sources?=20
[20:17:40] <janjust> cron2: both static and dynamic CR is explained in do=
c/management-notes.txt
[20:17:41] <dazo> heh
[20:18:02] <dazo> I think you might find part of the answer in snair's co=
mmit 6f31a83827627bbef58aaf073911e331369919b7
[20:19:30] <cron2> but you are right - BSD always had it that way, while =
SysV documents [ENXIO] "The process does not have a controlling terminal"=
 (and never mentions stdin)
[20:22:15] <snair> on Linux man getpass says it reads from /dev/tty
[20:22:28] <dazo> so ... back to the topics of today?
[20:22:53] <cron2> snair: oh, interesting.  BSD says "if /dev/tty cannot =
be opened, stdin is used instead"
[20:23:09] <cron2> snair: so, generally speaking, feeding openvpn from st=
din won't work, and expect might be the answer (pty)
[20:24:02] <cron2> dazo: we're totally on-topic I'm just not sure which o=
ne, maybe 2.3.12
[20:24:07] <cron2> but I think this is covered now
[20:24:17] <dazo>
[20:24:31] * dazo obviously lost track somewhere
[20:24:34] <snair> dazo: yeah, feeding user/pass from stdin never worked =
for me..
[20:25:21] <cron2> so, looking at the agenda, 2., 3. and 5. are covered. =
 what next?
[20:26:26] <dazo> 1) is an easy one ... just to have an idea what's going=
 on
[20:26:43] <dazo> I can start
[20:26:53] <cron2> so - what is everyone doing, and what is distracting y=
ou all?
[20:27:21] * syzzer is currently working an --tls-crypt
[20:27:46] <mattock> I'm trying to figure out why my laptop's screen show=
s grey, but otherwise the damn thing works ok :|
[20:27:54] <mattock> but that is somewhat off-topic here
[20:27:58] <dazo> I've started with OpenVPN Tech 14 days ago ... and will=
 have a lot of focus on getting an RFC in place for the wire protocol, lo=
ok into unification of misc end-user UI (if that is possible/doable), sys=
temd stuff and I've been asked to look at modernizing the management API
[20:28:20] <dazo> but I'll also start poking at our Trac tickets too, to =
see what's burning
[20:28:40] <dazo> I expect to be far more visible and do some heavy lifti=
ng with the git trees again too
[20:28:51] <mattock> I have no particular blockers as far as 2.3.12 or 2.=
4-alpha1 is concerned - all the important bits and pieces are there
[20:28:57] <cron2> dazo: cool
[20:29:01] <snair> I have been working on a patch to improve signal handl=
ing and found a few more bugs..
[20:29:13] <cron2> mattock: --fragment and --mssfix are broken right now,=
 so 2.4-alpha1 can NOT go out right now
[20:30:04] <cron2> trac #716
[20:31:12] <cron2> (we know why that is, but neither syzzer nor I had suf=
ficient time to make a "nice code" patch)
[20:31:30] <cron2> #715 is also relevant to make the NCP code more robust=
 in the face of "users with funny configurations"
[20:31:59] <mattock> cron2: oh, ic, but still no blockers at my end
[20:32:02] <cron2> ... but that is crossing topics to 4. already
[20:32:08] <cron2> so how's the new packaging coming along?
[20:32:17] <syzzer> hm, I rembedered 715, but totally forgot about 716...=
 sorry!  (not that I've had a lot of time...)
[20:32:22] <dazo> cron2: so this breakage is due to ncp patches alone?
[20:32:39] <cron2> syzzer: feel reminded
[20:33:11] <syzzer> dazo: I believe peer-id also broke something related,=
 but I'm not sure anymore
[20:33:20] <cron2> dazo: yes.  It is... complicated. There is this "struc=
t frame", which gets initialized early in the process, and carries (among=
 others) fragment and mssfix info
[20:33:36] <cron2> with NCP active, the frame gets rebuilt after "cipher =
xxx" is received
[20:33:49] <dazo> ahh, I see
[20:33:55] <cron2> and *that* code doesn't initialize mssfix and fragment=
 stuff
[20:34:23] <cron2> peer-id had side effects on link-mtu, but didn't actua=
lly *break* mssfix etc
[20:38:26] <mattock> I need to split soon, need to get up early
[20:39:43] <mattock> 4 and 6 still not covered, and 1 wip, right?
[20:39:52] <mattock> (got distracted when I had to switch laptops)
[20:40:01] <cron2> sort of.  good night
[20:40:43] <mattock> anyways, as for 2.3.12: any time works for me, and f=
or 2.4-alpha1: I need to verify that all the tiny bits are in right order=
, but all the hard stuff is done
[20:40:54] <syzzer> good night mattock!
[20:41:16] <mattock> I'll assign the tap-windows6 patch to cron2
[20:41:39] <cron2> I've added some more info to the "why's" to #716 and c=
c'ed dazo
[20:41:45] <mattock> oh, one thing: OSTIF.org contacted me and they had m=
anaged to raise a considerable sum of money for auditing VeraCrypt (a for=
k of TrueCrypt)
[20:41:51] <mattock> the next in line will be OpenVPN
[20:41:54] <dazo> cron2: cool!
[20:41:58] <cron2> mattock: cool (2.4-alpha1)
[20:42:17] <cron2> interesting that you bring this up, I was asked about =
OSTIF just yesterday
[20:42:21] <mattock> ah
[20:42:39] <mattock> anyways, I think we should have talk (meeting) with =
OSTIF again soon
[20:42:53] <cron2> moneyz!
[20:42:55] <cron2> t-shirts!
[20:42:58] <cron2> speaking of...
[20:43:02] <mattock> oh shit, those
[20:43:07] <cron2> (I bet he disappears really soon now)
[20:43:20] <syzzer> hahaha
[20:43:26] <janjust> hehe
[20:43:26] <mattock> not really, but I'm tempted to cut some corners this=
 time as far as bookkeeping is concerned
[20:44:13] <mattock> anyways, maybe we could have another meeting on 22nd=
 or 29th and invite OSTIF there
[20:44:28] <cron2> +1
[20:44:45] <cron2> (I'm in italy, and might be a few minutes late, but sh=
ould be able to make it)
[20:44:56] <mattock> ok, so on 22nd?
[20:45:06] <cron2> wfm
[20:45:24] <syzzer> yeah, me too
[20:45:32] <dazo> +1
[20:45:38] <mattock> ok, great!
[20:45:56] <mattock> please go on if you need to, I will check back in he=
re in a few minutes
[20:47:02] <janjust> I'm outta here too
[20:47:12] <janjust> until next time
[20:47:28] <cron2> I think we have covered 2.4_alpha1 mostly - as in: ens=
ure mssfix + fragment are back to working, ensure that auth-user-pass stu=
ff & systemd is working
[20:47:38] <cron2> janjust: are you coming to Helsinki?
[20:47:57] <cron2> (you could share a plane with syzzer and andj... )
[20:48:06] <janjust> err, when's helsinki planned?
[20:48:16] <cron2> http://community.openvpn.net/openvpn/wiki/HelsinkiHack=
athon2016
[20:48:17] <vpnHelper> Title: HelsinkiHackathon2016 =E2=80=93 OpenVPN Com=
munity (at community.openvpn.net)
[20:48:28] <cron2> sep 16-sep 19
[20:48:35] <cron2> 18
[20:48:38] <cron2> that weekend, anyway
[20:49:31] <janjust> will think about it, I've got something planned on s=
ept 16 en20th already, but perhaps I can squeeze it in there
[20:49:35] <janjust> I will let you know
[20:49:58] <cron2> september is busy for people... next year, find a sunn=
y place and go in november
[20:50:04] <cron2> someone working in egypt?
[20:51:13] <dazo> Dubai anyone?
[20:51:31] <janjust> Dubai is nice in november
[20:51:53] <cron2> indeed, so can openvpn tech open an office there, and =
invite us over, please?
[20:52:03] <dazo> hehehe +1!
[20:52:04] <cron2> http://community.openvpn.net/openvpn/wiki/StatusOfOpen=
vpn24
[20:52:05] <vpnHelper> Title: StatusOfOpenvpn24 =E2=80=93 OpenVPN Communi=
ty (at community.openvpn.net)
[20:53:16] <dazo> My work on the auth-user-pass rework is moving forward =
quite well now after snair started to reviewing patches too ... I'm very =
thankful for that!
[20:54:21] * cron2 is happy to see progress there, yes, thanks indeed
[20:55:33] * dazo need to leave in about 5-10 min
[20:56:01] <cron2> so, anything else on 2.4 or windows testing?
[20:56:14] <snair> sorry I was away, looks like didnt miss much...
[20:56:31] <snair> windows testing? sounds scary..
[20:56:32] <cron2> snair: quite a bit of disorganized this-and-that
[20:56:51] <cron2> well, I brought this to the list a few weeks ago, but =
it did not have the desired result (but the somewhat *expected* result)
[20:57:04] <dazo> windows testing is probably a too big task to start dis=
cussing now ... has anyone actually looked at some kind of test framework=
?
[20:57:24] <cron2> we need more systematic windows testing - I got lots o=
f wonderful advice about which language is best, and what test framework =
would rule the world, but nobody went out and actually coded anything
[20:58:06] <cron2> dazo: just keep in mind that there is a loose end... a=
nd unfortunately, windows users are our biggest user base, so that stuff =
need to be in really good shape for alpha1
[20:59:23] <dazo> I won't promise anything there, as I'm not a Windows pe=
rson at all ... but if OpenVPN Tech can spin up some Windows machines for=
 me (I have literally none at all in my possession), I can probably spend=
 some time investigating this once my current tasks reaches some closure
[21:00:11] <cron2> I think you better help with shaping git and unix/linu=
x - I've become more of a windows person in recent years (well, thanks to=
 openvpn building and testing...)
[21:01:06] <dazo> Sure, nothing is better that more suitable persons dig =
into it ... but testing is an area I'd like to spend a bit more time on, =
but that'll be a lot focused on unit testing as well
[21:01:16] <cron2> certainly welcome
[21:02:39] <dazo> I'd agree we should have some better testing for the 2.=
4 release ...  but fear alpha1 might be too sudden though.  However, havi=
ng /something/ before the beta cycle sounds reasonable
[21:02:42] <dazo> to me
[21:03:39] <dazo> alright, I need to move on now .... thanks a lot all!
[21:03:47] <cron2> g'night...
[21:03:59] <snair> good night
[21:04:17] <snair> And me to have to leave..
[21:04:25] <cron2> I think this was a useful excercise... just re-sync on=
 stuff
[21:04:29] <cron2> yeah, have to go to bed as well
[21:04:36] <cron2> by snair, thanks for showing up
[21:04:49] <snair> bye cron2
[21:05:00] <snair> my pleasure..
[21:06:06] <syzzer> good night!
[21:06:56] <cron2> syzzer: how's the house coming along?
[21:07:43] <syzzer> cron2: good we've got floors, paint on the walls, eve=
n the network patches are working :+
[21:07:50] <cron2> good!
[21:08:23] <syzzer> up next is turning the swamp behind the house into a =
garden :p


--------------C661A33D15C52B23E1BE196B--

