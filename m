Date: Sun, 22 Nov 2015 14:34:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151122133411.GG24952@...1296...>
References: <1448040238-21813-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZgsfP6ejcHXtpYqZ"
Content-Disposition: inline
In-Reply-To: <1448040238-21813-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] put virtual IPv6 addresses into env
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

--ZgsfP6ejcHXtpYqZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 20, 2015 at 06:23:58PM +0100, Heiko Hund wrote:
> Add missing environment variables for IPv6 virtual addresses:
>=20
>   * ifconfig_pool_local_ipv6
>   * ifconfig_pool_remote_ipv6
>   * ifconfig_pool_ipv6_netbits
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>

Semi-ACK.  I'm not exactly sure, but your patch refused to apply for me -
git am or git apply both give less than helpful refusal messages:

error: patch failed: src/openvpn/multi.c:1432
error: src/openvpn/multi.c: patch does not apply
error: patch failed: src/openvpn/socket.c:2443
error: src/openvpn/socket.c: patch does not apply
error: patch failed: src/openvpn/socket.h:410
error: src/openvpn/socket.h: patch does not apply

while plain old patch against master suggests that your patch might be
against release/2.3+local patches

patching file src/openvpn/multi.c
Hunk #1 succeeded at 1504 with fuzz 1 (offset 72 lines).
patching file src/openvpn/socket.c
Hunk #1 succeeded at 2608 with fuzz 2 (offset 165 lines).
patching file src/openvpn/socket.h
Hunk #1 succeeded at 402 with fuzz 2 (offset -8 lines).

could you rebase to master and re-send, please?


While at it:

> +{
> +  if (!IN6_IS_ADDR_UNSPECIFIED (addr) || !(flags & SA_SET_IF_NONZERO))
> +    {
> +      struct openvpn_sockaddr si;
> +      CLEAR (si);
> +      si.addr.in6.sin6_family =3D AF_INET6;
> +      memcpy (&si.addr.in6.sin6_addr, addr, sizeof (*addr));
> +      setenv_sockaddr (es, name_prefix, &si, flags|SA_NO_IP_SUFFIX);

... most of the other code I've seen that deals with sin6_addr will
just assign the structure

  +      si.addr.in6.sin6_addr =3D *addr;

(which calls memcpy() under the hood, of course).  While mostly a matter
of taste, it's actually stronger type-checking to ensure the target
structure is the same, aka "has enough room to copy in".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZgsfP6ejcHXtpYqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlHEUqkuBuNlUUl1AQIeuQP/Zn+3+QoOSKXVoiuAACeq+UIjRL4LMViT
LmLEcKRy83ngXgtt4sWPEOjJTVHpR47kAlfQAkNhT830fijuuHYVn8D40Dxeo/g6
rNDe1GzP4KyAooW52t/FRneLDmmFsXHNA1ycjVpi0eDNITcDUav5wAEOaH/yntLk
vldCD9TfFIQ=
=qpD3
-----END PGP SIGNATURE-----

--ZgsfP6ejcHXtpYqZ--

