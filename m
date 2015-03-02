Date: Mon, 2 Mar 2015 21:07:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150302200743.GH21893@...1296...>
References: <54F4BFE0.1000904@...1490...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <54F4BFE0.1000904@...1490...>
Subject: Re: [Openvpn-devel] server support for UV_ variables still not
	present in 2.3.6?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>
Cc: openvpn-devel@lists.sourceforge.net

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 03, 2015 at 08:54:08AM +1300, Jason Haar wrote:
> Back in Aug 2014, I needed the server to support exporting the UV_*
> variables the client sets into external programs the server calls on
> client-connect, so was told to try out openvpn-2.3_git - which had that
> missing code. So I did a clone of that and off I went
>=20
> I've been happily running on that for some time now - but just tried out
> 2.3.6 - and discovered that support still wasn't in there!
>=20
> Was it dropped for some reason, or was/is 2.3_git not a true
> representation of what ended up in the official 2.3 series? The missing
> code was in src/openvpn/misc.c

2.3_git is a bit misleading, this is what will be 2.*4* - it was forked
off 2.3.0, and after that, 2.3.x only got bugfixes and "long term=20
compatibility / stability" changes, while git master =3D 2.3_git got the
big new features.

This one in particular sounds harmless but the actual code change is=20
fairly invasive so we decided that it does not belong into 2.3.x (the
client side improvements, like IV_SSL_VERSION or whatever it's called,
went into 2.3.x :-)).

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVPTDDqkuBuNlUUl1AQJubgP/Spve+fUtKMT5NXsD7XcDTq9AgkUjA2pL
8QompSLFiSqigy9umjrfhL0c89ZNtX7Qu/VjawKXwxJTlcFVJEEiYHmfagxQPZ9h
J6WsHaIlsndyrapSzAlGg4iiO8HTdueJLV13gqPsOqiWPsHM8opzzEVM6wKXfY6D
j/pAOSJhPMk=
=fFW7
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

