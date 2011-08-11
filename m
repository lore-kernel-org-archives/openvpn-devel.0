Date: Thu, 11 Aug 2011 09:04:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110811070449.GG8496@...1296...>
References: <1312980908-25157-2-git-send-email-heiko.hund@...1489...>
	<1313046031-14499-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cloBtYVUdy+wc1I9"
Content-Disposition: inline
In-Reply-To: <1313046031-14499-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] define IN6_ARE_ADDR_EQUAL macro for
	WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--cloBtYVUdy+wc1I9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2011 at 07:00:31AM +0000, Heiko Hund wrote:
> +#ifdef USE_PF_INET6
> +
> +/* MSVC headers do not define this macro, so do it here */
> +#ifndef IN6_ARE_ADDR_EQUAL
> +#define IN6_ARE_ADDR_EQUAL(a,b) \
> +  (memcmp ((const void*)(a), (const void*)(b), sizeof (struct in6_addr))=
 =3D=3D 0)
> +#endif
> +
> +#endif

ACK!

(This way is easier to read).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cloBtYVUdy+wc1I9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTkN/EakuBuNlUUl1AQL0YQP8C+SMCvR9K3zooZ2oW7nSIOJN6Cmh6t9Z
3pZILPW/771LlP8xcUWKTd7Bb+LUZdUrHSTR6eIB18V98fQm9I98Kfuvu2E68wSv
cxV5u2trZ/xljZ5kqDAYDckpM7t7WuMQtgBaJezNYr+fT1hILgE0FJU01wIHJ8sW
H47NDVctn9U=
=Avuc
-----END PGP SIGNATURE-----

--cloBtYVUdy+wc1I9--

