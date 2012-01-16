Date: Mon, 16 Jan 2012 12:06:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120116110626.GU5060@...1296...>
References: <1326709901-16246-1-git-send-email-davids@...1347...>
	<1326711858-18337-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oHxSCaSS3y4TqjY8"
Content-Disposition: inline
In-Reply-To: <1326711858-18337-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Don't check for file presence on
	inline files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: dazo@...1345..., openvpn-devel@lists.sourceforge.net

--oHxSCaSS3y4TqjY8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 16, 2012 at 12:04:18PM +0100, David Sommerseth wrote:
> The configuration file supports inline files for --ca, --cert, --dh,
> --extra-certs, --key, --pkcs12, --secret and --tls-auth.  When this
> is used, the filename is set to [[INLINE]] (defined by INLINE_FILE_TAG).
>=20
> If the filename is set to INLINE_FILE_TAG for these options, don't
> call check_file_access().
>=20
> [v2 Simplify the code, using a flag to check_file_access()]

ACK!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oHxSCaSS3y4TqjY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTxQEsqkuBuNlUUl1AQIP8QQAh9Pys4XD7LGHfsLz4rObK1X+/nOFSsI/
eklcVHj4JzcU0RsSYkak1ypWYoX8i4TjmaKmJwXsTCHvv5VE/6QXv9goBTu7fS4H
e+omOl7QDyLNpzHgHsfXRiBLC4w07K3qU33LEJ6g1JjoSQKiBVHZ/QOyogmLHUK8
1oRVyvKrsWA=
=6zU4
-----END PGP SIGNATURE-----

--oHxSCaSS3y4TqjY8--

