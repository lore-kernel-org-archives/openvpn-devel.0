From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Message-ID: <56ae24a4-52ff-345e-8a7d-7511ce6b0f97@...515...>
Date: Wed, 29 May 2019 13:25:09 +0300
MIME-Version: 1.0
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r1B5ZPiq8g5uopVfaGxQyR554xMCA1dny"
Subject: [Openvpn-devel] Summary of the community meeting (29th May 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r1B5ZPiq8g5uopVfaGxQyR554xMCA1dny
Content-Type: multipart/mixed; boundary="7X0LCP19FSnpxmm3RqvtVlGb8Pm3Hx9E7";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <56ae24a4-52ff-345e-8a7d-7511ce6b0f97@...515...>
Subject: Summary of the community meeting (29th May 2019)
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>

--7X0LCP19FSnpxmm3RqvtVlGb8Pm3Hx9E7
Content-Type: multipart/mixed;
 boundary="------------C63BE5F5D3E021F3000D25FB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C63BE5F5D3E021F3000D25FB
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 29th May 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-05-29>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex and plaisthos participated in this meeting.

---

Talked about the possible DoS attack that forums had a few days ago.
Investigation of what happened is still ongoing. It is possible that it
was just a misbehaving bot (happens occasionally on community/trac).

This possible DoS attack was mitigated by turning on CloudFlare
temporarily. This caused some bad blood in the community. We'll continue
the discussion once we know exactly what happened.

---

Discussed tap-windows6 HLK testing. Mattock will setup a physical HLK
environment in his office. Developers can experiment with trying to make
tap-windows6 appear as a virtual device, as described in last meeting
summary:

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18476.=
html>

These two approaches ("make it virtual", "build physical HLK
environment") can and will go hand-in-hand. It is known that sgstair and
jamallx made all the (mandatory) tests pass using a physical HLK
environment, so that route is "guaranteed" to work, unlike the "make it
virtual" route.

---

Discussed dropping TAP support from Windows. Agreed that it can happen
in 2.6 at earliest (if at all). Tons of people are probably using TAP.
It was also agreed that if TAP support was ever dropped, it would be
best to just migrate to wintun altogether.

---

Talked about wintun. Agreed that having wintun support as an option in
OpenVPN 2.5 makes perfect sense. Lev is adding wintun support to OpenVPN
2 right now.

---

Next mini-hackathon will be arranged Friday next week (7th June)
starting in European morning. As usual, it will focus on OpenVPN 2.5 work.

---

Dazo is soon going to announce the public availability of openvpn3-linux
client v6 apt repositories for Debian and Ubuntu.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------C63BE5F5D3E021F3000D25FB
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-05-29.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-05-29.txt"

(12:30:20) syzzer: meeting today?
(12:32:01) plaisthos: I think so but I got to go in 20 minutes
(12:32:33) ***dazo is here
(12:32:54) syzzer: https://community.openvpn.net/openvpn/wiki/Topics-2019=
-05-29
(12:32:56) vpnHelper: Title: Topics-2019-05-29 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:33:05) mattock: howdy!
(12:33:25) mattock: syzzer: if there was an invite, there will be a meeti=
ng, people present or no :)
(12:33:32) mattock: ok so
(12:33:45) mattock: let me start with something outside of the topic list=
, ok?
(12:33:55) dazo: sure
(12:34:25) mattock: so, forums was attacked a few days ago
(12:34:33) mattock: or maybe it was just a badly behaving bot
(12:34:41) dazo: yikes
(12:34:57) mattock: ecrist is investigating the root cause, but so far no=
 updates
(12:35:27) syzzer: attacked as in DoS, or compromise?
(12:35:34) mattock: DoS
(12:35:43) mattock: novaflash (one of our employees) turned on CloudFlare=
 on forums temporarily to stop the attack, and on request of ecrist Cloud=
Flare is disabled again now
(12:36:35) mattock: ecrist was strongly opposed to turning on CloudFlare
(12:36:41) syzzer: ah, sucks, but shit happens
(12:36:54) ordex: ay ay=20
(12:37:45) lev__: hello
(12:38:03) mattock: the main result of this was that ecrist and novaflash=
 rubbed each other the wrong way
(12:38:16) syzzer: I have no opinion on the cloudflare thing
(12:38:28) ordex: rubbed each other ?
(12:38:40) mattock: both were pissed at each other basically
(12:38:46) ordex: ah ok :D
(12:39:15) mattock: so, I suggest we wait for ecrist's analysis and then =
think about what to do in the long run
(12:39:31) mattock: if this was just a bot, then cloudflare would be kind=
 of pointless
(12:40:05) mattock: I think that covers it
(12:40:25) mattock: tap-windows6 next? from https://community.openvpn.net=
/openvpn/wiki/Topics-2019-05-29
(12:40:26) vpnHelper: Title: Topics-2019-05-29 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:40:57) plaisthos: From my side I don't have much. But I will post a p=
atch set for OpenVPN 2.x to teach it the things needs for doing SSO via w=
eb and challenge/response without reconnect. Both features depend on usin=
g management. It is more an AS feature (or who else wants to implement it=
), client side is in OpenVPN for Android
(12:40:59) dazo: I fully and completely understand the resistance to CF (=
my Friday lost hours fighting it as well in a not related issue) ... it r=
eally can be a pain ... but also a life saver when shit hits the fan ... =
As long as our sites are properly secured and can tackle a storm, I don't=
 care that much how we reach that goal.  But if the solution in use is pa=
inful to work with on a day-to-day basis, well, then we need something di=
fferent
(12:41:53) dazo: tap-windows6 ... yes :)
(12:42:00) mattock: ok
(12:42:34) mattock: so, in last mini-hackathon rozmansi suggested that _m=
aybe_ it would be possible to modify the driver's parameters so that we c=
ould skip the NDISTest suite (which requires support machine etc.)
(12:42:59) mattock: rozmansi is busy until end of this year, but he did s=
ay he'd take a quick stab at that to see if he gets lucky
(12:43:27) mattock: because there are no guarantees, I have assembled lot=
s of stuff (computers, cables, switches) to build a physical HLK environm=
ent in my own office
(12:43:49) mattock: unfortunately getting that stuff from the company has=
 historically been really painful, and I do want to get this thing done a=
=2Es.a.p.
(12:43:53) ordex: mattock1: I think lev__ proposed a patch along this dir=
ection?
(12:43:56) dazo: can we sync up with what wintun does?  I just feels like=
 they managed to pull through this signing stuff incredibly quickly
(12:44:12) mattock: I don't mind if somebody researches that, but I'm not=
 waiting any longer :P
(12:44:29) mattock: we know that tap-windows6 can pass the HLK test suite=
 if HLK is running on physical computers
(12:44:56) mattock: if any of you guys (ping lev?) have spare time to exp=
eriment with this I welcome the help
(12:45:13) lev__: well wintun doesn't do tap
(12:45:30) dazo: but is TAP mode really relevant?
(12:45:37) mattock: rozmansi provided a patch to tap-windows6 that attemp=
ts to make HLK believe that tap-windows6 is a virtual network device
(12:45:48) ***dazo has no understanding of the low level windows driver l=
ayers, though
(12:45:49) ordex: dazo: well with openvpn2 people can do tap on windows s=
erver/client, no?
(12:45:49) mattock: that patch did not have the desired effect unfortunat=
ely, for HLK tests
(12:45:58) ordex: mattock1: oh ok
(12:46:13) mattock: worst case we need to talk to Microsoft (which probab=
ly takes ages) to get some exception for tap-windows6
(12:46:15) dazo: ordex: no, I mean ... for a software/virtual network ada=
pter ... does TAP mode really mattter?
(12:46:28) mattock: dazo: remember, it is HLK that cares
(12:46:39) mattock: whether there is a difference in the driver is irrele=
vant
(12:46:44) lev__: and wintun defines itself as a virtual device
(12:46:55) dazo: yes, but again, tap-windows6 isn't a hardware driver, it=
's a driver for a virtual NIC
(12:47:19) mattock: yes, but we need to make HLK think that, too
(12:47:28) ordex: I guess the fact that it is capable of doing L2 transpo=
rt makes it eligible for more tests, no?
(12:47:45) mattock: yes
(12:47:48) dazo: HLK requiring physical hardware makes sense when the dri=
ver is targeting a physical hardware ... but in this case, it is a virtua=
l interface it drives
(12:47:51) lev__: can we make a tun-only tap-windows6
(12:48:13) dazo: meh ... then we should probably just move over to wintun=
 alone
(12:48:28) mattock: yeah
(12:48:40) lev__: well I am working on wintun patch for openvpn2
(12:48:46) cron2: lev__: I think it would be easier to just use wintun th=
en - tap6 is an ethernet driver with ethernet built-in into everything
(12:48:59) dazo: unless we think we can easily get tap-windows6 (being a =
tun only driver) at least as efficient as wintun .... not sure it's worth=
 the effort though
(12:49:03) mattock: but anyways, I will build the physical HLK environmen=
t while anyone who can/wants can play with driver properties
(12:49:30) lev__: mattock1: it seems that tap support costs us a lot
(12:49:34) dazo: mattock1: sounds like a good plan=20
(12:49:39) mattock: lev: that is very true
(12:49:47) mattock: in real $$$
(12:50:06) lev__: which brings the question, do we really need it
(12:50:15) mattock: who wants to volunteer to send email to openvpn-users=
 and tell "we're dropping tap support on Windows" :D
(12:50:52) syzzer: there's probably a ton on people using it
(12:51:27) syzzer: and dropping support mid-life for 2.4 seems a bit hars=
h on our users
(12:51:32) syzzer: but we might consider this for 2.5
(12:51:33) mattock: agreed
(12:51:46) lev__: I would suggest to strip tap support, get HLK done and =
offer both tap and wintun options
(12:51:57) dazo: yeah, agreed ... I think even 2.5 is too early, unless w=
e're ready for some flame wars on the mailing lists and forums
(12:52:03) lev__: like we do with SSL backend
(12:52:23) dazo: but we can announce with the 2.5 release that we're movi=
ng towards a tun-only OpenVPN on Windows
(12:52:25) syzzer: lev__: adding wintun support is definitely a good plan=

(12:52:28) dazo: in 2.6, that is
(12:52:43) mattock: +1 for wintun in 2.5
(12:52:45) ordex: well, we can also "ask" for anybody being willing to ma=
intain tap support at his/her own expenses since we can't do that anymore=

(12:52:53) dazo: +1 for wintun in 2.5 too
(12:52:56) ordex: +1
(12:53:04) cron2: not sure why we're actually having this discussion.  We=
 have paid a lot for having a working driver, so we just need to finally =
finish the HLK tests...
(12:53:16) mattock: yes, let us finish the HLK tests
(12:53:27) syzzer: that needs to happen anyway, yes
(12:53:33) dazo: agreed
(12:53:47) ordex: assuming we are really able to finish those :p
(12:53:49) mattock: it will take me two working days probably to setup th=
e physical environment, unless there are some blockers (unlikely)
(12:53:55) cron2: and since these tests supposedly *do* pass, any talk ab=
out "drop tap support" seems to be activitionism
(12:54:01) mattock: we know that sgstair and jamallx finished HLK on real=
 hardware
(12:54:08) ordex: ok
(12:54:19) ordex: I was under the impression "that we don't really know w=
hen we'll be done"
(12:54:19) mattock: hence my inclination to build the physical environmen=
t and be done with it
(12:54:24) ordex: ok
(12:54:44) mattock: plus my colleagues at the office inherit (from a clie=
nt) a boatload of computers that fit the HLK testing roles perfectly
(12:54:58) mattock: which I can obtain for a reasonable amount of money (=
or maybe even lease)
(12:55:59) mattock: they're waiting for me to insert the Windows Server 2=
019 installation medium :)
(12:56:04) mattock: tap-windows6 covered?
(12:57:36) ordex: I guess you know :D
(12:57:45) dazo: yeah
(12:59:26) mattock: ok so 2.5 next on topic list
(12:59:29) mattock: anything to add there?
(13:00:07) dazo: nothing new, I presume ... we're just trying to get thin=
gs reviewed, ACKed and merged
(13:03:58) mattock: anything to add to dazo's analysis?
(13:04:41) syzzer: nope, "all we need is some focused dev/review time"
(13:06:23) cron2: yeah, basically that's it... I'm working on sitnl but t=
he meeting last week in Reykjavik cost me more time than I expected (=3D =
nothing happened on my end).  But I'll resume today/tomorrow.
(13:06:50) mattock: ok, so mini-hackaton coming up again next Friday
(13:06:58) mattock: next week's friday I mean
(13:07:12) cron2: yep.  I'm @ home and should be able to find half a day
(13:07:18) mattock: \o/
(13:07:31) cron2: (returning from a meeting at midnight... - thursday's m=
eeting will see me in a train :-) )
(13:09:26) mattock: ok
(13:09:30) mattock: anything else for todays meeting?
(13:13:46) dazo: Just a note that I'm in the final phase of having Debian=
 and Ubuntu repos ready for the new openvpn3 client .... going to test th=
e repos and announce them a bit later.
(13:14:23) dazo: The v6 beta release seems pretty solid now and should be=
 not be too scary to test, in regards to stability and bugs.
(13:14:59) mattock: \o/
(13:15:40) syzzer: nice :)
(13:15:53) syzzer: so, lunch then I guess
(13:16:07) mattock: if I can get a Linux client that does not suck at con=
figuring the system resolver I will buy it immediately :P
(13:16:29) mattock: anyways, you guys get lunch, I already did
(13:17:07) ***dazo arrived the office minutes before the meeting started =
:-P
(13:19:47) mattock: two minutes of silence -> end of meeting :)

--------------C63BE5F5D3E021F3000D25FB--

--7X0LCP19FSnpxmm3RqvtVlGb8Pm3Hx9E7--

--r1B5ZPiq8g5uopVfaGxQyR554xMCA1dny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzuXgUACgkQKVhNn0CG
RXi7KAgAtvK8lKXWhCaYhAZo2bpfgHKl1QnyLRcKTr5P3KM8QgfDNn2o2E52Aqpy
jN9IXqCtUZYjC8lo2BP1CsS+ubzI8IpI78+t1dD2ga6TQCXZMSKqFMBRgpMbBR3e
tJQwGfkseunqrbpI1/LnrFUEupPkQWcHN5umRPFYPNwA8k6BIVUskh5c4xQJkagY
dByYLirkhZ56fctoqYJIPddLeuEzPYBwQ6ZOvTczknCiZJXrpwM9NP8UYw31yIRY
Iz1Zm9jCKlnTzxlm2K/tNThVnD7bE5qj7RSgrRHTIM4mUkWOyzQIPoO+agH2c2wr
1fRcurTOhBJchT/eZesX8uLs7QjSRA==
=hS53
-----END PGP SIGNATURE-----

--r1B5ZPiq8g5uopVfaGxQyR554xMCA1dny--

