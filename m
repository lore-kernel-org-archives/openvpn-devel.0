From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <3f14bd18-10f2-7783-7060-301a54f5c5ff@...515...>
Message-ID: <40c727e1-4d64-0d34-9386-b593f2bf3980@...515...>
Date: Thu, 21 Nov 2019 21:34:20 +0200
MIME-Version: 1.0
In-Reply-To: <3f14bd18-10f2-7783-7060-301a54f5c5ff@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6SNjAzCvbFAa2Hs0aLaAOFS29o4FSShcr"
Subject: [Openvpn-devel] Summary of the community meeting (21st November
 2019)
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
--6SNjAzCvbFAa2Hs0aLaAOFS29o4FSShcr
Content-Type: multipart/mixed; boundary="q5RH0frgIdf7mSF6oifZK7ScljfqGYcGF"

--q5RH0frgIdf7mSF6oifZK7ScljfqGYcGF
Content-Type: multipart/mixed;
 boundary="------------D6B380F67E6D259478ACE9D0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D6B380F67E6D259478ACE9D0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 21st November 2019
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-11-21>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock and ordex participated in this meeting.

---

Tomorrow mattock will resume work on "trying to make the Windows 10
ARM64 laptop connected to the VPN server at all times". The Powershell
script that does it (plus Puppet scheduled task glue) was finished and
tested during the hackathon.

---

Ordex resumed his async-cc patch review this week. He wants to get it
off his plate before it starts needing rebase again.

---

Cron2 would love if syzzer would find time to do the review of the v5
patch. He has had prior exposure.

--

Full chatlog attached

--------------D6B380F67E6D259478ACE9D0
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-11-21.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-11-21.txt"

(21:00:48) mattock: hello
(21:03:08) cron2: hollo
(21:04:47) mattock: anybody else here?
(21:06:13) cron2: lots of folks idling in here...
(21:06:27) cron2: dazo, syzzer, ordex, plaistos: hello, good morning, how=
 are you? *sing*
(21:08:09) ordex: unz unz
(21:08:18) mattock: oh we have somebody else! \o/
(21:08:20) cron2: ah, the rythm appears
(21:08:27) ordex: anything to talk about? o-o
(21:08:46) cron2: 2.5 plannings?  or patch review? :-)
(21:09:13) mattock: I can tell that I will resume work on the "keep ARM64=
 laptop connected" task tomorrow
(21:09:18) cron2: there has been lots of activity around the wintun patch=
 set... one is cleanup (and I'll tackle that tomorrow) but for the rest I=
'm hoping for syzzer
(21:09:26) cron2: mattock1: so what happened to it, when it decided to di=
e?
(21:13:00) mattock: cron2: did not check yet, but it seemed to be "alive"=
 at least
(21:13:12) mattock: probably the VPN connection just died (e.g. reboot) a=
nd for some reason did not come up
(21:13:24) cron2: yeah, win10 likes reboots...
(21:13:56) mattock: but I finished the monitoring/recovery powershell scr=
ipt during the hackathon so I can just make that run there and test reboo=
ts etc.
(21:14:08) mattock: so, soonish, lev will get his arm64 test rig
(21:14:14) cron2: nice
(21:14:25) ordex: cool
(21:15:00) cron2: ordex: how's your time planning wrt async-cc review?  b=
usy with that other secret project?
(21:15:30) cron2: (or still recovering from the invasion of too many hair=
y geeks into peaceful trento? :) )
(21:19:14) ordex: cron2: no, that's the current thing on my list
(21:19:20) ordex: re-started that this week
(21:19:22) cron2: recovering?
(21:19:27) ordex: haha
(21:19:30) ordex: no, the review
(21:19:32) ordex: :p
(21:19:41) cron2: how's the secret project going on?
(21:20:15) cron2: but async-cc review is certainly welcome
(21:20:40) ordex: yeah, better shoot that down as soon as possible
(21:20:49) ordex: otherwise it will just idle in the todo list over and o=
ver..
(21:21:01) ordex: i really want to get over it
(21:21:03) cron2: and age, and require rebase, and break, ... :))
(21:21:08) ordex: yes
(21:21:09) ordex: :D
(21:21:21) ordex: plaisthos already rebased that recently (after a poke)
(21:21:26) cron2: ah, good
(21:21:31) ordex: so it is up to date at the moment
(21:25:52) mattock: mkay
(21:28:52) mattock: anything else?
(21:29:13) cron2: I have nothing in particular.  Will look a few hours at=
 the explosion in my mailbox and patchwork.
(21:29:30) mattock: sarcasm at work
(21:29:43) cron2: I'd really really love if syzzer would find time to do =
the review of the v5 patch... "prior exposure"
(21:30:03) cron2: well, that was "tomorrow, I'll look..." :-)
(21:30:06) mattock: syzzer: "You're our only hope" ^^^
(21:31:00) mattock: now, if there is nothing else, let's end this thing
(21:31:43) cron2: good night :-)
(21:31:53) mattock: likevise!
(21:31:55) cron2: next week wednesday, with hopefully lots of motivated w=
orking folks around
(21:31:58) mattock: yes!
(21:32:14) mattock: and an ARM64 laptop that refuses to stay offline!
(21:32:28) mattock: and is always available, despite microsoft update and=
 all that
(21:32:30) mattock: :D

--------------D6B380F67E6D259478ACE9D0--

--q5RH0frgIdf7mSF6oifZK7ScljfqGYcGF--

--6SNjAzCvbFAa2Hs0aLaAOFS29o4FSShcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl3W5rwACgkQKVhNn0CG
RXjK7gf+Pl/TeIZT/0o3p6ChWgb5fDC/DcxQxvQzsv9KTbt5XDon1TsXj3MNJZ9D
995x3vt/DJq1b+fssJOBKWOC+D81FFxpTaWv/uIHmy65ChAOMMHK2+KhbsMAMLc6
vaOJsGL8QSeI16R4C8yuDlfY7nqeck/sUj5c8nfiZuWcTElLVpGjsGa/aDrjedHD
Rfs7oseXXYYHoXmpeKnGfMf3OEkrL4YzKKNVfVDJ4aF5EPXl0EgJMfj3NXHwkUrc
S96FiFg9h7eZXc2AgaIkDVh6gQaIzV6z5MyXHbDMOMEaSFzRKgHa3P81zty6ptHe
HhtCgsBfMQCzvY1VNFaYT+lEqjyKDw==
=A/8p
-----END PGP SIGNATURE-----

--6SNjAzCvbFAa2Hs0aLaAOFS29o4FSShcr--

