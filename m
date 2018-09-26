From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <60b2b3e5-bf4a-8b83-0f0e-98555942a4c7@...515...>
Message-ID: <9ddad90f-e343-a713-ec4f-42f2a69d3746@...515...>
Date: Wed, 26 Sep 2018 14:08:19 +0300
MIME-Version: 1.0
In-Reply-To: <60b2b3e5-bf4a-8b83-0f0e-98555942a4c7@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ok8Gb9ZZ6kKRUjW7ZsNVRZAY2ZsyuuVSK"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 26th Sep 2018)
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
--Ok8Gb9ZZ6kKRUjW7ZsNVRZAY2ZsyuuVSK
Content-Type: multipart/mixed; boundary="3DYzsrV2h3XXOEfM1pZN9LTZg7pIVOQYi";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <9ddad90f-e343-a713-ec4f-42f2a69d3746@...515...>
Subject: Summary of the community meeting (Wed, 26th Sep 2018)
References: <60b2b3e5-bf4a-8b83-0f0e-98555942a4c7@...515...>
In-Reply-To: <60b2b3e5-bf4a-8b83-0f0e-98555942a4c7@...515...>

--3DYzsrV2h3XXOEfM1pZN9LTZg7pIVOQYi
Content-Type: multipart/mixed;
 boundary="------------5D7C55BFA2A6811036098689"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5D7C55BFA2A6811036098689
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 26th Sep 2018
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-09-26>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex, plaisthos, syzzer and tincantech
participated in this meeting.

--

Discussed tap-windows6 release and HLK testing. An outsourcing company
is currently HLK testing the driver, but they are probably unable to fix
some of the issues. OpenVPN Inc. may have to hire a Windows kernel
driver developer to resolve those issues, after which we can make HLK
tests pass, get WHQL certification and finally release a driver that
loads on Windows Server 2016 and later. Mattock will discuss this topic
in an internal meeting the upcoming Friday.

--

Discussed the Lviv hackathon:

https://community.openvpn.net/openvpn/wiki/LvivHackathon2018

Agreed that the focus should be on "what should go in to OpenVPN 2.5".
It was agreed that being in sync with Debian 10's release cycle would be
good:

https://lists.debian.org/debian-devel-announce/2018/04/msg00006.html

However, it will be a tough deadline to meet due to the number of
potential features:

https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25

Dazo and mattock will try to get more focus on 2.5 from OpenVPN Inc's
developers.

--

Discussed tap-windows6 in relation to the new Windows VPN API. It was
agreed that we can't migrate away from tap-windows6 any time soon, plus
the VPN API only works with "modern" apps. OpenVPN Inc has written a
proprietary OpenVPN 3-based "modern" app that uses the VPN API, but it
is still in beta in Windows Marketplace. Plus there are glitches in the
VPN API itself.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------5D7C55BFA2A6811036098689
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-09-26.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-09-26.txt"

(12:30:50) mattock: hi
(12:30:52) mattock: meeting time
(12:32:12) mattock: who is joining today?
(12:33:11) cron2: a mattock!
(12:34:21) lev__: hello there
(12:34:31) mattock: hi!
(12:34:57) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-09-26
(12:34:59) vpnHelper: Title: Topics-2018-09-26 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:35:19) mattock: I can start with #1, as that's only a status update f=
or those not in the loop
(12:35:27) cron2: go for it
(12:35:42) mattock: so, right now tap-windows6 is being HLK-tested by an =
outsourcing company
(12:35:52) mattock: they've made some progress, but some HLK tests are st=
ill failing
(12:36:28) mattock: according to jon fixing some of the issues might take=
 an experienced NDIS developer a couple of weeks even
(12:36:33) mattock: so they're not trivially fixable
(12:36:54) cron2: ewwww
(12:36:56) mattock: I will discuss the option of hiring such a developer =
the upcoming Friday
(12:37:14) mattock: I'll be in a meeting with CEO of OpenVPN Inc.
(12:37:45) cron2: has there been a change of role there?
(12:38:01) mattock: then there's another (rather big) company who has the=
 same tap-windows6 / HLK / WHQL certification issue, and we may be able t=
o co-operate with them
(12:38:06) ***ordex is here
(12:38:13) mattock: cron2: change of role where?
(12:38:21) cron2: CEO.  Still Francis?
(12:38:23) mattock: yes
(12:38:39) cron2: ok (I just wondered because you've never spoke so forma=
lly)
(12:38:43) mattock: :)
(12:38:54) mattock: well, people who read the chatlog might not know Fran=
cis is the CEO
(12:38:58) mattock: that was my reasoning
(12:38:59) cron2: yeah
(12:39:09) mattock: but now they _will_ know
(12:39:10) plaisthos: I am here too
(12:39:15) ordex: :D
(12:39:45) mattock: oh, I will send email to the "other company" about ta=
p-windows6 WHQL certification - they've been a bit slow to respond after =
we requested GPG encryption :P
(12:39:57) mattock: that's all I have to share about this topic
(12:40:29) mattock: Lviv next?
(12:40:46) ordex: ok
(12:41:02) ordex: it seems it is not going be to be a crowded hackathon
(12:41:14) plaisthos: yeah sadly :/
(12:41:48) ***syzzer present too
(12:42:11) syzzer: (lost track of time while debugging an issue with $cow=
orker)
(12:42:27) cron2: you need to spend less time on work!
(12:42:35) mattock: https://community.openvpn.net/openvpn/wiki/LvivHackat=
hon2018
(12:42:37) vpnHelper: Title: LvivHackathon2018 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:42:44) mattock: well we do have a fair amount of people joining
(12:42:57) mattock: not like last year, but still
(12:43:53) mattock: only two who are _not_ openvpn inc employees, but I g=
uess that's to be expected when OpenVPN Inc has tried to hire almost all =
OpenVPN devs there are
(12:44:18) ordex: :D
(12:44:20) cron2: yeah, I noticed the numbers :)
(12:44:33) mattock: so anything in particular to discuss about hackathon?=
 goals etc?
(12:44:44) mattock: are we aiming for 2.5 there?
(12:45:29) cron2: 2.5 release certainly not - far too much stuff missing.=
  An agreement on what should be *in* 2.5 plus a timeline would be good
(12:45:35) ordex: yap
(12:46:03) cron2: ordex and I discussed this in one of the mattock-free w=
eeks and are aiming for "end of the year for things-should-be-in" and may=
be ~march-ish for a release
(12:46:06) ordex: I guess we should probably spend some time at the begin=
ning (1 hour?) recapping all the open things and then deciding what we wa=
nt to put into 2.5
(12:46:12) cron2: yep
(12:46:36) cron2: basically #1 in the "What?" list on the hackathon page =
already
(12:46:43) ***dazo is here now :)
(12:46:47) ordex: yeah
(12:48:40) ordex: #2 is probably going to end nowhere :D but it's good to=
 have such discussion
(12:48:57) ordex: #3 can still be hold without Simon?
(12:49:10) mattock: good question about #3
(12:49:24) cron2: maybe simon can set aside time that weekend so we could=
 conference?
(12:49:30) cron2: "remote-hackathon"?
(12:49:33) mattock: yeah
(12:49:37) mattock: we can sure ask
(12:49:43) ordex: good idea
(12:49:55) mattock: I will ask him right now
(12:51:06) mattock: sent
(12:51:41) syzzer: nice :)
(12:51:51) tincantech [~tincantec@...1336.../kettlecalling] =C3=A8 entr=
ato nella stanza.
(12:51:52) dazo: I added "transport plug-in" to the 2.5 feature list
(12:52:37) syzzer: dazo: you have a link handy?
(12:52:42) cron2: good point
(12:53:53) dazo: syzzer: ? ... to patches?  ordex is the one managing tha=
t, I think he is getting closer to push something to the ML from the team=
 doing the grunt work
(12:54:07) syzzer: dazo: no, the 2.5 featurelist
(12:54:10) dazo: ahh
(12:54:23) cron2: https://community.openvpn.net/openvpn/wiki/LvivHackatho=
n2018
(12:54:24) vpnHelper: Title: LvivHackathon2018 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:54:32) dazo: https://community.openvpn.net/openvpn/wiki/LvivHackathon=
2018 ... and I looked at the discussion points from last year: https://co=
mmunity.openvpn.net/openvpn/wiki/KarlsruheHackathon2017
(12:54:33) vpnHelper: Title: KarlsruheHackathon2017 =E2=80=93 OpenVPN Com=
munity (at community.openvpn.net)
(12:54:39) cron2: not sure we have a formal 2.5 page yet
(12:54:47) dazo: No, I don't think we do
(12:55:09) mattock: let's create one
(12:55:16) syzzer: mattock1: +1
(12:55:31) mattock: MSI packaging might be a good goal for 2.5 as well
(12:55:36) mattock: both NSI and MSI
(12:55:44) mattock: or maybe just MSI...
(12:56:30) mattock: in any case, a deadline would be good to get things r=
olling there
(12:57:40) tincantech: be nice to get esayrsa3 in
(12:58:12) dazo: isn't easy-rsa 3.0 in the current NSI install packages?
(12:58:25) tincantech: no only 2
(12:58:39) mattock: yeah, easyrsa3 would be a fairly trivial addition
(12:58:57) dazo: I'd say "skip addition" ... update ;-)
(12:59:07) mattock: well yes in the context of 2.5
(12:59:27) dazo: yeah ... for the next 2.4 release, it can be an addition=
 to easy-rsa2
(12:59:34) mattock: I will make some notes to the hackathon page
(13:00:00) syzzer: mattock1: were you creating a 2.5 release page, or sha=
ll I?
(13:00:15) mattock: syzzer: feel free to
(13:00:24) mattock: I just added easyrsa3 and MSI as topics for the hacka=
thon
(13:01:16) syzzer: will do.  Looking if we had such a page for 2.4, but c=
an't find it
(13:01:33) syzzer: ah!
(13:01:38) syzzer: https://community.openvpn.net/openvpn/wiki/StatusOfOpe=
nvpn24
(13:01:39) vpnHelper: Title: StatusOfOpenvpn24 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:03:40) dazo: hmmm ... I think perhaps we should aim for another round=
 of Debian sync-up :-P   https://lists.debian.org/debian-devel-announce/2=
018/04/msg00006.html =20
(13:03:41) vpnHelper: Title: Bits from the release team: full steam ahead=
 towards buster (at lists.debian.org)
(13:03:44) dazo:  * 2019-01-12 - Transition freeze
(13:03:44) dazo:  * 2019-02-12 - Soft-freeze
(13:03:44) dazo:  * 2019-03-12 - Full-freeze
(13:04:19) mattock: sounds quite reasonable
(13:04:26) mattock: as long as we don't try to cram too much stuff in
(13:04:46) dazo: agreed
(13:04:52) cron2: so what does that mean for us?  release before 03-12 or=
 02-12?
(13:05:46) cron2: 2.4 release was like "two months of hard work after we =
thought all the features are in"
(13:06:11) dazo: If we manage to have the beta out late November .... and=
 and an RC ready early January, I think we can manage the Debian release =
date
(13:06:19) plaisthos: add OpenSSL 1.1.1 patches to 2.5
(13:06:21) cron2: but we won't maek that
(13:06:32) plaisthos: there is also IANA cipher list and other small thin=
gs
(13:06:37) cron2: no way to get all the stuff in until November
(13:06:47) ordex: I think we need until the nd of the year to have all th=
e code ready
(13:06:50) ordex: *end
(13:07:11) mattock: all openvpn inc devs stop what they're doing and star=
t working on 2.5
(13:07:19) mattock: that's the way to reach that deadline :P
(13:07:22) plaisthos: mattock1: sure, :)
(13:07:27) cron2: works for me :)
(13:07:57) dazo: mattock1: that might probably work ... we can discuss th=
is with Francis on Friday
(13:08:16) mattock: yeah, and you guys wouldn't really have to stop every=
thing, just allocate a bit more time to 2.5
(13:08:31) mattock: feels like things have moving forward at glacial pace=
 recently
(13:08:47) tincantech: because we hasve missed you mattock1=20
(13:08:50) cron2: the tap driver nightmare sucked up too much energy
(13:08:58) mattock: yeah, definitely
(13:09:09) dazo: If plaisthos, ordex and I put more time to the 2.5 relea=
se, this is not unlikely ... but some of the patch sets would need the ey=
es of syzzer and cron2 though, but we can do lots of the other grunt work=

(13:09:28) mattock: and the drama unraveled slowly, so there has not been=
 a point where we could have said "oh, let's just hire a NDIS developer t=
o do the job"
(13:10:00) dazo: oh right, the tap-windows6 is the real joker in the v2.5=
 release
(13:10:12) cron2: tap-windows6 needs to be sorted out way sooner
(13:10:24) cron2: there is an open security issue in the tap driver...
(13:10:32) mattock: two
(13:10:56) mattock: but the other is already out there in Git
(13:10:59) dazo: I know ... but there seems to be needed to put a lot of =
efforts into fixing things for the proper certification
(13:11:00) cron2: ah
(13:11:32) mattock: yes, the work that tap-windows6 needs now is "fluff" =
to keep HLK/WHQL happy
(13:11:37) cron2: dazo: yes...  but this nightmare is somewhat independen=
t from 2.5 release - it affects all windows releases
(13:11:40) mattock: basically Windows driver development esoteria
(13:11:44) dazo: that's right
(13:12:00) mattock: hence I will propose that we hire somebody to do the =
job
(13:12:09) mattock: e.g. Thomas Divine who ported tap-windows into tap-wi=
ndows6
(13:12:17) dazo: mattock1: any chance we can get some help from jkunkee t=
o "loan" some Microsoft resources to fix this?
(13:12:29) mattock: well, we can sure ask
(13:12:36) plaisthos: also OpenVPN's commercial client depends on it
(13:12:37) ordex: at some point we should consider gettind rid of that dr=
iver - if you sum up all the effort required to patch and fix and tuck
(13:12:44) mattock: then there's the other company (I won't hand out name=
s here) that has the same issue we do
(13:13:06) plaisthos: ordex: is there a good alternative? Or are you thin=
king going the UWP path for community?
(13:13:18) mattock: ordex: my main worry is if Microsoft starts requiring=
 WHQL certification for non-server OS
(13:13:19) cron2: UWP?
(13:13:30) ordex: cron2: new windows API=20
(13:13:32) mattock: universal windows platform?
(13:13:34) plaisthos: cron2: universial windows aaPs? or something like t=
hat
(13:13:37) ordex: plaisthos: I was thinking about a new slimmer driver
(13:13:38) dazo: Universal Windows Platform .... has it's own VPN API
(13:13:41) cron2: isn't that only available for tile apps?
(13:13:55) cron2: so, "full rewrite of everything"?
(13:13:58) mattock: ordex: this problem is not tap-windows6 related per s=
e, but to kernel-mode windows drivers in general
(13:14:08) mattock: so we need to get rid of the driver to get rid of thi=
s problem
(13:14:20) cron2: there is a VPN API in Win10, but to my understanding "o=
nly for tile apps"
(13:14:21) syzzer: Initial page: https://community.openvpn.net/openvpn/wi=
ki/StatusOfOpenvpn25
(13:14:22) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:14:38) ordex: I have often heard that the code of the driver itself a=
lso carries its own set of issues/complexity, regardless of the kernel-mo=
de
(13:14:44) ordex: but I am not deep into the topic
(13:14:48) ordex: thanks syzzer=20
(13:15:06) dazo: cron2: lev__ has something working for the OpenVPN3 code=
 base already .... but we've discovered lots of bugs in that API, so it w=
ill require a fairly recent Windows 10 to function correctly  (and still =
there are still a few unresolved issues left)
(13:15:13) mattock: ordex: probably, but the amount of development effort=
 required by tap-windows6 has been minimal so far
(13:15:22) dazo: syzzer++
(13:15:41) mattock: I don't think it is realistic to expect tap-windows6 =
/ kernel driver to go away any time soon
(13:15:44) cron2: ordex: the driver isn't that bad.  The DHCP hacky bits =
are hacky, but the code is fairly small.  The problematic bits are the ND=
IS parts we have to implement because they are now mandatory, but that we=
 don't use, so "nobody knows what it's good for"
(13:15:53) dazo: mattock1: I agree
(13:16:03) ordex: hm interesting
(13:16:18) cron2: dazo: interesting (openvpn3/VPN API)
(13:16:29) mattock: lev took the beating on that
(13:16:35) cron2: ... plus, won't help us for all other windows platforms=
=2E..
(13:16:39) mattock: yeah
(13:17:00) cron2: we should just hire Thomas Divine and split the bill wi=
th that other company
(13:17:14) ordex: remove ENABLE_CRYPTO <<< we are good with this, no ?
(13:17:22) plaisthos: I think so
(13:17:25) cron2: yep
(13:17:29) ordex: ok, I am removing it
(13:17:33) ***ordex is editing the page
(13:17:36) syzzer: I briefly looked into the UWP VPN API too.  My conclus=
ion was that it didn't fit current OpenVPN very well, but that some dirty=
 hacks could make it work for us.
(13:18:18) ***ordex saved the page
(13:18:18) syzzer: ordex: yeah, thought so too but didn't remember 100%, =
so just left it up to you guys to update,e xtend, fix, etc.
(13:18:46) plaisthos: but the expection that Microsoft has for VPN has (l=
ong living TCP control connection) + TCP/UDP data channel is reasonable e=
specially on mobile devices
(13:18:49) dazo: the UWP handles VPNs more like a plug-in to Windows ....=
 so it won't be an easy move for OpenVPN 2 -> UWP
(13:18:55) plaisthos: but openvpnwas designed in another time
(13:19:15) syzzer: ordex: you could have moved it to the 'items already d=
one' section, which would make you the lonely dev to accomplish finishing=
 a 2.5 feature :p
(13:19:47) cron2: whee :)
(13:19:50) ordex: opsss
(13:19:52) ordex: let me move it
(13:20:10) lev__: syzzer: we have more-or-less working port of openvpn3 f=
or UWP
(13:20:24) syzzer: lev__: ah, cool
(13:20:31) ordex: syzzer: is there an "already done" section ?
(13:20:36) ordex: ah, that'd be the first
(13:20:38) syzzer: bottom of the page
(13:20:47) ordex: oh ok
(13:21:36) ordex: done
(13:23:21) lev__: UWP client is available in Windows Store for restricted=
 audience, DM me if you want to help with testing
(13:25:53) syzzer: lev__: sorry - would love to, but too much on the plat=
e currently
(13:27:02) dazo: syzzer: pro-tip ... get a bigger plate! :-P
(13:27:28) plaisthos: syzzer: did you my question regarding stupid tls-ci=
pher api for tls 1.3 in #openvpn-devel?
(13:28:01) syzzer: plaisthos: no, didn't read the backlog yet
(13:28:20) plaisthos: ah=20
(13:28:29) plaisthos: in short tls-cipher  is only for tls 1.2 and below
(13:28:43) plaisthos: and for tls 1.3 cipher list there is a new api
(13:28:44) tincantech: syzzer: see https://community.openvpn.net/openvpn/=
ticket/1118
(13:28:45) vpnHelper: Title: #1118 (OpenVPN 2.4.6 does not respect -tls-c=
ipher priority when using TLS 1.3) =E2=80=93 OpenVPN Community (at commun=
ity.openvpn.net)
(13:29:46) plaisthos: so OpenSSL s_client/s_server now have:
(13:29:47) plaisthos:  -cipher val                Specify TLSv1.2 and bel=
ow cipher list to be used
(13:29:50) plaisthos:  -ciphersuites val          Specify TLSv1.3 ciphers=
uites to be used
(13:30:58) syzzer: ah, expected something like that
(13:31:16) syzzer: guess we'll need to add an option too then
(13:31:38) dazo: :/
(13:31:50) plaisthos: okay and just ignore it when having no openssl 1.1.=
1
(13:32:35) syzzer: yeah
(13:32:53) dazo: Could we switch the openssl call in the openvpn code, de=
pending on TLS version being used?
(13:32:54) syzzer: the cipher suites are sufficiently different that it's=
 never going to be an easy to use api...
(13:33:08) syzzer: dazo: we don't know which TLS version will be used
(13:33:15) dazo: ahh
(13:33:15) syzzer: depends on the peer we connect with
(13:33:27) plaisthos: dazo: I think anything other than exposing this idi=
osyncrasy to users will hurt us as both options are "take strings from us=
ers and program should not modify them"
(13:33:46) dazo: how will this be handled within mbed TLS?
(13:33:57) syzzer: dazo: don't know yet
(13:34:09) ordex: we should not make "our API" a clone of the "OpenSSL AP=
I" - can't we decide for the user somehow ?
(13:34:09) plaisthos: has no 1.3 support yet
(13:34:19) plaisthos: ordex: we already do
(13:34:20) syzzer: the mbed guys are not saying anything more than "we wi=
ll support TLS 1.3 at some point"
(13:34:25) plaisthos: ordex: we have a sane default for tls-cipher
(13:34:32) dazo: I'd say that we should sit on the fence a little bit lon=
ger until we know what happens in the mbed TLS ... so that we can have a =
way to unify those two
(13:34:34) plaisthos: and the OpenSSL default for tls-ciphersuite is also=
 sane
(13:35:07) syzzer: ordex: the user-friendly API would be to not expose th=
is mess...
(13:35:16) syzzer: so we have that now :p
(13:35:21) cron2: can we figure out that we just negotiated TLS 1.3 and l=
og a message to that extent?
(13:35:22) ordex: plaisthos: does it mean that if a user specifies -ciphe=
rsuites to s_client, then s_client will only use tls1.3 ?
(13:35:33) ordex: syzzer: :P
(13:35:36) cron2: "TLS 1.3 negotiated, ignoring --tls-cipher because Open=
SSL"?
(13:35:36) syzzer: cron2: yes, we could
(13:35:43) dazo: as a side remark ... I'm fairly disappointed how mbed TL=
S has developed over the later years ... it is not as fast moving as it u=
sed to be, almost feels like ARM has put mbed TLS on the back-burner
(13:36:22) syzzer: dazo: yes, I'm also getting less enthousiastic about i=
t
(13:36:47) plaisthos: ordex: nope
(13:36:47) syzzer: the code is still a lot cleaner than OpenSSL's, but on=
 all other fronts OpenSSL is improving a lot faster them mbed is
(13:36:55) ordex: it's not the small/clean/agile project it was, I believ=
e
(13:36:56) plaisthos: ordex: it only sets the 1.3 tls preferences
(13:37:05) ordex: plaisthos: ah ok - bleah
(13:37:29) dazo: syzzer: right ... and openssl development is now properl=
y funded ... so it does move better forward, resolving issues faster
(13:37:45) plaisthos: I think the most sensible is to add tls-ciphersuite=
s now
(13:37:51) syzzer: but... we're running over our hour-mark.  should we co=
ntinue next week?
(13:37:54) plaisthos: maybe mark it is as experimential or so=20
(13:38:01) plaisthos: and note it in the manpage=20
(13:38:19) ordex: plaisthos: is there any reasonable way to convert the a=
rgument for cipher to ciphersuite ?
(13:38:28) plaisthos: ordex: no
(13:38:33) syzzer: plaisthos: nah, doesn't need to be experimental I thin=
k
(13:38:36) lev__: mattock1: I think we need to discuss broken reconnect
(13:39:06) plaisthos: ordex: you have to implement logic around OpenSSL l=
ogic
(13:39:21) ordex: plaisthos: yeah, I didn't mean to pass the same argyume=
nt directly
(13:39:24) plaisthos: and then OpenSSL adds hacks like @SECLEVL=3D1 in tl=
s-cipher
(13:39:27) lev__: we got many complains from customers who switched from =
Connect to open source client that reconnect is broken if server uses opt=
-verify
(13:39:27) ordex: but at least we'd hide that logic internally
(13:39:43) ***ordex has to go for lunch
(13:40:21) mattock: ok sent email to the "other company" asking if they'r=
e interested in co-operating with us on the tap-windows6 HLK/WHQL issue
(13:40:25) plaisthos: ordex: you could implement something around that bu=
t a) would it confuse users since most ssl programs will jsut have two se=
ttings from now on and it is also maintainance nightmare
(13:40:44) plaisthos: you would have to keep a list which ciphersuite is =
tl1.2- and which one is 1.3+ in OpenVPN
(13:40:57) plaisthos: even for the non common like GOST etc.
(13:41:18) mattock: let's close the meeting for today and continue next w=
eek as syzzer suggested
(13:41:32) cron2: lev__: I hear you.  Continue on the list?
(13:41:51) mattock: I will prepare meetings on Monday from now on, probab=
ly until 2.5 is out
(13:41:57) cron2: (And generally speaking, I think --opt-verify in combin=
ation with --server is an extremely poor way of handling openvpn 1.x stup=
idity)
(13:41:57) mattock: then we can relax again
(13:41:58) mattock: :P
(13:42:20) cron2: so maybe we should deprecate --opt-verify + --server in=
 2.5...?
(13:42:31) cron2: mattock1: can you put that on next meeting's agenda? :)=

(13:42:47) plaisthos: syzzer: I will prepare a --tls-ciphersuite patch th=
en
(13:42:51) syzzer: lev__: just to put it out there - does opt-verify stil=
l makes sense to use?
(13:42:56) mattock: oh, one more thing
(13:43:05) mattock: today is the HackerOne demo at 18:00 CEST
(13:43:06) syzzer: but still, we need to fix the reconnect
(13:43:14) mattock: those who want and can join please do
(13:43:15) lev__: I dont know, but for example Access Server uses it
(13:43:17) syzzer: plaisthos: +1
(13:43:29) cron2: syzzer: what I said, and "yes" :)
(13:43:34) lev__: syzzer: https://patchwork.openvpn.net/patch/467/
(13:43:35) plaisthos: Oh yeah, I still need to figure out, what it is and=
 why my client is included in that program
(13:43:36) vpnHelper: Title: [Openvpn-devel,v2] Refactor NCP-negotiable o=
ptions handling - Patchwork (at patchwork.openvpn.net)
(13:43:46) cron2: lev__: last time I looked, Access Server was solidly li=
ving in the past...
(13:43:57) ***plaisthos knows
(13:44:31) cron2: mattock1: wrt hacker one - no promises yet, this is squ=
arely in "kids have dinner now" time.  So I might run away earlier
(13:44:37) dazo: cron2: Latest AS releases have shipped with v2.4 ... and=
 to my knowledge without any additional patches on top of the community v=
ersion
(13:44:47) plaisthos: cron2: I now also have a hand in AS, if you notice =
something just scream at me
(13:44:54) mattock: I will have to take care of $daughter at the same tim=
e, so I will probably mostly listen :P
(13:44:54) plaisthos: dazo: almost no patches extra
(13:45:05) cron2: dazo, plaisthos: this is good news.
(13:45:17) lev__: besides --opt-verify there are scary warnings in logs
(13:45:20) cron2: But the mindset behind "using --opt-verify" is still "p=
ast"
(13:45:29) lev__: (due to options mismatch)
(13:45:43) cron2: we should handle option mismatches much better these da=
ys, like "just push towards the client what is needed to make things work=
"
(13:45:48) plaisthos: configure --with-crypto-library=3Dmbedtls --disable=
-plugin-auth-pam --disable-plugin-down-root --disable-pf
(13:45:50) dazo: cron2: I'd say the --opt-verify stuff is something we sh=
ould discuss with James at the hackathon
(13:45:50) syzzer: lev__: regardless of opt-verify, we need to fix the bu=
g
(13:45:52) syzzer: totally agree
(13:45:55) plaisthos: that is the only change to a standard 2.4=20
(13:46:04) lev__: so I've sent patch to ML which fixes this issue
(13:46:09) plaisthos: (and the weird server configuration itself ;))
(13:46:20) syzzer: lev__: yeah, marked it for review, trying to find time=
 to do that...
(13:46:21) lev__: syzzer: do you have time to review it ?
(13:46:21) cron2: dazo: can you put it on the hackathon page?
(13:46:25) dazo: sure!
(13:47:14) plaisthos: oh fun, my newest OpenVPN for Android that I pushed=
 for OpenSSL 1.1.1 now segfault in zo1x_decompress_safe+
(13:47:15) cron2: it made sense when so many options couldn't be pushed, =
but nowadays I find it much better *in a client-server context* to just p=
ush what is needed.  peer-to-peer is different (no pushing), so there it =
makes sense
(13:47:23) cron2: plaisthos: ouch
(13:47:33) cron2: anyway.  Kid food time.  bbl...
(13:47:40) plaisthos: cron2: have fun

--------------5D7C55BFA2A6811036098689--

--3DYzsrV2h3XXOEfM1pZN9LTZg7pIVOQYi--

--Ok8Gb9ZZ6kKRUjW7ZsNVRZAY2ZsyuuVSK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAluraKMACgkQKVhNn0CG
RXg2zgf/f3xZxIFIt3ceJzHPbctXATVI/r+I41abWmrpLfCp/iCIEQ7u7g1gOucm
9ptrRcIXSKDTeG9ljnGdm5VGfKyC9ZLSbaE6cvUE6E4yC9kZu8tGo/57O6jRXJAW
UKCZakilEooGUovaSTEzkLgI8Ol4yuId3UdvBcZ7kVJxPETWa0uPNx1zzItCz+ZF
wPzGylZIgtKHUGKwvoEOr1OCC6AvhYvkN+JiF4z3Gklz8Vwa4LIuGvVDsR7wuAOY
qI2e5/hUf5K0QXZLsY8JKHl7Mt1Lj1ctvvNGuXJ/RvSBcZisjsfgKZSPV5R7SsO+
4LRyrVqgc/O387ZSX47W4ZzwFWC03w==
=fpaW
-----END PGP SIGNATURE-----

--Ok8Gb9ZZ6kKRUjW7ZsNVRZAY2ZsyuuVSK--

