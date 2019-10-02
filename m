From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Message-ID: <3ace604f-b76b-28e4-b1e3-8f3a807e93d7@...515...>
Date: Wed, 2 Oct 2019 14:46:28 +0300
MIME-Version: 1.0
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LVjYgMkCMQEecR6Hwi5FtX67cjBCn81a3"
Subject: [Openvpn-devel] Summary of the community meeting (2nd October 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LVjYgMkCMQEecR6Hwi5FtX67cjBCn81a3
Content-Type: multipart/mixed; boundary="ENSZJPAYiD55zPOoSUGwtM3jh9EN7HQj4";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <3ace604f-b76b-28e4-b1e3-8f3a807e93d7@...515...>
Subject: Summary of the community meeting (2nd October 2019)
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>

--ENSZJPAYiD55zPOoSUGwtM3jh9EN7HQj4
Content-Type: multipart/mixed;
 boundary="------------BD28EC7F2FA9574B10F8AE4C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BD28EC7F2FA9574B10F8AE4C
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 2nd October 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-10-02>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex, rozmansi and syzzer participated in
this meeting.

---

Discussed tap-windows6. Mattock produced a test installer which includes
two PRs:

<https://github.com/OpenVPN/tap-windows6/pull/84>
<https://github.com/OpenVPN/tap-windows6/pull/86>

An installer for Windows 10 and Server 2016/2019 is here:

<https://build.openvpn.net/downloads/temp/tap-windows-9.24.2-I601.exe>

It has only been install-tested so far.

--

Discussed the VLAN patchset. At the moment it is compiled in by default,
but can be disabled at build time with --disable-vlan. This approach
seemed adequate for all. The changes the patchset makes are fairly
non-intrusive (no effect on tun mode, very minimal effect on tap mode).

A new round of VLAN patches with minor fixes is coming up soon.

--

Discussed the OpenVPN 2.5 release.

Syzzer will have a look at Lev's wintun patches and wintun installer.

Ordex will work on client-connect and transport-API after VLAN patchset
is done.

Dazo will look into the struct argv overhaul patches.

--

Discussed OpenVPN 2.4.8 release. Agreed that it will be based on
"release/2.4" branch, an updated tap-windows6 installer (see above) and
the "openssl: Fix compilation without deprecated OpenSSL 1.1 APIs" patch:

<https://patchwork.openvpn.net/patch/787/>

--

Full chatlog attached.


--------------BD28EC7F2FA9574B10F8AE4C
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-10-02.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-10-02.txt"

(12:30:37) mattock: howdy
(12:30:42) rozmansi: hi
(12:31:50) lev__: hello
(12:34:26) mattock: anyone else?
(12:34:48) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-10-02
(12:34:49) vpnHelper: Title: Topics-2019-10-02 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:35:17) lev__: no, just me and Simon having wintun party here=20
(12:35:17) mattock: I can cover #3 quickly while waiting
(12:35:34) mattock: the signing computer is up again which mean I can pro=
duce a test installer
(12:35:41) mattock: for tap-windows6, including the two PRs
(12:36:42) mattock: the rest of the topics will require input from cron2 =
and ordex
(12:36:59) mattock: anything outside of the topic list we should bring up=
?
(12:37:06) ordex: here here
(12:37:08) cron2: I want output, not input :)
(12:37:17) mattock: :D
(12:37:23) mattock: hi guys btw!
(12:37:40) mattock: topic #1vlan patches / --enable-vlan or --disable-vla=
n?  or no #ifdef at all?=20
(12:37:55) ordex: right
(12:37:56) ordex: so
(12:37:58) syzzer: hi :)
(12:38:10) ordex: the implementation now enables VLAN code by default at =
compile time
(12:38:10) mattock: oh hi syzzer!
(12:38:14) cron2: that is my input - "what do we want this to be?" - but =
usually dazo is the one with strong opinions here
(12:38:17) cron2: hi syzzer
(12:38:17) ***dazo is here
(12:38:20) ordex: and it can be compiled out by providing --disable-vlan
(12:39:10) ordex: this way everybody gets the functionality without any h=
assle
(12:39:11) dazo: what is the impact of this feature, code wise?  Intrusiv=
e?  How useful is this for "everyone"?
(12:39:44) ordex: it touches code paths in multi.c (server side) and is n=
ot too intruisive if you ask me
(12:39:59) syzzer: how much would this code impact setups that doe not en=
able any vlan functionality in their config?
(12:40:00) cron2: it intrudes on tap mode, adds a few extra clauses and a=
 new vlan.c, and a few (not much) kbyte of code
(12:40:10) cron2: syzzer: not at all
(12:40:27) syzzer: so why make it compile-time configurable it all then?
(12:40:28) cron2: (and not in the tun code path at all)
(12:40:28) ordex: well, there are "ifs" that will of course lead to "skip=
 the vlan logic"
(12:40:32) syzzer: less ifdefs, more better
(12:40:42) cron2: ordex did it without visible #ifdefs
(12:40:52) ordex: it's all hidden in vlan.h
(12:41:01) ordex: the code has no ifdef VLAN anywhere
(12:41:14) dazo: then I think --disable-vlan is reasonable ... I see the =
argument of "no #ifdef" ... but I think brand new features can have the a=
dvantage of disabling them when debugging odd behaviours
(12:41:17) cron2: aka, vlan.h has lots of "vlan_make_decision()" function=
s which either get compiled to "the condition" or "no vlan, return 0" inl=
ines
(12:41:21) syzzer: ah, good. then "I don't care" :)
(12:41:57) ordex: :D
(12:42:00) cron2: ordex: there you go, dazo has spoken :)
(12:42:25) dazo: if you are 100% convinced this will not cause any negati=
ve impact for any configuration, I'm willing to be more relaxed on #ifdef=

(12:42:40) cron2: dazo: I expected you to go for "we want new features de=
fault-off, and thus --enable-vlan"  - and before we have this discussion =
*after* merging, I wanted to bring it up first :-)
(12:43:01) dazo: :)
(12:43:14) ordex: hehe
(12:43:23) cron2: dazo: 100% for tun, 99% for tap (I do not see any possi=
ble impact, but I might be wrong)
(12:43:24) dazo: Probably (or rather hopefully!) getting older and wiser =
;-)
(12:44:01) cron2: ok, done.  Now I have to leave anyway, but I got my ans=
wer - thanks :-)
(12:44:06) ordex: well, we have to throw it in the wild to see the bugs :=
p
(12:44:11) ordex: hehe
(12:44:12) ordex: goed !
(12:44:55) cron2: (which actually brings us to "updates on 2.5" - vlan pa=
tches have had their first round of review, things are looking mostly nic=
e, I complained about stylistic things, but nothing dramatic - new round =
to be expected "soonish!")
(12:45:06) cron2: plaisthos auth-token stuff has been fully merged
(12:45:34) dazo: thx!
(12:45:45) ordex: client-connect and transport-API are next on my list af=
ter we're donew it the VLANs
(12:45:52) dazo: I'll have a look at the struct argv overhaul patches ...=
 rebase them on latest master and see if there's anything else to fix
(12:46:41) ordex: oky
(12:51:20) lev__: did anyone had a chance to look at wintun patches / win=
tun installer ?
(12:51:31) syzzer: lev__: not yet, but I do plan to
(12:51:48) syzzer: mostly the integration into openvpn
(12:52:37) lev__: nice, thanks!
(12:53:23) syzzer: I'm considering to ship openvpn-nl with wintun. Less c=
ode, less attack surface.
(12:55:00) ordex: yap, from that perspective should be much better than t=
ap-windows6
(12:56:10) mattock: 2.4 release?
(12:57:37) syzzer: 2.4.8?
(12:59:13) ordex: yap
(12:59:30) ordex: what do we miss before being able to make this release =
?
(12:59:35) ordex: I geuss we wanted to wait for tap-windows ?
(12:59:48) mattock: I'm producing a test installer while you talk
(13:00:02) ordex: do we still want to wait for that actually ?
(13:00:15) cron2: I need input on whether there are unmerged patches that=
 need to go in
(13:00:58) mattock: cabinet file being scanned and hopefully signed by MS=
 now
(13:01:32) mattock: I think we should bundle the tap-windows6 release wit=
h 2.4.8 release if possible
(13:02:20) dazo: that's what we've been waiting for with the 2.4.8 releas=
e since the beginning, right?  Due to some important fixes in tap-windows=
6, right?
(13:02:21) mattock: it is not a biggie unless some issues are found in te=
sting or if testing takes too long
(13:02:55) mattock: dazo: not sure, but we have no "must release due to s=
ecurity reasons" motive anymore
(13:03:13) mattock: but there are two fixes for tap-windows6 which will b=
e included in the test installer that baking right now
(13:03:21) mattock: that is
(13:04:08) dazo: alright
(13:05:50) mattock: I'll have the tap-windows6 installer ready in <30 min=
utes
(13:06:27) mattock: besides 2.4.8 - is it just about "updated tap-windows=
6 + latest code from release/2.4"?
(13:06:38) mattock: or is there something that is not yet finished and sh=
ould go in?
(13:07:13) cron2: 12:00 < cron2> I need input on whether there are unmerg=
ed patches that need to go in
(13:07:14) dazo: that's what cron2 asked for @ 12:00:15 :-P
(13:07:18) cron2: yes :)
(13:07:33) ordex: I Don't think any of us is aware of something missing :=
D
(13:07:34) cron2: (I'm still around due to an unexpected meeting in my of=
fice)
(13:07:46) cron2: there's some sort of openssl/libressl/tls1.3 backport I=
 think
(13:08:02) cron2: https://patchwork.openvpn.net/patch/787/
(13:08:03) vpnHelper: Title: [Openvpn-devel,v3] openssl: Fix compilation =
without deprecated OpenSSL 1.1 APIs - Patchwork (at patchwork.openvpn.net=
)
(13:08:12) cron2: this one, I think it wants to go back (due to "long-ter=
m compat")
(13:08:34) cron2: plus the mbedtls explosion patch :)
(13:09:21) dazo: oh ... and we need to discuss if some of the auth-token-=
hmac stuff need to go to 2.4.x as well ... not the server side, but clien=
t side ... as I spotted that git master behaves more predictably than 2.4=
=2Ex when tokens expires
(13:09:47) cron2: client side compat/stability things are "ok for 2.4", s=
o, makes sense
(13:09:51) dazo: (due to not sending the token, but the users password on=
 token expiry)
(13:10:10) ordex: but auth-token-hmac is a new feature isn't it ?
(13:10:17) cron2: yes
(13:10:24) ordex: so not really 2.4-material, no?
(13:10:24) cron2: server-side and fairly big
(13:10:44) dazo: it's a fairly big change on the server side ... but ther=
e are some client side changes as well, to make things go smoothly when A=
UTH_FAILED with token expired messages are sent
(13:12:45) ordex: yap, but they should go together, no?
(13:13:29) ordex: meaning: we are talking about new behaviours that will =
interact with each other (server <--> client) so having both in 2.5 sound=
s reasonable=20
(13:14:00) cron2: we usually pull in client side long-term compat stuff t=
o 2.4, if "it makes interop with 2.5 servers better"
(13:14:34) cron2: it's *mostly* independent, except if sending an auth-to=
ken and getting back an "EXPIRED! go away!" reply
(13:14:57) cron2: dazo: please do double-check, it might be already in re=
lease/2.4 (because that was an independent patch from the "auth-token-hma=
c" patchset)
(13:15:18) ordex: hmm ok, I don't get what it fixed then
(13:15:29) dazo: oh, might be ... I only tested against 2.4.7 which was r=
eleased, not the release/2.4 branch
(13:15:30) ordex: (but maybe I should have complained at review time :P)
(13:15:44) cron2: the client used to "just loop" if getting an "auth fail=
ed, expired"
(13:15:53) cron2: instead of "fall back to password"
(13:15:56) ordex: oh ok
(13:16:07) dazo: ordex: these changes doesn't make things worse for 2.4.7=
 and older .... it would just improve things there as well
(13:16:15) cron2: the auth-token-hmac stuff is not visible on the wire
(13:16:28) cron2: it's just "now the server generates these tokens"
(13:16:47) ordex: okok, so this is something that could happen also when =
the server has the classic token mechanism in place, under certain condit=
ions
(13:16:49) ordex: ok
(13:16:52) cron2: yes
(13:17:00) dazo: +1
(13:17:38) cron2: commit 004f13b60d87fe7815f4feee9aded22ae4eacbaf
(13:17:38) cron2: Author: Arne Schwabe <arne@...1227...>
(13:17:38) cron2: Date:   Wed Oct 10 16:30:51 2018 +0200
(13:17:39) cron2: Fallback to password authentication when auth-token fai=
ls
(13:17:41) cron2: in release/2.4
(13:17:44) cron2: so it might be already in
(13:17:53) cron2:     Acked-by: Antonio Quartulli <antonio@...515...>
(13:17:53) cron2: :)
(13:18:13) dazo: Yeah, saw that just now .... and it's in 2.4.7 ... need =
to retest my setup then
(13:19:25) ordex: !!!
(13:19:26) ordex: :D
(13:19:42) ordex: move on move on, don't look!
(13:20:07) dazo: :-P
(13:21:38) syzzer: so, does this wrap it up?
(13:24:00) mattock: so a couple of things missing from release/2.4, plus =
new tap-windows6 installer
(13:24:55) ordex: I guess only this: https://patchwork.openvpn.net/patch/=
787/
(13:24:57) vpnHelper: Title: [Openvpn-devel,v3] openssl: Fix compilation =
without deprecated OpenSSL 1.1 APIs - Patchwork (at patchwork.openvpn.net=
)
(13:25:02) ordex: and the tap-windows 6 ?
(13:25:04) cron2: yes
(13:25:30) ordex: ok
(13:25:44) ***ordex has to leave for lunch
(13:25:50) ordex: but it seems we're done ?
(13:26:12) mattock: ok good
(13:26:30) syzzer: excellent :)
(13:26:33) mattock: MS signed the tap-windows6 driver, time to produce an=
 installer
(13:26:38) mattock: I will add a link to the meeting summary
(13:26:43) syzzer: ah, nice :D
(13:26:47) mattock: then link in the tap-windows6 PRs
(13:27:13) mattock: we're also going to get a new signing computer that c=
an also act as a tap-windows6 build computer
(13:27:31) mattock: meaning the process will be less convoluted (no need =
to to mount build dir via SMB shares)
(13:27:55) mattock: plus the new signing computer should not be as prone =
to overheating as the previous one (it was down every other time somebody=
 tried to use it)
(13:28:20) mattock: anyways, good meeting, summary will be sent soon

--------------BD28EC7F2FA9574B10F8AE4C--

--ENSZJPAYiD55zPOoSUGwtM3jh9EN7HQj4--

--LVjYgMkCMQEecR6Hwi5FtX67cjBCn81a3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2UjhQACgkQKVhNn0CG
RXi6VQf/fhEgP4vpeIp4HZEM0qpLSsa/t1DwSnZ+ByQa6q9SBP57gaJN9Yvd16fM
TwtOZTcmfRwRPRY6McaMzYsI3qdLBhlgWLogHqx+sgGKiwKjYvc+jA6Q2JtTFIA9
U/t8gP6EX3a3yVBbQwydTvbJEUm4zoFJ05ziPQpQjJgvxy81GDHrIqBy6TADYdUC
cz5+CFCpi+tbrDTxJcRLADnoGDv4xufJSNrK/ugVRA0LAtEO4T9zUnKVnPRn2HMO
lhBjrSI+rFA6dI827Pc3s8LYJo+sASS3lGVI07BondXIPySkW4besvgolJRSDoin
0a7wu9iecbD57Jvg5iVhpVmu7whOaw==
=BpC1
-----END PGP SIGNATURE-----

--LVjYgMkCMQEecR6Hwi5FtX67cjBCn81a3--

