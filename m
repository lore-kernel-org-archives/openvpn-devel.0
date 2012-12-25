Date: Tue, 25 Dec 2012 11:51:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121225105104.GR22465@...1296...>
References: <50D6F4EA.6050504@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QPUCuZQBccTQvBgW"
Content-Disposition: inline
In-Reply-To: <50D6F4EA.6050504@...1227...>
Subject: Re: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--QPUCuZQBccTQvBgW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 23, 2012 at 01:11:22PM +0100, Arne Schwabe wrote:
> I fear we may have to delay the final release. While debugging a problem=
=20
> with a user of my app I found a nasty bug which causes OpenVPN to crash=20
> if two PUSH_CONTROL messages are received.
>=20
> from push.c:
>=20
>        if (!c->c2.did_pre_pull_restore)
>          {
>            pre_pull_restore (&c->options);
>            md5_state_init (&c->c2.pulled_options_state);
>            c->c2.did_pre_pull_restore =3D true;
>          }
>=20
> This is executed on the first push message and initializes the md5=20
> state. On further push messages (continuation or new) this is not=20
> executed again.

Indeed, this is coupling two things - "pre-pull options saving" (to
restore to the state before pulling, which only ever needs to be executed
once), and "md5 state init", which needs to be executed for every round
of PUSH_REPLY...

Assuming there is only one PUSH_REPLY ever, this is no problem, but with
the new server side code plus mobile networks, this can indeed be triggered.

I'd propose to fix this by adding "bool c->c2.pulled_options_md5_init",
using that for md5_state_init() *and resetting it* after md5_state_final().

For a single PUSH_REPLY, this should not make a difference (except for=20
a few bytes of code), and for multiple PUSH_REPLY messages this will
re-init the md5_state properly.

(I'll send a patch as soon as I can test this - Arne, could you send me
login credentials + config for your "will crash client!" server, please?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QPUCuZQBccTQvBgW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUNmFGKkuBuNlUUl1AQKLlAQAiKnbvde+IgcUIGlW6aroIottMl7qIdiI
7j7m6l2ZDtGRcbB8Jz2EOxlWF/SKQkILt6j33eH2UsydxizGrdqvfRaqfM7NvIQ5
QHCoFIzUkILV5FQaUyi6KxWue/Fbl29AbbMIFC1WtEken4/LFRLrOErIv2S0s5Ei
KybLUmy/Xkk=
=Lw2/
-----END PGP SIGNATURE-----

--QPUCuZQBccTQvBgW--

