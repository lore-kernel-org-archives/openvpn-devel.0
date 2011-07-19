Date: Tue, 19 Jul 2011 15:59:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110719135928.GJ8496@...1296...>
References: <4E1F78E8.4050203@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8AyhkHmF38pqBh1Q"
Content-Disposition: inline
In-Reply-To: <4E1F78E8.4050203@...515...>
Subject: Re: [Openvpn-devel] Merged TODO.IPv6 and README.IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8AyhkHmF38pqBh1Q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 14, 2011 at 04:16:56PM -0700, Samuli Sepp=E4nen wrote:
> As discussed earlier[1], Windows has trouble coping with filenames that
> are identical except for the case. Here is my proposal for merged
> .ipv6/.IPv6 files:
>=20
> <http://pastebin.com/TbSVNpYH> (TODO.IPv6)
> <http://pastebin.com/4nGzRezE> (README.IPv6)
>=20
> Shall I create a patch against the "master" branch?

Yes, please.  It's a good starting point and if it reduces the pain
for Windows builders, it's worth doing.

JJO's README.IPv6 needs to be reworked somewhat, but that is a separate
project.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8AyhkHmF38pqBh1Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTiWNwKkuBuNlUUl1AQL8LAQAkJIqmjZJh3OF92MUbs+luEESNlzFt/qY
r6Glrc5wNz6VKgFm9G4zEWgB7+FDhD+RWBcL06YXZqKH59/9LFmzL8bAPlEf/r/7
UAHsToQTT4e/0AcL0qv70kL4cPQ4LxyfNLaSMiO/RwjNK+EbbpCC1qbvr2lvJsTZ
vKSfgQOkAvg=
=ZKUO
-----END PGP SIGNATURE-----

--8AyhkHmF38pqBh1Q--

