From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Message-ID: <a4a54617-324e-9dc7-83a9-71a5302fa805@...515...>
Date: Wed, 30 Oct 2019 13:33:24 +0200
MIME-Version: 1.0
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dCs54uJqXAZyr9KDmpwgcHEnTi3XgZhfK"
Subject: [Openvpn-devel] Summary of the community meeting (30th October 2019)
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
--dCs54uJqXAZyr9KDmpwgcHEnTi3XgZhfK
Content-Type: multipart/mixed; boundary="m30s9aswJ4xfOO4PHENs9bikT3oxMIVRf";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <a4a54617-324e-9dc7-83a9-71a5302fa805@...515...>
Subject: Summary of the community meeting (30th October 2019)
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>

--m30s9aswJ4xfOO4PHENs9bikT3oxMIVRf
Content-Type: multipart/mixed;
 boundary="------------3C7F344704AF9F8DCA70A6D5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3C7F344704AF9F8DCA70A6D5
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 30th October 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-10-30>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock and rozmansi participated in this meeting.

---

Talked about the OpenVPN 2.4.8. Cron2 will tag it ~13:00 CET after which
mattock will start the release machinery. The release process will
probably be 100% done tomorrow.

Merged the final pending tap-windows6 PRs. This means that the installer
bundled with OpenVPN 2.4.8 will be the same as was released earlier as a
test installer.

Decided to postpone merging the NCP/fragment patch as cron2 has had
issues reproducing the problem. [Earlier today decided to bundle OpenSSL
1.1.0 and upgrade to 1.1.1 in 2.4.9 which is due at / after hackathon]

--

Mattock will probably make the Windows "buildslave" a real buildslave,
as in: "connected to the buildmaster". And do the same with the Debian
package builder (sbuild_wrapper) instead of using home-grown Git
polling, locking, etc. routines. This should not require major
refactoring of the current Buildmaster configuration.

--

Noted that pushing to SF.net OpenVPN "master" branch is broken. Cron2's
support request was declined. Mattock will open an official one to get
SF.net support's attention.

--

Lev sent a small patch to enable Travis-CI for Visual Studio builds.
He'd like it to get review so that we don't accidentally break those builds.

--

Noted that we should do some brainstorming:

- t_client tests: figure out which branch we are in (they fail on 2.4)
- resolvctl: do we want to bundle scripts for it (e.g. for arch linux)

--

Noted that (due to hackathon) there won't be a meeting next week.

--

Full chatlog attached.



--------------3C7F344704AF9F8DCA70A6D5
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-10-30.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-10-30.txt"

(12:32:03) cron2: heelow
(12:32:06) mattock: hello
(12:32:15) lev__: guten tag
(12:32:23) rozmansi: hi
(12:33:19) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-10-30
(12:33:20) vpnHelper: Title: Topics-2019-10-30 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:34:45) cron2: updated
(12:36:09) mattock: okeli dokeli
(12:36:18) mattock: 2.4.8 - what is missing
(12:37:11) cron2: I have one patch on my list, and that's the NCP/fragmen=
t fix - but I currently can not reproduce the problem at all ("release/2.=
4/HEAD without the patch behaves *exactly* the same as master with the pa=
tch") - so I might postpone that
(12:37:15) cron2: everything else is in
(12:37:32) cron2: version.m4, changes.rst, ChangeLog, tag, push :)
(12:37:57) cron2: any other patches that need to go in that I forgot abou=
t?
(12:38:20) mattock: did the other tap-windows6 PR get ack?
(12:38:59) rozmansi: not yet AFAIK
(12:39:08) cron2: which one?
(12:39:21) mattock: https://github.com/OpenVPN/tap-windows6/pull/84
(12:39:24) vpnHelper: Title: Introduce TAP adapter as a virtual device by=
 rozmansi =C2=B7 Pull Request #84 =C2=B7 OpenVPN/tap-windows6 =C2=B7 GitH=
ub (at github.com)
(12:39:47) rozmansi: thou JJK and Rogier tested it and reported it fixes =
HP laptop issue
(12:39:54) mattock: yep
(12:40:51) cron2: I thought the HP laptop issue was in something we alrea=
dy merged
(12:41:09) rozmansi: cron2: it was a combination
(12:41:28) rozmansi: it's not until this last PR is in that it fixes it f=
inally
(12:43:14) cron2: well, it got some testing, nobody complained, so let's =
put it in...
(12:43:17) rozmansi: Surfnet would like to deploy OpenVPN (via eduVPN cli=
ent) to a university in Netherlands that is using this kind of HP laptops=
 exclusively and they would love to get this PR merged and published ASAP=
=2E
(12:44:56) cron2: seems that just happened... so we now need to bump the =
version numbers in the tap6-windows repo accordingly
(12:45:03) rozmansi: I don't see what could possibly go wrong. But it's a=
 big world out there and TAP-Windows6 adapters has been marked as physica=
l Ethernet NIC for a long long time.
(12:45:26) mattock: we'll know soonish :)
(12:45:50) cron2: mattock1: the driver out there is exactly what is in th=
e repo now, right?
(12:45:52) mattock: the to-be-released driver will be identical to the te=
st driver then
(12:45:55) mattock: yes
(12:46:04) lev__: cron2: that fragment/ncp stuff was fairly easy to repro=
duce, let me try now
(12:46:06) cron2: so we can keep the version number?
(12:46:09) mattock: yes
(12:46:28) cron2: lev__: that is what I thought :-) but 2.4 and master ar=
e behaving absolutely identically in my --fragment test setup
(12:47:24) lev__: cron2: have you looked at those steps https://community=
=2Eopenvpn.net/openvpn/ticket/1140
(12:47:26) vpnHelper: Title: #1140 (mssfix appears to be broken with NCP)=
 =E2=80=93 OpenVPN Community (at community.openvpn.net)
(12:47:41) cron2: lev__: yes
(12:48:03) cron2: mattock1: please push the version number update to the =
repo, then :-)
(12:48:21) mattock: cron2: will do
(12:48:55) cron2: this somewhat sounds like the totally anticlimatic end =
of a long journey...
(12:51:15) cron2: ok, tap6-windows done :-) - anything else for 2.4.8?
(12:51:24) cron2: mattock1: when do you need the tagging?
(12:52:54) mattock: is around 13:00 your time ok?
(12:53:44) mattock: the sooner I can start the various builds the better =
of course
(12:54:20) cron2: 1300 is doable if I either can get lev__s patch sorted =
out quickly or we decide to postpone
(12:56:47) mattock: ok, no rush - it is unlikely that I could do the full=
 release process today (lots of stuff in the evening plus toddler duty af=
ter that)
(12:56:57) mattock: but if I could build the stuff today that'd be nice
(12:58:00) cron2: working on Changes.rst
(12:58:03) cron2: anything noteworthy?
(12:58:23) mattock: not from my end - there's lots of windows stuff but t=
hat goes elsewhere
(12:58:44) lev__: cron2: I just reproduced it
(12:59:02) lev__: (and ncp-disable fixes those)
(12:59:24) cron2: lev__: so what did you do, exactly?
(12:59:45) lev__: actually, I reprodeuced the problem (IP fragmentation),=
 haven't tried the patch yet
(12:59:46) cron2: as I said, my release/2.4/HEAD build produces exactly t=
he same MSS values as master
(13:00:34) cron2: my test is "look at the MSS values in tcpdump and in op=
envpn log output", and I cannot see a difference there
(13:07:11) mattock: ok, so how shall we proceed with this?
(13:07:33) cron2: we agree that you shall have your tag at 1300, in 53 mi=
nutes :-)
(13:07:50) cron2: Lev__ is testing the MSS stuff, but we merge that after=
wards for 2.4.9 if we better understand what is happening
(13:07:51) mattock: ok, was referring to the discussion between you and l=
ev
(13:07:59) mattock: that is enough for me
(13:08:00) cron2: that got moved to query
(13:09:06) mattock: off one thing I want to add completely unrelated to 2=
=2E4.8
(13:09:29) ***cron2 listens :)
(13:09:30) mattock: I'm thinking that instead of bringing back the "Windo=
ws buildslave" as-is, I will make it a buildslave, but just with a differ=
ent build logic
(13:09:45) mattock: same with sbuild_wrapper which I use to build deb rel=
ease packages
(13:09:56) mattock: buildbot would handle queuing, git monitoring, etc.
(13:10:03) cron2: all I care is "if I break mingw building, I want to kno=
w right away" - so how the machine works, I do not need to know
(13:10:13) cron2: (and we should have the windows snapshot builds back on=
 the download site)
(13:10:17) mattock: yes, it would just trigger openvpn-build just like op=
envpn-windows-buildtest did
(13:10:47) mattock: we'd see build status in the buildbot ui as a bonus
(13:10:57) cron2: nice
(13:11:15) mattock: should be doable without major refactoring of buildma=
ster config (knock on wood)
(13:12:21) mattock: anything else for today?
(13:12:25) cron2: oh, something else I want to mention while I have peopl=
e's attention...
(13:12:41) cron2: pushing to sourceforge is broken - I can push to releas=
e/2.4 but not to master because a broken git lock is lying around
(13:12:58) cron2: their support tells me "please contact the project if y=
ou have questions about openvpn"... silly dimwits
(13:13:06) mattock: ugh
(13:13:16) cron2: no problem for 2.4 release, but something to keep in mi=
nd when fetching master
(13:13:58) mattock: do you have console output I could see and copy to th=
e SF.net support ticket "from the project"?
(13:14:07) mattock: I can open one right away
(13:14:19) cron2: sure
(13:14:49) lev__: "anything else for today" I've sent a small patch which=
 adds MSVC to travis build, would be nice to get it reviewed
(13:15:02) lev__: this will help us not to break VS builds
(13:15:08) cron2: coming over query
(13:15:10) cron2: yes
(13:17:17) cron2: pushing 2.4.8 to the buildbot repo... if they are happy=
, I'll tag and push to the official repos
(13:17:51) cron2: ah, mattock1: have you seen my request in #openvpn-deve=
l to remove 4 dead buildslaves?
(13:18:25) mattock: yes
(13:18:33) mattock: I'll tackle that as well
(13:19:01) cron2: thanks.  Buildbot is lazy today :)  (sometimes it picks=
 up new pushes "right away", sometimes it takes a few minutes)
(13:19:18) mattock: lazy is by design
(13:19:31) mattock: there is a "wait if new commits arive" timeout there
(13:19:31) cron2: anyway - 2.5 "nothing much has happened", except that I=
'm glueing my test server infra back together, so I can use that for TAP/=
VLAN tests "soon"
(13:20:02) cron2: mmmh, it's a pity dazo is not here
(13:20:54) cron2: we have t_client tests currently that fail on 2.4 ("not=
 implemented yet") but pass on master - and I want to make things conditi=
onal in t_client.rc... so an easy way to figure out "which git branch are=
 we in" would be appreciated...
(13:22:37) cron2: but maybe I can just tackle that next week
(13:22:43) cron2: so
(13:22:50) cron2: pull-resolv-conf/client.up
(13:22:58) cron2: this is a script for linux to get DNS info into place
(13:23:10) cron2: and it fails on Arch linux because they do not use "res=
olveconf" anymore but "resolvectl"
(13:23:22) mattock: the joys of new systemd components
(13:23:28) cron2: which seems to be the new and all improved systemd way =
to do things in a new way
(13:23:31) cron2: yes
(13:24:14) cron2: I could care less about all these newfangled Linux inve=
ntions, but unfortunately two colleagues @ customer have decided to use A=
rch for their home laptops, and now my openvpn configs I give them are fa=
iling (no DNS, and split DNS in use)...
(13:24:49) cron2: so, brainstorming session :-) - do we want to have this=
 in our repos?  eworm says "arch does not add scripts, they just pack wha=
t openvpn upstream ships"
(13:27:08) mattock: ok noted
(13:29:38) mattock: 1 minute left :)
(13:29:43) mattock: done?
(13:30:00) cron2: yeah... no meeting next week thursday
(13:30:19) mattock: good point
(13:30:39) cron2: but long meeting next week friday :-) - looking forward=
 to see you all again
(13:30:51) rozmansi: same here :)
(13:31:09) mattock: likevise!
(13:31:13) mattock: summary almost out

--------------3C7F344704AF9F8DCA70A6D5--

--m30s9aswJ4xfOO4PHENs9bikT3oxMIVRf--

--dCs54uJqXAZyr9KDmpwgcHEnTi3XgZhfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl25dQQACgkQKVhNn0CG
RXixBgf/R4qPS/J1Hh+6xR5b8hb32ZI8JtgErpV6RU80ZudY+NYcoUS+1/1GqsU8
I6p+tNKvwhznrdaGVRFD3Rs0IpnFkDGu/t5owTwH+TISYPxP44QNuDq0nD1D9J3j
X4LOhCz10Wy2/B8dEqFVzlvUfM3SN1rvRoZ83duKnryeLK2bIlhHdFIO244jSqxM
4lPgzxG2DEYdTsMr4M8xg+jvifPHuxP25VuwP5EqDl4Td8hOUHUWfZqq3fpKa7jK
dT285k4ju9n94D0YgaE6bQnA+tErZd99A4BXouVtYflRRlAJuOpd2K4OhfOfnmFh
Vp82c2fbqCERzWyiE+hI7heUx7bLjw==
=kSOO
-----END PGP SIGNATURE-----

--dCs54uJqXAZyr9KDmpwgcHEnTi3XgZhfK--

