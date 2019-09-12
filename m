From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
Message-ID: <877ee70e-be9d-52da-ce42-37ce352404a9@...515...>
Date: Thu, 12 Sep 2019 22:09:12 +0300
MIME-Version: 1.0
In-Reply-To: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r04nlNCm1lEmqWvBXhIpRXoQTEmW5RzES"
Subject: [Openvpn-devel] Summary of the community meeting (12th Sep 2019)
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
--r04nlNCm1lEmqWvBXhIpRXoQTEmW5RzES
Content-Type: multipart/mixed; boundary="m2uQarzK65fjroYyJeVCkMXhfMgtR85ez";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <877ee70e-be9d-52da-ce42-37ce352404a9@...515...>
Subject: Summary of the community meeting (12th Sep 2019)
References: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>
In-Reply-To: <8ac38ebd-23b0-9024-adcd-75f11c344398@...515...>

--m2uQarzK65fjroYyJeVCkMXhfMgtR85ez
Content-Type: multipart/mixed;
 boundary="------------2BD786C3AE7900AC79BCD270"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2BD786C3AE7900AC79BCD270
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 12th September 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-09-12>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and syzzer participated in this meeting.

---

Noted that tomorrow is our usual mini-hackathon. Some tasks for it are
listed below.

---

Discussed HLK testing. It turns out that HLK testing / WHQL
certification is _NOT_ needed for drivers to load properly on Windows
Server 2016/2019, despite_ what Microsoft documentation (clearly)
claims. Instead, the usual attestation-signed drivers that load on
Windows 10 desktop are sufficient. This was verified by mattock using
Windows Server 2019 with Secure Boot turned on. This means we don't
_need_ HLK testing after all.

Note from discussion earlier today: going through the HLK test suite
occasionally in a virtualised environment would still make sense, but
not at all cost.

--

Discussed the VLAN patches which ordex massaged into shape:

https://gitlab.com/ordex986/openvpn/commits/vlan

Ordex and cron will attempt to review this in tomorrow's mini-hackathon.

--

Discussed the auto-token patch set. Dazo will attempt to finish it up in
tomorrow's mini-hackathon.

--

Discussed the FIPS patch(set):

https://patchwork.openvpn.net/patch/131/

Noted that it got stuck for no particular reason. Mattock notified the
author of the patchset to get the ball rolling again.

--

Full chatlog attached.


--------------2BD786C3AE7900AC79BCD270
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-09-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-09-12.txt"

(20:59:18) cron2: meow
(21:01:28) mattock: hi
(21:01:33) syzzer: hi :)
(21:02:49) cron2: wow :)
(21:03:28) mattock: anyone else in our merry team?
(21:04:00) syzzer: *crickets*
(21:04:39) cron2: do we have an agenda? :)
(21:05:07) dazo: hey!
(21:05:40) dazo: https://community.openvpn.net/openvpn/wiki/Topics-2019-0=
9-12
(21:05:42) vpnHelper: Title: Topics-2019-09-12 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:06:23) cron2: oh, so dazo is the new agenda-keeper now :)
(21:07:12) dazo: hehe ... nah, just stumbled across it :)
(21:07:19) mattock: good work dazo!
(21:07:22) syzzer: so, #! ?
(21:07:27) syzzer: #1
(21:07:30) mattock: yes
(21:07:34) mattock: it seems we don't need HLK
(21:07:44) mattock: contrary to what microsoft says
(21:07:53) ***dazo facepalms
(21:07:59) syzzer: I read the backlog on -devel, totally confused now
(21:08:05) cron2: dazo: yes...
(21:08:16) mattock: so, basically Windows 10 attestation-signed drivers s=
eem to load just fine on Windows Server 2019 with secure boot turned on
(21:08:29) syzzer: can you summarize for mere mortals what you *do* have =
to do to sign the drivers?
(21:09:10) syzzer: is that just the "upload to MS for cross-signature"?
(21:09:20) cron2: I think there's a wiki page even... :-) - mattock1: I'm=
 still a bit confused about the "pre win10" and "win10" signing, what is =
done differently?
(21:11:07) mattock: syzzer: yes, except for the 25 minor details
(21:11:26) syzzer: :')
(21:11:28) mattock: with pre-windows 10 you can use cross-signing, i.e. g=
et an EV cert and sign the driver with that
(21:11:39) mattock: you don't contact microsoft all
(21:12:06) mattock: with windows 10 you either go through the HLK tests, =
submit the test results and the driver in an ev-signed package, and get b=
ack a microsoft-signed river=20
(21:12:39) mattock: or, you just create a driver package, ev-sign it, the=
n sent it to microsoft for "attestation signing" and get a microsoft-sign=
ed driver back
(21:13:46) mattock: anyways, MS documentation was horribly misleading, bu=
t the bright side is that it seems that we don't actually _need_ HLK for =
anything
(21:13:48) cron2: why is it called "cross" signing?  Seems to be pretty s=
traightforward-signing to me...
(21:14:08) mattock: you use a cross-certificate whatever that meant :P
(21:14:34) syzzer: it's a CA certificate that's signed by both a 'regular=
' CA and Microsoft
(21:14:47) mattock: that
(21:14:52) syzzer: a special code-signing CA
(21:14:56) cron2: ah
(21:15:24) mattock: going through the HLK tests was a good exercise, but =
the cost was terrible
(21:16:37) mattock: anyways, done with tap-windows6 / HLK? for "good" may=
be? :)
(21:16:56) syzzer: that would be very nice
(21:17:08) cron2: yep :-) - next meeting should have "which tap6 PRs to m=
erge, and when to ship a new release" on the agenda :-)
(21:17:13) cron2: maybe together with 2.4.8
(21:17:26) syzzer: sounds like a plan
(21:18:00) mattock: yeah together with 2.4.8 if possible
(21:19:28) cron2: ok... #2 - ordex has put out a tree full of vlan patche=
s
(21:19:37) mattock: noticed \o/
(21:20:16) cron2: I've skimmed the list and nothing of this makes sense t=
o me, yet, so I plan to give this some thoughts and discuss tomorrow ("mi=
ni-hackathon day").  I won't have all day, but about half a day should be=
 possible...
(21:20:40) cron2: (like, "what is a maddr object and why do I want to pop=
ulate it" :-) )
(21:21:12) cron2: where's plaisthos these days...?
(21:23:58) mattock: no idea
(21:24:10) mattock: so vlan patch review tomorrow?
(21:24:37) cron2: yes, if ordex and I happen to be on IRC at the same tim=
e
(21:24:49) mattock: ordex: doable?
(21:27:48) cron2: meeting feels a bit strained today...
(21:27:59) cron2: dazo: how's your schedule wrt auto-token patch set?
(21:27:59) mattock: yeah
(21:28:25) dazo: cron2: picking up the last things tomorrow, at least tha=
t's the plan
(21:28:32) cron2: nice
(21:28:47) cron2: a mini-hackathon day spent on "finish a patch set" is d=
efinitely a good day :-)
(21:28:54) dazo: :)
(21:29:24) mattock: +1
(21:30:55) mattock: anything else for tomorrow's mini-hackathon?
(21:32:03) mattock: 2.5 planning?
(21:32:13) cron2: there's lots of stuff in patchwork, but I haven't reall=
y kept track on what is waiting for whom (like, "have we answered and the=
 submitter hasn't responded")
(21:32:44) mattock: we have not done "Review patches on Patchwork" in age=
s (in meetings, at least)
(21:33:26) mattock: should we take a stab at it now?
(21:34:30) cron2: I don't really feel like it, I want to clean up first :=
-)  (merge patches with ACKs, look at the 2.4 patches that are backports =
of master and either merge them or complain)
(21:34:36) syzzer: I don't have much brains left today - so won't work fo=
r me
(21:34:51) cron2: I was about to suggest "I'm not going to stop syzzer or=
 dazo if they feel like it" ;-)
(21:35:01) mattock: we're short on brains today
(21:35:16) mattock: maybe call it a day?
(21:35:24) mattock: gather strength for tomorrow
(21:35:28) cron2: I call this "Thursday"!
(21:35:46) syzzer: hehe
(21:35:54) dazo: I've ack'ed a few pathces on the ML ... forgot what it w=
as though :-P
(21:36:19) cron2: patchwork keeps track :-) (TUN_PASS_BUFFER and tun_set(=
) void)
(21:36:45) mattock: oh one thing
(21:36:54) mattock: what was our plan regarding FIPS patchset?
(21:37:01) cron2: I'm not totally happy with the TUN_PASS_BUFFER thing, t=
hough - the net effect is the same, but the #ifdef in combination with th=
e function names makes this less than clear
(21:37:04) mattock: the author/committer asked about that
(21:37:09) mattock: a week ago or so
(21:37:17) cron2: mattock1: "have someone who understands crypto review a=
nd merge it" :-)
(21:37:51) mattock: that means syzzer?
(21:38:29) syzzer: do we find the fips patch set important?
(21:38:49) syzzer: I personally don't care much, but am willing to review=
 if other believe it is
(21:39:58) mattock: what is/was its maintenance status? I know it has bee=
n in production for some years at least in the patch author's environment=
=20
(21:40:18) mattock: but did and can the author maintain the patchset in t=
he long run?
(21:40:19) cron2: I do not care, but it seems to be a requirement in "cer=
tain environments"
(21:40:30) cron2: not sure how complex that patchset is, anyway...
(21:41:03) cron2: syzzer: you already reviewed it anyway, 21 Jan 2018 :-)=

(21:41:10) syzzer: oh :')
(21:41:17) syzzer: well, "done" then :p
(21:41:42) mattock: reviewed and acked?
(21:41:45) cron2: well... the submitter sent a new version...
(21:41:48) cron2: nah, asked for fixes
(21:42:12) cron2: mmmh
(21:42:18) cron2: no new version, the thread sort of died
(21:42:31) mattock: okay, that is something at least
(21:42:41) cron2: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg16021.html
(21:42:42) vpnHelper: Title: [Openvpn-devel] [PATCH 1/2] Added support fo=
r OpenSSL FIPS Object Module v2.0 validated encryption (at www.mail-archi=
ve.com)
(21:43:16) cron2: so - from a quick skim, feedback was given, and no new =
patch came forward.  But this is all I could find with "FIPS" in *my* mai=
l heap
(21:43:46) cron2: there's also https://community.openvpn.net/openvpn/tick=
et/725 but I haven't checked if there is a newer patch in there
(21:43:47) vpnHelper: Title: #725 (Consider to add FIPS support in OpenVP=
N) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:44:26) mattock: where is patch 2/2?
(21:45:32) cron2: ah, and the review got stuck anyway, syzzer's mail ends=
 with
(21:45:35) cron2: > I hope to look into this patch more, and run some tes=
t later.
(21:45:52) syzzer: yeah, just read the thing back
(21:46:50) syzzer: I kind of expected to receive a patch update with the =
discussed improvements
(21:47:16) cron2: you got an "here's two extra hunks" and a bit of discus=
sion, which then just ended :-)
(21:49:16) mattock: what if I poke the author and say please update the p=
atch and let's continue discussion?
(21:49:18) syzzer: okay, starred converstion and will look at it later
(21:49:39) syzzer: mattock1: that would work too
(21:49:43) mattock: ok
(21:49:51) cron2: mattock1: that sounds like a plan
(21:49:59) cron2: and we poke syzzer if he doesn't discuss :)
(21:50:07) mattock: ok :)
(21:51:19) mattock: anything else for today?
(21:52:55) syzzer: not from me
(21:53:23) cron2: nah... my TV is calling :-)
(21:53:29) mattock: ok
(21:53:46) mattock: that's it then, I will wrap up the summary and notify=
 the author of the VLAN patchset
(21:53:59) syzzer: great, good night!
(21:54:09) cron2: FIPS :)
(21:54:22) cron2: I hope the author of the current VLAN patchset will rea=
d the backlog on his own accord ;-)
(21:55:07) cron2: and a good night, indeed
(21:55:43) mattock: good night!
(21:57:29) ordex: sorry guys - got a situation to deal with today and tot=
ally missed the meeting
(21:57:34) ordex: :(
(21:58:12) mattock: ordex: will you be able to go through the VLAN patchs=
et tomorrow with cron2?
(21:58:19) ordex: yeah just reading the backlog
(21:58:27) ordex: I'll try to coordinate with him
(21:58:49) ordex: cron2: just ping me when you are online and getting ont=
o the patches and I'll try to schedule myself around that :D

--------------2BD786C3AE7900AC79BCD270--

--m2uQarzK65fjroYyJeVCkMXhfMgtR85ez--

--r04nlNCm1lEmqWvBXhIpRXoQTEmW5RzES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl16l9kACgkQKVhNn0CG
RXjlwQf6Aiu6tX2u3zctI4JpxMzBs2aMZxLKcgztFgh9FNTSQ1BVtWTH/vGrSJ4c
2N0jtl0kUB5OfjhQOAnEeWv/ru7FTYPg9aSrFxJCiDuJcit5sw53L5fQNY2jmhHp
YQwELVDSMvYlut4g5G08m/w6Pd1MSghI5UNFHcnUj/nOgptJJKg2zWXqKI3G076W
35TGFj12MoL48n6wRK9yjvp7GlWfAAD/J89vgDRDyqZPLNuhtBOvn/vENUNk96CW
QFK1edX3OUKPMyZgBBoSKCgIxTWBQRLnAfXVuxvVp+ZkG6X6093jU+qQS2xpd2aD
+QyNznWJL8x+CBHWfG15PIsiEA0XsQ==
=z5th
-----END PGP SIGNATURE-----

--r04nlNCm1lEmqWvBXhIpRXoQTEmW5RzES--

