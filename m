From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
Message-ID: <9e6ef98c-0125-4660-d598-a9da0ceac663@...515...>
Date: Wed, 8 Jan 2020 13:26:50 +0200
MIME-Version: 1.0
In-Reply-To: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0g4DmINJwR4MMOGtDaUyEXc4QlBbS9JPP"
Subject: [Openvpn-devel] Summary of the community meeting (8th Jan 2020)
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
--0g4DmINJwR4MMOGtDaUyEXc4QlBbS9JPP
Content-Type: multipart/mixed; boundary="EmkQTquFBvgt6z4jo1VGXs3qoqVHyPqK9"

--EmkQTquFBvgt6z4jo1VGXs3qoqVHyPqK9
Content-Type: multipart/mixed;
 boundary="------------4A873DC6F585CE8A3F6D70D2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4A873DC6F585CE8A3F6D70D2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 8th January 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-01-08>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock, plaisthos and rozmansi participated in this meeting.

---

Discussed status of OpenVPN 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

Identified the missing parts and their current owners:

win buildslave: mattock
wintun:         rozmansi, lev, mattock
do NCP right:   syzzer, cron
2FA patch set:  dazo, plaisthos
async-cc:       ordex, plaisthos
ipv6-only:      cron
argv:           plaisthos
msi:            rozmansi, mattock

Mattock decided to put the Windows buildslave on the top of his queue.

Agreed that with the current level of involvement there is no way we can
make the January 31st 2020 deadline. Decided to try to get dazo more
actively involved in 2.5 release process - he can then pull the strings
to get OpenVPN 3 core team involved in completing the remaining pieces
of 2.5.

--

Full chatlog attached

--------------4A873DC6F585CE8A3F6D70D2
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-01-08.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-01-08.txt"

(12:33:41) mattock: howdy
(12:37:13) mattock: quiet today?
(12:37:22) rozmansi: cron2: I have a v3 version of https://patchwork.open=
vpn.net/patch/960/, but forgot to send it...
(12:37:24) cron2: you joined late :)
(12:38:08) cron2: rozmansi: please re-send so lev__ can ACK :)
(12:38:10) mattock: hi guys!
(12:38:36) rozmansi: hi
(12:39:20) cron2: everyone else still on vacation?
(12:39:31) mattock: don't know
(12:39:44) mattock: dazo does not seem to be as he's been sending interna=
l emails
(12:40:08) cron2: I've seen plaisthos in #openvpn-devel yesterday
(12:42:07) mattock: I've actually been sick for a week and doing only the=
 bare minimum amount of work I have to
(12:42:17) mattock: throat infection if you're wondering
(12:42:38) mattock: the current horse medicine seems to be working throug=
h, which is very nice
(12:43:19) cron2: eww...=20
(12:44:54) mattock: anyways, so what are the blockers for 2.5 now?
(12:45:05) mattock: "where are we at?"
(12:45:15) cron2: nothing has happened since last meeting
(12:45:49) mattock: let me poke at dazo et al internally and see if he co=
uld join
(12:46:31) mattock: done
(12:47:17) cron2: async-cc, msi, wintun, ipv6-only, argv, ...
(12:47:51) mattock: ordex was active about an hour ago
(12:47:57) mattock: no other discussion from the other guys
(12:51:09) mattock: who is responsible for what? if nobody else appears s=
oon the best we can do is compile as list of "who should do what" and sta=
rt putting some pressure on people :)
(12:51:13) lev__: hello
(12:51:22) mattock: hi lev!
(12:51:25) cron2: hi lev
(12:51:29) rozmansi: hi
(12:51:36) mattock: good to have at least one from the openvpn3 team here=
 :)
(12:51:37) cron2: msi is on rozmansi and mattock, it seems :-)
(12:51:42) lev__: yes, please send V3 and I'll ack it
(12:51:49) cron2: wintun is on lev and rozmansi
(12:51:54) plaisthos: mattock: get well soon
(12:51:55) rozmansi: msi is on me
(12:52:02) cron2: windows buildslave / snapshot builder is on mattock
(12:52:09) lev__: also maybe rozmansi can look at https://patchwork.openv=
pn.net/patch/946/
(12:52:10) vpnHelper: Title: [Openvpn-devel] options.c: do not force rout=
e delay when not using DHCP - Patchwork (at patchwork.openvpn.net)
(12:52:12) mattock: plaishos: I'm doing my best :)
(12:52:17) plaisthos: argv review is on me
(12:52:52) mattock: cron2: yep, that is high up my queue - actually I cou=
ld put it on the top now, just finished something else
(12:52:53) cron2: the "do NCP right" stuff is not on the list, but needs =
to go in - syzzer/dazo/me?
(12:53:35) plaisthos: syzzer reviewed the first patch of the series and t=
hat got almost an ACK
(12:53:48) cron2: saw that :)
(12:54:34) cron2: ISTR the "2FA patch set" is on dazo
(12:55:18) plaisthos: the ncp v2 sounds  like crypto but is actually not =
:D
(12:55:27) plaisthos: it is more comparing lists etc.
(12:55:46) cron2: I can certainly have a look on that
(12:56:18) plaisthos: okay 4/4 is a bit crypto related (normalising of ci=
pher names)
(12:57:02) cron2: "two step authentication methods" is the name of the pa=
tchset
(12:57:27) cron2: v1 is on the list, and dazo&plaisthos agreed to work on=
 a v2 that is "ready for merge", if I recall...
(12:57:57) cron2: given work load, I assume it's sitting on dazo's queue
(13:04:35) mattock: async-cc, ipv6-only, argv?
(13:05:04) cron2: ipv6-only is on me, argv is on plaisthos ("he just said=
 so"), async-cc on plaisthos+ordex
(13:05:41) mattock: ok, so here's the current list - looks good?
(13:05:47) mattock: win buildslave: mattock
(13:05:47) mattock: wintun:         rozmansi, lev, mattock
(13:05:47) mattock: do NCP right:   syzzer=09
(13:05:47) mattock: 2FA patch set:  dazo, plaisthos
(13:05:47) mattock: async-cc:       ordex, plaisthos
(13:05:47) mattock: ipv6-only:      cron
(13:05:47) mattock: argv:           plaisthos
(13:06:11) rozmansi: msi: rozmansi
(13:06:20) cron2: put my name on "do NCP right" as well, if that's only v=
ery little crypto I'm fine iwth it
(13:06:33) cron2: (haven't even looked yet, though, too busy with christm=
as + family + ...)
(13:06:35) mattock: oh yes, that was missing
(13:07:08) mattock: did those fixes
(13:07:39) mattock: I will put my name to msi as well as I can't get off =
the hook completely anyways
(13:08:00) cron2: yeah :)
(13:08:18) mattock: building the official installers etc...
(13:08:47) mattock: so, how do we make the deadline?
(13:09:03) cron2: with the current engagement?  "no way"
(13:09:08) mattock: that is my feeling as well
(13:09:26) mattock: mandatory mini-hackathons twice a week?
(13:09:42) mattock: or deadlines for each of these tasks
(13:10:07) mattock: we don't want this release to drag on for weeks or mo=
nths
(13:10:16) cron2: it would be good to have dazo around, as half of the im=
possibilities here depend on openvpn inc scheduling
(13:10:31) mattock: yeah
(13:11:29) mattock: yep, and dazo can best coordinate 2.5 work with"openv=
pninc work" the best
(13:12:02) mattock: I'll poke him personally
(13:14:21) mattock: ok done
(13:14:40) mattock: I think he's away from the keyboard now, but he'll su=
rely get back to me
(13:14:51) mattock: anything else we should or can cover today?
(13:15:08) cron2: I think we're good for today... (and I need to quit any=
way)
(13:15:16) mattock: ok
(13:15:22) rozmansi: ok
(13:15:33) mattock: I will send the summary when my email starts working
(13:15:46) mattock: rackspace imap servers are misbehaving, but perhaps S=
MTP still works...
(13:15:53) cron2: broken throat, broken e-mail, broken windows buildslave=
, ... :-)
(13:15:57) mattock: lol yes!
(13:16:04) mattock: I can like with the latter two :D
(13:16:08) cron2: someone is trying to silence you :)
(13:16:13) cron2: anyway, get well soon!
(13:16:17) mattock: they have to cut off my fingers to do that :D
(13:16:19) mattock: thanks!
(13:16:30) mattock: so it must be a finger infection next!

--------------4A873DC6F585CE8A3F6D70D2--

--EmkQTquFBvgt6z4jo1VGXs3qoqVHyPqK9--

--0g4DmINJwR4MMOGtDaUyEXc4QlBbS9JPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl4VvHoACgkQKVhNn0CG
RXik7AgAi5WKUBCfLyfOfI3yVlCh0sef2svbdjr6arHpCWoX9ZotavWAXbb2aKhe
zBCNKQbPSACGZDhwmXMLMxVjosEsiWXBqp65b+V1T7niDfF+6ON2WdSNWR9Y7vbO
wslNAyFAkI7013BTMA8L34eOkuSLfAp6JMOOcJU9aH1PEjc2T2tzf8FvyFpDRnpW
ul/gwdK3CBSeV4c2w8xkmsh7sBmuUSU0qrtLXaNHQ8d6hXmNenbqUCH7Vanqqs+f
Y9k4R5ktSjF7QNcS/Pgn8bZLcXFDzxuVLs1bbvyugR0N3pr5xJKZvYgYTf8eiClD
XfWbUEgaO0GotKsqv5+mETx2DqV1NA==
=XkyA
-----END PGP SIGNATURE-----

--0g4DmINJwR4MMOGtDaUyEXc4QlBbS9JPP--

