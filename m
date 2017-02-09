Date: Thu, 9 Feb 2017 11:01:38 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170209030138.GD11922@...2182...>
References: <1486581944-29627-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <1486581944-29627-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make auth-nocache cooperate with
 auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Feb 08, 2017 at 02:25:44PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Keep the username even if auth-nocache is specified so that
>   any auth_token pushed by the server could be utilized

This means that even when using no auth-token the username will be cached.
Can this be a security concern? Maybe not because the username is already c=
ached
in the terminal? (Somebody had to type it)

Cheers,

--=20
Antonio Quartulli

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYm9uOAAoJEJ6F1zG2JyOsDeQP/0FlrJRfbZQa50U8SUPlGhXf
CDYR0ed8UmULDc7KnZe2qdh6fud4FfnpsPqfSPKeDDZAVc2VTBfZ0yW51IG78hSh
GjmBkxNtwHPc8h1xeWMMGYHHJfDqTxHfr2YPHkDu7YbdOJKXQPMS9Je7kf5GRBph
Necy2ZdmkUJOGaGrTFz/0Fzn9C5UTF12AcYIApaWfowLPDtYwcwvglh35l4KkuD5
z2r5fDuaDmAlPMcb1SnTNh5DciyibrfHUWDl/A4iFq8aACCn0ZHWrhoUasK+bP9C
Uez95iaLDYedsw2Sb44Vl/77ZtRPZfiC+ZyaOOABMmY911w6YtbfOK2uSWxU4Fc/
pGBDGGBVjiTCJpIIHYtSyKEHNI/aasMzYHj4D6DoRjeRbuDCWLg8sPROpAaVqQL1
XbXG202DhQ89VqSVwfDR7yGXcvA8iBK4s6Ok29lNC8ligVlmgfQqXzPhTc/3DJm5
P6/NAmmexJla/1LMfr41wnREB2Uz049USeCHF/cb21cs8vAz9qmhF4jMbn0HNbJJ
EIrmPpUd93J3eTwsqQvcncEJYtbzV7NX7kHkz8KOFeXDws8GoxUXE66YGvUCH2QH
9YIB9Vrb9rmhb9dw6pGkKwGiY3MBIp3N71zJQ7TEHmMhdDTX+Efxo2lsjbUb0Cg3
aS8LgwhsDPSZCfWklL7R
=K2mS
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

