Date: Thu, 14 Aug 2014 10:07:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140814080720.GO1118@...1296...>
References: <CAGyAFMVnFsowuvJayx5sSv6-XzTTWWfBP4Wv4e8aMNbP9yPrkQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UvpYTYiEf4v7Dcv"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVnFsowuvJayx5sSv6-XzTTWWfBP4Wv4e8aMNbP9yPrkQ@...278...>
Subject: Re: [Openvpn-devel] Possible memory leaks found by Coverity
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--9UvpYTYiEf4v7Dcv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 14, 2014 at 08:00:38AM +0000, Lev Stipakov wrote:
> I have analyzed OpenVPN code with Coverity and I could not explain
> some resource leaks Coverity has found.
>=20
> 1) https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/options.c#L=
4378
>=20
> char * ipv6_local;
> VERIFY_PERMISSION (OPT_P_UP);
> if ( get_ipv6_addr( p[1], NULL, &netbits, &ipv6_local, msglevel ) &&
> ipv6_addr_safe( p[2] ) ) {
>   if ( netbits < 64 || netbits > 124 ) {
>     msg( msglevel, "ifconfig-ipv6: /netbits must be between 64 and
> 124, not '/%d'", netbits );
>     goto err;
>   }
>=20
> Coverity claims that "err" branch leaks "ipv6_local". I looked into
> "get_ipv6_addr" implementation and noticed that it does not pass any
> "gc" to subsequent string_alloc call. To my understanding, in this
> case caller is responsible for cleaning up, which is not the case for
> "err" branch.

This might well be true, but since "err" leads to "program ends, resources
reclaimed" under most conditions, it's not a fairly serious leak...  I'll
still put it on my list for fixing.


> 2) https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/proxy.c#L863
>=20
> char *pa =3D NULL;
> const int method =3D get_proxy_authenticate(sd, p->options.timeout, &pa,
> NULL, signal_received);
> if (method !=3D HTTP_AUTH_NONE) {
>   if (pa)
>     msg (D_PROXY, "HTTP proxy authenticate '%s'", pa);
>     if (p->options.auth_retry =3D=3D PAR_NCT && method =3D=3D HTTP_AUTH_B=
ASIC) {
>       msg (D_PROXY, "HTTP proxy: support for basic auth and other
> cleartext proxy auth methods is disabled");
>       goto error;
>     }
>=20
> Coverity claims that "error" branch leaks "pa". Same pattern as above,
> "get_proxy_authenticate" passes NULL (4th parameter) as "gc" to
> "string_alloc".
>=20
> Do those issues look like problems? Does it make sense to submit a
> patch fixing those?

Again, I don't think it's a serious issue - but still, not having leaks
is good practice, so a patch adding the appropriate free() calls would
be welcome :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9UvpYTYiEf4v7Dcv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU+xuOKkuBuNlUUl1AQLL5QQAuaIx5IPu0TBp6zn0/besXIFzFXzPjhS0
8tOxMXuBp6qXWTxsbkNXc24YdNADZ9Ok+2zUNhZL2NkEbMPXSIfgxvT2aD2oLJr8
qYvUPnRvjrcLzYPTjpntWWCEqpuALTxhG3FANuHPAGe/x7ZYm8uDFBv4qV1lS42G
ZLm/mUJcbf8=
=7Cil
-----END PGP SIGNATURE-----

--9UvpYTYiEf4v7Dcv--

