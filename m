From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Message-ID: <a5c96318-8f21-7087-cd9f-9dadb715a0d4@...515...>
Date: Thu, 12 Mar 2020 21:57:03 +0200
MIME-Version: 1.0
In-Reply-To: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1NITYP5C4Ov2BYcywocz6ejZc5och34zj"
Subject: [Openvpn-devel] Summary of the community meeting (12th March 2020)
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
--1NITYP5C4Ov2BYcywocz6ejZc5och34zj
Content-Type: multipart/mixed; boundary="2jWfRAtcjlipFK0UsAKwPVckYnKslSmYh"

--2jWfRAtcjlipFK0UsAKwPVckYnKslSmYh
Content-Type: multipart/mixed;
 boundary="------------B1ABCA1E6BAD559A24BBE89D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B1ABCA1E6BAD559A24BBE89D
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 12th March 2020
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-03-12>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, plaisthos and rozmansi participated in this
meeting.

---

Mattock mentioned that he fixed the "unable to register [to community
services] due to plus sign in the mail address" issue today:

<https://community.openvpn.net/openvpn/ticket/1171>

--

Talked about the OpenVPN MSI installer. Rozmansi's work consists of
several PRs and patches:

<https://github.com/OpenVPN/tap-windows6/pull/106>
<https://github.com/OpenVPN/openvpn-build/pull/141>

Mattock will review the PRs. It would be good if Windows-capable
developers such as lev or selvanair would do the same. The MSM code is
from the Wireguard project and modified only minimally.

Rozmansi has tested the MSI installers pretty thoroughly. Still it would
be good to get external testing as well. Rozmansi will provide test
installer for now and lev will put them on staging.openvpn.net.

It was agreed that we should only publish the EXE installer (will pick
32 or 64-bit MSI embedded). We will instruct IT admins to run
"openvpn-install.exe /extract" to get the MSI packages, e.g. for GPO
deployments.

--

Discussed the "disable DNS testing" patch. It was agreed that it is
still useful and should be merged.

--

Noted that the following things still need work before we can release 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

- Purge NSIS installers
- Review and test of MSI changes (rozmansi, mattock, lev, selvanair)
- sync client-connect support (lev, plaisthos, dazo)
- async compress patch (plaisthos)
- man page formatting change

On top of that we should

- go through what we have on the list / in patchwork
- go through trac and see what's broken (a few tickets are important)

---

Full chatlog attached

--------------B1ABCA1E6BAD559A24BBE89D
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-03-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-03-12.txt"

(20:59:11) mattock: evening
(21:00:09) lev__: hello
(21:00:30) rozmansi [sid334387@...2315.../web/irccloud.com/x-nzmdtcodbfqmjyc=
i] =C3=A8 entrato nella stanza.
(21:00:38) rozmansi: 'evening
(21:02:13) cron2: hullo
(21:02:19) plaisthos: moin
(21:02:55) mattock: it seems we have a crowd here
(21:03:15) cron2: indeed... any word from dazo?
(21:03:28) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-03-12
(21:03:30) vpnHelper: Title: Topics-2020-03-12 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:04:16) mattock: checking
(21:06:05) mattock: nothing in my inbox from dazo
(21:06:11) dazo: hey!
(21:06:14) mattock: hi!
(21:06:37) dazo: sorry!  Just deep into coding ... and time flies ....
(21:07:50) mattock: btw. I resolved this today: https://community.openvpn=
=2Enet/openvpn/ticket/1171 ("unable to register due to plus sign in the m=
ail address")
(21:07:52) vpnHelper: Title: #1171 (unable to register due to plus sign i=
n the mail address) =E2=80=93 OpenVPN Community (at community.openvpn.net=
)
(21:08:08) mattock: long-standing issue which some people really wanted
(21:08:11) mattock: to get fixed
(21:08:19) cron2: mattock: this is nice.  A friend of mine ran into this =
and then complained to me just the other day :)
(21:08:31) mattock: yep, and people complained on twitter which triggered=
 this fix
(21:08:43) mattock: fortunately the fix did not require a Pwm upgrade (th=
at would have been a big job)
(21:09:18) mattock: anyhow
(21:09:20) mattock: 2.5?
(21:09:38) mattock: MSI maybe? :P
(21:09:49) cron2: I've done a bit of merge-ACKed and also reviewed some o=
f rozmansi's new work
(21:10:03) cron2: it would be good to have reviews and test on the openvp=
n-build and the msi work
(21:10:44) cron2: I am happy to merge everything that looks like "it does=
 not introduce broken code" and "rozmansi knows what he's doing", though =
- so all the openvpnmsica stuff is his code anyway
(21:10:50) rozmansi: sure... I have tested it myself as much as I could..=
=2E But still, everything is very fresh.
(21:10:57) lev__: are new MSI installers available somewhere
(21:11:10) rozmansi: I can build and post them...
(21:11:39) rozmansi: mind it's a set of three:
(21:11:40) rozmansi: https://github.com/OpenVPN/tap-windows6/pull/106
(21:11:41) vpnHelper: Title: MSM packaging by rozmansi =C2=B7 Pull Reques=
t #106 =C2=B7 OpenVPN/tap-windows6 =C2=B7 GitHub (at github.com)
(21:11:45) lev__: maybe upload them to https://build.openvpn.net/download=
s/snapshots/
(21:11:47) vpnHelper: Title: Index of /downloads/snapshots/ (at build.ope=
nvpn.net)
(21:11:50) rozmansi: patches on mailing list (patchwork)
(21:12:10) cron2: it's not an openvpn patch
(21:12:13) rozmansi: and  https://github.com/OpenVPN/openvpn-build/pull/1=
41
(21:12:15) vpnHelper: Title: Windows MSI Packaging by rozmansi =C2=B7 Pul=
l Request #141 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (at github.com)=

(21:12:31) cron2: lev__: patchwork only has openvpn patches (today)
(21:12:55) cron2: tap-windows6 and openvpn-build only have github repos *=
and* do PRs
(21:12:59) rozmansi: lev__: sure, probably later this evening
(21:13:18) lev__: well I meant build.openvpn.net, where we have snapshots=
=20
(21:13:32) cron2: ah, misunderstanding
(21:14:34) rozmansi: lev__: but I don't know if I have permissions/means =
to upload anything to https://build.openvpn.net/downloads/snapshots/... W=
ill upload somewhere and post URL.
(21:14:36) lev__: rozmansi: if you provide me binary I can upload it to s=
taging.openvpn.net
(21:14:47) rozmansi: lev__: okay
(21:17:19) mattock: I can put stuff to build.openvpn.in if needed
(21:18:42) mattock: I see that the tap-windows6 has extensive changes to =
docs etc.
(21:18:54) mattock: I'll review that
(21:19:25) rozmansi: There is one commit that did it. It is my vision how=
 the TAP-Windows6 driver should be deployed in the future.
(21:20:17) rozmansi: We could remove that commit for now if you think I'm=
 going too fast. But do review it to get a better idea what the TAP-Windo=
ws6 MSM is about.
(21:20:42) mattock: I'll check it, I have no opinions yet
(21:21:05) plaisthos: dazo: you still need to review the 2FA patches
(21:21:11) mattock: I'll also check the changes in https://github.com/Ope=
nVPN/openvpn-build/pull/141
(21:21:14) vpnHelper: Title: Windows MSI Packaging by rozmansi =C2=B7 Pul=
l Request #141 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (at github.com)=

(21:21:20) mattock: maybe selva or lev could also have a look
(21:21:44) lev__: rozmansi: that MSM packaging code in tap-windows6 - is =
it mostly from WG?
(21:21:49) lev__: *wintun=20
(21:21:50) dazo: yikes ... yes, plaisthos
(21:22:09) mattock: rozmansi: also: is the code from wireguard 100% the s=
ame or slightly different?
(21:23:04) rozmansi: lev__: yes, MSM packaging is a duplicate of Wintun M=
SM with some minor amends to adopt it for TAP-Windows6
(21:23:46) rozmansi: mattock: I have removed the ioctl call to force clos=
e handles (TAP-Windows6 doesn't have that).
(21:24:00) lev__: that PR is huge
(21:24:05) rozmansi: mattock: and renamed function and file names
(21:24:38) rozmansi: lev__: the project file was done from scratch. Could=
 merge it to a single commit. The .h and .c files are copied.
(21:24:50) lev__: and openvpn-build has 103 commits :)
(21:24:53) mattock: I suppose the code has been pretty static at the wire=
guard end? I'm just wondering about long-term maintenance
(21:24:54) lev__: (PR)
(21:25:17) rozmansi: oh, openvpn-build... I started working on that PR in=
 2018.
(21:25:31) mattock: it needs some squashing once it is "ready" :D
(21:26:36) rozmansi: yep. Whatever you prefer. I kept it in baby steps be=
cause things were pretty much my brainstorming before it settled. Squash =
would be fine with me.
(21:27:12) mattock: anyways, let's check the PRs and move from there
(21:27:35) mattock: so rozmansi will provide test installer for now, and =
lev will put them on staging.openvpn.net?
(21:28:13) rozmansi: yes
(21:28:16) lev__: yes
(21:28:57) mattock: ok
(21:29:07) mattock: what else on 2.5?
(21:29:20) cron2: dazo, plaisthos: how's your schedule?
(21:29:53) cron2: lev__, rozmansi: with the new tun.c patches that reorde=
r ifconfig/set dns, do we still want to merge the "disable DNS testing" p=
atch?  Or is it no longer helpful?
(21:30:11) cron2: it got two ACKs, but if the new order does not need it,=
 I'm a bit at a loss what to do
(21:30:23) lev__: DNS validation you mean?
(21:30:49) cron2: yes
(21:31:20) rozmansi: cron2: it is helpful. If you are not merging Domagoj=
's patch, I'll submit my own down the road. :)
(21:31:21) plaisthos: I can try to go through patchwork again and see wha=
t else is open
(21:31:24) dazo: cron2: I have a deadline tomorrow for a component of our=
 OpenVPN Cloud service .... but plaisthos 2FA stuff needs to be resolved =
too ... I'll try to squeeze that in tomorrow after my deadline
(21:31:43) cron2: rozmansi: this is all I wanted to hear, so I'll merge t=
hat one tomorrow
(21:31:47) rozmansi: cron2: in other words - please do merge it. It has t=
wo acks, it is a general improvement
(21:31:54) cron2: all good :)
(21:32:21) lev__: rozmansi: so DNS validation still may fail even after w=
e fixed order?
(21:32:22) cron2: (sometimes patches get ACKs, and then someone else rewr=
ites large parts of the code and things are obsoleted before being merged=
 - in that case I come asking)
(21:33:27) rozmansi: lev__: yes, exactly... fixing the order would just s=
olve the dns validation for IPv6 when DNS servers pushed are directly ins=
ide the openvpn network being connected to.
(21:33:55) rozmansi: however, ipv6 already has DNS validation disabled. S=
o, this commit was more or less aesthetics.
(21:35:42) lev__: dazo: plaisthos when would you have time to review clie=
nt-connect
(21:36:10) plaisthos: lev__: I cannot review it because I send it to the =
list
(21:36:25) lev__: that and msi are two biggest missing pieces
(21:38:45) rozmansi: lev__: https://dat.amebis.si/s/X7p247HD7j9mLJm
(21:38:48) vpnHelper: Title: Amebisov spletni datote=C4=8Dni stre=C5=BEni=
k (at dat.amebis.si)
(21:39:00) rozmansi: here is compiled MSI stuff
(21:39:51) lev__: rozmansi: do we now have separate x86 and x64 installer=
s ?
(21:40:04) rozmansi: install using EXE installer (will pick 32 or 64-bit =
MSI embedded), or separate MSI packages for GPO deployment
(21:40:18) rozmansi: regular users =3D> EXE, enterprise users =3D> MSI
(21:40:32) mattock: rozmansi: shall I publish that link?
(21:40:44) mattock: or shall we wait until lev puts it on staging.openvpn=
=2Enet?
(21:40:48) rozmansi: exe is 7-zip sfx, so it may be extracted to get the =
MSI packages. Technically, MSI packages does not need to be deployed sepa=
rately.
(21:41:23) rozmansi: the server I send URL has pretty poor link. Do copy =
the content to staging.openvpn.net, please.
(21:41:27) plaisthos: the async compress patch from me is also missing ac=
ks iirc
(21:41:28) mattock: ok
(21:42:24) cron2: yes
(21:42:41) cron2: and a few older things might warrant a look for "pursue=
 or drop"
(21:43:02) rozmansi: yeah, maybe don't even deploy MSI files to prevent c=
onfusion. EXE should do just fine. For IT admins needing MSI files, tell =
them to run openvpn-install.exe /extract (must lookup exact 7-z SFX flag =
for it)
(21:43:18) cron2: the two next weeks will be a bit crazy for me, because =
our kids' school is closed due to corona... so I can't get any "real" wor=
k done anyway, so will use time on OpenVPN :)
(21:43:29) mattock: rozmansi: +1
(21:43:46) rozmansi: cron2: +1 (school close down on monday)
(21:43:54) cron2: rozmansi: yay
(21:44:24) dazo: schools and kindergartens closes here as well, as from t=
omorrow .... luckily wife is a teacher and also gets time off :-P
(21:45:45) mattock: out here schools or kindergartens are not closing _ye=
s_ but probably soon
(21:46:12) lev__: mattock: probably after sweden :)
(21:46:25) mattock: of course after Sweden, no need to even mention that
(21:46:27) mattock: :D
(21:46:44) mattock: (Finns don't do anything before Swedes do it first)
(21:46:53) mattock: not 100% accurate, but 90% probably :P
(21:47:22) mattock: anything else about 2.5? I guess the "go through tick=
ets etc" is not yet started?
(21:47:54) lev__: so will dazo review client-connect?
(21:47:55) rozmansi: mattock: I hope that's not true for the "Swedish Che=
ef" (from Sesame Street) :)
(21:48:17) mattock: we don't have a Finnish Chef if you're implying that =
:D
(21:48:49) rozmansi: good to hear that :)
(21:49:57) dazo: lev__: I can give it a stab after plaisthos 2FA patches
(21:50:59) dazo: Isn't that from the Muppet Show?
(21:51:09) mattock: yep
(21:51:10) dazo: (the swedish chef, that is)
(21:51:17) mattock: technically not by swedes
(21:51:17) cron2: age showing
(21:51:29) mattock: that's probably why Finns don't have a "Finnish chef"=

(21:51:43) dazo: hahaha
(21:52:15) mattock: seriously - are we good for today
(21:52:17) mattock: ?
(21:52:45) rozmansi: looks like
(21:52:47) cron2: yeah
(21:53:00) dazo: no, lets keep mattock up longer ... just because ... :-P=

(21:53:33) mattock: we still have 7 minutes to waste if needed :D
(21:53:38) mattock: but yeah, I have the summary ready
(21:53:44) ***cron2 goes couching
(21:54:03) mattock: gut
(21:54:09) mattock: next meeting next wednesday then
(21:54:26) cron2: yes
(21:54:29) rozmansi: good night
(21:54:32) dazo: alrighty
(21:54:37) lev__: guten nacht

--------------B1ABCA1E6BAD559A24BBE89D--

--2jWfRAtcjlipFK0UsAKwPVckYnKslSmYh--

--1NITYP5C4Ov2BYcywocz6ejZc5och34zj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl5qlBAACgkQKVhNn0CG
RXi3swf/Wmahi6KK7Y2pCt611mUodHb7Gf3eawGv/4TeeAN2pFh87H/xv7RN9Zt7
UWU2ilJcypGbF1YxeqSJRK2KEMLwJ7zHcB60F9sO+OutuZggAy6O4qZsbGxNJKO9
A/yHKgQrd1AW30KNjfCovUzIwq/3LViIhR2pkS/MId8WVJMBo00dAfZA3LZAIzRy
+TYl77A4XJY2uQzGDexJYaWBN/Uvw8+PF9ymPZtTKrL3ZBCirsf9c777hcWvLbm5
qZ+TYFQ/XocizCQtPQmzL8h70ri2cs3VRM+fZ/NvJXTRZrldTVUE/VpKwDB732uM
M1U75RA2w+ZiHspTo0KjRC7Zzt2bLA==
=Gf3u
-----END PGP SIGNATURE-----

--1NITYP5C4Ov2BYcywocz6ejZc5och34zj--

