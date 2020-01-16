From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
Message-ID: <52df2da3-eaf7-5364-510a-f7781d62ea9f@...515...>
Date: Thu, 16 Jan 2020 21:40:36 +0200
MIME-Version: 1.0
In-Reply-To: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="piRfKihByW82wFecvAexZCXOfj9Z8RKep"
Subject: [Openvpn-devel] Summary of the community meeting (16th January 2020)
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
--piRfKihByW82wFecvAexZCXOfj9Z8RKep
Content-Type: multipart/mixed; boundary="y9Bp4jvrxDEbVZxPxNbiR6wKaLoZgjL03"

--y9Bp4jvrxDEbVZxPxNbiR6wKaLoZgjL03
Content-Type: multipart/mixed;
 boundary="------------66FB6008BC01BFBF584CE64D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------66FB6008BC01BFBF584CE64D
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 16th January 2020
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-01-16>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev and mattock participated in this meeting.

---

Discussed status of OpenVPN 2.5 and tomorrow's mini-hackathon:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

Agreed that we should have easy-rsa 3 in the OpenVPN 2.5 Windows MSI
installers. We probably had made this decision earlier as well.

Lev and rozmansi have been working on the wintun patches. Lev will
review the latest of rozmansi's patches tomorrow.

Mattock has a new buildslave that he will configure to build Windows
installers with openvpn-build in tomorrow's hackathon. Buildmaster will
need some restarts in the process. Later Debian/Ubuntu package building
can be added to buildbot as well.

Cron2 will merge what has already been ACKed tomorrow and will do some
other stuff as well.

Dazo has lots of deadlines at the moment but will do his best to
allocate time for the mini-hackathon.

Noted that two of plaisthos' patchsets require review: "2FA thing" and
async-cc. Also noted that the struct argv stuff could be reviewed by anyone.

--

Full chatlog attached

--------------66FB6008BC01BFBF584CE64D
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-01-16.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-01-16.txt"

(20:59:29) lev__: hello
(21:00:09) dazo: hey!
(21:00:18) mattock: hello!
(21:01:46) lev__: guten aben
(21:02:03) lev__: *d
(21:02:20) mattock: anyone else here?
(21:03:15) dazo: hmm
(21:03:26) cron2: oh, meeting time
(21:03:31) mattock: yep!
(21:03:49) cron2: *and* people here :)
(21:04:04) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-01-16
(21:04:06) vpnHelper: Title: Topics-2020-01-16 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:04:13) mattock: anything to add to the topic list?
(21:04:20) mattock: #1 is probably enough though :D
(21:05:20) lev__: me and Simon are reviewing each other's wintun patches,=
 mostly prettifying code
(21:06:04) mattock: I've setup a new buildslave which will soon start bui=
lding stuff with openvpn-build
(21:06:48) mattock: it won't build any of the normal stuff, just run open=
vpn-build on each commit
(21:07:08) mattock: should be fairly straightforward
(21:07:10) cron2: nice
(21:07:33) lev__: speaking of 2.5, shall we switch to easyrsa3 in new msi=
 installer?
(21:07:34) mattock: I'd _like_ to also automate creation of Debian/Ubuntu=
 packages but that is slightly more involved
(21:07:50) mattock: lev: that would probably make sense
(21:07:57) mattock: not sure if we actually decided to do that or not
(21:08:53) mattock: also, as the MSI installer is still work in progress =
(afaik) there's little point in adding easy-rsa 2 to it
(21:09:01) mattock: why not just go directly to easy-rsa 3 that is
(21:09:48) cron2: lev__: I've seen ACKs, will go merge tomorrow
(21:10:39) dazo ha scelto come argomento: Next meeting 22/Jan/2020 at 11:=
30 CET.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2020=
-01-22
(21:11:39) dazo: I think the easyrsa3 move was depending on some easyrsa-=
2 support ... so you could use existing easyrsa-2 or upgrade it to easyrs=
a-3
(21:11:51) dazo: ecrist should know, I think
(21:12:18) dazo: if that's already resolved (agreed, fixed, whatever), th=
en all is fine to ship easyrsa 3
(21:12:29) cron2: I would say "ship easyrsa-3 and have a note in the READ=
ME displayed at install time what to do when you have easyrsa 2 in active=
 use"
(21:12:40) mattock: +1
(21:12:49) cron2: or better, make it a seamless replacement :)
(21:13:04) dazo: yeah, I think they were working the seamless approach :)=

(21:16:54) mattock: ok, easy-rsa done
(21:17:15) mattock: more on 2.5 that needs coordination/updates?
(21:18:08) cron2: "get work done" :)
(21:18:32) mattock: :D
(21:18:39) dazo: :)
(21:18:54) mattock: speaking of which
(21:18:58) mattock: tomorrow's mini-hackathon
(21:19:05) cron2: yes!#
(21:19:05) mattock: who will join? what shall we do there?
(21:19:23) cron2: I'll merge what is ACKed and have a look at other stuff=

(21:19:51) mattock: I will try to get openvpn-build running via buildbot
(21:21:19) cron2: dazo?
(21:21:21) dazo: Core team is pretty much loaded these days (lots of rele=
ases we're involved in + preparations for a bigger launch of a new servic=
e) ... but I'll try to see what we can manage.  ordex is also pretty much=
 tied up with the kernel module work, so I don't want him to loose that f=
ocus anytime soon (where openvpn 2.x support is planned too)
(21:21:44) lev__: I'll review latest patch(es) from rozmansi
(21:23:04) dazo: I have a couple of releases I'll try to complete today, =
then I have more time for stuff tomorrow ... but due to unexpected things=
 I'm involved in on the personal side, I soon need to schedule sleep in m=
y calendar too :-/
(21:24:15) dazo: and everything I'm involved in now needs to be done and =
signed off between end of January and mid-February
(21:24:48) cron2: that very much sounds like "postpone code-freeze to end=
 of february"
(21:25:22) cron2: can we make things happen until then?  We need time fro=
m ordex, plaisthos, dazo who all got sucked into corp... :)
(21:26:48) cron2: (an open source project is what is, and if life or paid=
 work gets in the way, this is what it is.  It is good when people *know*=
 why "people are not active", so we can adjust)
(21:26:53) dazo: I believe plaisthos would have some time to do some comm=
unity stuff, ordex I really want to have a chance to get the kernel modul=
e moving forward ... and I'll do my best.  Right now there's only one pat=
ch-set from plaisthos missing review, I believe
(21:27:14) cron2: two, the 2FA thing and the async-cc set
(21:27:45) dazo: the async-cc has had some internal discussions, iirc ...=
 awaiting a few clarifications or patch updates
(21:28:18) cron2: if it's all done and just need to hit the list, perfect=
 :-) (but then, it should eventually do exactly this ;-) )
(21:28:37) dazo: I think we can manage, if not end of January at least be=
ginning of February .... I'm not too keen on loosing the pressure on Open=
VPN 2.5 just because of corp side things.  But not having a hard expectat=
ion helps a bit on the mental side of things
(21:29:27) cron2: good :)
(21:29:28) dazo: There's also the struct argv stuff ... but that anyone c=
an review
(21:29:43) cron2: plaisthos wanted that, but you kept him busy
(21:29:58) cron2: (and I offered to review, and my datacenter move kept m=
e busy...)
(21:30:01) dazo: hehe ... yeah
(21:30:03) cron2: always someone to blame
(21:30:19) dazo: unfortunately=20
(21:30:33) cron2: see !blame next door :)
(21:30:42) dazo: hehehe
(21:32:21) mattock: ok, blaming done, what next :D
(21:34:50) mattock: anything or just get some sleep so that tomorrow's mi=
ni-hackathon becomes overwhelmingly successful?
(21:35:08) cron2: sleep sounds great
(21:35:20) mattock: all agree?
(21:36:29) cron2: all asleep already :)
(21:36:58) dazo: hehe
(21:37:01) mattock: excellent! then they will have more energy tomorrow! =
:D
(21:37:10) mattock: ok, if there's nothing else I'm ready to send the sum=
mary
(21:37:22) dazo: need to get two releases out the door first ... *then* s=
leep :)

--------------66FB6008BC01BFBF584CE64D--

--y9Bp4jvrxDEbVZxPxNbiR6wKaLoZgjL03--

--piRfKihByW82wFecvAexZCXOfj9Z8RKep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl4gvDQACgkQKVhNn0CG
RXj4MggAkFmomRfBw0tXhy7yzBWhD784+yYmZTOAOyNvxEbWix+1bLpzm4nOzwOQ
3qq+39FNik60HNGeUibWG+yBRVGMG9QZGW5JhgeLPqZgiOWKtIii0ejJ5PRWJVTN
0T1LyG5gfIleOKeMM+riaiqXLhp7IFO5SMtm9SlnyaqjkiGOaxHP6Ia/CXmBMrnS
axTB8NDIE+Y815JT1u+ix/GqM2oMjMjQ/oBGxB+v9Q1MAvwkIMQcP9nIkI8V+QzJ
Qi67pbgGLGIsZOrtW7V5s5ubsc+JGSKiBG47l9Bx+AcfE85cud5u90jIdaIp1SyL
vYFjy94+rupFxTsPfNo40K5p16ZYYQ==
=3hHU
-----END PGP SIGNATURE-----

--piRfKihByW82wFecvAexZCXOfj9Z8RKep--

