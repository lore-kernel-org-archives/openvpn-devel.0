Date: Tue, 31 Aug 2010 18:51:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100831165110.GK10703@...1296...>
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<4C7CD670.4030706@...1147...> <4C7CDAD7.9070500@...1294...>
	<20100831113136.GJ10703@...1296...> <4C7CFD59.8080707@...1294...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqN4RWvJTb9VNux/"
Content-Disposition: inline
In-Reply-To: <4C7CFD59.8080707@...1294...>
Subject: Re: [Openvpn-devel] Netmask OpenVPN Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eike Lohmann <e.lohmann@...1294...>
Cc: openvpn-devel@lists.sourceforge.net

--tqN4RWvJTb9VNux/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 31, 2010 at 03:02:17PM +0200, Eike Lohmann wrote:
> We are also using old openvpn clients with windows, there we have to use=
=20
> /30 netmasks (4 ip's) and can only configure 4096 users.

65536 / 4 =3D 16000 :-) - a /16 pool holds 2^16 addresses, I already took
that into account when asking for the 16000 users.

> To handle the load on the machines we build a cluster with dynamic=20
> routing and yes, we are getting close to the /16 network limit.

Amazing.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tqN4RWvJTb9VNux/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH0y/qkuBuNlUUl1AQJd4AP/b+DUlO79gU5iKKDsH/DgzMeWZEkQ+5Vn
+MtTD8kpPbStd+Rgi53EgdvNn6ngOIW38/lj3jMRdxkeD+HpINy83pN1b057IL7A
LOLSFuBkVaiRStjN2I9pHCGmfp9g3XWxGi735BATOMszAANnCxPBaxqGc7smb7gA
4FlNx8ex64I=
=Kdc6
-----END PGP SIGNATURE-----

--tqN4RWvJTb9VNux/--

