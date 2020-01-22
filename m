From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
Message-ID: <414ee8a3-2634-4699-5351-d9a00b862485@...515...>
Date: Wed, 22 Jan 2020 13:08:08 +0200
MIME-Version: 1.0
In-Reply-To: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ZvODaLFgEOXebtZpgPKcG0VnmvGV4Rdw"
Subject: [Openvpn-devel] Summary of the community meeting (22nd January 2020)
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
--7ZvODaLFgEOXebtZpgPKcG0VnmvGV4Rdw
Content-Type: multipart/mixed; boundary="vQbdM1XaA4oHR4mTTN6xaH5EUOcsfNBOM"

--vQbdM1XaA4oHR4mTTN6xaH5EUOcsfNBOM
Content-Type: multipart/mixed;
 boundary="------------2C8F5F8427E9111E1425621B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2C8F5F8427E9111E1425621B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 22nd January 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-01-22>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2 and mattock participated in this meeting.

---

Noted that the new openvpn-build buildslave is now building Windows
installers on every commit and publishing them here:

<https://build.openvpn.net/downloads/snapshots/>

The branch name is included in the installer names now.

--

Cron2 has merged work from lev/simon and tried his luck with the argv
patch set but noticed a conflict with lev/simon's tun.c work). The rest
of the patches are waiting for dazo, plaisthos and ordex.

--

Full chatlog attached

--------------2C8F5F8427E9111E1425621B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-01-22.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-01-22.txt"

(12:38:29) mattock: hello
(12:38:54) cron2: hello.  I did make it \o/ :)
(12:42:19) mattock: did anyone else make it?
(12:42:21) mattock: :P
(12:42:37) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(12:43:34) mattock: let's wait for a while and see if somebody appears
(12:46:52) cron2: mattock2 got lost
(12:47:17) cron2: I've already seen half of the good news - the windows-b=
uildslave is back, and does uploads \o/
(12:47:59) mattock: yes, it is now building and hopefully the installer n=
ame will include the branch name
(12:48:43) mattock: so we'd get "feature installers" as well
(12:49:10) mattock: anyways, it looks like its just the two of us
(12:49:18) mattock: shall we skip this meeting?
(12:50:17) cron2: we made 1/3rd already :)
(12:50:57) cron2: but anyway... not much to report from my side either...=
 merged lev/simon so far, tried my luck with the argv patch set (conflict=
 with lev/simon's tun.c work), waiting for dazo...
(12:51:08) cron2: and for the rest, waiting for dazo, plaisthos, ordex :(=

(12:51:16) mattock: ok
(12:51:42) cron2: (and gentoo folks are having fun with mbedtls version.h=
 f*ups... :-) - https://bugs.gentoo.org/show_bug.cgi?id=3D705864
(12:51:45) vpnHelper: Title: 705864 net-libs/mbedtls-2.19.1 installs mbed=
tls/version.h which claims 2.17.0 (at bugs.gentoo.org)
(12:53:49) mattock: uh, interesting
(12:54:27) cron2: spent quite a bit of time on this, trying to figure out=
 why my gentoo builds broke in such weird ways..
(12:56:23) mattock: do they just bundle a wrong header file?
(12:57:12) cron2: mbedtls*.tar.gz needs a second package mbedcrypto*.tar.=
gz nowadays, and the second one *also* packs an mbedtls/version.h, which =
- for mbedcrypto 2.0.0 - claims "mbedtls 2.17.0"
(12:57:26) cron2: mbedcrypto should not bundle mbedtls-version-claiming t=
hings
(12:57:29) mattock: ok
(12:57:34) cron2: or it should fail building if incompatible
(12:57:36) cron2: or whatever
(12:58:37) mattock: anyhow, I'll summarize this very brief discussion if =
there's nothing else we think is worth mentioning
(12:58:58) cron2: nothing here, except some amount of loneliness
(13:00:48) mattock: ok, summary shall be sent soon

--------------2C8F5F8427E9111E1425621B--

--vQbdM1XaA4oHR4mTTN6xaH5EUOcsfNBOM--

--7ZvODaLFgEOXebtZpgPKcG0VnmvGV4Rdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl4oLRgACgkQKVhNn0CG
RXhnAQf+Lbuf3g5SXmws9htVA97CA3UD10CvsI9l4+25czHEWXrSwNF27HVplyAP
vxY716hHuD1OnI12/mvG6TUMznb9MsBITbzBrcgDIZAxqUq4p735c09d1fDDhXv2
6UQQMzQNg9S49buI0SZV/s8X+V+Mjzx9LUt/iGlQGSMU2rpm910FU1zAO54/GQSz
4QHZt5mOnSAydZYwGMEBXDs/F+lf3dhsjO1AnUN8BllmJdDD1zajO/tRhWC8P9X5
xET2cR0vxzJ6yvpNFunIV+LMBktd3AjE97SQVfh/SvDrDt+0Wy+xlcggjFeAgBRt
BjrjHh/gA7G0C3+sjwW5mQSdwrE7GA==
=Vcuh
-----END PGP SIGNATURE-----

--7ZvODaLFgEOXebtZpgPKcG0VnmvGV4Rdw--

