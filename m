From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
Message-ID: <238fe195-8ba9-c27b-d71b-a55027db64b5@...515...>
Date: Thu, 26 Sep 2019 22:08:43 +0300
MIME-Version: 1.0
In-Reply-To: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GuCGLFttBSR55yO1dqJRtydjU0vW9S8oe"
Subject: [Openvpn-devel] Summary of the community meeting (26th Sep 2019)
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
--GuCGLFttBSR55yO1dqJRtydjU0vW9S8oe
Content-Type: multipart/mixed; boundary="pN9lT0bUwchyP6CwJYf6f7aLOwqsNV8lQ";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <238fe195-8ba9-c27b-d71b-a55027db64b5@...515...>
Subject: Summary of the community meeting (26th Sep 2019)
References: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
In-Reply-To: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>

--pN9lT0bUwchyP6CwJYf6f7aLOwqsNV8lQ
Content-Type: multipart/mixed;
 boundary="------------F27CFE2FE5E0C3B626A41AE9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F27CFE2FE5E0C3B626A41AE9
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 26th September 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-09-26>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, lev, mattock, ordex and zx2c4 participated in this meeting.

---

Discussed broken buildslaves/builds and noted that they still need to be
fixed.

---

Discussed relative merits of Buildbot and Jenkins. Dazo has had some
strange issues with Buildbot and upgrading Buildbot might be a worthy
effort. Migrating to Jenkins would be a big effort and it is unclear if
it would be a better solution in our particular use-case.

---

Noted that mattock still needs to produce a tap-windows6 test installer
with PRs from here:

<https://github.com/OpenVPN/tap-windows6/pulls>

As mentioned in last week's meeting summary if testing of that installer
goes well and Selva gives his ACK on

<https://github.com/OpenVPN/tap-windows6/pull/86>

we will include the new driver in the OpenVPN 2.4.8 installer.

--

Discussed the problem of OpenVPN Inc. people getting dragged into
internal projects due to internal pressure and thus unintentionally
deprioritizing community work. The OpenVPN 3 team has recently tried to
allocate Friday for community work. Mattock will attempt to follow suit
going forward.

--

Agreed that we want wintun in OpenVPN 2.5 installers. According to zx2c4
the upcoming Wintun 1.0 API version will be stable. As far as Wireguard
is concerned the API needs no changes at the moment, but zx2c4 is still
waiting for input from external parties.

Wintun installation can be handled either as Merge Modules (MSM) in an
MSI installer. Or a silent wintun MSI installer can be embedded into an
MSI installer.

--

Full chatlog attached.

--------------F27CFE2FE5E0C3B626A41AE9
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-09-26.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-09-26.txt"

(20:52:58) L'argomento di #openvpn-meeting =C3=A8: Next meeting 18/Sept/2=
019 at 11:30 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/=
Topics-2019-09-18
(20:52:58) L'argomento per #openvpn-meeting =C3=A8 stato impostato da ord=
ex!~linuxaro@...2309.../batman/ordex a 13:04:22 su 17/09/2019
(21:01:25) ***dazo is here
(21:01:53) mattock: good evening!
(21:02:05) mattock: who are the merry participants today?
(21:03:24) dazo: cron2 couldn't make it, I heard ... technically, plaisth=
os is some kind of holiday iirc, but he has been online earlier today :-P=

(21:03:45) dazo: rozmansi said last week he needed a ping :-P
(21:04:49) mattock: rozmansi: ping if you want to join the meeting
(21:05:00) ***dazo pinged ordex and lev__ internally
(21:05:03) mattock: ok
(21:06:15) lev__: hellou
(21:06:44) dazo: \o/ one of three pings responded! :-P
(21:06:49) mattock: that's not all bad
(21:06:57) mattock: so let's see our topic list
(21:07:15) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-09-26
(21:07:17) vpnHelper: Title: Topics-2019-09-26 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:07:25) mattock: tap-windows6: no progress whatsoever
(21:07:43) mattock: that may be something for tomorrow's mini-hackathon t=
hough
(21:07:48) dazo ha scelto come argomento: Next meeting 2/Octt/2019 at 11:=
30 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-201=
9-09-26
(21:07:51) dazo ha scelto come argomento: Next meeting 2/Oct/2019 at 11:3=
0 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2019=
-09-26
(21:08:24) dazo: mattock1: we also need to get some focus on the missing =
build slaves, though
(21:08:31) mattock: and that one
(21:08:38) dazo: now the buildbot machinery is kinda crippled
(21:09:27) lev__: dazo: can we delegate it to our ops team
(21:09:36) dazo: mattock1: ^^^
(21:10:05) mattock: well, all of us in the ops team have boatload of work=
 at any given time
(21:10:35) mattock: there's not help there tbh
(21:10:45) lev__: so it is about prioritization
(21:11:01) dazo: actually we should have a serious discussion if we want =
to continue with buildbot .... or if we should consider switching to Jenk=
ins.  The "force build" feature works fairly ad-hoc for me; usually only =
the first time but not the second one (which might be needed because some=
 non-code related failures)
(21:11:01) mattock: yes, and at the moment community stuff tends to get d=
eprioritized way too much
(21:11:35) mattock: I'm not sure why force building fails for you - I hav=
e not had issues
(21:11:52) dazo: yeah, that isn't ideal at all ... which is why Core team=
 tries to allocate at least Fridays for these mini-hackathons
(21:12:17) mattock: I may need to do the same, because there's no end in =
sight for the flow of work at ops
(21:12:33) mattock: even if worked 24/7 the work would never end :|
(21:12:36) dazo: mattock1: try forcing a rebuild with the same commit aft=
er the prior one failing .... 5 of 5 times, those requests went to /dev/n=
ull
(21:13:05) mattock: failing because of what?
(21:13:27) dazo: mattock1: I also know Nick would like to help out on the=
 community side; not sure if his priorities has shifted ... but worth con=
sidering
(21:13:36) dazo: mattock1: I dunno ... it just doesn't happen
(21:13:46) mattock: uh, I abhor jenkins personally
(21:14:13) mattock: I see lots of pains in getting it even running on all=
 the operating systems we support
(21:14:22) mattock: slash test with buildbot at the moment
(21:14:31) dazo: Jenkins has been working quite well from a devs perspect=
ive for Core team
(21:15:19) mattock: I'm sure it is possible to make it work, I'm just not=
 sure it is the best solution given all the corner-cases we have in build=
bot due to OS differences and all that
(21:15:24) dazo: and I can force and re-run jobs as much as I want, I see=
 what is piled up in the work queue before it starts working on it (also =
something I don't see in buildbot, so I don't know if jobs have been acce=
pted or is deliberately ignored)
(21:15:31) ordex: sorry was on dinner
(21:15:45) dazo: ordex: just bring the wine now! ;-)
(21:15:53) ordex: hehe
(21:16:10) lev__: at least builds for various linux distos can be easily =
handled by jenkins+docker
(21:16:32) mattock: we have solaris, openbsd, freebsd, netbsd plus someth=
ing like 7 linux distros
(21:16:58) mattock: as for nick - I doubt he could pull this off given hi=
s workload
(21:17:21) mattock: also, is doing a big migration really what we should =
be doing if we're already struggling to even fix simple stuff?
(21:17:25) ordex: dazo: are you sure you are pushing the right button ?
(21:17:40) ordex: sometimes I accidentally go for "cancel these builders"=
 rather than "build with these builders"
(21:17:41) mattock: also, I can see what work is queued in buildbot
(21:17:45) ordex: thus doingnothing
(21:18:03) dazo: ordex: well, it worked the first time ... and going to t=
he same place the second time doesn't give any results ... so, I believe =
I do it on the right spot
(21:18:18) ordex: hmm ok
(21:18:32) dazo: but the webui is horrendous, it is easy to not scroll fa=
r enough down ... but the last runs I'm fairly sure I've done the right t=
hing
(21:18:45) mattock: note that our buildbot installation is fairly old
(21:19:07) mattock: upgrading it would almost certainly be much easier th=
an switching to completely different system
(21:19:25) mattock: I won't give my opinion on the Jenkins webui here tho=
ugh :D
(21:19:34) dazo: we can sure do that as a first step, to see if these ann=
oyances disappears
(21:19:37) ordex: upgrading is good, until it breaks everything :P
(21:19:45) mattock: as is switching systems :D
(21:20:10) ordex: hehe yes
(21:20:22) dazo: it's just that we have broader company knowledge about J=
enkins these days .... buildbot knowledge is mostly mattock1 nowadays, I =
think
(21:20:46) mattock: and if we could get the company to work on community =
that might help :D
(21:20:55) mattock: that is the first and foremost problem we seem to hav=
e
(21:20:59) dazo: mattock1: if you use the "Blue" interface in Jenkins, it=
's pretty neat
(21:21:12) mattock: I've only seen the default (crappy) one
(21:21:24) mattock: internally jenkins is pile of poop
(21:21:27) mattock: imho
(21:21:37) dazo: that I don't know much about :)
(21:21:41) mattock: lucky you :)
(21:21:48) mattock: anyhow
(21:21:51) mattock: move on maybe?
(21:21:57) ordex: so, should we fix the current problematic slaves for st=
arters ?
(21:22:01) ordex: or are we dropping the ball ?
(21:22:02) mattock: yes we should
(21:22:03) mattock: no
(21:22:08) ordex: oky
(21:22:21) mattock: I need to cut myself loose from "generic" ops work, a=
t least on a weekly basis
(21:22:30) mattock: get these long overdue things fixed one at a time
(21:22:49) mattock: buildslaves -> tap-windows6 test build -> builder ins=
tance ->  and so forth
(21:23:00) ordex: just get a day like we do and focus on community things=
 ;p
(21:23:10) dazo: that would certainly help (not that I should claim Core =
team has been that much better)
(21:23:29) mattock: well, there's so much internal pressure piling up at =
all times that I can't blame you, only myself
(21:23:41) mattock: and not really myself, either, except for not priorit=
izing a bit
(21:24:05) mattock: so fridays are your "try to work on community things"=
 days?
(21:24:15) dazo: yes, it is
(21:24:22) mattock: that sounds reasonable
(21:24:49) mattock: I will start tomorrow - I can hopefully focus for thr=
ee hours or so
(21:25:04) mattock: due to appointments and meetings not more than that t=
his Friday
(21:25:12) ordex: that's a good start
(21:25:16) mattock: yep
(21:25:19) ordex: maybe you can fix one or two buildslaves in 3 hours
(21:25:24) ordex: and cron2 will be happy
(21:25:25) ordex: :D
(21:25:30) mattock: well it can be 10 minutes or 2 hours per buildslave
(21:25:35) mattock: depends :P
(21:26:21) ordex: :D
(21:26:23) ordex: right
(21:26:53) mattock: so, what else?
(21:26:55) mattock: 2.5?
(21:27:19) lev__: I really want to get wintun support into 2.5
(21:28:11) mattock: that is a good goal
(21:28:18) lev__: I have been using client with wintun for a week and did=
 some performance / stress testing
(21:28:51) lev__: we need someone to review those patches
(21:29:03) dazo: lev__: but we should really ensure we package things cor=
rectly, so a wintun driver upgrade via a wg install/update breaks openvpn=
's wintun integration
(21:29:51) gcoxmoz: (Is there | can there be) a list of known things bloc=
king 2.5 going out?
(21:30:11) mattock: the openvpn2.5 status page on trac is the closest one=
 there is
(21:30:18) ordex: https://community.openvpn.net/openvpn/wiki/StatusOfOpen=
vpn25
(21:30:19) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:30:26) mattock: the MSI installer rozmansi needs to be revamped
(21:30:30) ordex: but is not up to date
(21:30:31) lev__: dazo: yeah that is something we should decide - do we r=
ely on community wintun driver (supported by wintun) or use our "own" by =
changing device id not to conflict with "official" one
(21:30:32) ordex: will update now
(21:31:23) ordex: mattock1: Purge NSIS installers  << is this done ?
(21:32:09) mattock: lemme check
(21:32:09) lev__: can I add wintun support to that page?
(21:32:37) ordex: dazo: struct argv overhaul << was this done ?
(21:32:50) mattock: well, purging NSIS installers can't be done until we =
have new MSI installers
(21:32:53) ordex: dazo: auth-gen-token: Inform client why auth-token was =
rejected << how about this ?
(21:32:57) ordex: mattock1: ok
(21:33:00) mattock: plus it's more like "do not build NSIS for 2.5 anymor=
e"
(21:33:29) dazo: ordex: I need to double check the struct argv overhaul, =
but I do know I sent things for review long time ago
(21:33:38) ordex: ok, so still kinda pending
(21:33:39) ordex: okok
(21:33:50) dazo: ordex: the auth-token-hmac stuff, there is one patch mis=
sing review ... everything else should have an ack by now
(21:33:55) ordex: ok
(21:36:57) ordex: just updated some text in the table :)
(21:37:02) ordex: anything else?
(21:37:35) dazo: not from my side :)
(21:37:47) mattock: what is the status of the FIPS patches? did we get up=
dated patches to ml?
(21:37:56) ordex: i don't think so
(21:39:29) dazo: lev__: in regards to wintun support ... it would be a re=
ally nasty user experience if users experiences openvpn breaking if wireg=
uard updates are installed with newer drivers with incompatible APIs.  I =
dunno enough about if Windows has mechanisms to avoid this except of havi=
ng multiple, non-colliding drivers installed in parallel
(21:39:44) dazo: mattock1: what ordex says ... not heard anything in rega=
rds to FIPS
(21:40:42) dazo: I wouldn't put too much stress on FIPS currently ... see=
ms to be a fairly scarce user case .... even thought it could probably he=
lp getting a bigger footprint within government environments, where such =
certifications are much more common
(21:41:21) mattock: does wintun have some sort of auto-update thing going=
 on?
(21:41:36) dazo: it's bundled with wireguard install
(21:41:44) lev__: mattock1: not wintun, but wireguard client does
(21:42:59) lev__: are there companies/products which depend on our tap-wi=
ndows6? how do they solve this problem? (we may update driver and break t=
heir software)
(21:43:29) dazo: I don't think we've ever added any API changes to our dr=
iver
(21:43:52) mattock: hmm
(21:43:57) dazo: the biggest change was when switching to tap-windows6 ..=
=2E and I don't even think that required any changes in openvpn
(21:44:08) mattock: perhaps we need a customly named driver just like wit=
h tap-windows6
(21:44:35) mattock: yeah tap-windowsX has been extremely stable / stale
(21:44:40) mattock: we don't break it because we don't develop it
(21:44:42) mattock: :P
(21:45:01) ***dazo leaves the proper needed magic to the Windows wizards =
:)
(21:46:19) mattock: yeah it is not a big deal
(21:46:26) mattock: just a change in the inf file if I recall correctly
(21:47:04) mattock: then even if somebody has OpenVPN Wintun and Wireguar=
d Wintun side-by-side they should not collide
(21:47:14) mattock: nor would wireguard auto-update cause issues for Open=
VPN
(21:47:43) dazo: that would be the ideal setup, yes
(21:47:50) lev__: yep, there is tap-windows6, tapos, fsfreedometap you na=
me it. there is "wintun" and could be "openvpnwintun"
(21:47:57) lev__: *tapoas
(21:48:36) dazo: tapas? :-P
(21:49:32) zx2c4: Youre doing it wrong
(21:49:52) zx2c4: We specifically designed the wintun msm to be installab=
le by multiple parties
(21:50:01) dazo: nice!
(21:50:02) zx2c4: With installation reference counting
(21:50:08) zx2c4: So we dont uninstall eachother
(21:50:18) zx2c4: It only gets removed on the uninstallation of the last =
user
(21:50:34) zx2c4: So just bundle the msm into your installer
(21:50:42) mattock: technically we're not yet doing anything, we're just =
planning, so it's good you brought this up :)
(21:50:44) zx2c4: Simon knows exactly what to do there
(21:51:01) lev__: zx2c4: but what happens if you guys update wireguard cl=
ient with new wintun driver with different API ?
(21:51:09) zx2c4: We designed it so that it's 1 line to add to your wix a=
nd 1 line to add to our wix
(21:51:33) zx2c4: 1.0 release means we'll keep the api
(21:51:37) zx2c4: Otherwise its chaos
(21:51:49) zx2c4: Easy to make ioctls versioned internally too
(21:52:24) zx2c4: So use the period now to test the hell out of the thing=
 and figure out the complete breadth of ovpn requirements
(21:52:34) zx2c4: And when its ready we'll stamp the 1.0 on it
(21:52:49) zx2c4: Sound good?
(21:54:16) lev__: as mattock1 said, we haven't started working on install=
er and at the moment we rely on a version provided by wireguard
(21:54:19) dazo: zx2c4: Do you have an idea when the 1.0 release would ar=
rive?  Are there any other big changes happening?
(21:55:01) dazo: (before the 1.0 release)
(21:56:01) zx2c4: dazo: from WireGuard's end, requirements are done. Im w=
aiting to learn of you all need anything and for a review of the codebase=
 from some third parties
(21:56:46) dazo: zx2c4: cool! Sounds good!  lev__ is the one who would ha=
ve such input though, as he has been working on both openvpn 3 and openvp=
n 2 code bases for wintun support
(21:56:57) zx2c4: lev__: if you want to ship your own more intermediate m=
si before your final one, take a look at the msi example. You should be a=
ble to churn something acceptable out in 5 minutes using that
(21:57:42) zx2c4: dazo: yes well aware. I generally prefer to talk to him=
 about it rather than get embroiled in your openvpninc deceptive stuff
(21:58:38) lev__: zx2c4: I think openvpn still uses NSIS installer, but I=
 can probably make it work there by extracting install.dll from msm modul=
e and call rundll to install/uninstall=20
(21:58:57) zx2c4: lev__: mattock1 so anyway - the installer situation sho=
uld be fine without the need to rename it internally. Just let me know wh=
en your driver requirements start to solidify and ill get the scheduling =
for third party code review stuff underway
(21:59:04) zx2c4: lev__: no!!!!!!
(21:59:07) lev__: but we're moving to msi in 2.5, so naturally we could u=
se msm module there
(21:59:23) zx2c4: Read the docs and also our private conversation again
(21:59:32) zx2c4: Do not use installer.dll directly EVER
(21:59:34) mattock: at the moment we rely on rozmansi's MSI work, and the=
 previous MSI incarnation can't be used for reasons I can't exactly remem=
ber
(21:59:54) zx2c4: Reference counting is done by the msm component
(22:00:09) zx2c4: But! Lots of people shipping wintun use nsis
(22:00:24) zx2c4: And for this its trivial to embed a wintun-only silent =
msi
(22:00:34) lev__: zx2c4: I see
(22:00:37) zx2c4: Whose lifetime is attached to that of the nsis install =
item
(22:01:26) zx2c4: Check out the docs for the example msi thing
(22:01:38) zx2c4: People are already using that in production
(22:01:56) lev__: zx2c4: that is good to know, thanks
(22:02:00) zx2c4: And if you encounter sharp corners we can refine it too=
 of course
(22:03:21) mattock: we're 3 minutes overtime
(22:03:32) mattock: enough discussion for today?
(22:03:34) mattock: :P
(22:04:02) dazo: I don't have anything else
(22:04:04) zx2c4: lev__ feel free to message me as always while coding=20
(22:05:08) mattock: ok good, I'll send the summary in a few minutes
(22:05:10) lev__: zx2c4: hehe thanks, I will when I start looking into in=
staller part
(22:05:15) mattock: see you in tomorrow mini-hackathon
(22:05:23) mattock: I'll join around 11:15 EEST

--------------F27CFE2FE5E0C3B626A41AE9--

--pN9lT0bUwchyP6CwJYf6f7aLOwqsNV8lQ--

--GuCGLFttBSR55yO1dqJRtydjU0vW9S8oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2NDLwACgkQKVhNn0CG
RXhFiQf+J4FPf73HCOapKeqzmKtMfarTtz94Qod6gcNPCjAp0z/byX93VYoqRkua
Y6bDTiiwctOufGIzArViZhjkU4zs+rT1sNWBf78MyBKXhJV4EcFS7OjqnXlAnSmP
HwRBxKQl4shgYTxtymBKgNQZw+JnzjTeDyppGLH79lY9I9qOJ31aOT9Kf/tXsA7x
gpGJWAVYs/OMhFpaLEY2ChDqFak06fz0PEnXfftlFKDAiMwPSatTEykgV7Ki2gFr
HKjtVlM9bnN9clCAULJiEQHT8jROMWC7kokDiyr4PMxnu+kIMh/xyJAJpOn/4245
2mFWEpnw+Z28Bvf59m3L1QMDlt4BDQ==
=qC+g
-----END PGP SIGNATURE-----

--GuCGLFttBSR55yO1dqJRtydjU0vW9S8oe--

