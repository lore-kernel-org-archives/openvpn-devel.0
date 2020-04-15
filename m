From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Message-ID: <19931d36-6546-75cf-5428-66b235462cd5@...515...>
Date: Wed, 15 Apr 2020 13:38:37 +0300
MIME-Version: 1.0
In-Reply-To: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rVT3v4cWfse8WdJYLzYH1BX7r17ivgJlC"
Subject: [Openvpn-devel] Summary of the community meeting (15th April 2020)
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
--rVT3v4cWfse8WdJYLzYH1BX7r17ivgJlC
Content-Type: multipart/mixed; boundary="Ertv4sQA69DWiPfDp0kRgcGk42QhXF43w"

--Ertv4sQA69DWiPfDp0kRgcGk42QhXF43w
Content-Type: multipart/mixed;
 boundary="------------14B95AB50E25717D30AAE4B1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------14B95AB50E25717D30AAE4B1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 15th April 2020
Time: 11:30 CEST (09:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-04-15>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock, ordex and plaisthos participated in this meeting.

---

Talked about the WolfSSL patches. Agreed that they're much less invasive
and hence more acceptable now than previously. Some changes were
requested earlier and we're waiting for WolfSSL's response.

---

Talked about the upcoming OpenVPN 2.4.9 release. It will include an
important security fix and a few other things we wish to get in:

- NCP async fix from lev
- two patches from Selva
- the ecliptic curve patch (1/3)

Agreed that we should have a CVE for the security issue. Dazo had
promised to resurface at 14:00 CEST today, which means he can probably
handle the CVE generation as usual.

Our goal is to release 2.4.9 tomorrow, if possible.

---

Mattock will check if it would be possible to give unique identifiers to
Windows 7 and Windows 10 flavors of tap-windows6. This would prevent
situations where an existing, cached Windows 7 driver is preferred over
a Windows 10 (attestation signed) version, hence causing driver
installation failures.

Mattock will also check if we could, with a reasonable effort, provide
users with an easy way to clean up old tap-windows6 drivers in the NSIS
installer. The process is already known and can be done with external
scripts, but integration / reimplementation in NSIS is missing.

These changes would be nice to have in 2.4.9-I601, but we can postpone
them to another Windows installer release if needed.

--

Full chatlog attached

--------------14B95AB50E25717D30AAE4B1
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-04-15.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-04-15.txt"

(12:31:17) mattock: meeting time
(12:31:21) cron2: hooray
(12:31:25) lev__: hello
(12:31:54) mattock: hi guys!
(12:32:27) plaisthos: hey!
(12:34:27) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-04-15
(12:34:51) plaisthos: Okay I will just start with one topic, the quality =
of the WolfSSL patch approaches a level that might consider it for inclus=
ion
(12:35:36) plaisthos: but I would put a note there that it is in the not =
actively supported by the community project and bugs/problem with it that=
 cannot replicated with OpenSSL need to be reported to WolfSSL
(12:35:40) ordex: hi
(12:35:46) plaisthos: hey ordex=20
(12:36:18) ordex: well, issues will be reported to our mailing list in an=
y case
(12:36:33) ordex: we just have to ensure that wolfssl will stick to the l=
ist
(12:37:05) cron2: I am fine with merging the patch, as it has nearly no c=
ode changes anymore, just pushing autoconf towards "yes, this function is=
 there, even if it's a macro and you can't see it"
(12:37:32) ordex: yup
(12:37:35) ordex: much better
(12:37:36) cron2: and yes, documentation needs to be clear "this is not s=
omething we test, so if there are problems, talk to WolfSSL"
(12:38:24) ordex: can't the cryptoapi check be performed at configure tim=
e ?
(12:38:29) ordex: why an #error in the code ?
(12:39:38) cron2: ENABLE_CRYPTOAPI is not coming "from configure" but fro=
m syshead.h
(12:39:44) plaisthos: it basically breaks the build on win32
(12:39:48) cron2: but I think the #error is more an extra saveguard, beca=
use
(12:39:53) cron2: #if defined(_WIN32) && defined(ENABLE_CRYPTO) && define=
d(ENABLE_CRYPTO_OPENSSL)
(12:39:56) cron2: #define ENABLE_CRYPTOAPI
(12:39:59) cron2: #endif
(12:39:59) cron2: oh
(12:40:06) ordex: ah, so it's a windows thing only
(12:40:21) plaisthos: yeah cryptoapi is the windows key sotre
(12:40:23) ordex: but it needs ENABLE_CRYPTO_OPENSSL
(12:40:30) ordex: which on't be the case with WOLFSSL, no ?
(12:40:48) cron2: mmmh, now if WolfSSL enables ENABLE_CRYPTO_OPENSSL, whi=
ch I think it needs to do (otherwise, we won't compile the openssl stuff.=
=2E.), it will break windows builds
(12:40:51) plaisthos: ah yes
(12:41:12) ordex: ah
(12:41:19) cron2: ssl_openssl.c is guarded by "#if defined(ENABLE_CRYPTO)=
 && defined(ENABLE_CRYPTO_OPENSSL)"
(12:41:26) cron2: and WolfSSL provides "openssl compat" headers + API
(12:41:45) plaisthos: yeah basically wolfssl is not working on win32
(12:41:51) ordex: yeah
(12:41:56) plaisthos: something that I can live with
(12:41:58) cron2: I think that #error is not good.  They should adjust sy=
shead.h instead, and have an extra WolfSSL check there
(12:42:03) ordex: right
(12:42:15) ordex: like: #if defined(_WIN32) && defined(ENABLE_CRYPTO) && =
defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL)
(12:42:17) ordex: no ?
(12:42:20) plaisthos: cron2: I think the cryptoapi stuff might be called =
in more places
(12:42:37) plaisthos: that might have the wrong ifdef or so
(12:42:38) cron2: plaisthos: it should all be wrapped with ENABLE_CRYPTOA=
PI
(12:42:51) cron2: so if we just not define it ("like when building with m=
bedtls")...
(12:43:05) plaisthos: but I don't really care. If they do not care about =
win32 support, we should not fix it for them
(12:43:19) plaisthos: cron2: might have something like if (ossl) in a lar=
ger win32 block
(12:43:47) ordex: but the problem is only about cryptoapi - not windows i=
n general
(12:44:00) ordex: they just have to avoid defining cryptoapi if wolfssl i=
s used, no=20
(12:44:01) ordex: ?
(12:44:07) cron2: plaisthos: well, I'd consider this a bug on our side...=
 if we call cryptoapi stuff outside an ENABLE_CRYPTOAPI block, our code i=
s buggy
(12:44:22) ordex: agreed
(12:45:54) plaisthos: cron2: yes it is a bug on our side=20
(12:46:25) plaisthos: but I just wanted to express that we should just no=
t invest time now in it if there is no strong need fr=7For it
(12:46:39) cron2: right
(12:47:24) plaisthos: I can prepare a text for README.wolfssl=20
(12:47:38) plaisthos: and post it first here/#openvpn-devel and then late=
r on the mailing list
(12:49:22) cron2: yep
(12:49:37) mattock: +1
(12:50:38) cron2: so - wolfssl covered?
(12:50:48) cron2: (I have sent my concerns about that #error back to the =
list already)
(12:51:09) ordex: sounds good
(12:51:14) plaisthos: and I asked why it needs an OpenSSL 1.0.1d workarou=
nd :P
(12:51:21) cron2: yep
(12:51:35) cron2: patchwork set to "changes requested"
(12:51:56) plaisthos: +1
(12:52:08) ordex: goood
(12:52:24) ordex: the 1.0.1d workaround sounds like something they could =
fix in their compat thing anyway :-P
(12:52:30) ordex: just trying to push the complexity elsewhere hehe
(12:52:53) cron2: or leftover from previous versions
(12:53:00) plaisthos: also it feels that would break in other project tha=
t try to use it without the workaround
(12:53:28) plaisthos: also we probably will get rid of all the < 1.0.2 st=
uff once RHEL6 reaches EOL
(12:53:49) cron2: amazeballs
(12:54:21) ordex: hehe
(12:54:50) plaisthos: which is nov this year
(12:54:57) plaisthos: so we might drop that in master soon
(12:55:53) ***ordex likes
(12:56:35) plaisthos: so 2.4.9 release=20
(12:56:36) ***cron2 sees an ACK and likes that :)
(12:56:45) cron2: yes.
(12:56:49) cron2: can one of you reach dazo?
(12:57:20) cron2: m-a thinks we should have a CVE for that bug... I'm uns=
ure, but in any case we'd need dazo to get one
(12:57:21) plaisthos: yeah he got stuck with kids!
(12:57:30) cron2: how could that happen
(12:57:47) cron2: anyway
(12:58:10) lev__: cron2: you mean float bug?
(12:58:14) cron2: mattock: we want a 2.4.x release soon, because the bug =
in floating warrants a "soon!" release, and there is other good stuff in =
2.4 that we want out
(12:58:17) cron2: lev__: yes
(12:58:21) mattock: yes
(12:58:42) mattock: is all the "other good stuff" already in?
(12:58:45) plaisthos: I think we should include the  Fix OpenSSL 1.1.1 no=
t using auto ecliptic curve selection also in 2.4.9
(12:58:57) cron2: on my list is the NCP async fix from lev plus two patch=
es from Selva that he wants in 2.4, plus the ecliptic curve patch
(12:59:12) cron2: plaisthos: only 1/3 (the #ifdef jungle) or the whole pa=
tch set?
(12:59:14) plaisthos: the tls-group stuff is no important because it is o=
nly required for exotic curves=20
(12:59:22) cron2: okay, only 1/3 is it, then
(12:59:51) plaisthos: tls-group is kinda required if you do not use one o=
f 5 standard curves=20
(13:00:47) ordex: should tls-group be just master material ?
(13:00:50) ordex: while 1/3 also for 2.4 ?
(13:00:51) mattock: if all the stuff is in by tomorrow morning my time I =
can do the release tomorrow - otherwise it might have to be postponed to =
monday (friday is fragmented)
(13:01:17) plaisthos: the question is basically how much do you care for =
people with OpenSSL 1.1.1 and exotic curves
(13:01:33) cron2: mattock: okay.  This is a clear mandate to me :)
(13:01:49) ordex: well, the question is: is it a feature? or are we fixin=
g something that right now breaks? to me it sound slike we are supporting=
 new functionalities
(13:02:02) plaisthos: both actually
(13:02:07) ordex: exotic curves? not supported yet
(13:02:42) ordex: hmm something is broken/buggy right now ?
(13:03:35) plaisthos: with openssl 1.0.2/mbedtls exotic curves work since=
 it only used when you use a certificate with that curve=20
(13:03:51) plaisthos: with tls 1.3 ec is also used in ecdh with rsa certi=
ficate
(13:03:56) plaisthos: so it got decoupled
(13:04:25) plaisthos: so you know have a list of curves/groups that are s=
upported and if your cert curve is not in that list, your connection does=
 not work
(13:04:51) plaisthos: e.g. if you have a brainpool curve cert, it will wo=
rk with OpenVPN/OpenSSL 1.0.2 or OpenVPN/mbedTLS
(13:05:12) plaisthos: but if you use OpenSSL 1.1.1, you need to override =
tls-groups to include brainpool
(13:05:32) cron2: shouldn't the "/* OpenSSL 1.1.0 and newer have always e=
cdh auto loading enabled," comment be *after* the #endif, matching the "r=
eturn" part?
(13:05:36) ordex: yeah, still sounds like an unsupported setup
(13:06:40) plaisthos: cron2: I put it in the ifdef, so it gets removed wh=
en we remove the ifdef for older version
(13:07:19) ordex: or maybe it should go on top of the ifdef <1.1.0 ?
(13:07:28) ordex: to explain why that if is needed ?
(13:07:38) plaisthos: yeah it is quite exotic and I don't think we need t=
o force it into this release
(13:07:46) ordex: yap
(13:08:58) cron2: the code flow in that function hurts my brain
(13:09:12) ordex: yeah
(13:09:15) ordex: it's a jungle ..
(13:09:20) ordex: but I'd leave the re-style for later
(13:09:26) plaisthos: yeah syzzer and I did not catch this when we review=
ed that patch=20
(13:10:18) cron2: especially since the code does "more things after the #=
if jungle, but only if older openssl, which is not obvious due to the ret=
urns out of the #if block
(13:10:32) cron2: and only for non-default curves
(13:10:36) ordex: yeah
(13:10:48) ***cron2 gets some booze and just merges this
(13:10:51) ordex: I'd love to see the entire thing refactored
(13:10:52) plaisthos: or does more things if you have tls-ecdh-curve sets=

(13:10:56) ordex: but not in release/2.4
(13:11:29) plaisthos: my tls-group patch actually discourages from using =
ecdh-curve
(13:12:05) plaisthos: since the first group is actually the preferred ecd=
h curve
(13:13:59) ordex: the code is still a jungle :p
(13:14:00) ordex: hehe
(13:14:40) mattock: done with 2.4.9?
(13:14:48) mattock: we have 15 (full) minutes
(13:14:58) mattock: "release tomorrow" is the goal
(13:15:06) ordex: do we need the CVE before releasing ?
(13:15:26) plaisthos: hm
(13:15:30) cron2: it should go to the announcement and commit, so, yes
(13:15:44) cron2: if CVE at all
(13:16:23) mattock: I thought I saw dazo here but no
(13:16:30) cron2: so, any *other* patches we want in 2.4 that have not ye=
t been mentioned?
(13:16:52) plaisthos: auth-token is only 2.5, right?
(13:17:22) cron2: the server side is 2.5
(13:17:25) plaisthos: lev__: your async push with ncp, is that 2.4 or 2.5=
 only?
(13:17:30) lev__: both
(13:17:42) cron2: that is both, and on my list already ("a review would b=
e nice")
(13:18:37) plaisthos: I will review it later then
(13:18:59) mattock: can we make dazo create a CVE today?
(13:19:09) lev__: plaisthos: se the last comment https://community.openvp=
n.net/openvpn/ticket/1259
(13:19:13) lev__: *see
(13:19:26) cron2: mattock: dunno, haven't seen anything from him in the l=
ast two weeks :(
(13:20:18) plaisthos: he was on vacation the last two weeks :D
(13:20:56) mattock: what shall we do if he remains hidden?
(13:21:15) mattock: definitely not postpone the release
(13:21:39) ordex: he should be online in the afternoon after 2pm
(13:21:44) cron2: he was using a contact at RedHat, if I remember right, =
to get the CVE number.  Maybe we can go via OSTIF / Derek?
(13:21:44) ordex: we can poke him and see what he says
(13:21:45) lev__: he promised to appear at 14.00 CET
(13:21:50) cron2: good enough
(13:22:01) mattock: Derek has been missing for ~2 months
(13:22:04) ordex: CEST !! we are in summer now
(13:22:07) cron2: ewww
(13:22:30) mattock: but if dazo resurfaces at 14:00 CEST then we should b=
e ok
(13:22:38) ordex: yap
(13:22:39) lev__: ordex: it is snowing here right now
(13:22:45) ordex: let's reconvene later then
(13:22:50) mattock: it was snowing here yesterday and the day before
(13:22:50) ordex: lev__: that's your problem!!
(13:22:51) ordex: hehe
(13:22:55) ordex: lol
(13:23:00) mattock: now the sun is shining beautifully
(13:23:04) mattock: anyhow
(13:23:10) ordex: :)
(13:23:12) mattock: shall we conclude the meeting or do we have something=
 else?
(13:23:37) ordex: I don't have anything
(13:23:42) cron2: 2.5?
(13:23:47) cron2: MSI?
(13:23:55) cron2: ah, yes
(13:24:07) lev__: yeah we need to start testing MSI installer
(13:24:10) mattock: no progress on MSI front, don't want to just poke it =
but fully focus on it
(13:24:11) cron2: mattock: what shall we do with the TAP driver complicat=
ions for 2.4.9?
(13:24:16) mattock: lev and I agreed to start looking into it
(13:24:27) cron2: so, NSIS installer and tap stuff
(13:24:29) mattock: you mean the certificate warning on Windows 7?
(13:24:43) cron2: no, the install failure on win10 if that machine has se=
en a win7 driver before
(13:24:47) mattock: ah that one
(13:24:55) mattock: hmm
(13:25:04) mattock: can't recall what the plan was exactly
(13:25:09) plaisthos: it actually snowed here monday morning briefly
(13:25:17) cron2: mattock: "unique identifiers" was one of the options
(13:25:39) mattock: I need to dig up the plan/discussion to understand if=
 this is a trivial thing to do, or something that takes time
(13:25:47) cron2: please :)
(13:26:04) mattock: my hunch is "non-trivial", but we'll see
(13:26:24) cron2: but we need a solution there (... which could come as a=
 I602 re-spin, but nevertheless)
(13:26:42) mattock: yep, no need to force-feed it in first 2.4.9 release
(13:26:48) mattock: if time is scarse
(13:26:53) mattock: anyhow
(13:26:55) cron2: the second thing was "can we have a '[X] remove all rem=
ainders of existing tap drivers' checkbox" in the installer, to do the TA=
P-cleanup
(13:27:09) cron2: (off-by-default, just for people that have installation=
 pains)
(13:28:15) mattock: it might be enough to just document this well enough =
- I don't think we will be able to catch the error in the installer to pr=
ovide any meaningful error message
(13:28:55) mattock: which means people will need to figure out what the p=
roblem is, and we should make that figuring out as easy as possible (e.g.=
 INSTALL-win32.txt, Wiki, etc)
(13:29:09) cron2: I do not want meaningful error messages, I just want in=
stallers that succeed
(13:29:18) mattock: easier said than done
(13:29:39) mattock: we'd need to catch the error or somehow figure out th=
e issue before running the installer
(13:29:44) mattock: anyhow
(13:29:48) mattock: I'll take a look
(13:29:52) cron2: so said checkbox would be a kludge for "more force is r=
equired" - you do have all the tools today to remove tap drivers from the=
 system, we just do not give users an ways way to enable them
(13:30:00) cron2: so, the strategy is twofold
(13:30:22) cron2:  - reference the win10 driver with a difference unique =
identifier than the win7 driver, so we get what we ask for, not "what win=
dows think there is already installed"
(13:30:35) mattock: well yeah now it comes back to me
(13:30:46) cron2:  - provide an easy way to clean up the tap install, wit=
hout having to download extra scripts and instructions
(13:31:00) cron2: ("if it fails with a weird tap driver error, try re-ins=
talling with that checkbox enabled")
(13:32:07) mattock: I don't look forward to doing the latter in NSIS
(13:32:15) mattock: but I will check how much pain it would be
(13:32:22) cron2: appreciated :)
(13:32:25) mattock: anyhow, overtime and need to go get some lunch
(13:32:27) cron2: and with that, our time is over
(13:32:28) cron2: enjoy
(13:32:33) mattock: thanks!

--------------14B95AB50E25717D30AAE4B1--

--Ertv4sQA69DWiPfDp0kRgcGk42QhXF43w--

--rVT3v4cWfse8WdJYLzYH1BX7r17ivgJlC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6W5C0ACgkQKVhNn0CG
RXhdxggAkQyBFB+J1lh7GRSzIpqRUnXr4YebcrJfIEgWv26GLxTfBGU8Fvxy3vxv
KPmh4EI+N0VSEoGXfApxXAnAI/6m50k7lgLlGuLtFbBmxVfm1XiCcaele6h9Giam
tA9+hmEm2qyaR4VtV/X48/JbpcP7wa8OBQjFC4MH4Izug6i2Xz81YRXyN6TU73sB
1Zg1KRQ4g3yxecJMsiyaxKCPgXeZkMGqaHJ6QcjkWYqM/CWE7l8nUwvcmKJfhlh2
dVvtuvA5PQ8P37Aw/N3lo70+plTmnkKLlsyqVl3SeB6fgalF7s+k7SKp+C9hvZdQ
cIwG9aKIUB3cuNj29dtqDO8kSZJ7yA==
=Wp/W
-----END PGP SIGNATURE-----

--rVT3v4cWfse8WdJYLzYH1BX7r17ivgJlC--

